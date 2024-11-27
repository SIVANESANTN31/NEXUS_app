import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nexus/API/Apiurl.dart';
import 'package:toastification/toastification.dart';
import "package:http/http.dart" as http;

import '../../Datastore/Datastore.dart';
import '../../screens/admin/admindb.dart';

class LoginClassApi{
void AdminLogin(BuildContext context) async {
  try {
    // Set up headers for the Laravel API
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    print(LoginData);
    // Make the POST request
    final response = await http.post(
      Uri.parse(AdminLoginurl),
      headers: headers,
      body: jsonEncode(LoginData),
    );

    print(response.body);

    // Check the status code
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['status'] == true) { // Laravel typically uses "status" or "success"
        print(data);

        // Show success toast
        toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored,
          context: context,
          title: Text('${data['message'] ?? 'Login successful!'}'),
          showProgressBar: false,
          icon: const Icon(
            Icons.check_circle_outline,
            color: Color.fromARGB(255, 154, 251, 158),
          ),
          showIcon: true,
          autoCloseDuration: const Duration(seconds: 2),
        );

        // Navigate to the admin dashboard
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const admindb()),
          (route) => false,
        );

        // Clear login data
        LoginData.clear();
      } else {
        // Show error toast with Laravel's message
        toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          context: context,
          title: Text('${data['message'] ?? 'Login failed!'}'),
          icon: const Icon(
            Icons.cancel_rounded,
            color: Colors.red,
          ),
          showIcon: true,
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    } else {
      // Handle unexpected status codes
      var errorData = jsonDecode(response.body);
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        context: context,
        title: Text(
          '${errorData['message'] ?? 'Something went wrong. Please try again.'}',
        ),
        icon: const Icon(
          Icons.cancel_rounded,
          color: Colors.red,
        ),
        showIcon: true,
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 2),
      );
    }
  } catch (e) {
    // Handle general errors
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      context: context,
      title: const Text('Something went wrong'),
      showProgressBar: false,
      icon: const Icon(
        Icons.cancel_rounded,
        color: Colors.red,
      ),
      showIcon: true,
      autoCloseDuration: const Duration(seconds: 2),
    );
    print("Error: $e");
  }
}

// // patient Login funcations


//   void Patientlogin(BuildContext context)async{
//     try {
//       final response  =  await http.post(Uri.parse(PatientLoginurl),body: jsonEncode(LoginData));
//       if(response.statusCode ==200){
//         var data = jsonDecode(response.body);
//         if(data["Status"]){
//           print(data);
//               toastification.show(
//                 type: ToastificationType.success ,
//       style: ToastificationStyle.flatColored,
//       context: context, // optional if you use ToastificationWrapper
//       title: Text('${data['message']} 🎉'),
//       showProgressBar: false,
//       icon: const Icon(Icons.check_circle_outline,color: Colors.green,),
//       showIcon: true, // show or hide the icon
      
//       autoCloseDuration: const Duration(seconds: 2),
//     );
//     Navigator.pushAndRemoveUntil(
//     context,
//     MaterialPageRoute(builder: (context) => const PatientMainScreen()),(route)=>false);
//     LoginData.clear();
//     patient_id = data['userInfo']['patient_id'];
//     Doctor_id = data['userInfo']['doctorid'];
    
    


//         }
//         else{
//           toastification.show(
//                 type: ToastificationType.error ,
//       style: ToastificationStyle.flatColored,
//       context: context, // optional if you use ToastificationWrapper
//       title: Text('${data['message']}'),
//       icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
//       showIcon: true, // show or hide the icon
//       showProgressBar: false,
//       autoCloseDuration: const Duration(seconds: 2),
//     );

//         }
//       }
      

//     } catch (e) {
//       toastification.show(
//                 type: ToastificationType.error ,
//       style: ToastificationStyle.flatColored,
//       context: context, // optional if you use ToastificationWrapper
//       title: const Text('Something went wrong'),
//       showProgressBar: false,
//       icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
//       showIcon: true, // show or hide the icon
      
//       autoCloseDuration: const Duration(seconds: 2),
//     );
      
//     }
    

//   }

//   void Adminlogin(BuildContext context)async{
//     try {
//       final response  =  await http.post(Uri.parse(AdminLoginurl),body: jsonEncode(LoginData));
//       if(response.statusCode ==200){
//         var data = jsonDecode(response.body);
//         if(data["Status"]){
//           print(data);
//               toastification.show(
//                 type: ToastificationType.success ,
//       style: ToastificationStyle.flatColored,
//       context: context, // optional if you use ToastificationWrapper
//       title: Text('${data['message']} 🎉'),
//       showProgressBar: false,
//       icon: const Icon(Icons.check_circle_outline,color: Colors.green,),
//       showIcon: true, // show or hide the icon
      
//       autoCloseDuration: const Duration(seconds: 2),
//     );
//     Navigator.pushAndRemoveUntil(
//     context,
//     MaterialPageRoute(builder: (context) => const Adminmainpage()),(route)=>false);
//     LoginData.clear();
//     Doctor_id = data['userInfo']['doctor_id'];
    
    


//         }
//         else{
//           toastification.show(
//                 type: ToastificationType.error ,
//       style: ToastificationStyle.flatColored,
//       context: context, // optional if you use ToastificationWrapper
//       title: Text('${data['message']}'),
//       icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
//       showIcon: true, // show or hide the icon
//       showProgressBar: false,
//       autoCloseDuration: const Duration(seconds: 2),
//     );

//         }
//       }
      

//     } catch (e) {
//       toastification.show(
//                 type: ToastificationType.error ,
//       style: ToastificationStyle.flatColored,
//       context: context, // optional if you use ToastificationWrapper
//       title: const Text('Something went wrong'),
//       showProgressBar: false,
//       icon: const Icon(Icons.cancel_rounded,color: Colors.red,),
//       showIcon: true, // show or hide the icon
      
//       autoCloseDuration: const Duration(seconds: 2),
//     );
      
//     }
    

//   }

//   void adminlogin(BuildContext context) {}
  
  



}