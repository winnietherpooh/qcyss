import 'package:flutter/material.dart';
import 'package:yss/data/map.dart';
import 'package:yss/pages/banner.dart';

class Test2Page extends StatefulWidget {
  @override
  _Test2PageState createState() => _Test2PageState();
}

class _Test2PageState extends State<Test2Page> {

  ScrollController _controller;
  List<String> data = new List();

  @override
  void initState() {
    _controller = ScrollController();
    List.generate(300, (index) => data.add('item${index + 1}'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('新闻'),
          centerTitle: true,
        ),
        body:  Container(
          color: Color.fromRGBO(240, 240, 240, 1),
          child:  ListView(
            controller: _controller,
            children: <Widget>[
              BannerPage(),
              Container(
                height: 20,
              ),
              Container(
                color: Color.fromRGBO(240, 240, 240, 1),
//             padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: RefreshIndicator(
                    child: ListView(
                      controller: _controller,
                      shrinkWrap: true,
                      children: _getData(),
                    ),
                    onRefresh: (){
                      return Future.delayed(Duration(seconds: 1),(){
                        setState(() {
                          data.insert(0,'addNewItem');
                        });
                      });
                    }),
              )
            ],
          ),
        )

    );
  }


  List<Widget> _getData() {
    var tempList = dataList.map((e) {
      return Column(
        children: <Widget>[
          Container(
            height: 145,
            color: Color.fromRGBO(255, 255, 255, 1),
            padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 135.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: NetworkImage(e['avatar']), fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 20, 24, 0),
                        child: Text(
                          e['userName'],
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 15, 24, 0),
                        child: Text(
                          e['detail'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 6, 40, 0),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          e['times'],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 10,
          )
        ],
      );
    });
    return tempList.toList();
  }
}
