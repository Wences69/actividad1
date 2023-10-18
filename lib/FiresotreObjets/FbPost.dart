import 'package:cloud_firestore/cloud_firestore.dart';

class FbPost{


  final String title;
  final String body;

  FbPost ({
    required this.title,
    required this.body
  });

  factory FbPost.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbPost(
        title: data?['title'] != null ? data!['title'] : "xxxx",
        body: data?['body'] != null ? data!['body'] : "xxxx"
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (body != null) "body": body
    };
  }
}