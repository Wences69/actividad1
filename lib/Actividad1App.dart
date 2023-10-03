import 'package:flutter/material.dart';

import 'OnBoarding/LoginView.dart';

class Actividad1App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp=MaterialApp(title: "Actividad 1",
    routes: {
      "/loginview":(context) => LoginView()

    },
    initialRoute: "/loginview",
    );

    return materialApp;
  }
}
