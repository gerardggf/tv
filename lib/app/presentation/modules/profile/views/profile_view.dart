import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/theme_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();
    final bool darkMode = themeController.darkMode;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Dark mode'),
                value: darkMode,
                onChanged: (value) {
                  themeController.onChanged(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
