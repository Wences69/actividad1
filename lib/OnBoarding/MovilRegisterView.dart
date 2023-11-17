import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomSnackBar.dart';
import '../Custom/Widgets/MovilCustomButton.dart';
import '../Custom/Widgets/MovilCustomTextField.dart';

class MovilRegisterView extends StatefulWidget {
  MovilRegisterView({Key? key});

  @override
  _MovilRegisterViewState createState() => _MovilRegisterViewState();
}

class _MovilRegisterViewState extends State<MovilRegisterView> {
  // text controllers
  final TextEditingController tecUsername = TextEditingController();
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPasswd = TextEditingController();
  final TextEditingController tecConfirmPasswd = TextEditingController();

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
                  Icons.person,
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

                // username textfield
                MovilCustomTextField(
                  sHint: "Username",
                  blIsPasswd: false,
                  tecControler: tecUsername,
                ),

                const SizedBox(height: 10),

                // email textfield
                MovilCustomTextField(
                  sHint: "Email",
                  blIsPasswd: false,
                  tecControler: tecEmail,
                ),

                const SizedBox(height: 10),

                // password textfield
                MovilCustomTextField(
                  sHint: "Password",
                  blIsPasswd: !isPasswordVisible,
                  tecControler: tecPasswd,
                  iconButton: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MovilCustomTextField(
                  sHint: "Confirm Password",
                  blIsPasswd: true,
                  tecControler: tecConfirmPasswd,
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

                // register button
                MovilCustomButton(sText: "Register", onTap: onClickRegister),

                const SizedBox(height: 25),

                // don't have an account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color:
                        Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: goToLogin,
                      child: Text(
                        " Login here",
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

  void onClickRegister() async {
    String errorMessage = checkFields();

    if(errorMessage.isNotEmpty){
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }

    else if (errorMessage.isEmpty) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPasswd.text,
        );
        Navigator.of(context).popAndPushNamed("/perfilview");
      }

      on FirebaseAuthException catch (e) {

        if (e.code == 'weak-password') {
          CustomSnackbar(sMensaje: 'La contraseña es muy débil').show(context);
        }

        else if (e.code == 'email-already-in-use') {
          CustomSnackbar(sMensaje: 'Ya existe una cuenta con este correo').show(context);
        }
      }
      catch (e) {
        print(e);
      }
    }
  }

  String checkFields() {
    StringBuffer errorMessage = StringBuffer();

    if (tecUsername.text.isEmpty && tecPasswd.text.isEmpty && tecConfirmPasswd.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    }

    else if (tecUsername.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de correo electrónico');
    }

    else if (tecPasswd.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de contraseña');
    }

    else if (tecConfirmPasswd.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de confirmación de contraseña');
    }

    return errorMessage.toString();
  }

  void goToLogin() {
    Navigator.of(context).popAndPushNamed("/loginview");
  }
}