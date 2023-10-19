import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/utils/utils.dart';
import 'package:new_app/widget/round_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class AddFireStoreDataScreen extends StatefulWidget {
  const AddFireStoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {

  final postController = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Firestore data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                hintText: "What is in Your mind",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(title: 'Add',
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });

           String id = DateTime.now().millisecondsSinceEpoch.toString();
             fireStore.doc(id).set({
           'title' : postController.text.toString(),
              'id' :id
             }).then((value) {
               setState(() {
                 loading=false;
               });
             Utils().toastMessage('Post added');
             }).onError((error, stackTrace) {
               setState(() {
                 loading= false;
               });
               Utils().toastMessage(error.toString());
             });

                }),
          ],
        ),
      ),
    );
  }

}



