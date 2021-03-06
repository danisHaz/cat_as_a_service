import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAGA-SsZEt9SZDttWLdStGmwnucTjHEzQk',
    appId: '1:940382111202:web:b84c626e65952ccf4525bb',
    messagingSenderId: '940382111202',
    projectId: 'cat-as-a-service',
    authDomain: 'cat-as-a-service.firebaseapp.com',
    storageBucket: 'cat-as-a-service.appspot.com',
    measurementId: 'G-BV593RHYMM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2JVPdSK5r8mQi07TWMOwduoCMpurXIUs',
    appId: '1:940382111202:android:f3c9135e2d9ef9aa4525bb',
    messagingSenderId: '940382111202',
    projectId: 'cat-as-a-service',
    storageBucket: 'cat-as-a-service.appspot.com',
  );
}
