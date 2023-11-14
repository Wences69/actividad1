import 'package:actividad1/Main/HomeView.dart';
import 'package:actividad1/Main/PostCreateView.dart';
import 'package:actividad1/Main/PostView.dart';
import 'package:actividad1/OnBoarding/PerfilView.dart';
import 'package:actividad1/OnBoarding/RegisterView.dart';
import 'package:actividad1/Singeltone/DataHolder.dart';
import 'package:actividad1/Splash/SplashView.dart';
import 'package:actividad1/Theme/DarkMode.dart';
import 'package:actividad1/Theme/LightMode.dart';
import 'package:actividad1/Theme/WebTheme.dart';
import 'package:flutter/material.dart';

import 'OnBoarding/LoginView.dart';

class Actividad1App extends StatelessWidget {
  const Actividad1App({super.key});

  @override
  Widget build(BuildContext context) {
    late MaterialApp materialApp;
    DataHolder().initPlatformAdmin(context);
    if(DataHolder().platformAdmin.isWebPlatform()) {
      materialApp = MaterialApp(
        title: 'Actividad 1 in web',
        debugShowCheckedModeBanner: false,
        theme: WebTheme,
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView(),
          '/splashview': (context) => SplashView(),
          '/perfilview': (context) => PerfilView(),
          '/postview': (context) => PostView(),
          '/postcreateview': (context) => PostCreateView(),
        },
        initialRoute: '/splashview',
      );
    }
    else {
      materialApp = MaterialApp(
        title: 'Actividad 1',
        debugShowCheckedModeBanner: false,
        theme: LightMode,
        darkTheme: DarkMode,
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView(),
          '/splashview': (context) => SplashView(),
          '/perfilview': (context) => PerfilView(),
          '/postview': (context) => PostView(),
          '/postcreateview': (context) => PostCreateView(),
        },
        initialRoute: '/splashview',
      );
    }
    return materialApp;
  }
}
