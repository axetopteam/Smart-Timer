import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/core/app_theme/app_theme.dart';
import 'package:smart_timer/main.dart';
import 'package:smart_timer/routes/router_interface.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  AppTheme get theme => GetIt.I<AppTheme>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amberAccent,
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 168),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  'EASY\nTIMER',
                  style: theme.textTheme.headline1,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  buildContainer(
                    title: 'AMRAP',
                    color: theme.colorScheme.amrapColor,
                    onPressed: () {
                      getIt.get<RouterInterface>().showAmrap();
                    },
                  ),
                  const SizedBox(width: 10),
                  buildContainer(
                    title: 'FOR TIME',
                    color: theme.colorScheme.afapColor,
                    onPressed: () {
                      getIt.get<RouterInterface>().showAfap();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  buildContainer(
                    title: 'EMOM',
                    color: theme.colorScheme.emomColor,
                    onPressed: () {
                      getIt.get<RouterInterface>().showEmom();
                    },
                  ),
                  const SizedBox(width: 10),
                  buildContainer(
                    title: 'TABATA',
                    color: theme.colorScheme.tabataColor,
                    onPressed: () {
                      getIt.get<RouterInterface>().showTabata();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  buildContainer(
                    title: '1 : 1',
                    color: theme.colorScheme.workRestColor,
                    onPressed: () {
                      getIt.get<RouterInterface>().showWorkRest();
                    },
                  ),
                  const SizedBox(width: 10),
                  buildContainer(
                    title: 'CUSTOM',
                    color: theme.colorScheme.customColor,
                    onPressed: () {
                      getIt.get<RouterInterface>().showCustomSettings();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer({required Color color, required String title, Function? onPressed}) {
    return GestureDetector(
      onTap: () => onPressed?.call(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: theme.textTheme.headline2,
        ),
      ),
    );
  }
}
