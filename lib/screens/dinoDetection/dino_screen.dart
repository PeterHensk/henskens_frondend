import '../shares/bottomNavigation.dart';
import 'ArDinoPage.dart';
import 'package:flutter/material.dart';
import '../../plugins/wikitude_plugin.dart';
import '../../plugins/wikitude_response.dart';

class ArPage extends StatefulWidget {
  const ArPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<ArPage> {
  List<String> features = ["image_tracking"];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Flutter AR App"),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: navigateToDinos, child: const Text("Scan de dino's!")),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _selectedIndex,
        ));
  }

  void navigateToDinos() {
    debugPrint("Wij gaan naar dino's");

    checkDeviceCompatibility().then((value) => {
          if (value.success)
            {
              requestARPermissions().then((value) => {
                    if (value.success)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArDinoPage()),
                        )
                      }
                    else
                      {
                        debugPrint("AR permissions denied"),
                        debugPrint(value.message)
                      }
                  })
            }
          else
            {debugPrint("Device incompatible"), debugPrint(value.message)}
        });
  }

  Future<WikitudeResponse> checkDeviceCompatibility() async {
    return await WikitudePlugin.isDeviceSupporting(features);
  }

  Future<WikitudeResponse> requestARPermissions() async {
    return await WikitudePlugin.requestARPermissions(features);
  }
}
