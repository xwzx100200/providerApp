///可以组合Provider所提供的类，给Ui提供多个数据Model。

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BannerModel>(create: (context) => BannerModel()),
        ChangeNotifierProvider<ListModel>(create: (context) => ListModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('provider'),
        ),
        body: Column(
          children: <Widget>[
            Builder(
              builder: (context) {
                BannerModel modol = Provider.of<BannerModel>(context);
                return Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    color: Colors.lightBlueAccent,
                    child: Text('当前Banner有几个：${modol.counter}'));
              },
            ),
            Consumer<ListModel>(
              builder: (context, model, child) {
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.lightGreen,
                  child: Text(
                    '当前Banner有几个：${model.counter}',
                  ),
                );
              },
            ),
            Consumer<BannerModel>(
              builder: (context, model, child) {
                return FlatButton(
                    color: Colors.tealAccent,
                    onPressed: model.getBanner,
                    child: Text("获取banner"));
              },
            ),
            Consumer<ListModel>(
              builder: (context, model, child) {
                return FlatButton(
                    color: Colors.tealAccent,
                    onPressed: model.getList,
                    child: Text("获取列表"));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BannerModel with ChangeNotifier {
  int counter = 0;

  Future<void> getBanner() async {
    await Future.delayed(Duration(microseconds: 500));
    counter++;
    notifyListeners();
    print(counter);
  }
}

class ListModel with ChangeNotifier {
  int counter = 0;

  Future<void> getList() async {
    await Future.delayed(Duration(microseconds: 500));
    counter++;
    notifyListeners();
    print(counter);
  }
}
