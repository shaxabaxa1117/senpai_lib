// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAWSzOcK4ee44d9wousqWH9-edqLMbD268',
    appId: '1:513501194756:web:9365c9db957aeff5c12351',
    messagingSenderId: '513501194756',
    projectId: 'senpai-lib',
    authDomain: 'senpai-lib.firebaseapp.com',
    storageBucket: 'senpai-lib.firebasestorage.app',
    measurementId: 'G-3446BQKDKW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqyWCspNqrwC7oy8U-R72sUehMgA_hoyQ',
    appId: '1:513501194756:android:f36e447afc52d0aac12351',
    messagingSenderId: '513501194756',
    projectId: 'senpai-lib',
    storageBucket: 'senpai-lib.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvW1xVoavcOkdoP72_zj5DopkrImloDoI',
    appId: '1:513501194756:ios:a943c3efd85b0a6dc12351',
    messagingSenderId: '513501194756',
    projectId: 'senpai-lib',
    storageBucket: 'senpai-lib.firebasestorage.app',
    iosBundleId: 'com.example.senpaiLib',
  );
}
