import 'package:connectivity_plus/connectivity_plus.dart';

ConnectivityResult result = ConnectivityResult.none;


//Checks if the internet is connected. Sends true if its internet is on
Future<bool> internetConnection() async {
  result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}


//TODO do the internet check for internet on but no internet.
