import 'package:flutter/material.dart';
import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomSnackbar.dart';
import '../Custom/Widgets/CustomTextField.dart';
import '../FiresotreObjets/FbPost.dart';
import '../Singeltone/DataHolder.dart';

class PostCreateView extends StatelessWidget {
  PostCreateView({Key? key}) : super(key: key);

  final TextEditingController tecTitle = TextEditingController();
  final TextEditingController tecBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("Crea un nuevo post",
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary
            )
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Aquí puedes crear un post",
                  style: TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 50),

                CustomTextField(
                    sHint: "Titulo del post",
                    blIsPasswd: false,
                    tecControler: tecTitle
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "¿Qué esta pasando?",
                  blIsPasswd: false,
                  tecControler: tecBody,
                ),

                const SizedBox(height: 25),

                CustomButton(sText: "Postear", onTap: () => crearPost(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Crea un nuevo post

  void crearPost(context) {
    String errorMessage = checkFields();
    if(errorMessage.isNotEmpty){
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
    else if (errorMessage.isEmpty) {
      FbPost postNuevo = FbPost(
          title: tecTitle.text,
          body: tecBody.text
      );
      DataHolder().fbadmin.subirPost(postNuevo);
      Navigator.pop(context);
    }
  }

  // Comprueba que todos los campos del post estén completos

  String checkFields() {
    StringBuffer errorMessage = StringBuffer();
    if (tecTitle.text.isEmpty && tecBody.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    }
    else if (tecTitle.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de título');
    }
    else if (tecBody.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de cuerpo');
    }
    return errorMessage.toString();
  }
}
