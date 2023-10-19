import 'package:new_app/ui/post/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widget/round_button.dart';



class VerifiedCodeScreen extends StatefulWidget {

 final String verificationId;
  const VerifiedCodeScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifiedCodeScreen> createState() => _VerifiedCodeScreenState();
}

class _VerifiedCodeScreenState extends State<VerifiedCodeScreen> {
  @override

  bool loading = false;
  final verifyCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80,),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: verifyCodeController,
              decoration: InputDecoration(
                hintText: '6 digit code',
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Verify', loading: loading ,onTap: ()async{
            setState(() {
              loading = true;
            });
              final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verifyCodeController.text.toString(),
              );
              try{

                await auth.signInWithCredential(credential);
                Navigator.push(context,MaterialPageRoute(builder: (context)=> PostScreen()));
              }catch(e){
   setState(() {
     loading = false;
   });
              }
            }),
          ],
        ),
      ),
    );
  }
}
