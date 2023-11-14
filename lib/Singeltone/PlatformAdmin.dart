import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PlatformAdmin{

  //int iANDROID_PLATFORM=0;
  //int iIOS_PLATFORM=1;
  //int iWEB_PLATFORM=2;
  BuildContext context;

  PlatformAdmin({required this.context});

  String getPlatform() {
    String platform;
    if (isAndroidPlatform()) {
      platform='android';
    } else if (isIOSPlatform()) {
      platform='ios';
    } else if (isWebPlatform()) {
      platform='web';
    } else {
      platform='Desconocido';
    }
    return platform;
  }

  double getScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  double getScreenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  bool isAndroidPlatform(){
    return defaultTargetPlatform == TargetPlatform.android;
  }

  bool isIOSPlatform(){
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  bool isWebPlatform(){
    return kIsWeb;
    //&& defaultTargetPlatform != TargetPlatform.fuchsia
    //&& defaultTargetPlatform != TargetPlatform.linux
    //&& defaultTargetPlatform != TargetPlatform.windows
    //&& defaultTargetPlatform != TargetPlatform.macOS
  }

}