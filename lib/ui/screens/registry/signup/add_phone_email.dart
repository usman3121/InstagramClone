import 'package:flutter/material.dart';

import '../../../components/tabs.dart';

class AddPhoneEmail extends StatefulWidget {
  const AddPhoneEmail({super.key});

  @override
  State<AddPhoneEmail> createState() => _AddPhoneEmailState();
}

class _AddPhoneEmailState extends State<AddPhoneEmail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Add phone number or \n       email address',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 24, // Text size
                  fontWeight: FontWeight.bold, // Text weight
                ),
              ),
            ),
            DefaultTabController(
              length: 2, // Number of tabs
              child: Column(
                children: [
                  const TabBar(
        
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      Tab(
                        text: 'Phone Number',
                      ),
                      Tab(
                        text: 'Email Address',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        200, // Adjust height as needed
                    child: const TabBarView(
                      children: [
                        PhoneNumberTab(),
                        EmailAddressTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
