import 'package:flutter/material.dart';
import 'package:note_app_class_version/controller/note_screen_controller.dart';
import 'package:note_app_class_version/view/note_screen/note_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteScreenController.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
          )),
      debugShowCheckedModeBanner: false,
      home: NoteScreen(),
    );
  }
}
