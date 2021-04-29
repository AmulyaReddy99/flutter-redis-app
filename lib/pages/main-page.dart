import 'package:flutter/material.dart';
import 'package:flutter_redis_app/pages/user-list.dart';
// import 'package:redis/redis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void onButtonPress(){
    Future<void> addUser() {
      return users
          .add({
            'username': this.usernameController.text,
            'email': this.emailController.text, 
            'password': this.passwordController.text
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    addUser();
    
      // command.send_object(["username",this.usernameController.text])
      // .then((var response){
      //   assert(response == 1);  
      // });
      // command.send_object(["email",this.emailController.text])
      // .then((var response){
      //   assert(response == 2);
      // });
      // command.send_object(["password",this.passwordController.text])
      // .then((var response){
      //   assert(response == 2);
      // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Redis App'),
        elevation: 2,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: new Column(children: [
                SizedBox( height: 20, ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      labelText: 'Username', border: OutlineInputBorder()),
                ),
                SizedBox( height: 20, ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                ),
                SizedBox( height: 20, ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
                SizedBox( height: 20, ),
                FloatingActionButton(
                  onPressed: onButtonPress,
                  tooltip: 'Save User',
                  child: Icon(Icons.save),
                ),
                SizedBox( height: 100, ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  child: Text("List of all users"),
                  padding: const EdgeInsets.all(25),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new UserPage()),
                    );
                  }
                ),

              ],
            ),
            ) 
          )
        ]
      )
    );
  }
}
