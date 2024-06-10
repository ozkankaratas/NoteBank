import 'package:isar/isar.dart';

// Bu satir dosya olusturmak icindir
// dart run build_runner build calistirin
part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}