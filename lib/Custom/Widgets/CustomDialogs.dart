import 'package:flutter/material.dart';
import '../../Singeltone/DataHolder.dart';

class CustomDialogs {
  static void showSearchDialog(BuildContext context, TextEditingController _searchController) {
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
}

