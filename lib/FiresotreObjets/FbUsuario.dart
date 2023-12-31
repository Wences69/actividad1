import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario {

  final String name;
  final int age;
  final String username;
  final String bio;

  FbUsuario ({
    required this.name,
    required this.age,
    required this.username,
    required this.bio
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbUsuario(
        name: data?['name'] != null ? data!['name'] : "",
        age: data?['age'] != null ? data!['age'] : 0,
        username: data?['username'] != null ? data!['username'] : "Anónimo",
        bio: data?['bio'] != null ? data!['bio'] : "",
    );

  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name" : name,
      if (age != null) "age" : age,
      if (username != null) "username" : username,
      if (bio != null) "bio" : bio,
    };
  }
}

