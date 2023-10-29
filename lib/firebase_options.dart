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
    apiKey: 'AIzaSyAa6RBwLscQkAM0TBwRJm3eqP1Pi0FbI9w',
    appId: '1:819111566876:web:41d263e7fe30e01a6649d9',
    messagingSenderId: '819111566876',
    projectId: 'personal-finance-managem-1b5ed',
    authDomain: 'personal-finance-managem-1b5ed.firebaseapp.com',
    storageBucket: 'personal-finance-managem-1b5ed.appspot.com',
    measurementId: 'G-WMBLSPWH03',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzvaeXm9xBPoM4uxE_Jsl3-oN3k6g2qmw',
    appId: '1:819111566876:android:73efbdd968d563c06649d9',
    messagingSenderId: '819111566876',
    projectId: 'personal-finance-managem-1b5ed',
    storageBucket: 'personal-finance-managem-1b5ed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbcgd5e0Dt_6ftargyxmLLbxRD8Q7cXIM',
    appId: '1:819111566876:ios:d43096a69041b09c6649d9',
    messagingSenderId: '819111566876',
    projectId: 'personal-finance-managem-1b5ed',
    storageBucket: 'personal-finance-managem-1b5ed.appspot.com',
    iosBundleId: 'com.example.personalFinance',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbcgd5e0Dt_6ftargyxmLLbxRD8Q7cXIM',
    appId: '1:819111566876:ios:76d8a7481e55a92d6649d9',
    messagingSenderId: '819111566876',
    projectId: 'personal-finance-managem-1b5ed',
    storageBucket: 'personal-finance-managem-1b5ed.appspot.com',
    iosBundleId: 'com.example.personalFinance.RunnerTests',
  );
}
