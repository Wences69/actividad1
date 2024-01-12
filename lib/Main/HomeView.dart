import 'package:actividad1/Custom/Widgets/CustomSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import '../Custom/Views/PostCellView.dart';
import '../Custom/Views/PostListCellView.dart';
import '../Custom/Widgets/CustomBottomMenu.dart';
import '../Custom/Widgets/CustomDrawer.dart';
import '../FiresotreObjets/FbPost.dart';
import '../OnBoarding/LoginView.dart';
import '../Singeltone/DataHolder.dart';
import 'SearchPostsView.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  final List<FbPost> posts = [];
  late Future<List<FbPost>> futurePosts;
  late Position position;
  late double temperatura;
  bool blIsList = true;
  List<FbPost> searchResults = [];

  @override
  void initState() {
    super.initState();
    cargarPosts();
    initData();
  }

  Future<void> initData() async {
    await determinarPosicionActual();
    await determinarTemperaturaActual();
    DataHolder().GPSSuscribeUser();
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
      mostrarCuadroDialogoBusqueda();
    } else if (indice == 3) {
      getTemperatura();
    } else if (indice == 4) {
      Navigator.of(context).popAndPushNamed("/mapview");
    } else if (indice == 5) {
      DataHolder().fbadmin.cerrarSesion();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const LoginView()),
        ModalRoute.withName("/loginview"),
      );
    }
  }

  void mostrarCuadroDialogoBusqueda() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Buscar Posts"),
          content: TextField(
            controller: _searchController,
            decoration: const InputDecoration(hintText: "Escribe algo aquí..."),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                if (await buscarPosts()) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchPostsView(searchResults: searchResults),
                    ),
                  );

                }
              },
              child: const Text("Buscar"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> buscarPosts() async {
    String postBuscar = _searchController.text;
    List<FbPost> results = await DataHolder().fbadmin.buscarPostPorTitulo(postBuscar);
    if (postBuscar.isNotEmpty) {
      if (results.isEmpty) {
        const CustomSnackbar(sMensaje: "No se encontraron resultados").show(context);
        return false;
      } else {
        setState(() {
          searchResults = results;
        });
        return true;
      }
    } else {
      const CustomSnackbar(sMensaje: "Por favor, escriba algo").show(context);
      return false;
    }
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
      color: Theme.of(context).colorScheme.primary
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

  Future<void> getTemperatura() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Temperatura actual"),
          content: Container(
            height: 80.0, // Ajusta la altura según tus necesidades
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Cargando..."),
                SizedBox(height: 10.0),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );

    try {
      await determinarTemperaturaActual();
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("TEMPERATURA ACTUAL"),
            content: Text("La temperatura en su ubicacion actual es de $temperatura ºC"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Volver"),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print("Error al obtener la temperatura: $error");
      Navigator.of(context).pop();
    }
  }
  Future<void> determinarPosicionActual() async {
    final positionTemp = await DataHolder().geolocAdmin.determinePosition();
    setState(() {
      position = positionTemp;
    });
  }

  Future<void> determinarTemperaturaActual() async {
    await determinarPosicionActual();
    temperatura = await DataHolder().httAdmin.getTemByGeoloc(position.latitude, position.longitude);
  }
}