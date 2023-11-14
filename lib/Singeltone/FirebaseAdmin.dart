import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../FiresotreObjets/FbUsuario.dart';
import 'DataHolder.dart';

class FirebaseAdmin{

  String? getCurrentUserID(){
    return FirebaseAuth.instance.currentUser?.uid;
  }

  User? getCurrentUser(){
    return FirebaseAuth.instance.currentUser;
  }

  FirebaseFirestore getFirestoreInstance(){
    return FirebaseFirestore.instance;
  }

  FirebaseAuth getFirebaseAuthInstance(){
    return FirebaseAuth.instance;
  }


  /*Future<void> loginFb(TextEditingController tecUsername, TextEditingController tecPassword) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: tecUsername.text,
        password: tecPassword.text,
      );
      // El inicio de sesión fue exitoso, puedes agregar lógica adicional aquí si es necesario.
    } catch (e) {
      // Manejo de errores si el inicio de sesión falla
      print("Error en el inicio de sesión: $e");
      throw e; // Lanza el error para que sea manejado por quien llama a la función.
    }
  }


  DocumentReference<FbUsuario> connectToAuth(){
    DocumentReference<FbUsuario> ref = DataHolder().fbadmin.getFirestoreInstance().collection("Users")
        .doc(DataHolder().fbadmin.getCurrentUserID())
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
        toFirestore: (FbUsuario usuario, _) => usuario.toFirestore());
    return ref;
  }

  Future<FbUsuario> inicioDeSesionCompleto(tecUsername,tecPassword) async {
    loginFb(tecUsername, tecPassword);
    DocumentSnapshot<FbUsuario> docSnap = await connectToAuth().get();

    return docSnap.data()!;
  }*/

}