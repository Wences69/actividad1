import 'package:actividad1/Custom/Widgets/CustomDialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Custom/Views/PostCellView.dart';
import '../Custom/Views/PostListCellView.dart';
import '../Custom/Widgets/CustomBottomMenu.dart';
import '../Custom/Widgets/CustomDrawer.dart';
import '../FiresotreObjets/FbPost.dart';
import '../OnBoarding/LoginView.dart';
import '../Singeltone/DataHolder.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<FbPost> posts = [];
  late Future<List<FbPost>> futurePosts;
  bool blIsList = true;

  @override
  void initState() {
    super.initState();
    cargarPosts();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            "H O M E",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: listOrGrid(blIsList),
        drawer: CustomDrawer(fOnItemTap: onDrawerPressed, fOnProfilePictureTap: onDrawerProfilePressed),
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
      ),
    );
  }

  // Espera a cargarPosts()

  Future<void> onRefresh() async {
    await cargarPosts();
  }

  // Gestion de los botones del Drawer

  void onDrawerPressed(int indice) async {
    if (indice == 0) {
      Navigator.pop(context);
    } else if (indice == 1) {
      Navigator.of(context).pushNamed("/settingsview");
    } else if (indice == 2) {
      TextEditingController _searchController = TextEditingController();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Busca un post")),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Introduzca el titulo de un post",
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      String searchValue = _searchController.text.trim();
                      if (searchValue.isNotEmpty) {
                        Navigator.of(context).pop();

                        List<Map<String, dynamic>> searchResults =
                        await DataHolder().fbadmin.buscarPostPorTitulo(searchValue);

                        if (searchResults.isNotEmpty) {
                          showResultsDialog(context, searchResults);
                        } else {
                          showNoResultsDialog(context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      //primary: Theme.of(context).colorScheme.primary,
                      //onPrimary: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Text("Buscar"),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
    else if (indice == 3) {
      DataHolder().fbadmin.cerrarSesion();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const LoginView()),
        ModalRoute.withName("/loginview"),
      );
    }
  }

  static void showResultsDialog(BuildContext context, List<Map<String, dynamic>> searchResults) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("Resultados")),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var result in searchResults)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Título: ${result['title']}'),
                      Text('Cuerpo: ${result['body']}'),
                      Divider(),
                    ],
                  ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    // primary: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text("Aceptar"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showNoResultsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("Resultados de la búsqueda")),
          content: Text("No se encontraron resultados"),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  // primary: Theme.of(context).colorScheme.primary,
                ),
                child: Text("Aceptar"),
              ),
            ),
          ],
        );
      },
    );
  }

  // Gestion de el cambio de imagen de perfil

  void onDrawerProfilePressed() {
    Navigator.of(context).pushNamed("/profileimagechangeview");
  }

  // Gestion de los botones del BottomMenu

  void onBottomMenuPressed(int indice) {
    setState(() {
      if (indice == 0) {
        blIsList = true;
      } else if (indice == 1) {
        blIsList = false;
      } else if (indice == 2) {
        SystemNavigator.pop(); // Cerrar la aplicación
      }
    });
  }

  // Gestiona el click del post

  void onPostPressed(int index) {
    DataHolder().selectedPost = posts[index];
    Navigator.of(context).pushNamed("/postview");
  }

  // Gestiona el click mantenido del post

  void onPostLongPressed(int index) {
    DataHolder().selectedPost = posts[index];
    Navigator.of(context).pushNamed("/posteditview");
  }

  // Creador de items en forma de celda

  Widget? itemGridBuilder(BuildContext context, int index) {
    return PostGridView(
        sTitle: posts[index].title,
        sBody: posts[index].body,
        iPosicion: index,
        fOnItemTap: onPostPressed,
        fOnItemLongPressed: onPostLongPressed
    );
  }

  // Creador de items en forma de lista

  Widget? itemListBuilder(BuildContext context, int index) {
    return PostListView(
        sTitle: posts[index].title,
        sBody: posts[index].body,
        iPosicion: index,
        fOnItemTap: onPostPressed,
        fOnItemLongPressed: onPostLongPressed
    );
  }

  // Creador del separador de lista

  Widget separadorLista(BuildContext context, int index) {
    return Divider(
      thickness: 2,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  // Llena la lista de posts

  Future<void> cargarPosts() async {
    futurePosts = DataHolder().fbadmin.descargarPosts();
    List<FbPost> listaPosts = await futurePosts;
    setState(() {
      posts.clear();
      posts.addAll(listaPosts);
    });

  }

  // Cambia entre ListView o GridView

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
}
