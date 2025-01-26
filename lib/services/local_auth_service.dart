import 'package:budgetbeam/utils/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

final LocalAuthentication localAuth = LocalAuthentication();

Future<bool> authenticate(String msg) async {
  final bool canAuthenticateWithBiometrics = await localAuth.canCheckBiometrics;
  final bool canAuthenticate =
      canAuthenticateWithBiometrics || await localAuth.isDeviceSupported();
  if (canAuthenticate) {
    try {
      final bool didAuthenticate = await localAuth.authenticate(
        localizedReason: msg,
      );
      return didAuthenticate;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  } else {
    debugPrint("Device not supported");
    showErrorSnackbar("Device not supported");
    return false;
  }
}
