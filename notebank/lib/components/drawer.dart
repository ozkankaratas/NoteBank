// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:notebank/components/drawer_tile.dart';
import 'package:notebank/pages/setttings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // başlık
           Padding(
             padding: const EdgeInsets.only(top: 80, bottom: 20),
             child: Image.asset('assets/icons/note.png'),
           ),

          const SizedBox(height: 25),

          // Notlarım başlığı
          DrawerTile(
            title: "N O T L A R",
            leading:const Icon(Icons.edit), 
            onTap:() => Navigator.pop(context),
          ),

          // Ayarlar kısmı
          DrawerTile(
            title: "A Y A R L A R",
            leading:const Icon(Icons.settings), 
            onTap:() {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          )
        ],
      )
    );
  }
}