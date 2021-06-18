import 'package:flutter/material.dart';
import 'package:pruebatrii/src/models/api.dart';
import 'package:pruebatrii/src/providers/usuarios_providers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Principalpage extends StatefulWidget {
  @override
  _Principalpage createState() => _Principalpage();
}

class _Principalpage extends State<Principalpage> {
  String inputText="";
  List<digimon>  usuarios=[];
  List<digimon>  digimons=[];
  @override
  void initState() {
    super.initState();
    this.stackHelp1();
  }

  void stackHelp1() async {
    var url = 'https://digimon-api.vercel.app/api/digimon';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    print(response.body);
    var tagObjsJson = jsonDecode(response.body) as List;
    digimons=tagObjsJson.map((tagJson) => digimon.fromJson(tagJson)).toList();
    usuarios=digimons;
    this.stackHelp();
  }

  Future<List<digimon> > stackHelp() async {
    var url = 'https://digimon-api.vercel.app/api/digimon';
    print("entro");
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    print(response.body);
    var tagObjsJson = jsonDecode(response.body) as List;
    digimons=tagObjsJson.map((tagJson) => digimon.fromJson(tagJson)).toList();
    usuarios=digimons;
    this.stackHelp();
    usuarios=digimons.where(
            (x) => x.name.toLowerCase().contains(inputText.toLowerCase())
    ).toList();
      return usuarios;
  }

  @override
  Widget build(BuildContext context) {
    setState((){ // <--  this setState is un-recognizable by flutter ide
      this.stackHelp();
    });
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TextField(
            style: TextStyle(color: Colors.white),
              decoration: new InputDecoration(
                hintText: "Buscar digimon",
                hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white)
              ),
            onChanged: (text) {
              setState((){ // <--  this setState is un-recognizable by flutter ide
                print("Text $text");
                this.inputText=text;
              });

            },
          ),
        ),
        body:FutureBuilder(
            future: stackHelp(),
            builder:(context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.separated(
                        itemCount: usuarios.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                        return  GestureDetector(
                          onTap: (){
                            print("Container clicked");
                            this._mostrarAlert(context,usuarios[index]);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                              Text(usuarios[index].name),
                            Container(
                                  height: 50,
                                  child:  Image.network('${usuarios[index].img}'),
                                )
                              ],
                            )
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),

                );
              }
            }
        )
    );
  }

  void _mostrarAlert(BuildContext context,digimon digimonelegido) {

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {

          return AlertDialog(
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
            title: Text(
                '${digimonelegido.name}',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Nivel: ${digimonelegido.level}'),
                Container(
                  padding: EdgeInsets.all(5),
                  height: 150,
                  child:  Image.network('${digimonelegido.img}'),
                )
              ],
            ),
          );

        }

    );


  }
}

/*

class _Principalpage extends State<Principalpage> {

  List<digimon>  usuarios=[];
  Future<List<digimon> > stackHelp() async {
    var url = 'https://digimon-api.vercel.app/api/digimon';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
      print(response.body);
      var tagObjsJson = jsonDecode(response.body) as List;

      return usuarios=tagObjsJson.map((tagJson) => digimon.fromJson(tagJson)).toList();
  }

  @override
  Widget build(BuildContext context) {
    setState((){ // <--  this setState is un-recognizable by flutter ide
      this.stackHelp();
    });
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TextField(
            onChanged: (text) {
              print("Text $text");
              usuarios.where(
                      (x) => x.name.toLowerCase().contains(text.toLowerCase())
              ).toList();
            },
          ),
        ),
        body:FutureBuilder(
            future: stackHelp(),
            builder:(context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                    child: ListView.separated(
                        itemCount: usuarios.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                        return  GestureDetector(
                          onTap: (){
                            print("Container clicked");
                            this._mostrarAlert(context,usuarios[index]);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                              Text(usuarios[index].name),
                            Container(
                                  height: 50,
                                  child:  Image.network('${usuarios[index].img}'),
                                )
                              ],
                            )
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    )
                );
              }
            }
        )
    );
  }

  void _mostrarAlert(BuildContext context,digimon digimonelegido) {

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {

          return AlertDialog(
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
            title: Text('${digimonelegido.name}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Nivel: ${digimonelegido.level}'),
                Container(
                  height: 100,
                  child:  Image.network('${digimonelegido.img}'),
                )
              ],
            ),
          );

        }

    );


  }
}

 */


