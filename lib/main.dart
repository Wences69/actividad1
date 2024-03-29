import 'package:actividad1/Actividad1App.dart';
import 'package:actividad1/Singeltone/DataHolder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DataHolder().initDataHolder();
  Actividad1App actividad1app = Actividad1App();
  runApp(actividad1app);
}