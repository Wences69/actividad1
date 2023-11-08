import 'package:actividad1/Main/HomeView.dart';
import 'package:actividad1/Main/PostCreateView.dart';
import 'package:actividad1/Main/PostView.dart';
import 'package:actividad1/OnBoarding/PerfilView.dart';
import 'package:actividad1/OnBoarding/RegisterView.dart';
import 'package:actividad1/Splash/SplashView.dart';
import 'package:flutter/material.dart';

import 'OnBoarding/LoginView.dart';

class Actividad1App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp=MaterialApp(title: 'Actividad 1',
      debugShowCheckedModeBanner: false,
      routes: {
        '/loginview':(context) => LoginView(),
        '/registerview':(context) => RegisterView(),
        '/homeview' :(context) => HomeView(),
        '/splashview' :(context) => SplashView(),
        '/perfilview' :(context) => PerfilView(),
        '/postview' :(context) => PostView(),
        '/postcreateview' :(context) => PostCreateView()
      },
      initialRoute: '/splashview',
    );

    return materialApp;
  }
}