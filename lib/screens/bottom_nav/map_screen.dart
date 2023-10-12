import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/directions_repo.dart';
import '../../models/directions.dart';
import '../../models/event.dart';
import '../../providers/event_provider.dart';
import '../../widgets/map/center_focus_widget.dart';
import '../../widgets/map/locator_event_detail.dart';
import '../../widgets/map/text_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapPageState();
}

class _MapPageState extends State<MapScreen> {
  GoogleMapController?
      googleMapController; // google map controller to controll and interract with the map
  Directions? info; // get directions, distance and durations

  Marker? origin;

  // String? darkMapStyle; // custome map style for google maps
  String? lightMapStyle; // custome map style for google maps

  bool cameraIsMoving = false; // check if google map camera is moving

  BitmapDescriptor markerIcon =
      BitmapDescriptor.defaultMarker; // map location marker

  List<Marker> markers = [];

  LatLng current = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();

    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    // get marker from event details
    markers = eventProvider.events.map((e) {
      return addMarkers(
        event: e,
      );
    }).toList();

    // // convert dark_map_style file to string
    // rootBundle.loadString('assets/map/map_style.txt').then((string) {
    //   darkMapStyle = string;
    // });

    // convert light_map_style file to string
    rootBundle.loadString('assets/map/light_map_style.txt').then((string) {
      lightMapStyle = string;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    await getCurrentLocation();

    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: current,
          zoom: 14,
        ),
      ),
    );
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
  List<Event> eventDetail = [];
  Map<String, dynamic> infoDuration = {};

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/");
        throw 1;
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                current.latitude,
                current.longitude,
              ),
              zoom: 14,
            ),
            onMapCreated: (controller) {
              googleMapController = controller;
              googleMapController?.setMapStyle(lightMapStyle);
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
                eventDetail = [];
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

          // event detail dialog
          eventDetail.isEmpty // check if event detail is empty
              ? const SizedBox()
              : LocatorEventDetail(
                  sheetPosition: sheetPosition,
                  event: eventDetail.first,
                  duration: infoDuration,
                  getDirection: () {
                    double lat = eventDetail.first.latlng["lat"] ?? 0.0;
                    double lng = eventDetail.first.latlng["lng"] ?? 0.0;

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
            currentLocation: current,
          ),
        ],
      ),
    );
  }

  // get user current location and set it to a default marker
  Future<void> getCurrentLocation() async {
    LatLng? latlng;
    await Geolocator.getCurrentPosition().then((value) {
      double lat = value.latitude;
      double lng = value.longitude;
      LatLng valueLatLng = LatLng(lat, lng);

      latlng = valueLatLng;
    });

    setState(() {
      current = latlng!;
    });

    origin = Marker(
      markerId: const MarkerId("origin"),
      position: current,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    );

    markers.add(origin!);
  }

  // add marker function
  Marker addMarkers({required Event event}) {
    double lat = event.latlng["lat"] ?? 0.0;
    double lng = event.latlng["lng"] ?? 0.0;

    LatLng pos = LatLng(lat, lng);
    String id = event.id;

    Marker marker = Marker(
      position: pos,
      markerId: MarkerId(id),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      onTap: () async {
        setState(() {
          eventDetail = [];
          info = null;
          infoDuration = {};
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
      origin: current,
      destination: destinationPos,
    );

    setState(() => infoDuration = duration ?? {});
  }

  // get direction and animate camera to bounds
  Future<void> getDirections(LatLng destinationPos) async {
    final directions = await DirectionsRepo().getDirections(
      origin: current,
      destination: destinationPos,
    );
    setState(() => info = directions);
    CameraUpdate.newLatLngBounds(info!.bounds, 100.0);
  }

  // Function to toggle the sheet's position
  void _toggleSheet(event) {
    setState(() {
      sheetPosition =
          sheetPosition == 0 ? 32.h : 0; // Adjust the height as needed
      eventDetail = [event];
    });
  }
}
