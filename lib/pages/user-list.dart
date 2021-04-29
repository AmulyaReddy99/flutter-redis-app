import 'package:flutter/material.dart';
// import 'package:redis/redis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();
}

// RedisConnection conn = new RedisConnection();

abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;
  HeadingItem(this.heading);
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }
  Widget buildSubtitle(BuildContext context) => null;
}

class Items implements ListItem {
  String username;
  String email;
  Items(this.username, this.email);
  Widget buildTitle(BuildContext context) => Text(username);
  Widget buildSubtitle(BuildContext context) => Text(email);
}


class _UserPage extends State<UserPage> {

  List<ListItem> items = [];

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  _asyncMethod() async {
    items = [];
    await FirebaseFirestore.instance
    .collection('users')
    .get()
    .then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((doc) {
          items.add(Items(doc["username"],doc["email"]));
        })
    });
  }
  
  @override
  Widget build(BuildContext cntxt) {
    for(int i=0; i<10; i++)
      items.add(Items("1","1"));

    return Scaffold(
      appBar: AppBar(
        title: Text('Users Page'),
        elevation: 2,
        backgroundColor: Theme.of(cntxt).primaryColor,
      ),
      body: 
        ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
          return FutureBuilder(
            future: this._asyncMethod(),
            builder: (cxt, snapshot) {
              if(snapshot.connectionState != ConnectionState.done){
                return Text('Waiting...');
              }
              final item = items[index];
              return ListTile(
                title: item.buildTitle(context),
                subtitle: item.buildSubtitle(context),
                contentPadding: const EdgeInsets.all(20),
                tileColor: Colors.red[50],
              );
            }
          );
          }
        )
    );
  }
}
