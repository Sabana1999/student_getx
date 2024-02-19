import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:student_getx/func/dbfun.dart';
import 'package:student_getx/func/studentm.dart';
import 'package:student_getx/helper/student.dart';
import 'package:student_getx/helper/validator.dart';
import 'package:student_getx/screen/home.dart';

class AddPage extends StatefulWidget {
   AddPage({
    super.key,
    required this.isEdit,
    this.stu});

   bool isEdit = false ;
   StudentModel? stu;

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  DbFunctions dbhelper = DbFunctions();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _mobileController = TextEditingController();

  final _emailController = TextEditingController();

  final gender = ['male','female'];

  String selGender='';

  final domainList = [ 'Civil',
    'Mechanical',
    'Computer science',
    'It',
    'Electrical',
    'Electronics'
];

  String selDomain = '';

  File? _selectedImage;

  DateTime dob = DateTime.now();

  String? d;

  DateTime? db;
  //instance
final controller = Get.put(StudentGetX());

  @override
  Widget build(BuildContext context) {

    

    if(widget.isEdit){
      controller.profileImage?.value = widget.stu!.photo;
      _nameController.text = widget.stu!.name;
      controller.gender?.value = widget.stu!.gender;
      controller.domain?.value = widget.stu!.domain;
      db = DateTime.parse(widget.stu!.dob);
      _mobileController.text = widget.stu!.mobile;
      _emailController.text = widget.stu!.email;


    }
    return  Scaffold(
        appBar: AppBar(
          title: widget.isEdit?const Text("Edit student details"):const Text("Register new students")
        ),
    
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                    children: [

                         Obx(
                           (){
                            return GestureDetector(
                            onTap: () async{
                               controller.getImage();
                               
                            },
                            child: Container(
                              height: 120,width: 120,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 2)
                              ),
                              child: controller.profileImage != ''
                              ?Image.file(File(controller.profileImage.toString()),fit: BoxFit.fill,)
                              :const Icon(Icons.photo)                  
                                             ,
                            )
                                             );
  }),
                      
        
        
                      const SizedBox(height: 20,),
        
                      TextFormField(
                        controller: _nameController,
                        validator: Validators.validateFullName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:  InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), 
    ),

                        ),
                      ),
        
                      const SizedBox(height: 20,),
        
          Obx(
            ()=> Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gender',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: gender.map((String value1) {
                  return  Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        children: [
                          Text(
                            value1,
                            style: const TextStyle(
                              fontSize: 12, 
                            ),
                          ),
                          Radio(
                            value: value1,
                            groupValue: controller.gender!.value,
                            onChanged: (selectedValue) {
                              
                                selGender = selectedValue.toString();
                              controller.getGender(selGender);
                            },
                          ),
                        ],
                      ),
                    );
                 
                }).toList(),
              ),
               ],
                ),
              ),
          ),
            const SizedBox(height: 20,),
      
              DropdownButtonFormField(
                    validator: (value){
                        if(value == null ){
                          return "select Department";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Department',
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(117, 185, 237, 1)),
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0))),
                      items: domainList.map((String domain) {
                        return DropdownMenuItem(
                            value: domain, child: Text(domain));
                      }).toList(),
                      onChanged: (String? domain) {
                        controller.getDomain(domain!);
                      }),
                
        
                      const SizedBox(height: 15,),
        
                      Row(
                        children: [
                          const Text("Date Of Birth"),
                               Obx(
                                 ()=> TextButton(onPressed: (){
                                   showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2025)).then((value) => controller.getDOB(value!));
                                  
                              }, child: Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(controller.dateOfBirth.toString())))),
                               ),
                          
                        ],
                      ),
        
                      const SizedBox(height: 10,),
        
                      TextFormField(
                        validator: Validators.validateMobile,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _mobileController,
                        decoration:  InputDecoration(
                          hintText: "Mobile ",
                          border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), 
    ),

                        ),
                        keyboardType: TextInputType.number,
                      ),
        
                      const SizedBox(height: 20,),
        
                      TextFormField(
                        validator:Validators.validateEmail,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailController,
                        decoration:  InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), 
    ),

                        ),
                        keyboardType: TextInputType.emailAddress,
                      )
                    ],
                  )),
                ),
    
                const SizedBox(height: 20,),
    
              widget.isEdit?
              ElevatedButton.icon(
                onPressed: (){
                    edit(d=controller.domain.toString(), db=DateTime.parse(controller.dateOfBirth.toString()));
                }, 
                icon: const Icon(Icons.update), 
                label: const Text("Update"))
                :ElevatedButton.icon(
                onPressed: (){

                  submit(
                    d=controller.domain.toString(), db=DateTime.parse(controller.dateOfBirth.toString())
                  );
                }, 
                icon: const Icon(Icons.save), 
                label: const Text("ADD"))
    
              ],
            ),
          ),
    )
    );
  }

//add ...
Future<void> submit(String? d, DateTime? db) async {
  var imagePath = controller.profileImage!.value;
  final name = _nameController.text.trim();
  var gender = controller.gender!.value;
  final domain = d;
  final dob = db?.toString();
  final mobile = _mobileController.text.trim();
  final email = _emailController.text.trim();

  if (_formKey.currentState?.validate() ?? false) {
    if (imagePath != null && dob != null ) {
      final student = StudentModel(
        photo: imagePath,
        name: name,
        gender: gender,
        domain: domain!,
        dob: dob,
        mobile: mobile,
        email: email,
      );
      dbhelper.addStudent(student);
      controller.profileImage?.value = '';
      controller.gender?.value = '';
      Get.snackbar("Successful", "Student registered",snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.teal);

      Get.to(const HomePage());
    } else {
  Get.snackbar("Error", "Not registered",snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.redAccent);

    }
  }else{
  Get.snackbar("Error", "Not registered",snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.redAccent);

  }
}

// update
Future<void> edit(String? d, DateTime? db) async {
  int? id = widget.stu!.id;
  final imagePath = _selectedImage?.path;
  final name = _nameController.text.trim();
  final gender = selGender;
  final domain = d;
  final dob = db?.toString();
  final mobile = _mobileController.text.trim();
  final email = _emailController.text.trim();

  if (_formKey.currentState?.validate() ?? false) {
    if (imagePath != null && dob != null && gender!=null) {
     dbhelper.editStudent(id!, imagePath, name, gender, domain!, dob, mobile, email);
    } else {
  Get.snackbar("Error", "Add all data",snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.redAccent);

    }
  }else{
  Get.snackbar("Error", "Add all data ",snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.redAccent);

  }
}

}
