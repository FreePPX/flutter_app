import 'package:flutter/material.dart';
import './Home/home_page.dart';
import './Video/video_page.dart';
import '../src/my/my_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<String> appTitle = ['首页', '视频', '我的'];
  final List<Object> getBodyItem = [
    new HomePage(),
    new VideoPage(),
    new MyPageWidget(),
  ];

  void _clickBottermIterm(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Color _getTabColor(index) {
    if(_currentIndex == index) {
      return Color(0xFFdf232f);
    } else {
      return Color(0xFF999999);
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
            onPressed: () => Navigator.of(context).pop(true),
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
          appBar: AppBar(
            centerTitle: true,
            title: _currentIndex != 0 ? Text(appTitle[_currentIndex]) : SearchWidget(),
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          body: getBodyItem[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: _getTabColor(0)), title: Text(appTitle[0], style: TextStyle(color: _getTabColor(0)))),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business, color: _getTabColor(1)), title: Text(appTitle[1], style: TextStyle(color: _getTabColor(1)))),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_mall, color: _getTabColor(2)), title: Text(appTitle[2], style: TextStyle(color: _getTabColor(2)))),
            ],
            currentIndex: _currentIndex,
            onTap: _clickBottermIterm,
          )
      ),
    );
  }
}



class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/search');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.00),
          color: Colors.white,
        ),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
        alignment: Alignment.center,
        child: Text(
          '请输入出库单号查询订单',
          style: TextStyle(color: Color(0x90df222e), fontSize: 15),
        ),
      ),
    );
  }
}
