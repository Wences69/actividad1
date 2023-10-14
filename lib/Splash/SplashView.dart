import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView>{
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  void checkSession() async {
    //await Future.delayed(Duration(seconds: 5));
    if(FirebaseAuth.instance.currentUser != null){
      Navigator.of(_context).pushNamed("/homeview");
    }
    Navigator.of(_context).pushNamed("/loginview");
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    checkSession();

    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("resources/kyty_logo.png", width: 300, height: 450),
        CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.cyanAccent,
          strokeWidth: 6.0, // Ajusta el grosor del indicador
        )
      ],
    );

    return Center(child: column);
  }
}
