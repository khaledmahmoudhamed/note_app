import 'package:flutter/material.dart';
import 'package:note_app/note_database.dart';

import 'notes_screen.dart';

class EditNotesScreen extends StatefulWidget {
  const EditNotesScreen({super.key,required this.note,required this.hint,required this.date, required this.id});


  final String note;
  final String hint;
  final String date;
  final int id;
  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {



  MyDatabaseWithSqfLite sqlDb = MyDatabaseWithSqfLite();
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController hintController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  checkDataValid() {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      print("Valid");
    } else {
      print("Not Valid");
    }
  }

  @override
  void initState() {
    widget.id;
    noteController.text=widget.note;
    dateController.text=widget.date;
    hintController.text=widget.hint;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Add Notes Page",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: noteController,
                validator: (note) {
                  if (note!.isEmpty) {
                    return "Note Must Not Be Empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'note content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                      hintText: 'date time',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  validator: (date) {
                    if (date!.isEmpty) {
                      return "Date Must Not Be Empty";
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: hintController,
                  decoration: InputDecoration(
                      hintText: 'hint content',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  validator: (hint) {
                    if (hint!.isEmpty) {
                      return "Hint Must Not Be Empty";
                    }
                    return null;
                  }),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      sqlDb.insertData(
                          '''
                          UPDATE notes SET 
                           note ='${noteController.text}',
                           hint='${hintController.text}',
                           date='${dateController.text}'
                           WHERE id='${widget.id}'
                           ''');
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const NotesScreen()));
                    } else {
                      return;
                    }
                    // checkDataValid();
                  },
                  child: const Text(
                    "Update Note",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
