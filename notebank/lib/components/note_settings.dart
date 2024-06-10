import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;

  const NoteSettings(
      {super.key, required this.onEditTap, required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // düzenleme için
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onEditTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: Center(
                child: Text(
              "Düzenle",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            )),
          ),
        ),

        // silmek için
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDeleteTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: Center(
                child: Text(
              "Sil",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            )),
          ),
        ),
      ],
    );
  }
}
