import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../FiresotreObjets/FbUsuario.dart';


class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  Position? _ubicacionActual;
  late GoogleMapController _controller;
  Set<Marker> marcadores = {};
  FirebaseFirestore db = FirebaseFirestore.instance;
  final Map<String, FbUsuario> tablaUsuarios = {};
  CameraPosition? _kUser;

  @override
  void initState() {
    obtenerUbicacionActual();
    suscribirADescargaUsuarios();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> obtenerUbicacionActual() async {
    final posicion = await Geolocator.getCurrentPosition();
    setState(() {
      _ubicacionActual = posicion;
      _kUser = CameraPosition(
        target: LatLng(
          _ubicacionActual!.latitude,
          _ubicacionActual!.longitude,
        ),
        zoom: 15.0,
      );
    });
  }

  void suscribirADescargaUsuarios() async {
    CollectionReference<FbUsuario> ref = db.collection("Users")
        .withConverter(
      fromFirestore: FbUsuario.fromFirestore,
      toFirestore: (FbUsuario post, _) => post.toFirestore(),
    );
    ref.snapshots().listen(usuariosDescargados, onError: descargaUsuariosError);
  }

  void usuariosDescargados(QuerySnapshot<FbUsuario> usuariosDescargados) {
    print("NUMERO DE USUARIOS ACTUALIZADOS>>>> ${usuariosDescargados.docChanges
        .length}");

    Set<Marker> marcTemp = {};

    for (int i = 0; i < usuariosDescargados.docChanges.length; i++) {
      FbUsuario temp = usuariosDescargados.docChanges[i].doc.data()!;
      tablaUsuarios[usuariosDescargados.docChanges[i].doc.id] = temp;

      if (_ubicacionActual != null) {
          Marker marcadorTemp = Marker(
          markerId: MarkerId(usuariosDescargados.docChanges[i].doc.id),
          position: LatLng(temp.geoloc.latitude, temp.geoloc.longitude),
          infoWindow: InfoWindow(
            title: temp.name,
            snippet: '@${temp.username}'
          ),
        );
        marcTemp.add(marcadorTemp);
      }
    }

    if (mounted) {
      setState(() {
        marcadores.addAll(marcTemp);
      });
    }
  }

  void descargaUsuariosError(error) {
    print("Listen failed: $error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
            "M A P S",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: _ubicacionActual != null
              ? GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                    _ubicacionActual!.latitude,
                    _ubicacionActual!.longitude,
                    ),
                  zoom: 15.0,
                  ),
                onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                },
                markers: marcadores,
                )
              :  CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                    strokeWidth: 6.0,
                  ),
        ),
      ),
    );
  }
}