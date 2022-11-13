import 'package:flutter/material.dart';
import 'package:flutterproviderapp/Models.dart';

class DiscoverDetailPage extends StatelessWidget {
  final MyModel models;
  DiscoverDetailPage(this.models);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('hhhhh'),
          backgroundColor: Colors.grey,
        ),
        body: Column(
          children: <Widget>[
            Text('${models.counter}'),
            FlatButton(
                color: Colors.tealAccent,
                onPressed: () {
                  models
                      .incrementCounter(); // 这里调用model的incrementCounter，会notify上一个页面的内容。上一个页面也会被渲染。
                },
                child: Icon(Icons.ac_unit)),
          ],
        ));
  }
}
