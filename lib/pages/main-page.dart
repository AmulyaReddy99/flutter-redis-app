import 'package:flutter/material.dart';
import 'package:redis/redis.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

RedisConnection conn = new RedisConnection();
conn.connect('localhost',6379)
  .then((Command command) {
    command.send_object(["SET","key","0"])
    .then((var response){
      assert(response == 'OK');
      return command.send_object(["INCR","key"]);
    })
    .then((var response){
      assert(response == 1);  
      return command.send_object(["INCR","key"]);
    })
    .then((var response){
      assert(response == 2);
      return command.send_object(["INCR","key"]);
    })
    .then((var response){
      assert(response == 3);
      return command.send_object(["GET","key"]);
    })
    .then((var response){
      return print(response); // 3
    });
});


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
  String id;
  String body;
  Items(this.id, this.body);
  Widget buildTitle(BuildContext context) => Text(id);
  Widget buildSubtitle(BuildContext context) => Text(body);
}


class _MainPage extends State<MainPage> {
  List<ListItem> items = [
    Items("1", "Hello"),
    Items("2", "World"),
    Items("3", "Welcome"),
    Items("4", "Flutter"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Redis App'),
        elevation: 2,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
              final item = items[index];

                return (
                  Column(children: [

                  ListTile(
                    title: item.buildTitle(context),
                    subtitle: item.buildSubtitle(context),
                  ),


                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: new Column(children: [
                      SizedBox( height: 20, ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Add an item to the list', border: OutlineInputBorder()),
                      ),
                      SizedBox( height: 20, ),
                      FloatingActionButton(
                        tooltip: 'Add Item',
                        child: Icon(Icons.add),
                      ),
                    ],)
                  ),
                  
                  ],
                )
                );
              },
            )
    );
  }
}
