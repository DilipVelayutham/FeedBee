import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth =
      LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      final canAuthenticate =
          await _auth.canCheckBiometrics ||
          await _auth.isDeviceSupported();

      if (!canAuthenticate) {
        return false;
      }

      return await _auth.authenticate(
        localizedReason:
            'Authenticate to export feedback data',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return Future.error(e);
    }
  }
}