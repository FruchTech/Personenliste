import 'package:flutter/material.dart';
import 'package:flutter_application_2/entities/Person.dart';
import 'package:file_picker/file_picker.dart';

class EditPersonPage extends StatelessWidget {
  EditPersonPage({super.key, required this.p}) {
    vornameCTRL.text = p.vorname;
    nachnameCTRL.text = p.nachname;
    emailCTRL.text = p.email;
    alterCTRL.text = p.alter.toString();
    pictureCTRL.text = p.picture;
  }

  final Person p;

  final TextEditingController vornameCTRL = TextEditingController();
  final TextEditingController nachnameCTRL = TextEditingController();
  final TextEditingController emailCTRL = TextEditingController();
  final TextEditingController alterCTRL = TextEditingController();
  final TextEditingController pictureCTRL = TextEditingController();

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      pictureCTRL.text = result.files.single.path!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Wenn Back gedrückt wird, Person behalten
      onWillPop: () async {
        Navigator.of(context).pop(p); // ursprüngliche Person zurückgeben
        return false; // verhindert das automatische Pop
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Person bearbeiten")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Vorname"),
                TextField(
                  controller: vornameCTRL,
                  decoration: InputDecoration(hintText: "Vorname eingeben"),
                ),

                SizedBox(height: 16),
                Text("Nachname"),
                TextField(
                  controller: nachnameCTRL,
                  decoration: InputDecoration(hintText: "Nachname eingeben"),
                ),

                SizedBox(height: 16),
                Text("E-Mail"),
                TextField(
                  controller: emailCTRL,
                  decoration: InputDecoration(hintText: "E-Mail eingeben"),
                ),

                SizedBox(height: 16),
                Text("Alter"),
                TextField(
                  controller: alterCTRL,
                  decoration: InputDecoration(hintText: "Alter eingeben"),
                ),

                SizedBox(height: 16),
                Text("Profilbild"),
                TextField(
                  controller: pictureCTRL,
                  decoration: InputDecoration(hintText: "E-Mail eingeben"),
                ),

                ElevatedButton.icon(
                  onPressed: pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text("Bild auswählen"),
                ),

                const Spacer(),
                Expanded(child: SizedBox()),

                ElevatedButton(
                  onPressed: () {
                    p.vorname = vornameCTRL.text;
                    p.nachname = nachnameCTRL.text;
                    p.email = emailCTRL.text;
                    p.alter = int.tryParse(alterCTRL.text) ?? p.alter;
                    p.picture = pictureCTRL.text;

                    Navigator.of(context).pop(p); // Änderungen speichern
                  },
                  child: Text("Änderungen Speichern"),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(null); // Person löschen
                  },
                  child: Text("Person löschen"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
