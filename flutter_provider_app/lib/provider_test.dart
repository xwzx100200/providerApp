///Provider
///描述：是为恒定的数据提供的方法(类)。当一个widget只是从这个model中取数据，而不去监听数据的变化而去重绘界面.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyModel {
  MyModel({this.counter = 0});

  int counter = 0;

  /*Future<void> incrementCounter() async {
    await Future.delayed(Duration(microseconds: 500));
    counter++;
    print(counter);
  }*/

  void incrementCounter() {
    counter++;
    print(counter);
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("build方法来了");
    return Provider(
      create: (_) => MyModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('provider'),
        ),
        body: Column(
          children: <Widget>[
            Builder(
              builder: (context) {
                // 获取到provider提供出来的值
                MyModel _model = Provider.of<MyModel>(context, listen: false);
                return Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    color: Colors.lightBlueAccent,
                    child: Text('当前是：${_model.counter}'));
              },
            ),
            Consumer<MyModel>(
              // 获取到provider提供出来的值
              builder: (context, model, child) {
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.lightGreen,
                  child: Text(
                    '${model.counter}',
                  ),
                );
              },
            ),
            Consumer<MyModel>(
              // 获取到provider提供出来的值
              builder: (context, model, child) {
                return FlatButton(
                    color: Colors.tealAccent,
                    onPressed: model.incrementCounter,
                    child: Icon(Icons.add));
              },
            ),
          ],
        ),
      ),
    );
  }
}
