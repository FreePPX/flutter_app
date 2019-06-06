import 'package:flutter/material.dart';
import 'package:dio/dio.dart' show DioError;
import '../http/dio.dart';


class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

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

  Future _setTempToken() async{
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

  Future _loginHttp() async {
    try {
      await DioUtils.post('loginRest/login', {'userCode': _userNameEditController.text, 'password': '123456', 'kaptcha': _captchaEditController.text, 'tempToken': this.tempToken});
    } on DioError catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        _loginHttp();
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
      obscureText: true,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: (){
            setState((){
              _setTempToken();
            });
          },
          child: Image.network('${DioUtils.api}captchaRest/getValidateImg?tempToken=${this.tempToken}', height: 50,),
        ),
        border: OutlineInputBorder(),
        labelText: 'Captcha',
      ),
    );
  }
}