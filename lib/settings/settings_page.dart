import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/core/app_theme/theme.dart';
import 'package:smart_timer/core/context_extension.dart';

import 'support.dart/application_support.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: CupertinoListSection(
        header: const Text('GENERAL'),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.color.containerBackground,
        ),
        children: [
          CupertinoListTile(
            title: Text('Rate Us'),
            leading: const Icon(CupertinoIcons.star_fill),
            // onTap: () {},
          ),
          CupertinoListTile(
            title: const Text('Contact Us'),
            leading: const Icon(CupertinoIcons.at),
            onTap: () => ApplicationSupport.showSupportDialog(context),
          ),
        ],
      ),
    );
  }
}
