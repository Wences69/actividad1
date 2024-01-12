import 'package:flutter/material.dart';

import '../Custom/Views/PostCellView.dart';
import '../Custom/Views/PostListCellView.dart';
import '../Custom/Widgets/CustomBottomMenu.dart';
import '../FiresotreObjets/FbPost.dart';
import '../Singeltone/DataHolder.dart';

class SearchPostsView extends StatefulWidget {
  final List<FbPost> searchResults;

  const SearchPostsView({super.key, required this.searchResults});

  @override
  _SearchPostsViewState createState() => _SearchPostsViewState();
}

class _SearchPostsViewState extends State<SearchPostsView> {

  final List<FbPost> posts = [];
  bool blIsList = true;
  late CustomBottomMenu bottomMenu;

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return const Divider(color: Color.fromRGBO(37, 77, 152, 1.0), thickness: 2,);
  }

  @override
  void initState() {
    descargarPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Posts encontrados",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: listOrGrid(blIsList),
      bottomNavigationBar: CustomBottomMenu(fOnItemTap: onBottomMenuPressed),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/postcreateview");
        },
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }

  Widget? listOrGrid(bool blIsList) {
    late Widget builder;
    if (blIsList) {
      builder = ListView.separated(
          padding: const EdgeInsets.all(8),
          itemBuilder: itemListBuilder,
          separatorBuilder: separadorLista,
          itemCount: posts.length
      );
    }
    else {
      builder = GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: itemGridBuilder,
        itemCount: posts.length,
      );
    }
    return builder;
  }


  Widget? itemGridBuilder(BuildContext context, int index) {
    return PostGridView(
        sTitle: posts[index].title,
        sBody: posts[index].body,
        iPosicion: index,
        fOnItemTap: onPostPressed,
        fOnItemLongPressed: onPostLongPressed
    );
  }

  Widget? itemListBuilder(BuildContext context, int index) {
    return PostListView(
        sTitle: posts[index].title,
        sBody: posts[index].body,
        iPosicion: index,
        fOnItemTap: onPostPressed,
        fOnItemLongPressed: onPostLongPressed
    );
  }


  Widget separadorLista(BuildContext context, int index) {
    return Divider(
      thickness: 2,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  void descargarPosts() async {
    try {
      posts.clear();
      if (widget.searchResults.isNotEmpty) {
        posts.addAll(widget.searchResults);
      }
    } catch (e) {
      print("Error al descargar posts: $e");
    }
  }


  void onBottomMenuPressed(int indice) {
    setState(() {
      if(indice == 0){
        blIsList = true;
      }
      else if(indice == 1){
        blIsList = false;
      }
      else if(indice == 2){
        Navigator.of(context).popAndPushNamed('/loginview');
      }
    });
  }

  void onPostLongPressed(int index) {
    DataHolder().selectedPost = posts[index];
    Navigator.of(context).pushNamed("/posteditview");
  }

  void onPostPressed(int index) {
    DataHolder().selectedPost = posts[index];
    Navigator.of(context).pushNamed("/postview");
  }
}