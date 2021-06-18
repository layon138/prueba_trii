import 'package:flutter/material.dart';
import 'package:pruebatrii/src/providers/usuarios_providers.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class MyDemo extends StatefulWidget {
  @override
  _MyDemoState createState() => _MyDemoState();
}

class _MyDemoState extends State<MyDemo> {
  String _usuario="";
  String _password="";
   String validacion="";
  _onChanged(){
    rootBundle.loadString('assets/usuarios.json').then(
            (data){
          var tagObjsJson = jsonDecode(data)['usuarios'] as List;
          List<Usuario>  usuario = tagObjsJson.map((tagJson) => Usuario.fromJson(tagJson)).toList();
          print(this._usuario);
          usuario=usuario.where(
                  (x) => x.name.toLowerCase()== this._usuario.toLowerCase() && x.password.toLowerCase()== this._password.toLowerCase()
          ).toList();
          print(usuario.length);
            if (usuario.length==1) {
              Navigator.pushNamed(context, 'main');
            }else{
              print("No existe");
              this._mostrarAlert(context);
            }
        }
    );


  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor:  Colors.white,
        body: Center(
          child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10,top: 50,bottom: 15),
                    child:   Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 30,
                          color: const Color(0xffe6293f),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child:   Text(
                          "TU CORREO",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 40.0,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            print(value);
                            if (value!.isEmpty) {
                              print("entro");
                              this.validacion= 'Please enter some text';
                            }
                          },
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF2F2F2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(width: 40,color: Colors.red),
                            ),
                            hintText: "correo@correo.com",
                          ),
                          onChanged: (valor){

                            setState((){ // <--  this setState is un-recognizable by flutter ide
                              this._usuario=valor;
                            });
                          },
                        ),
                      ),
                      Text(this.validacion),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child:   Text(
                          "CONTRASEÑA",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 40.0,
                        child: TextField(
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF2F2F2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(width: 40,color: Colors.red),
                            ),
                            hintText: "*******",
                          ),
                          onChanged: (valor){
                            setState((){ // <--  this setState is un-recognizable by flutter ide
                              this._password=valor;
                            });
                          },
                        ),
                      ),
                      Boton1(
                        onChanged: _onChanged,
                        palabra: "Ingresar",
                      )
                    ],
                  )

                ],
              )
          ),
        )

    );
  }

  void _mostrarAlert(BuildContext context) {

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {

          return AlertDialog(
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
            title: Text(
                'Error',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Usuario o contraseña incorrecto')
              ]
            ),
          );

        }

    );


  }


// every method which changes state should exist within class only
  Widget _check(){
    return    Container(
      margin: EdgeInsets.all(10),
      height: 40.0,
      child: TextField(
        decoration: new InputDecoration(
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 40,color: Colors.red),
          ),
          hintText: "correo@correo.com",
        ),
        onChanged: (valor){
          setState(() {
            print("hola");
          });
        },
      ),
    );
  }

}



class Boton1 extends StatelessWidget {
  Boton1({required this.onChanged,required this.palabra});
  final GestureTapCallback  onChanged;
  final String  palabra;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10,
        left: 15,
        right: 15,
      ),
      child:   SizedBox(
        width: double.infinity,
        height: 45,// match_parent
        child: RaisedButton(
          child: Text(
            palabra,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          shape:  new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0),side: BorderSide(color: const Color(0xffe6293f))),
          onPressed: onChanged,
          highlightColor: Colors.black,
          color:const Color(0xffe6293f),//specify background color  of button from our list of colors
        ),
      ),
    );
  }
}