import 'package:flutter/material.dart';
import 'package:flutter_application_2/entities/Person.dart';
import 'package:file_picker/file_picker.dart';

class AddPersonPage extends StatefulWidget {
  const AddPersonPage({super.key});

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  final TextEditingController vornameCTRL = TextEditingController();
  final TextEditingController nachnameCTRL = TextEditingController();
  final TextEditingController emailCTRL = TextEditingController();
  final TextEditingController alterCTRL = TextEditingController();
  final TextEditingController pictureCTRL = TextEditingController();

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      setState(() {
        pictureCTRL.text = result.files.single.path!;
      });
    }
  }

  void addPerson(BuildContext context) {
    if (vornameCTRL.text.isEmpty ||
        nachnameCTRL.text.isEmpty ||
        emailCTRL.text.isEmpty ||
        alterCTRL.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Alle Felder müssen ausgefüllt sein!")),
      );
      return;
    }

    Person newPerson = Person(
      vorname: vornameCTRL.text,
      nachname: nachnameCTRL.text,
      email: emailCTRL.text,
      alter: int.parse(alterCTRL.text),
      picture: pictureCTRL.text, // egal ob leer → Person setzt default
    );

    Navigator.of(context).pop(newPerson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Person hinzufügen')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Vorname"),
              TextField(
                controller: vornameCTRL,
                decoration: const InputDecoration(hintText: "Vorname eingeben"),
              ),
              const SizedBox(height: 24),

              const Text("Nachname"),
              TextField(
                controller: nachnameCTRL,
                decoration: const InputDecoration(
                  hintText: "Nachname eingeben",
                ),
              ),
              const SizedBox(height: 24),

              const Text("E-Mail"),
              TextField(
                controller: emailCTRL,
                decoration: const InputDecoration(hintText: "E-Mail eingeben"),
              ),
              const SizedBox(height: 24),

              const Text("Alter"),
              TextField(
                controller: alterCTRL,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Alter eingeben"),
              ),
              const SizedBox(height: 24),

              const Text("Profilbild (URL oder Datei)"),
              TextField(
                controller: pictureCTRL,
                decoration: const InputDecoration(
                  hintText: "Profilbild-URL eingeben oder Datei wählen",
                ),
              ),

              const SizedBox(height: 12),

              // Bild auswählen Button
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Bild auswählen"),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () => addPerson(context),
                child: const Text("Hinzufügen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
