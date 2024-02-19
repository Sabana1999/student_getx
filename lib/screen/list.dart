import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:student_getx/func/dbfun.dart';
import 'package:student_getx/func/studentm.dart';
import 'package:student_getx/screen/add.dart';


class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {

  void initState(){
    super.initState();
    // controller.getStudents();
    // controller.studentCount();
    
  }

  final SearchController = TextEditingController();
  String searchText='';
  Timer? debouncer;

  final controller = Get.put(DbFunctions());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('STUDENT DETAILS',
            style: GoogleFonts.orbitron(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
      ),

      body:  SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 25),
              child: TextFormField(
                controller: SearchController,
                onChanged: (value) {
                  onSearchChange(value);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25)
                  )
                ),
              ),
            ),

            SizedBox(
              height: 600,
              child: controller.studentList.isEmpty? 
              Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No details found')
                ],
              ),)
              :Obx(
                ()=> ListView.separated(
                      itemBuilder: ((context,index){
                        final data = controller.studentList[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(), 
                            children:[
                              SlidableAction(onPressed: (context){
                                Get.to(AddPage(isEdit: true,stu: data,));
                              },icon: Icons.edit,backgroundColor: Colors.teal,),
                            ],
                            ),
                            startActionPane: ActionPane(
                              motion: const DrawerMotion(), 
                              children:[
                                SlidableAction(onPressed: (context){
                                 controller.deleteStudent(data.id!);
                                },icon: Icons.delete,backgroundColor: Colors.redAccent)
                              ]),
                          child: ListTile(
                            onTap: () {
                            detailsSheet(context, data.id!, data.photo, data.name, data.gender, data.domain, data.dob, data.mobile, data.email);
                            },
                            leading:  CircleAvatar(
                              radius: 40,
                              backgroundImage:FileImage(File(data.photo)) ,
                            ),
                            title: Text(data.name),
                            subtitle: Text(data.domain),
                          ),
                        );
                      }), 
                      separatorBuilder: ((context,index){
                        return const Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Divider(),
                        );
                      }),   
                      itemCount:controller.studentList.length),
              ),
            )
          ],
        ),
      ),
    );
  }

  void detailsSheet(BuildContext context,int id,String photo,String name,String gender,String domain,String dob,String mobile,String email){
    Get.bottomSheet(
      Card(
        elevation: 10,
        margin: const EdgeInsets.all(15),
        shadowColor: Colors.teal,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(70)),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 5,),
            CircleAvatar(
              radius: 40,
              backgroundImage: FileImage(File(photo)),
            ),
            Text("Name : $name",style: textStyle(),),
            Text("Gender : $gender",style: textStyle(),),
            Text("Domain : $domain",style: textStyle(),),
            Text("Date of birth : ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(dob))}",style: textStyle(),),
            Text("Mobile : $mobile",style: textStyle(),),
            Text("Email : $email",style: textStyle(),),
        
            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  onSearchChange(String value){
    final studendb = Hive.box<StudentModel>('student_db');
    final students = studendb.values.toList();
    value = SearchController.text;

    if(debouncer?.isActive ?? false) debouncer?.cancel();
    debouncer = Timer(const Duration(milliseconds: 250), () {
      if(this.searchText != SearchController){
        
          final filteredStudents = students.where((students) => 
            students.name.toLowerCase().contains(value.toLowerCase())).toList();
            controller.studentList.value = filteredStudents;
      
      }
     });
  }

  TextStyle textStyle() => GoogleFonts.roboto(fontSize: 18);
}