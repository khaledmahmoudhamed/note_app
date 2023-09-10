import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/add_notes_screen.dart';

import 'notes_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  // File? image;
  // Future uploadImage()async{
  //   ImagePicker imagePicker=ImagePicker();
  //   var pickedImage=await imagePicker.pickImage(source: ImageSource.camera);
  //   if(pickedImage !=null){
  //     image=File(pickedImage.path);
  //   }else{
  //
  //   }
  // }

  File? _image;

  // This is the image picker
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "Home Page",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


             const SizedBox(height: 20,),
             const CircleAvatar(
             radius: 120,
             child:Image(image: AssetImage('assets/note.png'))
            ),
            const SizedBox(height: 50,),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const NotesScreen()));
            }, child:const Text("Go To Notes Page",style: TextStyle(fontSize: 25),))
          ],
        ),
      ),
    );
  }
}
