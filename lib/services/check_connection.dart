
import 'dart:io';

class CheckConnection {
  Future<bool> isConnected () async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Internet connection is available
      }
    } on SocketException catch (_) {
      return false; // No internet connection
    }
    return false;
  }


}
