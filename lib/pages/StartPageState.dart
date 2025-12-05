import 'package:flutter/material.dart';
import 'package:flutter_application_2/entities/ImageProvider.dart';
import 'package:flutter_application_2/entities/Person.dart';
import 'package:flutter_application_2/pages/AddPersonPage.dart';
import 'package:flutter_application_2/pages/EditPersonPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StartPageState();
  }
}

class _StartPageState extends State<StartPage> {
  List<Person> personen = <Person>[
    Person(
      vorname: "Max",
      nachname: "Mustermann",
      email: "max.mustermann@example.com",
      alter: 56,
      picture: "",
    ),
    Person(
      vorname: "Erika",
      nachname: "Musterfrau",
      email: "erika.musterfrau@example.com",
      alter: 51,
      picture: "",
    ),
    Person(
      vorname: "Karl",
      nachname: "Klammer",
      email: "karl.klammer@example.com",
      alter: 25,
      picture: "",
    ),
    Person(
      vorname: "Peter",
      nachname: "Peterson",
      email: "peter.peterson@example.com",
      alter: 32,
      picture: "",
    ),
    Person(
      vorname: "Bernie",
      nachname: "Windows",
      email: "bernie.windows@example.com",
      alter: 82,
      picture: "",
    ),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> personJsons = <String>[];
    for (Person p in personen) {
      personJsons.add(p.toJSON());
    }
    prefs.setStringList("personen", personJsons);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? personJsons = prefs.getStringList("personen");
    if (personJsons != null) {
      personen = personJsons.map((json) => Person.fromJSON(json)).toList();
      setState(() {});
    }
  }

  ListView createListView() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: personen.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: getImageProvider(personen[index].picture),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${personen[index].vorname} ${personen[index].nachname} (${personen[index].alter})',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        personen[index].email,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () async {
                  final updatedPerson = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return EditPersonPage(p: personen[index]);
                      },
                    ),
                  );

                  if (updatedPerson == null) {
                    setState(() {
                      personen.removeAt(index);
                    });
                    setData();
                  } else {
                    setState(() {
                      personen[index] = updatedPerson;
                    });
                    setData();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.menu_open_rounded, size: 32.0),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  GestureDetector createButton() {
    return GestureDetector(
      onTap: () async {
        final newPerson = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPersonPage()),
        );

        if (newPerson != null) {
          setState(() {
            personen.add(newPerson);
          });
          setData();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Icon(
          Icons.add,
          size: 32.0,
          color: Color.fromARGB(255, 61, 138, 17),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              "Personalverwaltung",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
            ),
            Expanded(child: createListView()),
            createButton(),
          ],
        ),
      ),
    );
  }
}
