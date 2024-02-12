
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:task_manager/ui/auth/login_screen.dart';
import 'package:task_manager/utils/utils.dart';

import 'user_screen.dart';


class PostScreen extends StatefulWidget {

  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Task');
  final markControl= TextEditingController();
  final dateControl= TextEditingController();
  final auth= FirebaseAuth.instance;
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          },
            icon: Icon(Icons.logout_outlined),),
          SizedBox(width: 10,),
        ],
      ),
      body: Column(
        children:[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(alignment: Alignment.center,
                child: Text('Admin Portal', style: TextStyle(fontSize: 30),)),
          ),
          SizedBox(height: 5,),
          Divider(),

          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: markControl,
              decoration: InputDecoration(
                hintText: 'Role',
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return 'enter role';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: dateControl,
              decoration: InputDecoration(
                hintText: 'task assign',
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return 'enter task';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    String id= DateTime.now().millisecondsSinceEpoch.toString();
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => MarkScreen()));
                    //'id' :    DateTime.now().millisecondsSinceEpoch.toString(),
                    //child(DateTime.now().millisecondsSinceEpoch.toString()).set
                    databaseRef.child(id).set({
                      'role': markControl.text.toString(),
                      'task': dateControl.text.toString(),
                      'id': id,
                    }).then((value){
                      Utils().toastMessage1('task assigned to user');
                    }).onError((error, stackTrace){
                      Utils().toastMessage(error.toString());
                    });

                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    child: Center(child: Text('Assign Task', style: TextStyle(color: Colors.white),)),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen()));
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    child: Center(child: Text('View Task', style: TextStyle(color: Colors.white),)),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              showDialog(context: context, builder: (context) => AlertDialog(
                title: Text('Leave'),
                content: Text('Are you sure?'),
                actions: [
                  TextButton(onPressed: (){
                    auth.signOut().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    }).onError((error, stackTrace){
                      Utils().toastMessage(error.toString());
                    });
                  }, child: Container(
                    height: 50,
                    width: 200,
                    child: Center(child: Text('Leave', style: TextStyle(color: Colors.white),)),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ), ),
                ],
              ));
            },
            child: Align(alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 150,
                child: Center(child: Text('Leave', style: TextStyle(color: Colors.white),)),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }



}