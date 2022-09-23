import 'package:flutter/material.dart';
import 'package:flutter_course_autumn_2021/gen_l10n/app_localizations.dart';
import 'package:flutter_course_autumn_2021/ui/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('flutter'),
              accountEmail: Text('flutter@gmail.com'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.home),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.sections),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/settings'),
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.settings),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.email),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.password),
              obscureText: true,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(AppLocalizations.of(context)!.singin))
          ],
        ),
      ),
    );
  }
}
