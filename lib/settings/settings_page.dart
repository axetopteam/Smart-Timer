import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/purchasing/premium_state.dart';
import 'package:smart_timer/utils/utils.dart';

import 'settings_state.dart';
import 'support.dart/application_support.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _state = SettingsState();
  late final PremiumState premiumState;

  @override
  void initState() {
    premiumState = context.read<PremiumState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _generalBlock(),
          _planBlock(),
          _soundBlock(),
          _legalBlock(),
        ],
      ),
    );
  }

  Widget _generalBlock() {
    return CupertinoListSection.insetGrouped(
      backgroundColor: context.color.background,
      header: Text(
        'GENERAL',
        style: context.textTheme.titleMedium?.copyWith(color: context.color.secondaryText),
      ),
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      decoration: BoxDecoration(
        color: context.color.containerBackground,
      ),
      children: [
        CupertinoListTile.notched(
          title: Text('Rate Us'),
          leading: const Icon(CupertinoIcons.star_fill),
          // onTap: () {},
        ),
        CupertinoListTile.notched(
          title: const Text('Contact Us'),
          leading: const Icon(CupertinoIcons.at),
          onTap: () => ApplicationSupport.showSupportDialog(context),
        ),
      ],
    );
  }

  Widget _planBlock() {
    return CupertinoListSection.insetGrouped(
      backgroundColor: context.color.background,
      header: Text(
        'PLAN',
        style: context.textTheme.titleMedium?.copyWith(color: context.color.secondaryText),
      ),
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      decoration: BoxDecoration(
        color: context.color.containerBackground,
      ),
      children: [
        CupertinoListTile.notched(
          title: const Text('Purchase Plan'),
          leading: const Icon(CupertinoIcons.star_circle_fill),
          onTap: () {},
        ),
        CupertinoListTile.notched(
          title: const Text('Plan'),
          leading: const Icon(CupertinoIcons.check_mark_circled),
          trailing: Observer(builder: (ctx) {
            return Container(
              padding: const EdgeInsets.fromLTRB(6, 2, 6, 4),
              decoration: BoxDecoration(
                color: premiumState.isPremiumActive ? context.color.premium : context.color.warning,
                borderRadius: BorderRadius.circular(6),
              ),
              child: premiumState.isPremiumActive ? Text('Active') : Text('Inactive'),
            );
          }),
        ),
        CupertinoListTile.notched(
          title: const Text('Restore Purchases'),
          leading: const Icon(Icons.cloud_download),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _soundBlock() {
    return CupertinoListSection.insetGrouped(
      header: Text(
        'SOUND',
        style: context.textTheme.titleMedium?.copyWith(color: context.color.secondaryText),
      ),
      backgroundColor: context.color.background,
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.color.containerBackground,
      ),
      children: [
        CupertinoListTile.notched(
          title: Text('Sound On'),
          leading: const Icon(CupertinoIcons.speaker_3_fill),
          trailing: Observer(
            builder: (context) {
              final soundOn = _state.soundOn;
              if (soundOn != null) {
                return CupertinoSwitch(
                  value: soundOn,
                  onChanged: (value) {
                    _state.saveSoundOn(value);
                  },
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _legalBlock() {
    return CupertinoListSection.insetGrouped(
      header: Text(
        'LEGAL',
        style: context.textTheme.titleMedium?.copyWith(color: context.color.secondaryText),
      ),
      backgroundColor: context.color.background,
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.color.containerBackground,
      ),
      children: [
        CupertinoListTile.notched(
          title: Text('Privacy Policy'),
          leading: const Icon(CupertinoIcons.checkmark_shield_fill),
          onTap: () => AppUtils.tryLaunchUrl('https://axetop.dev/privacy'),
        ),
        CupertinoListTile.notched(
          title: Text('Terms of Use'),
          leading: const Icon(CupertinoIcons.doc_plaintext),
          onTap: () => AppUtils.tryLaunchUrl('https://axetop.dev/terms'),
        ),
      ],
    );
  }
}
