/// 当一个model依赖另一个model时，就以用ChangeNotifierProxyProvider把依赖的model推给被依赖model对像。
/// 当前例子模拟的是picmodel成功后，submitmodel才能成功。（场景：点击提交按钮的时候，先图片上传，成功了页面才提交成功）

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyHomePage6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PicModel>(create: (context) => PicModel()),
        ProxyProvider<PicModel, SubmitModel>(
          update: (context, myModel, anotherModel) => SubmitModel(myModel),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('provider'),
        ),
        body: Column(
          children: <Widget>[
            Builder(
              builder: (context) {
                PicModel modol = Provider.of<PicModel>(context);
                return Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    color: Colors.lightBlueAccent,
                    child: Text('提交图片：${modol.counter}'));
              },
            ),
            Consumer<PicModel>(
              builder: (context, model, child) {
                return FlatButton(
                    color: Colors.tealAccent,
                    onPressed: model.upLoadPic,
                    child: Text("提交图片"));
              },
            ),
            Consumer<SubmitModel>(
              builder: (context, model, child) {
                return FlatButton(
                    color: Colors.tealAccent,
                    onPressed: () {
                      model.subMit().then((value) {
                          print("页面提交成功！");
                      });
                    },
                    child: Text("提交页面"));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PicModel with ChangeNotifier {
  int counter = 0;
  Future<void> upLoadPic() async {
//    counter++;
//    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    counter++;
    notifyListeners();
    print(counter);
    print("图片提交成功");
  }
}

class SubmitModel {
  PicModel _model;

  SubmitModel(this._model);

  Future<void> subMit() async {
    await _model.upLoadPic();
  }
}
