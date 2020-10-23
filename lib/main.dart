import 'package:flutter/material.dart';
import 'package:eventario/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:eventario/models/event_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> EventViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Home.id,
        routes: {
          Home.id : (context) => Home(),
        },
      )
    );
  }
}
