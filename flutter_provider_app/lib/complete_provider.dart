import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage7 extends StatelessWidget {
  Widget LoginHeader() {
    return Container(
      height: 50,
      color: Colors.blueGrey,
      child: Text(
        'hhhhhh',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(loginServive: LoginServive()),
      child: LoginHeader(), // 这部分是不会被重新渲染的。
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('封装的Provider'),
        ),
        body: Column(
          children: <Widget>[
            child!,
            model.state == ViewState.Loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(model.info),
            FlatButton(
                color: Colors.tealAccent,
                onPressed: () => model.login("pwd"),
                child: Text("登录")),
          ],
        ),
      ),
    );
  }
}

/// viewModel
class LoginViewModel extends BaseModel {
  LoginServive _loginServive;
  String info = '请登录';

  LoginViewModel({required LoginServive loginServive})
      : _loginServive = loginServive;

  Future<String> login(String pwd) async {
    setViewState(ViewState.Loading);
    info = await _loginServive.login(pwd);
    setViewState(ViewState.Success);
    return "";
  }
}

/// api
class LoginServive {
  static const String Login_path = 'xxxxxx';

  Future<String> login(String pwd) async {
    return new Future.delayed(const Duration(seconds: 1), () => "登录成功");
  }
}

enum ViewState { Loading, Success, Failure, None }

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.None;

  ViewState get state => _state;

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final T model;
  final Widget child;
  final Function(T)? onModelReady;

  BaseWidget({
    Key? key,
    required this.builder,
    required this.model,
    required this.child,
    this.onModelReady,
  }) : super(key: key);

  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (BuildContext context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
