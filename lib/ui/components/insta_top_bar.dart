import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstaTopBar extends StatelessWidget {
  const InstaTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width *1,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:15,top: 10,right:10),
            child: Text('Instagram',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: GoogleFonts.oleoScript().fontFamily,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left:100,top: 10,right:10),
            child: IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.heart,color: Colors.white),),
          ),
          IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.facebookMessenger,color: Colors.white,),),
        ],
      ),
    );
  }
}