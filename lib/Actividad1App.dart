import 'package:actividad1/Main/HomeView.dart';
import 'package:actividad1/OnBoarding/RegisterView.dart';
import 'package:flutter/material.dart';

import 'OnBoarding/LoginView.dart';

class Actividad1App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp=MaterialApp(title: 'Actividad 1',
    routes: {
      '/loginview':(context) => LoginView(),
      '/registerview':(context) => RegisterView(),
      '/homeview' :(context) => HomeView()
    },
    initialRoute: '/loginview',
    );

    return materialApp;
  }
}
