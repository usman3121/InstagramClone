
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Custom_Eleveted_Button extends StatelessWidget {
  String label;
  final VoidCallback onPressed;

   Custom_Eleveted_Button({
    super.key, required this.label, required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Set border radius to 0 for no border radius
          ),

        backgroundColor: Colors.blue[700]
      ),
        onPressed: onPressed,
        child: SizedBox(
          height: Get.height * 0.06,
          child: Center(
            child:Text(
              label,
              style:const TextStyle( fontSize: 18, color: Colors.white),
            ),
          ),
        ));
  }
}