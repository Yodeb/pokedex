import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex/pages/Img.dart';
import 'package:http/http.dart' as http;

class homePage extends StatefulWidget {
  static const String route = "/home";
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late Future<List<String>> _listadoImg;

  void _getImgs() async {
    final response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=151"));

    List<String> imgs = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData["data"]) {
        imgs.add(String.fromCharCode(item["title"]));
      }
    } else {
      throw Exception('Falló la conexión');
    }
  }

  @override
  void initState() {
    super.initState();
    _getImgs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex Regional de Kanto"),
      ),
      body: FutureBuilder(
        future: _listadoImg,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return GridView.count(
              crossAxisCount: 2,
              children: _listImgs (snapshot.data),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error");
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> _listImgs(List<String>? data) {
    List<Widget> imgs = [];
    return imgs;
  }
}
