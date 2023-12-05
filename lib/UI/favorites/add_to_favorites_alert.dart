import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

typedef OnSaveFavorite = Future<void> Function({required String name, required String description});

class AddToFavoritesAlert extends StatefulWidget {
  static Future<void> show(BuildContext context, {required OnSaveFavorite addToFavorites}) {
    return showAdaptiveDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return AddToFavoritesAlert(
            addToFavorites: addToFavorites,
          );
        });
  }

  const AddToFavoritesAlert({super.key, required this.addToFavorites});
  final OnSaveFavorite addToFavorites;

  @override
  State<AddToFavoritesAlert> createState() => _AddToFavoritesAlertState();
}

class _AddToFavoritesAlertState extends State<AddToFavoritesAlert> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(LocaleKeys.favorites_add_title.tr()),
      ),
      content: Column(
        children: [
          CupertinoTextField(
            controller: _nameController,
            placeholder: LocaleKeys.favorites_name.tr(),
          ),
          const SizedBox(height: 12),
          CupertinoTextField(
            controller: _descriptionController,
            placeholder: LocaleKeys.favorites_description.tr(),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          isDestructiveAction: true,
          child: Text(LocaleKeys.cancel.tr()),
        ),
        CupertinoDialogAction(
          onPressed: () async {
            final navigator = Navigator.of(context);
            await widget.addToFavorites(name: _nameController.text, description: _descriptionController.text);
            navigator.pop();
          },
          child: Text(LocaleKeys.save.tr()),
        ),
      ],
    );
  }
}
