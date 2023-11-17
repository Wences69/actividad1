import 'package:actividad1/Custom/Widgets/MovilCustomButton.dart';
import 'package:actividad1/Custom/Widgets/MovilCustomTextField.dart';
import 'package:actividad1/Singeltone/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Custom/Widgets/CustomSnackBar.dart';
import '../FiresotreObjets/FbUsuario.dart';

class MovilLoginView extends StatefulWidget {
  MovilLoginView({Key? key}) : super(key: key);

  @override
  State<MovilLoginView> createState() => _MovilLoginViewState();
}

class _MovilLoginViewState extends State<MovilLoginView> {
  // text controllers
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPasswd = TextEditingController();

  // password visibility
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.lock,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(height: 25),

                // app name
                Text(
                  "M I N I M A L",
                  style: TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 50),

                // email textfield
                MovilCustomTextField(
                    sHint: "Email",
                    blIsPasswd: false,
                    tecControler: tecEmail
                ),

                const SizedBox(height: 10),

                // password textfield
                MovilCustomTextField(
                  sHint: "Password",
                  blIsPasswd: !isPasswordVisible,
                  tecControler: tecPasswd,
                  iconButton: IconButton(
                    icon: Icon(isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot password?"),
                  ],
                ),

                const SizedBox(height: 25),

                // sign in button
                MovilCustomButton(sText: "Login", onTap: onClickLogin),

                const SizedBox(height: 25),

                // don't have an account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary)),
                    GestureDetector(
                      onTap: goToRegister,
                      child: Text(
                        " Register here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onClickLogin() async {
    String errorMessage = checkFields();
    if (errorMessage.isNotEmpty) {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
    else if (errorMessage.isEmpty) {
      try {
        await DataHolder().fbadmin.getFirebaseAuthInstance().signInWithEmailAndPassword(
          email: tecEmail.text,
          password: tecPasswd.text,
        );

        DocumentReference<FbUsuario> ref = DataHolder().fbadmin.getFirestoreInstance().collection("Users")
            .doc(DataHolder().fbadmin.getCurrentUserID())
            .withConverter(fromFirestore: FbUsuario.fromFirestore,
          toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),);

        DocumentSnapshot<FbUsuario> docSnap = await ref.get();
        FbUsuario usuario = docSnap.data()!;

        if (usuario != null) {
          Navigator.of(context).popAndPushNamed("/homeview");
        }
        else {
          Navigator.of(context).popAndPushNamed("/perfilview");
        }
      }

      on FirebaseAuthException catch (e) {

        if (e.code == 'user-not-found') {
          CustomSnackbar(sMensaje: 'Ningún usuario encontrado para ese correo electrónico').show(context);
        }

        else if (e.code == 'wrong-password') {
          CustomSnackbar(sMensaje: 'Contraseña incorrecta proporcionada para ese usuario').show(context);
        }
      }
    }
  }

  void goToRegister() {
    Navigator.of(context).popAndPushNamed("/registerview");
  }

  String checkFields() {
    StringBuffer errorMessage = StringBuffer();

    if (tecEmail.text.isEmpty && tecPasswd.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    }

    else if (tecEmail.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de correo electrónico');
    }

    else if (tecPasswd.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de contraseña');
    }

    return errorMessage.toString();
  }
}