///可以给FutureProvider提供一份初始的数据Model，通过Future方法返回新的Model数据，刷新ui。
///FutureProvider可以用于只有第一次需要刷新的ui.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyModel with ChangeNotifier {
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
    notifyListeners();
  }
}

class MyHomePage3 extends StatelessWidget {
  Future<MyModel> getFutureProviderData(BuildContext context) async {
    await Future.delayed(Duration(seconds: 5)); // 休息5s
    return MyModel(counter: 100);
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
        initialData: MyModel(counter: 0),
        create: getFutureProviderData, // 当这个函数执行的时候，会渲染UI
        child: Scaffold(
          appBar: AppBar(
            title: Text('FutureProvider'),
          ),
          body: Column(
            children: <Widget>[
              Builder(builder: (context) {
                MyModel _model = Provider.of<MyModel>(context);
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.lightBlueAccent,
                  child: Text('当前是：${_model.counter}'),
                );
              }),
              Consumer<MyModel>(builder: (context, model, child) {
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
              }),
              Consumer<MyModel>(builder: (context, model, child) {
                return FlatButton(
                    color: Colors.tealAccent,
                    onPressed: model.incrementCounter,
                    child: Icon(Icons.add));
              }),
            ],
          ),
        ));
  }
}
