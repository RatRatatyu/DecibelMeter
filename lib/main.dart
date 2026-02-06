import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sound_metter/screens/mainScr.dart';
import 'package:sound_metter/state/noisePrividerState.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    ChangeNotifierProvider(
        create: (_) => NoiseProvider(),
        child: const MyApp()
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(0xFF1B1D1C),
      ),
      home:  MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}


class _MyHomePage extends State<MyHomePage> {
  bool micGranted = false;

  @override
  void initState() {
    super.initState();
    requestMicPermission();
  }


  Future<void> requestMicPermission() async {
    final status = await Permission.microphone.request();

    setState(() {
      micGranted = status.isGranted;
    });

    if (!micGranted) {
      Future.microtask(() => showMicDialog());
    }

    if (status.isPermanentlyDenied) {
      Future.microtask(() => showMicDialog());
    }
  }

  void showMicDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Need Permission"),
          content: Text("The app needs access to the microphone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: Text("OK"),
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Canсel")
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
        body: MainScreen()
    );
  }
}



