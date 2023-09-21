import 'package:cruise/data.dart';
import 'package:cruise/helpers/directions_repo.dart';
import 'package:cruise/helpers/location_helper.dart';
import 'package:cruise/helpers/map_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sizer/sizer.dart';

import '../models/directions.dart';
import '../widgets/map/center_focus_widget.dart';
import '../widgets/map/locator_event_detail.dart';
import '../widgets/map/search_location.dart';
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

  String? mapStyle; // custome map style for google maps

  TextEditingController? searchController; // search event text controller

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

    // convert map_style file to string
    rootBundle.loadString('assets/map/map_style.txt').then((string) {
      mapStyle = string;
    });
  }

  @override
  void dispose() {
    super.dispose();

    // dispose controllers
    googleMapController?.dispose();
    searchController?.dispose();
  }

  // event detail sheet height
  double sheetPosition = 0;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    Map<String, dynamic> eventDetail = {};

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          initialCameraPosition: GoogleMapHelper.getInitialCameraLocation(),
          onMapCreated: (controller) {
            googleMapController = controller;
            googleMapController?.setMapStyle(mapStyle);
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
            });
          },
          onCameraIdle: () {
            setState(() {
              cameraIsMoving = false;
              if (eventDetail.isNotEmpty) sheetPosition = 32.h;
            });
          },
          onCameraMoveStarted: () {
            setState(() {
              sheetPosition = 0;
              cameraIsMoving = true;
            });
          },
        ),

        // text app bar
        const TextBar(),

        // search even container
        SearchLocation(
          controller: searchController ?? TextEditingController(),
          cameraIsMoving: cameraIsMoving,
        ),

        LocatorEventDetail(
          sheetPosition: sheetPosition,
          getDirection: () => getDirections(
            const LatLng(
              6.425933503271069,
              3.4244839013258326,
            ),
          ),
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
      onTap: () {
        _toggleSheet(event);
      },
    );

    return marker;
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
      if (sheetPosition != 0) {
      } else {
        sheetPosition =
            sheetPosition == 0 ? 32.h : 0; // Adjust the height as needed
      }
    });
  }
}
