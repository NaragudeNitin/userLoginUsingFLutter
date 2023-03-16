import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../auth/note_firebase_service.dart';
import '../auth/sqlflite.dart';

class InternetConnection{
  bool isDeviceConnected = false;
  InternetConnection._(){
    getConnectivity();
  }
  static final instance = InternetConnection._();
  void getConnectivity() =>
      Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected) {
            log('Connected to internet');
            final notes = await SqlFlite.instance.getAsyncNotesList();
            for(var note in notes){
              await NoteFirebaseService.updateFirestoreWithLocalDb(note.convertToNotesModel());
            }
          }else{
            log('not Connected to internet');
          }
},
);
}