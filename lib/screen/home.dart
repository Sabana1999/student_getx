import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:student_getx/func/dbfun.dart';
import 'package:student_getx/screen/add.dart';
import 'package:student_getx/screen/list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String studentCountText = '';

  @override
  void initState() {
   controller.getStudents();
    super.initState();
  }
//obj of dbfn clss
  final controller = Get.put(DbFunctions());

  @override
  Widget build(BuildContext context) {

        return  Scaffold(
      



          backgroundColor: Colors.white,
        appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
        elevation: 8,
        shadowColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.home),
          color: Colors.white,
        ),
        title: Text('STUDENT REGISTER',
            style: GoogleFonts.orbitron(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        centerTitle: true,
      ),

    
        body:  SingleChildScrollView(
          
          child: Padding(
            
            padding: const EdgeInsets.only(left:110.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
    
                const SizedBox(height: 30,),
                //option 1
                InkWell(overlayColor:  MaterialStatePropertyAll(Colors.teal),
                  onTap: () => Get.to(AddPage(isEdit: false)),
                  child: Card(
                    
                    
                    elevation: 15,
                    shadowColor: Colors.teal,
                    surfaceTintColor: Colors.teal,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: Colors.teal,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add,color: Colors.white,),
        Text(
          "Add",
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
      ],
    ),
  ],
)

                    ),
                  ),
                ),
        
                const SizedBox(height: 40,),
        
                //option 2
                InkWell(overlayColor:  MaterialStatePropertyAll(Colors.teal),
                 onTap:()=> Get.to(const StudentList()),
                  child: Card(
                    elevation: 15,
                    shadowColor: Colors.teal,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: Colors.teal,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:Row(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.account_circle,color: Colors.white,),
        Text(
          "Details",
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
      ],
    ),
  ],
)

                    ),
                  ),
                )
    
    
             
              ],
            ),
          ),
        ),
      );
  }
}