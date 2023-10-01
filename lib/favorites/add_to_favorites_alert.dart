import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        child: Text('Save To Favorites'),
      ),
      content: Column(
        children: [
          CupertinoTextField(
            controller: _nameController,
            placeholder: 'Name',
          ),
          const SizedBox(height: 12),
          CupertinoTextField(
            controller: _descriptionController,
            placeholder: 'Description',
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
          isDestructiveAction: true,
        ),
        CupertinoDialogAction(
          child: Text('Save'),
          onPressed: () async {
            await widget.addToFavorites(name: _nameController.text, description: _descriptionController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
