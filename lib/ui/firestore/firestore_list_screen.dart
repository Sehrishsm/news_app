import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_app/ui/auth/login_screen.dart';
import 'package:new_app/ui/firestore/add_firestore_data.dart';
import 'package:new_app/ui/post/add_posts.dart';
import 'package:new_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth =FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
 CollectionReference ref = FirebaseFirestore.instance.collection('users');
  // or final ref1 = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
            });

          }, icon:Icon(Icons.logout_outlined),),
          SizedBox(width: 10,),
        ],
        title: Text('Firestore Screen'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),

          // Expanded(
          //     child: StreamBuilder(
          //       stream: ref.onValue,
          //     builder: (context , AsyncSnapshot<DatabaseEvent> snapshot){
          //
          //         if(!snapshot.hasData || snapshot.data!.snapshot.value == null){
          //           return CircularProgressIndicator();
          //         }else{
          //           Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
          //           List<dynamic> list = [];
          //           list.clear();
          //           list = map.values.toList();
          //           return ListView.builder(
          //               itemCount: snapshot.data!.snapshot.children.length,
          //               itemBuilder: (context, index){
          //                 return ListTile(
          //                   title: Text(list[index]['title']?? 'No title'),
          //                 );
          //               }
          //               );
          //         }
          //
          //     },
          //     )
          // ),
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
              builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.connectionState== ConnectionState.waiting)
                  return CircularProgressIndicator();

                if(snapshot.hasError)
                  return Text('Some error');
              return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){

                        return ListTile(
                          onTap: (){
                            // ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                            //   'title' : 'asif taj subscribe',
                            // }).then((value) {
                            //   Utils().toastMessage('post updated');
                            // }).onError((error, stackTrace){
                            //   Utils().toastMessage(error.toString());
                            // });
                            ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                          },
                          title: Text(snapshot.data!.docs[index]['title'].toString()),
                          subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                        );
                      }
                  ),
                );
              }
          ),


        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFireStoreDataScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> showMyDialogue(String title, String id)async{
    editController.text= title;
    return showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Update'),
            content: Container(
                child: TextField(
                  controller: editController,
                  decoration: InputDecoration(
                    hintText: 'edit here',
                  ),
                )
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);


              }, child: Text('update')
              ),
            ],
          );
        }
    );
  }
}


