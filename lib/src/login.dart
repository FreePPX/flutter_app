import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart' show DioError;
import '../http/dio.dart';


class LoginWidget extends StatefulWidget {

  final Map params;

  LoginWidget({Key key, this.params}):super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState(this.params);
}

class _LoginWidgetState extends State<LoginWidget> {

  final _params;

  _LoginWidgetState(this._params);

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
        Navigator.pop(context);
      }
    } on DioError catch(e) {
      print(e);
    }
  }


  Future<bool> _onWillPop() {
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