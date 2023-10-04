import 'package:flutter/material.dart';

import '../Custom/CustomAppBar.dart';

class LoginView extends StatelessWidget {

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context=context;
    return Scaffold(
      appBar: CustomAppBar(titulo: 'Login')
    );
  }
}
