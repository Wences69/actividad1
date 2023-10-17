import 'package:cloud_firestore/cloud_firestore.dart';

class FBUsuario {

  final String name;
  final int age;
  final String username;
  final String bio;

  FBUsuario ({
    required this.name,
    required this.age,
    required this.username,
    required this.bio
  });

  factory FBUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FBUsuario(
        name: data?['name'],
        age: data?['age'],
        username: data?['username'],
        bio: data?['bio'],
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

