import 'package:flutter/material.dart';
import 'package:maid/pages/session_page.dart';
import 'package:maid/static/generation_manager.dart';
import 'package:maid/static/host.dart';
import 'package:maid/widgets/chat_widgets/chat_ui.dart';
import 'package:maid/widgets/settings_widgets/maid_text_field.dart';

import 'package:system_info2/system_info2.dart';

import 'package:maid/pages/character_page.dart';
import 'package:maid/pages/model_page.dart';
import 'package:maid/pages/settings_page.dart';
import 'package:maid/pages/about_page.dart';


class MaidHomePage extends StatefulWidget {
  final String title;

  const MaidHomePage({super.key, required this.title});

  @override
  MaidHomePageState createState() => MaidHomePageState();
}

class MaidHomePageState extends State<MaidHomePage> {
  static int ram = SysInfo.getTotalPhysicalMemory() ~/ (1024 * 1024 * 1024);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              ram == -1 ? 'RAM: Unknown' : 'RAM: $ram GB',
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    Color.lerp(Colors.red, Colors.green, ram.clamp(0, 8) / 8) ??
                        Colors.red,
                fontSize: 15,
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            ListTile(
              leading: Icon(Icons.person,
                  color: Theme.of(context).colorScheme.onPrimary),
              title: Text(
                'Character',
                style: Theme.of(context).textTheme.labelLarge),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CharacterPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.chat_rounded,
                  color: Theme.of(context).colorScheme.onPrimary),
              title: Text(
                'Sessions',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SessionPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_tree_rounded,
                  color: Theme.of(context).colorScheme.onPrimary),
              title: Text(
                'Model',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ModelPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color: Theme.of(context).colorScheme.onPrimary),
              title: Text('Settings',
                  style: Theme.of(context).textTheme.labelLarge),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info,
                  color: Theme.of(context).colorScheme.onPrimary),
              title:
                  Text('About', style: Theme.of(context).textTheme.labelLarge),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              },
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            SwitchListTile(
              title: const Text('Local / Remote'),
              value: GenerationManager.remote,
              onChanged: (value) {
                setState(() {
                  GenerationManager.remote = value;
                });
              },
            ),
            if (GenerationManager.remote)
              MaidTextField(
                headingText: 'URL', 
                labelText: 'URL',
                initialValue: Host.url,
                onChanged: (value) {
                  Host.url = value;
                },
              ),
          ],
        ),
      ),
      body: const ChatUI()
    );
  }
}