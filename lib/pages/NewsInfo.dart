import 'package:flutter/material.dart';
import 'package:yss/common/apis/News.dart';
import 'package:yss/common/util/screen.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:yss/common/utils.dart';
import 'package:yss/model/NewsInfoModel.dart';

class NewsInfoPage extends StatefulWidget {
  final String id;

  NewsInfoPage({Key key, this.id}) : super(key: key);

  @override
  _NewsInfoPageState createState() =>
      _NewsInfoPageState();
}

class _NewsInfoPageState extends State<NewsInfoPage> {

  Map arguments;
  var _title="";
  var _createTime="";
  var _content="";

  @override
  void initState() {
    _getData();
  }
  _NewsInfoPageState();

  _getData() async {
    NewsInfoRequestModel newsInfoRequestModel = NewsInfoRequestModel(
        id: widget.id, type: '1'
    );
    NewsInfoModel newsInfoModel = await NewsInfoApi.getData(
        context: context,
        newsInfoRequestModel: newsInfoRequestModel
    );
    print(newsInfoModel);
    if(widget.id != null){
      setState(() {
        this._title = newsInfoModel.data.title;
        this._createTime = newsInfoModel.data.time;
        this._content = newsInfoModel.data.content;
        print(MediaQuery.of(context).size.width);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(arguments);
    return Scaffold(
      appBar: AppBar(
        title: Text('新闻详情'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
          child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(
                    sySetWidth(24), sySetHeight(50), sySetHeight(24), 0),
                child: Text(
                  '${this._title}',
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: sySetFontSize(32)),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    sySetWidth(24), sySetHeight(30), sySetHeight(24), 0),
                child: Text(
                  '${this._createTime}',
                  style: TextStyle(
                      color: Color.fromRGBO(153, 153, 153, 1),
                      fontSize: sySetFontSize(24)),
                ),
              ),
             Padding(
               padding: EdgeInsets.all(1),
               child:  _getHtmlWidget(),
             )
            ],
          ),
        ],
      )),
    );
  }

  Widget _getHtmlWidget(){
    return  Container(
      width: syGetWidth(),
      margin: EdgeInsets.fromLTRB(
          sySetWidth(10), sySetHeight(10), sySetHeight(24), 0),
      child: Html(
        data: this._content,
//        shrinkWrap:false,
        //Optional parameters:
        style: {
          "html": Style(
//            padding: EdgeInsets.all(10),
//            margin: EdgeInsets.all(10),
            //width: 1920,
            fontSize:FontSize(sySetFontSize(28)),
            color: Color.fromRGBO(51, 51, 51, 1),
          ),
//            "h1": Style(
//              textAlign: TextAlign.center,
//            ),
          "table": Style(
            backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
          ),
          "tr": Style(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          "th": Style(
            padding: EdgeInsets.all(6),
            backgroundColor: Colors.grey,
          ),
          "td": Style(
            padding: EdgeInsets.all(6),
          ),
          "var": Style(fontFamily: 'serif'),
        },
        customRender: {
          "flutter":
              (RenderContext context, Widget child, attributes, _) {
            return FlutterLogo(
              style: (attributes['horizontal'] != null)
                  ? FlutterLogoStyle.horizontal
                  : FlutterLogoStyle.markOnly,
              textColor: context.style.color,
              size: context.style.fontSize.size * 5,
            );
          },
        },
        onLinkTap: (url) {
          print("Opening $url...");
        },
        onImageTap: (src) {
          print(src);
        },
        onImageError: (exception, stackTrace) {
          print(exception);
        },
      ),
    );
  }
}
