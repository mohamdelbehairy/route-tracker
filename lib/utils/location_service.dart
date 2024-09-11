import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  Future<bool> checkLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkLocationPermission() async {
    var permissonStatus = await location.hasPermission();
    if (permissonStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissonStatus == PermissionStatus.denied) {
      await location.requestPermission();
      return permissonStatus == PermissionStatus.granted;
    }
    return true;
  }

  void getCurrentLocation(void Function(LocationData)? onData) {
    location.changeSettings(distanceFilter: 2);
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocation() async {
    return await location.getLocation();
  }
}
