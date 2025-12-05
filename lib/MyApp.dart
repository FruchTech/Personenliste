import 'package:flutter/material.dart';
import 'package:flutter_application_2/myRouter.dart';
import 'package:flutter_application_2/pages/StartPageState.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: MyRouter.routes,
      initialRoute: MyRouter.STARTINGPAGE,
      home: StartPage()
    );
  }
}
