import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_tracke/utils/location_service.dart';

class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({super.key});

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;
  late GoogleMapController googleMapController;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0));
    locationService = LocationService();
    super.initState();
  }

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
            updateCurrentLocation();
          },
          zoomControlsEnabled: false,
          initialCameraPosition: initialCameraPosition),
    );
  }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationService.getLocation();
      var currentPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
      var marker = Marker(
          markerId: const MarkerId("myMarker"), position: currentPosition);
      var cameraPosition = CameraPosition(zoom: 16, target: currentPosition);
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      markers.add(marker);
      setState(() {});
    } on LocationServiceException catch (e) {
    } on LocationPermissionException catch (e) {
    } catch (e) {
      
    }
  }
}
