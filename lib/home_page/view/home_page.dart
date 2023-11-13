import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../settings_page/settings_page.dart';

enum SortRequestType { creation, lastModified }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppWideConstants.appTitle),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
