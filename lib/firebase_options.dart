// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'AIzaSyAOC03bJQ8IB8utIDyRSDSUMA6cT_Cc-r4',
    appId: '1:476043789808:web:08d3816f5703069e60c935',
    messagingSenderId: '476043789808',
    projectId: 'ushop-11775',
    authDomain: 'ushop-11775.firebaseapp.com',
    storageBucket: 'ushop-11775.appspot.com',
    measurementId: 'G-WN0EJ75M9R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmPOy7szzLELGpreqaPOA1mn_97537Mbg',
    appId: '1:476043789808:android:8ceb1a4e4a449f1060c935',
    messagingSenderId: '476043789808',
    projectId: 'ushop-11775',
    storageBucket: 'ushop-11775.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDr09yYZiuXgY9yL_xYMIwe8gmBjXe12Uc',
    appId: '1:476043789808:ios:929498f7480e9c5560c935',
    messagingSenderId: '476043789808',
    projectId: 'ushop-11775',
    storageBucket: 'ushop-11775.appspot.com',
    iosBundleId: 'com.example.ushop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDr09yYZiuXgY9yL_xYMIwe8gmBjXe12Uc',
    appId: '1:476043789808:ios:c22b87444c5569f260c935',
    messagingSenderId: '476043789808',
    projectId: 'ushop-11775',
    storageBucket: 'ushop-11775.appspot.com',
    iosBundleId: 'com.example.ushop.RunnerTests',
  );
}
