
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_getx/func/studentm.dart';

class StudentGetX extends GetxController{

  RxString? profileImage=''.obs;
  RxString? dateOfBirth =DateTime.now().toString().obs;
  RxString? gender = ''.obs;
  RxString? domain = ''.obs;

  List<StudentModel> _studentList = [];
  List<StudentModel> get studentLists => _studentList;
  


//add image
  getImage()async{
     final picker = ImagePicker();
     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
       if(pickedImage!=null){
           profileImage!.value=pickedImage.path.toString();
         }
    
  }

// add dob
  getDOB(DateTime dob){
    dateOfBirth?.value = dob.toString();
    
  }

// add gender
  getGender(String g){
    gender!.value = g;
    
  }

// add domain
  getDomain(String d){
    domain!.value = d;
    
  }

  searchStudent(List<StudentModel> newList){
    _studentList = newList;
    update();
    
  }



}