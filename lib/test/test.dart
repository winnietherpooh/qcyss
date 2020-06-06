import 'package:flutter/material.dart';
import 'package:yss/pages/banner.dart';
import 'package:yss/data/map.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('测试'),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((content, index) {
                return BannerPage();
              }, childCount: 1),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((content, index) {
                return Container(
                  height: 135,
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
                              image: NetworkImage(dataList[index]['avatar']), fit: BoxFit.cover),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(10, 20, 24, 0),
                              child: Text(
                                dataList[index]['userName'],
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
                                dataList[index]['detail'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 6, 40, 0),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                dataList[index]['times'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: 6),
            )
          ],
        ),
      //backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      backgroundColor: Colors.red,
    );
  }

}
