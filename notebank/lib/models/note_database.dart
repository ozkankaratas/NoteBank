import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notebank/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier{
  static late Isar isar;

  // I N I T I A L I Z E - D A T A B A S E
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }
  // NOTLARIN LISTESI
  final List<Note> currentNotes = [];

  // O L U S T U R - not olusturup veritabanina kaydetmek
  Future<void> addNote(String textFromUser) async{
    // yeni not objesi olustur
    final newNote = Note()..text = textFromUser;

    // veritabanina kaydet
    await isar.writeTxn(() => isar.notes.put(newNote));

    // veritabanindan yeniden oku
    fetchNotes();
  }

  // O K U - veritabanindaki notlari oku
  Future<void> fetchNotes() async{
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // G U N C E L L E - veritabanindaki notlari guncelle
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if(existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // D E L E T E - veritabanindaki notu sil
Future<void> deleteNote(int id) async {
  await isar.writeTxn(() => isar.notes.delete(id));
  await fetchNotes();
}

}