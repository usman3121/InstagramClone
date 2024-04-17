import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Custom_Text_Form_Field extends StatelessWidget {
  String name;
  final TextEditingController? controller;
  final bool obscureText;
   Custom_Text_Form_Field({
    super.key, this.controller, required this.name,this.obscureText=false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.06, // Customize height here
      decoration: BoxDecoration(
        color: Colors.grey[900], // Grey color
        borderRadius: BorderRadius.circular(8), // Circular border
        border: Border.all(
          width: 1.5, // Border width
        ),
      ),
      child:  Padding(
        padding: const EdgeInsets.only(left: 15,top: 10,bottom: 2),
        child:  TextField(
          obscureText:  obscureText,
          controller: controller ,
          decoration: InputDecoration(

              border: InputBorder.none, // Remove default border
              hintText: name,
              hintStyle: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}