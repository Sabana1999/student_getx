import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_getx/func/studentm.dart';
import 'package:student_getx/screen/home.dart';

void main() async{

  
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(StudentModelAdapter());
  Hive.openBox<StudentModel>('student_db');
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black54),
          titleTextStyle: GoogleFonts.roboto(color: Colors.black54),
          elevation: 0
        ), colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal).copyWith(background: Colors.white)
      ),
      home: const HomePage(),
    );
  }
}