import 'package:flutter/material.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/main.dart';
import 'package:smart_timer/routes/router_interface.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        // elevation: 0,
        title: const Text('Smart Timer'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildContainer(
                  title: 'AMRAP',
                  color: Colors.amber,
                  onPressed: () {
                    getIt.get<RouterInterface>().showAmrap();
                  },
                ),
                buildContainer(
                  title: 'FOR TIME',
                  color: Colors.pink,
                  onPressed: () {
                    getIt.get<RouterInterface>().showAfap();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildContainer(
                  title: 'EMOM',
                  color: Colors.indigoAccent,
                  onPressed: () {
                    getIt.get<RouterInterface>().showEmom();
                  },
                ),
                buildContainer(
                  title: 'TABATA',
                  color: Colors.green,
                  onPressed: () {
                    getIt.get<RouterInterface>().showTabata();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildContainer(
                  title: 'Custom',
                  color: Colors.deepOrangeAccent,
                  onPressed: () {
                    getIt.get<RouterInterface>().showCustomSettings();
                  },
                ),
                buildContainer(
                  title: '1:1',
                  color: Colors.purple,
                  onPressed: () {
                    getIt.get<RouterInterface>().showWorkRest();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildContainer({required Color color, required String title, Function? onPressed}) {
    return GestureDetector(
      onTap: () => onPressed?.call(),
      child: Container(
        width: 120,
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
