


// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:notebank/components/drawer.dart';
import 'package:notebank/components/note_tile.dart';
import 'package:notebank/models/note_database.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class notes_Page extends StatefulWidget {
  const notes_Page({super.key});

  @override
  State<notes_Page> createState() => _notes_PageState();
}

class _notes_PageState extends State<notes_Page> {
  // text controller
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  // not olusturmak
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(
          controller: textController,
        ),
        actions: [
          // buton yap
          MaterialButton(
            onPressed: () {
              // veritabanina ekle
              context.read<NoteDatabase>().addNote(textController.text);

              // kontrolcüyü temizle
              textController.clear();

              // dialogBox kapat
              Navigator.pop(context);
            },
            child: const Text("Oluştur"),
          )
        ],
      ),
    );
  }

  // notu okumak
  void readNotes(){
    context.read<NoteDatabase>().fetchNotes();
  }

  // notu guncellemek
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Notu Güncelle"),
        content: TextField(controller: textController),
        actions: [
          // güncelle butonu
          MaterialButton(
            onPressed: (){
              // notu veritabanında güncelle
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              // kontrolcüyü temizle
              textController.clear();
              // dialog box kapat
              Navigator.pop(context);
            },
            child: const Text("Güncelle"),
                )
              ],
            ));
  }

  // notu silmek
  void deleteNote(int id){
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {

    // note veritabanı
    final noteDatabase = context.watch<NoteDatabase>();

    // mevcut notlar
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary ,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add, 
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer:const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BASLIK
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 20, bottom: 10),
            child: Text(
              'Notlar',
              style: TextStyle(
                fontFamily: 'DMSerifText',
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),
          ),



          // NOTLAR LISTESI
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
          
                final note = currentNotes[index];
          
                return NoteTile(
                  text: note.text,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note.id),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
