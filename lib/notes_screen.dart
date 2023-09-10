import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:note_app/add_notes_screen.dart';
import 'package:note_app/edit_screen.dart';
import 'package:note_app/note_database.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  MyDatabaseWithSqfLite sqlDb = MyDatabaseWithSqfLite();
  Future<List> getDataFromDataBase() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    return response;
  }

  DateTime date=DateTime.now();
  bool isTrue=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AddNotesScreen()));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text(
            "Notes Page",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        body:
        ListView(
          children: [
           isTrue?
            FutureBuilder(
                future: getDataFromDataBase(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: Text("${snapshot.data![index]['date']}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          sqlDb.deleteData(
                                              "DELETE FROM notes WHERE (id=${snapshot.data![index]['id']})");
                                        });
                                      },
                                      icon: const Icon(Icons.delete,color: Colors.red,)),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditNotesScreen(
                                                        note:
                                                            '${snapshot.data![index]['note']}',
                                                        hint:
                                                            '${snapshot.data![index]['hint']}',
                                                        date:
                                                            '${snapshot.data![index]['date']}',
                                                        id: snapshot
                                                            .data![index]['id'],
                                                      )));
                                        });
                                      },
                                      icon: const Icon(Icons.update,color: Colors.blue,)),
                                ],
                              ),
                              title: Text("${snapshot.data![index]['note']}"),
                              subtitle:
                                  Text("${snapshot.data![index]['hint']}"),
                            ),
                          );
                        });
                  } else {
                    return const SizedBox();
                  }
                }):Center(child: CircularProgressIndicator(),)
          ],
        ));
  }
}
