import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FiresotreObjets/FbPost.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  String sNombre="Kyty DataHolder";
  late String sPostTitle;
  FbPost? selectedPost;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbadmin=FirebaseAdmin();
  GeolocAdmin geolocAdmin = GeolocAdmin();

  DataHolder._internal() {

  }

  void initDataHolder(){

    sPostTitle="Titulo de Post";
    //loadCachedFbPost();
  }

  factory DataHolder(){
    return _dataHolder;
  }

  void insertPostEnFB(FbPost postNuevo){
    CollectionReference<FbPost> postsRef = db.collection("Posts")
        .withConverter(
      fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),
    );

    postsRef.add(postNuevo);
  }

  void saveSelectedPostInCache() async{
    if(selectedPost!=null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('fbpost_titulo', selectedPost!.title);
      prefs.setString('fbpost_cuerpo', selectedPost!.body);
    }

  }

  Future<FbPost?> loadFbPost() async{
    if(selectedPost!=null) return selectedPost;

    await Future.delayed(Duration(seconds: 10));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpost_titulo = prefs.getString('fbpost_titulo');
    fbpost_titulo??= "";

    String? fbpost_cuerpo = prefs.getString('fbpost_cuerpo');
    fbpost_cuerpo??="";

    selectedPost=FbPost(title: fbpost_titulo, body: fbpost_cuerpo);
    return selectedPost;
  }
}