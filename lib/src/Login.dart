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
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _pwdFocusNode  = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userNameEditController.addListener(() => setState(() => {}));
    _pwdEditController.addListener(() => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(30),
            child: _buildNameTextFieldWidget(),
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: _buildPwdTextFieldWidget(),
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: RaisedButton(
              onPressed: () {
                loginHttp();
              },
              child: const Text(
                  'Submit Button',
                  style: TextStyle(fontSize: 20)
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildNameTextFieldWidget() {
    return TextField(
      controller: _userNameEditController,
      focusNode: _userNameFocusNode,
      obscureText: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'UserName',
      ),
    );
  }

  _buildPwdTextFieldWidget() {
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
}

void loginHttp() async {
  var a = '';
  var b = a ?? 9;
  print(b);
  try {
    var res = await DioUtils.post('loginRest/login', {'userCode': '', 'password': '', 'kaptcha': '', 'tempToken': ''});
    print(res);
  } on DioError catch(e) {
    print(e);
  }
}