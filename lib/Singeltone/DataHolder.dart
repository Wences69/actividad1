import 'package:actividad1/Singeltone/HttpAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../FiresotreObjets/FbPost.dart';
import '../FiresotreObjets/FbUsuario.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';
import 'PlatformAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  late FbPost selectedPost;
  late PlatformAdmin platformAdmin;
  FbUsuario? usuario;

  FirebaseAdmin fbadmin=FirebaseAdmin();
  GeolocAdmin geolocAdmin = GeolocAdmin();
  HttpAdmin httpAdmin = HttpAdmin();

  void initDataHolder() {}

  DataHolder._internal();

  factory DataHolder(){
    return _dataHolder;
  }

  void initPlatformAdmin(BuildContext context){
    platformAdmin=PlatformAdmin(context: context);
  }

  void GPSSuscribeUser(){
    geolocAdmin.recordLocationChanges(posicionDelMovilCambio);

  }

  void posicionDelMovilCambio(Position? position) {
    if (usuario != null && position != null) {
      usuario!.geoloc = GeoPoint(position.latitude, position.longitude);
      fbadmin.actualizarPerfilUsuario(usuario!);
    } else {
      print("Error: Usuario o posición es null. No se puede actualizar la ubicación.");
      print("Usuario"+usuario.toString());
    }
  }

  Future<FbUsuario?> loadFbUsuario() async{
    String uid=FirebaseAuth.instance.currentUser!.uid;
    print("UID DE DESCARGA loadFbUsuario------------->>>> ${uid}");
    DocumentReference<FbUsuario> ref=DataHolder().fbadmin.db.collection("Users")
        .doc(uid)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
      toFirestore: (FbUsuario usuario, _) => usuario.toFirestore());


    DocumentSnapshot<FbUsuario> docSnap=await ref.get();
    print("docSnap DE DESCARGA loadFbUsuario------------->>>> ${docSnap.data()}");
    usuario=docSnap.data();
    return usuario;
  }
}