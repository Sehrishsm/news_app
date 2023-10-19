import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/utils/utils.dart';
import 'package:new_app/widget/round_button.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('forget'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              TextFormField(
                controller: emailController,
             decoration: InputDecoration(
               hintText: 'email',
             ),
              ),
            SizedBox(
              height: 40,
            ),
            RoundButton(title: 'forget', onTap: (){
          auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
         Utils().toastMessage('changed');
          }).onError((error, stackTrace) {
            Utils().toastMessage(error.toString());
          });
            }),
          ],
        ),
      ),
    );
  }
}
