import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  Future<void> checkLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        throw LocationServiceException();
      }
    }
  }

  Future<void> checkLocationPermission() async {
    var permissonStatus = await location.hasPermission();
    if (permissonStatus == PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }
    if (permissonStatus == PermissionStatus.denied) {
      permissonStatus = await location.requestPermission();
      if (permissonStatus != PermissionStatus.granted) {
        throw LocationPermissionException();
      }
    }
  }

  void getCurrentLocation(void Function(LocationData)? onData) async {
    await checkLocationService();
    await checkLocationPermission();
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocation() async {
    await checkLocationService();
    await checkLocationPermission();
    return await location.getLocation();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
