import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sizer/sizer.dart';

import '../data.dart';
import '../helpers/directions_repo.dart';
import '../helpers/location_helper.dart';
import '../helpers/map_helper.dart';
import '../models/directions.dart';
import '../widgets/map/center_focus_widget.dart';
import '../widgets/map/locator_event_detail.dart';
import '../widgets/map/text_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapPageState();
}

class _MapPageState extends State<MapScreen> {
  GoogleMapController?
      googleMapController; // google map controller to controll and interract with the map
  Marker? origin; // this indicates the origin of the route
  Directions? info; // get directions, distance and durations

  String? darkMapStyle; // custome map style for google maps
  String? lightMapStyle; // custome map style for google maps

  bool cameraIsMoving = false; // check if google map camera is moving

  BitmapDescriptor markerIcon =
      BitmapDescriptor.defaultMarker; // map location marker

  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();

    getCurrentLocation();

    // get marker from event details
    markers = event.map((e) {
      return addMarkers(
        event: e,
      );
    }).toList();

    // convert dark_map_style file to string
    rootBundle.loadString('assets/map/map_style.txt').then((string) {
      darkMapStyle = string;
    });

    // convert light_map_style file to string
    rootBundle.loadString('assets/map/light_map_style.txt').then((string) {
      lightMapStyle = string;
    });
  }

  @override
  void dispose() {
    super.dispose();

    // dispose controllers
    googleMapController?.dispose();
  }

  // event detail sheet height
  double sheetPosition = 0;

  //event details data
  Map<String, dynamic> eventDetail = {};
  String infoDuration = "";

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          initialCameraPosition: GoogleMapHelper.getInitialCameraLocation(),
          onMapCreated: (controller) {
            googleMapController = controller;
            googleMapController?.setMapStyle(
                MediaQuery.platformBrightnessOf(context) == Brightness.light
                    ? lightMapStyle
                    : darkMapStyle);
          },
          markers: Set<Marker>.of(markers),
          polylines: {
            if (info != null)
              Polyline(
                polylineId: const PolylineId("overview_polyline"),
                color: primaryColor,
                width: 5,
                points: info!.polylinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              ),
          },
          onTap: (_) {
            setState(() {
              info = null;
              sheetPosition = 0;
              eventDetail = {};
            });
          },
          onCameraIdle: () {
            googleMapController?.setMapStyle(
              MediaQuery.platformBrightnessOf(context) == Brightness.light
                  ? lightMapStyle
                  : darkMapStyle,
            );
            setState(() {
              cameraIsMoving = false;
              if (eventDetail.isNotEmpty) sheetPosition = 32.h;
            });
          },
          onCameraMoveStarted: () {
            googleMapController?.setMapStyle(
              MediaQuery.platformBrightnessOf(context) == Brightness.light
                  ? lightMapStyle
                  : darkMapStyle,
            );
            setState(() {
              sheetPosition = 0;
              cameraIsMoving = true;
            });
          },
        ),

        // text app bar
        const TextBar(),

        // event detail dialog
        eventDetail.isEmpty // check if event detail is empty
            ? const SizedBox()
            : LocatorEventDetail(
                sheetPosition: sheetPosition,
                data: eventDetail,
                duration: infoDuration,
                getDirection: () {
                  double lat = eventDetail["lat"] ?? 0.0;
                  double lng = eventDetail["lng"] ?? 0.0;

                  getDirections(
                    LatLng(
                      lat,
                      lng,
                    ),
                  );
                },
              ),

        // icon button to center the map to a given location from the map controller
        CenterFocusWidget(
          googleMapController: googleMapController,
        ),
      ],
    );
  }

  // get user current location and set it to a default marker
  Future<void> getCurrentLocation() async {
    markerIcon = await LocationHelper.setCustomMarker();

    await LocationHelper.requestPermission().then(
      (value) => origin = Marker(
        position: LatLng(value.latitude, value.longitude),
        markerId: const MarkerId(""),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        onTap: () {},
      ),
    );
    markers.add(origin!);
  }

  // add marker function
  Marker addMarkers({required Map<String, dynamic> event}) {
    double lat = event["lat"] ?? 0.0;
    double lng = event["lng"] ?? 0.0;

    LatLng pos = LatLng(lat, lng);
    String id = event["id"] ?? "";

    Marker marker = Marker(
      position: pos,
      markerId: MarkerId(id),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      onTap: () async {
        setState(() {
          eventDetail = {};
          info = null;
          infoDuration = "";
        });
        getDirectionDuration(pos);
        _toggleSheet(event);
      },
    );

    return marker;
  }

  // get duration from origin to destination
  Future<void> getDirectionDuration(LatLng destinationPos) async {
    final duration = await DirectionsRepo().getDuration(
      origin: origin!.position,
      destination: destinationPos,
    );

    setState(() => infoDuration = duration!);
  }

  // get direction and animate camera to bounds
  Future<void> getDirections(LatLng destinationPos) async {
    final directions = await DirectionsRepo().getDirections(
      origin: origin!.position,
      destination: destinationPos,
    );
    setState(() => info = directions);
    CameraUpdate.newLatLngBounds(info!.bounds, 100.0);
  }

  // Function to toggle the sheet's position
  void _toggleSheet(Map<String, dynamic> event) {
    setState(() {
      sheetPosition =
          sheetPosition == 0 ? 32.h : 0; // Adjust the height as needed
      eventDetail = event;
    });
  }
}
