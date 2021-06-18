import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
class usuario_providers{
List<Usuario>  usuarios=[];

usuario_providers(){
  cargar_usuarios();
}


void cargar_usuarios(){
   rootBundle.loadString('assets/usuarios.json').then(
       (data){
         var tagObjsJson = jsonDecode(data)['usuarios'] as List;
         usuarios = tagObjsJson.map((tagJson) => Usuario.fromJson(tagJson)).toList();
         print(usuarios[0]);
       }
   );
}


}


class Usuario {
  String name;
  String password;

  Usuario(this.name, this.password);

  factory Usuario.fromJson(dynamic json) {
    return Usuario(json['name'] as String, json['password'] as String);
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.password} }';
  }
}


final user_providers=new usuario_providers();