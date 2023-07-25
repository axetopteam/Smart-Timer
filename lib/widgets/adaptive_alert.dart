import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

class DialogAction {
  DialogAction({
    required this.actionTitle,
    required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
  });
  final String actionTitle;
  final VoidCallback onPressed;
  final bool isDefaultAction;
  final bool isDestructiveAction;
}

class AdaptiveDialog extends StatelessWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? content,
    bool useRootNavigator = false,
    bool closeDialogOnButtonPress = false,
    List<DialogAction>? actions,
    bool barrierDismissible = false,
    bool showDefaultAction = true,

    ///if actions is null, close dialog action will be showed
  }) {
    final isIOS = Platform.isIOS;
    final dialog = AdaptiveDialog(
      title: title,
      content: content,
      actions: actions,
      showDefaultAction: showDefaultAction,
      closeDialogOnButtonPress: closeDialogOnButtonPress,
    );

    if (isIOS) {
      return showCupertinoDialog<T>(
        context: context,
        useRootNavigator: useRootNavigator,
        builder: (ctx) => dialog,
        barrierDismissible: barrierDismissible,
      );
    } else {
      return showDialog<T>(
        context: context,
        useRootNavigator: useRootNavigator,
        builder: (ctx) => dialog,
        barrierDismissible: barrierDismissible,
      );
    }
  }

  final String? title;
  final String? content;
  final List<DialogAction>? actions;
  final bool showDefaultAction;
  final bool closeDialogOnButtonPress;

  ///if actions is null, close dialog action will be showed

  const AdaptiveDialog({
    this.title,
    this.content,
    this.actions,
    this.showDefaultAction = true,
    this.closeDialogOnButtonPress = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actionsCopy = actions;
    final List<Widget> actionButtons;
    final isIOS = Platform.isIOS;
    if (isIOS) {
      actionButtons = actionsCopy != null
          ? actionsCopy
              .map((action) => CupertinoDialogAction(
                    onPressed: () {
                      action.onPressed();
                      if (closeDialogOnButtonPress) {
                        Navigator.of(context).pop();
                      }
                    },
                    isDefaultAction: action.isDefaultAction,
                    isDestructiveAction: action.isDestructiveAction,
                    child: Text(action.actionTitle),
                  ))
              .toList()
          : showDefaultAction
              ? [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDefaultAction: true,
                    child: Text(LocaleKeys.close.tr()),
                  )
                ]
              : [];
    } else {
      actionButtons = actionsCopy != null
          ? actionsCopy
              .map(
                (action) => TextButton(
                  child: Text(action.actionTitle),
                  onPressed: () {
                    action.onPressed();
                    if (closeDialogOnButtonPress) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              )
              .toList()
          : showDefaultAction
              ? [
                  TextButton(
                    child: Text(
                      tr('ok'),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ]
              : [];
    }

    final dialog = isIOS
        ? CupertinoAlertDialog(
            title: buildTitle(),
            content: content != null ? Text(content!) : null,
            actions: actionButtons,
          )
        : AlertDialog(
            title: buildTitle(),
            content: content != null
                ? Text(
                    content!,
                    textAlign: TextAlign.center,
                  )
                : null,
            actions: actionButtons,
            actionsAlignment: MainAxisAlignment.spaceAround,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          );
    return dialog;
  }

  Widget? buildTitle() {
    return title != null
        ? Text(
            title!,
            textAlign: TextAlign.center,
          )
        : null;
  }
}
