import 'dart:ffi';

import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    final AuthService _auth = AuthService();
    return StreamProvider<List<Brew>?>.value(
      //initialData: QuerySnapshot(),
      initialData: [],
      value: DatabaseService(uid: '').brew,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Select'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
              ),
              label: Text('Log out'),
              // style: ButtonStyle(
              //     backgroundColor:
              //         MaterialStateProperty.all<Color>(Colors.white)),
            ),
            TextButton.icon(
              // style: ButtonStyle(
              //     backgroundColor:
              //         MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(
                Icons.settings,
              ),
              label: Text('settings'),
              autofocus: true,
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList()),
      ),
    );
  }
}
