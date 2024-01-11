import 'package:flutter/material.dart';
import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomSnackbar.dart';
import '../Custom/Widgets/CustomTextField.dart';
import '../FiresotreObjets/FbUsuario.dart';
import '../Singeltone/DataHolder.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({Key? key}) : super(key: key);

  @override
  _PerfilViewState createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  TextEditingController tecName=TextEditingController();
  TextEditingController tecAge=TextEditingController();
  TextEditingController tecUsername=TextEditingController();
  TextEditingController tecBio=TextEditingController();

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
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(height: 25),

                const Text(
                  "Completa tu perfil",
                  style: TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 50),

                CustomTextField(
                  sHint: "Nombre completo",
                  blIsPasswd: false,
                  tecControler: tecName,
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "Edad",
                  blIsPasswd: false,
                  tecControler: tecAge,
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "Nombre de usuario",
                  blIsPasswd: false,
                  tecControler: tecUsername,
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "Biografía",
                  blIsPasswd: false,
                  tecControler: tecBio,
                ),

                const SizedBox(height: 25),

                CustomButton(sText: "Aceptar", onTap: () => onClickAceptar()),

                const SizedBox(height: 10),

                CustomButton(sText: "Cancelar", onTap: () => onClickCancelar()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Gestiona el texto de ¿Ya tienes una cuenta? Inicia sesión aquí

  Future<void> onClickAceptar() async {
    String errorMessage = checkFields();

    if(errorMessage.isNotEmpty){
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
    else if (errorMessage.isEmpty) {
      FbUsuario user = FbUsuario(name: tecName.text, age: int.parse(tecAge.text), username: tecUsername.text, bio: tecBio.text);
      await DataHolder().fbadmin.getFirestoreInstance().collection("Users").doc(DataHolder().fbadmin.getCurrentUserID()).set(user.toFirestore());
      Navigator.of(context).popAndPushNamed("/homeview");
    }
  }

  void onClickCancelar() {
    DataHolder().fbadmin.getFirebaseAuthInstance().signOut();
    Navigator.of(context).popAndPushNamed("/loginview");
  }

  // Comprueba que todos los campos del register esten completos, la ultima comprobación comprueba que las contraseñas coincidan

  String checkFields() {
    StringBuffer errorMessage = StringBuffer();

    if (tecName.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de nombre\n');
    }
    if (tecAge.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de edad\n');
    }
    if (tecUsername.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de nombre de usuario\n');
    }
    if (tecBio.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de biografía\n');
    }
    return errorMessage.toString();
  }
}





