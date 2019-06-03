import 'package:flutter/material.dart';
import '../../http/dio.dart';

class SearchNavigatorWidget extends StatefulWidget {
  SearchNavigatorWidget({Key key}) : super(key: key);

  @override
  _SearchNavigatorWidgetState createState() => _SearchNavigatorWidgetState();
}

class _SearchNavigatorWidgetState extends State<SearchNavigatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: TextFieldWidget(),
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('list item $index'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: TextField(
              onChanged: (context) {
                getHttp();
              },
              style: TextStyle(color: Color(0xFFdf222e)),
              autofocus: true,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                border: InputBorder.none,
                hintText: '请输入出库单号查询订单',
                hintStyle: TextStyle(color: Color(0x90df222e)),
              ),
            ),
          ),
        )
      ],
    );
  }
}

void getHttp() async {
  try {
    await DioUtils.get("pushRest/getPushNewsNum?msgType=01");
//    print(response);
  } catch (e) {
//    print(e);
  }
}