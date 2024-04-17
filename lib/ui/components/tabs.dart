import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/ui/components/cutom_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../services/controller/registration_controller.dart';
import 'custom_text_form_field.dart';
import 'package:instagram/services/model/user_model.dart';

final RegistrationController controller = Get.put(RegistrationController());

class PhoneNumberTab extends StatelessWidget {
  const PhoneNumberTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, bottom: 10, top: 10),
              child: Container(
                height: 50, // Customize height here
                decoration: BoxDecoration(
                  color: Colors.grey[900], // Grey color
                  borderRadius: BorderRadius.circular(8), // Circular border
                  border: Border.all(
                    width: 1.5, // Border width
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 22, right: 5, bottom: 5),
                  child: IntlPhoneField(
                    controller: controller.mobileController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Phone Number',
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, bottom: 10, top: 10),
              child: Text(
                'You may recieve SMS notifications from us for security \n'
                '                                     and login purposes',

                // Replace with relevant phone number
                style: TextStyle(fontSize: 13),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, bottom: 10, top: 10),
              child: Custom_Eleveted_Button(label: "Next", onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}

class EmailAddressTab extends StatelessWidget {
  const EmailAddressTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
            child: Custom_Text_Form_Field(
              name: 'Email address',
              controller: controller.emailController,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
            child: Custom_Eleveted_Button(
                label: "SignUp",
                onPressed: () {
                  controller.signUp();
                }),
          )
        ],
      ),
    );
  }
}
class tabTest extends StatelessWidget {
  const tabTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



class ImageGrid extends StatelessWidget {
  final String images;

  const ImageGrid({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Image.network(images[index], fit: BoxFit.cover);
      },
    );
  }
}



