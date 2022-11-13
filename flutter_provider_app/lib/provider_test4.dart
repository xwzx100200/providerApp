/// 可以给StreamProvider提供一份初始的数据Model，通过给StreamProvider设置了一个每隔1秒更新一次的stream，
/// ui上的计数值也是每隔一秒改变一次。

import 'package:flutter/foundation.dart';
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

class MyHomePage4 extends StatelessWidget {
  Stream<MyModel> getStreamProviderData(BuildContext context) {
    print("getStreamProviderData方法");
    return Stream<MyModel>.periodic(Duration(seconds: 1), getMyModel);
  }

  MyModel getMyModel(int count) {
    print("getMyModel方法");
    count++;
    if (count > 60) {
      return MyModel(counter: 60);
    }else {
      return MyModel(counter: count);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build方法来了");
    return StreamProvider(
        initialData: MyModel(counter: 0),
        create: getStreamProviderData, // 当这个函数执行的时候，会渲染UI
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
