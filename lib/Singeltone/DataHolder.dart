import 'package:flutter/material.dart';

import '../FiresotreObjets/FbPost.dart';
import 'FirebaseAdmin.dart';
import 'PlatformAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  FirebaseAdmin fbadmin=FirebaseAdmin();

  late FbPost selectedPost;
  late PlatformAdmin platformAdmin;

  void initDataHolder() {}

  DataHolder._internal();

  factory DataHolder(){
    return _dataHolder;
  }

  void initPlatformAdmin(BuildContext context){
    platformAdmin=PlatformAdmin(context: context);
  }
}