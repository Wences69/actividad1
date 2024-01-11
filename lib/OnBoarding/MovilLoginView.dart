import 'package:flutter/material.dart';
import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomSnackbar.dart';
import '../Custom/Widgets/CustomTextField.dart';
import '../Singeltone/DataHolder.dart';

class MovilLoginView extends StatefulWidget {
  const MovilLoginView({Key? key}) : super(key: key);

  @override
  _MovilLoginViewState createState() => _MovilLoginViewState();
}

class _MovilLoginViewState extends State<MovilLoginView> {
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPasswd = TextEditingController();

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
                Icon(
                  Icons.lock,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(height: 25),

                const Text(
                  "Inicio de sesión",
                  style: TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 50),

                CustomTextField(
                    sHint: "Correo electrónico",
                    blIsPasswd: false,
                    tecControler: tecEmail),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "Contraseña",
                  blIsPasswd: !isPasswordVisible,
                  tecControler: tecPasswd,
                  iconButton: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 25),

                CustomButton(
                  onTap: () => iniciarSesion(tecEmail.text, tecPasswd.text),
                  sText: "Inicar sesión",
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "¿No tienes cuenta?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary)),
                    GestureDetector(
                      onTap: goToRegister,
                      child: const Text(
                        " Registrate aquí",
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

  // Gestiona el texto de ¿No tienes cuenta? Registrate aquí

  void goToRegister() {
    Navigator.of(context).popAndPushNamed("/registerview");
  }

  // Gestiona el boton de inicar sesión

  void iniciarSesion(String email, String password){
    String errorMessage = checkFields();

    if(errorMessage.isNotEmpty){
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
    else if (errorMessage.isEmpty) {
      Future<String?> result = DataHolder().fbadmin.iniciarSesion(tecEmail.text, tecPasswd.text);
      result.then((mensajeError) {
        if (mensajeError == null || mensajeError.isEmpty) {
          Navigator.of(context).popAndPushNamed("/homeview");
        } else {
          CustomSnackbar(sMensaje: mensajeError).show(context);
        }
      }
      );
    }
  }

  // Comprueba que todos los campos del login esten completos

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