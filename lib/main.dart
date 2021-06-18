import 'package:flutter/material.dart';
import 'package:pruebatrii/src/pages/login_page.dart';
import 'package:pruebatrii/src/pages/principal_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: getApplicationRoutes(),
    );
  }
}



Map<String, WidgetBuilder> getApplicationRoutes() {

  return <String, WidgetBuilder>  {
    '/'      : ( BuildContext context ) => MyDemo(),
    'main'  : ( BuildContext context ) => Principalpage(),
  };

}
