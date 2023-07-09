import 'package:flutter/material.dart';
import 'package:i_ponto/utils/utils.dart';
import 'package:location/location.dart';

class LocationService {
  var location = Location();
  late LocationData _locData;

  Future<Map<String, double?>?> initializeAndGetLocation(
      BuildContext context) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // First check whether location is anabled or not ...
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        if (context.mounted) {
          Utils.showSnackBar('Please Enable Location Service', context);
        }
        return null;
      }
    }
    //
    // First service is enabled then ask permission for location from user ...
    permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.granted) {
        if (context.mounted) {
          Utils.showSnackBar("Please Allown Location Access'", context);
        }
        return null;
      }
    }

    // Afther permission is granted then return the coordinates
    _locData = await location.getLocation();
    return {'latitude': _locData.latitude, 'longitude': _locData.longitude};
  }
}
