import 'package:flutter/material.dart';
import 'package:flutter_application_2/entities/Person.dart';
import 'package:flutter_application_2/pages/AddPersonPage.dart';
import 'package:flutter_application_2/pages/EditPersonPage.dart';
import 'package:flutter_application_2/pages/StartPageState.dart';

class MyRouter {
  static const String STARTINGPAGE = "/";
  static const String ADDPERSONPAGE = "/person/add";
  static const String EDITPERSONPAGE = "person/edit";

  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case STARTINGPAGE:
        {
          return MaterialPageRoute(builder: (context) => StartPage());
        }
      case ADDPERSONPAGE:
        {
          return MaterialPageRoute(builder: (context) => AddPersonPage());
        }
      case EDITPERSONPAGE:
        {
          Person p = settings.arguments as Person;
          return MaterialPageRoute(builder: (context) => EditPersonPage(p: p));
        }
      default:
        {
          return MaterialPageRoute(builder: (context) => StartPage());
        }
    }
  }
}
