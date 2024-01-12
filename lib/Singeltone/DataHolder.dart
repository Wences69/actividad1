import 'package:actividad1/Singeltone/HttpAdmin.dart';
import 'package:flutter/material.dart';

import '../FiresotreObjets/FbPost.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';
import 'PlatformAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  late FbPost selectedPost;
  late PlatformAdmin platformAdmin;

  FirebaseAdmin fbadmin=FirebaseAdmin();
  GeolocAdmin geolocAdmin = GeolocAdmin();
  HttpAdmin httAdmin = HttpAdmin();

  void initDataHolder() {}

  DataHolder._internal();

  factory DataHolder(){
    return _dataHolder;
  }

  void initPlatformAdmin(BuildContext context){
    platformAdmin=PlatformAdmin(context: context);
  }
}