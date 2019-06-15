import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart' show DioError;
import 'package:flutterapp/http/dio.dart';
import 'package:flutterapp/components/tost.dart';


class LoginWidget extends StatefulWidget {

  final params;

  LoginWidget({Key key, this.params}):super(key: key);
//  LoginWidget({Key key}):super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  bool _visible = true;

  TextEditingController _userNameEditController = TextEditingController();
  TextEditingController _pwdEditController = TextEditingController();
  TextEditingController _captchaEditController = TextEditingController();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _pwdFocusNode  = FocusNode();
  FocusNode _captchaFocusNode  = FocusNode();

  String tempToken;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _setTempToken();
    _userNameEditController.addListener(() => setState(() => {}));
    _pwdEditController.addListener(() => setState(() => {}));
    _captchaEditController.addListener(() => setState(() => {}));
  }

  Future<Null> _setTempToken() async{
    tempToken = await _getTempToken();
  }

  Future _getTempToken() async{
    try {
      var response = await DioUtils.get('captchaRest/getTempToken');
      return response['msg'];
    } on DioError catch(e){
      print(e);
    }
  }

  Future _loginHttp(BuildContext context) async {
    try {
      var loginRes = await DioUtils.post('loginRest/login', {'userCode': _userNameEditController.text, 'password': this._pwdEditController.text, 'kaptcha': _captchaEditController.text, 'tempToken': this.tempToken});
//      var loginRes = await DioUtils.post('loginRest/login', {'userCode': '18080008003', 'password': '123456', 'kaptcha': _captchaEditController.text, 'tempToken': this.tempToken});
      if(loginRes['result']) {
        await DioUtils.setPre('String', 'token', loginRes['obj']['token']);
        Toast.toast(context, '登录成功');
        Navigator.pop(context);
      }
    } on DioError catch(e) {
      print(e);
    }
  }


  Future<bool> _onWillPop() async{
    final token = await DioUtils.getPre('token');
    if(token != null) {
      Navigator.pop(context);
      return false;
    }
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('提示'),
        content: new Text('确定退出应用吗？'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('再看一会'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              exit(0);
            },
            child: new Text('退出'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
//    Map _people = ModalRoute.of(context).settings.arguments;
//    print(_people['age'] is int);
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: this._buildNameTextFieldWidget(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: this._buildPwdTextFieldWidget(),
                    ),
                    _visible ? Dismissible(
                        key: ValueKey('myString'),
                        child: ListTile(title: Text('123456789'),),
                        movementDuration: Duration(seconds:3),
                        direction: DismissDirection.horizontal,
                        background: Container(color: Colors.lightBlue, child: Icon(Icons.add, textDirection: TextDirection.rtl,)),
                        secondaryBackground: Container(color: Colors.cyanAccent, child: Icon(Icons.cancel),),
                        onDismissed: (direction) {
                          _visible = false;
                        }) : Container(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: this._buildCaptchaTextFieldWidget(),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            color: Color(0xFF35a2d1),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                            onPressed: () {
                              _loginHttp(context);
                            },
                            child: const Text(
                              '登录',
                              style: TextStyle(fontSize: 20, letterSpacing: 20, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        ),
    );
  }

  Widget _buildNameTextFieldWidget() {
    return TextField(
      controller: _userNameEditController,
      focusNode: _userNameFocusNode,
      style: TextStyle(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'UserName',
      ),
    );
  }

  Widget _buildPwdTextFieldWidget() {
    return TextField(
      controller: _pwdEditController,
      focusNode: _pwdFocusNode,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
    );
  }

  Widget _buildCaptchaTextFieldWidget() {
    return TextField(
      controller: _captchaEditController,
      focusNode: _captchaFocusNode,
      decoration: InputDecoration(
        suffixStyle: TextStyle(),
        suffixIcon: GestureDetector(
          onTap: (){
            setState((){
              _setTempToken();
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            child: Image.network('${DioUtils.uri}captchaRest/getValidateImg?tempToken=${this.tempToken}', height: 50,),
          ),
        ),
        border: OutlineInputBorder(),
        labelText: 'Captcha',
      ),
    );
  }
}