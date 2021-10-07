import 'package:flutter/material.dart';
import 'package:smart_timer/main.dart';
import 'package:smart_timer/pages/tabata_settings_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: const Text('Smart Timer'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildContainer(title: 'AMRAP', color: Colors.amber),
                buildContainer(title: 'FOR TIME', color: Colors.pink),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildContainer(title: 'EMOM', color: Colors.indigoAccent),
                buildContainer(
                    title: 'TABATA',
                    color: Colors.green,
                    onPressed: () {
                      router.showTabataSettings();
                    }),
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
