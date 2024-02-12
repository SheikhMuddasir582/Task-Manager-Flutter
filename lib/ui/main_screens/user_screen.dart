
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/utils/utils.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool loading =false;
  final databaseRef = FirebaseDatabase.instance.ref('Task');
  final searchControl= TextEditingController();
  final editControl= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('View Task'),
        ),
        body: Column(
          children: [
            SizedBox(height: 10,),
            // RoundButton(title: 'upload image', onTap: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageScreen()));
            // }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: searchControl,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value){
                  setState(() {

                  });
                },
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: databaseRef,
                  defaultChild: Text('Loading'),
                  itemBuilder: (context, snapshot, animation, index) {

                    final date= snapshot.child('date').value.toString();

                    if(searchControl.text.isEmpty){
                      return ListTile(
                        title: Text(snapshot.child('role').value.toString()),
                        subtitle: Text(snapshot.child('task').value.toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) =>
                          [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    showMyDialog(date, snapshot.child('id').value.toString());
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                )),
                            PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    databaseRef.child(snapshot.child('id').value.toString()).remove();
                                  },
                                  leading: Icon(Icons.delete_outline),
                                  title: Text('Delete'),
                                )),
                          ],
                        ),
                      );
                    }
                    else if(date.toLowerCase().contains(searchControl.text.toLowerCase().toString())){
                      return ListTile(
                        title: Text(snapshot.child('role').value.toString()),
                        subtitle: Text(snapshot.child('task').value.toString()),
                      );
                    }
                    else{
                      return Container();
                    }
                  }
              ),
            ),
          ],
        )
    );
  }


  Future <void> showMyDialog(String date, String id) async{
    editControl.text= date;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editControl,
                decoration: InputDecoration(
                    hintText: 'Edit'
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: Text('Cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);
                databaseRef.child(id).update({
                  'task': editControl.text.toLowerCase(),
                }).then((value){
                  Utils().toastMessage1('Task Updated');
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });

              },
                  child: Text('Update')),
            ],
          );
        });
  }
}