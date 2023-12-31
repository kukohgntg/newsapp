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
    apiKey: 'AIzaSyCkHeh5EUJafV0CIAK8PX6o8rClpmEbwx4',
    appId: '1:2355509492:web:fff6b9ce56c2ff4a4286a1',
    messagingSenderId: '2355509492',
    projectId: 'newsapp-c593a',
    authDomain: 'newsapp-c593a.firebaseapp.com',
    storageBucket: 'newsapp-c593a.appspot.com',
    measurementId: 'G-1TMP4M0EL9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuXsopcqzx5KVJPHKvDW3ULanHtB3NnTw',
    appId: '1:2355509492:android:d36928b557b146c34286a1',
    messagingSenderId: '2355509492',
    projectId: 'newsapp-c593a',
    storageBucket: 'newsapp-c593a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpItOyM8RScXaUUF9RG0hBrciuMxw9K1c',
    appId: '1:2355509492:ios:72e9f00d30d718c64286a1',
    messagingSenderId: '2355509492',
    projectId: 'newsapp-c593a',
    storageBucket: 'newsapp-c593a.appspot.com',
    iosBundleId: 'com.kukohgntg.newsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpItOyM8RScXaUUF9RG0hBrciuMxw9K1c',
    appId: '1:2355509492:ios:af712d1591517bbc4286a1',
    messagingSenderId: '2355509492',
    projectId: 'newsapp-c593a',
    storageBucket: 'newsapp-c593a.appspot.com',
    iosBundleId: 'com.kukohgntg.newsapp.RunnerTests',
  );
}
