/// 当model对像中有数据变化时，需要触发widget中的元素重绘，实现数据驱动，这时我们需要用到ChangeNotifierProvider。

import 'package:flutter/material.dart';
import 'package:flutterproviderapp/detailPage.dart';
import 'package:provider/provider.dart';
import 'Models.dart';

class MyHomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MyHomePage2的build方法来了");
    return ListenableProvider(
      /* ListenableProvider和ChangeNotifierProvider几乎是一样的效果，只是ListenableProvider比ChangeNotifierProvider多了个_dispose函数，
      会在适当的时候自动销毁，一般情况下只用changeNotifierProvider即可。
      */
      create: (_) => MyModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ChangeNotifierProvider'),
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
              child: Container(
                // consumer 里的child的组件是不会被渲染的，builder里的组件是会被重新渲染的
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.lightGreen,
                child: Text(
                  'hhhhhhhhhhh',
                ),
              ),
              builder: (context, model, child) {
                print("Consumer里的builder来了");
                return Column(
                  children: <Widget>[
                    child!,
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      color: Colors.lightGreen,
                      child: Text(
                        '${model.counter}',
                      ),
                    )
                  ],
                );
              },
            ),
            MyText(),
            MyText2(),
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

// 初始化一个单独的子部件套进去，看能不能用provider.of(context)获取model
class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MyText子部件的build方法来了");
    MyModel _model =
        Provider.of<MyModel>(context); // 这里的也能正常拿到Provider中的model的，因为是共享的。
    return Container(
      child: Text('当前是MyText里的：${_model.counter}'),
    );
  }
}

class MyText2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MyText2子部件的build方法来了");
    MyModel models =
        Provider.of<MyModel>(context); // 这里的也能正常拿到Provider中的model的，因为是共享的。
    return Container(
      child: FlatButton(
          color: Colors.tealAccent,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DiscoverDetailPage(models);
            }));
          },
          child: Icon(Icons.ac_unit)),
    );
  }
}
