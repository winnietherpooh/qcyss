import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yssqc/common/apis/Question.dart';
import 'package:yssqc/common/router/router.gr.dart';
import 'package:yssqc/common/util/screen.dart';
import 'package:yssqc/common/widgets/appbarWidget.dart';
import 'package:yssqc/common/widgets/toast.dart';
import 'package:yssqc/model/QuestionResponseModel.dart';
import 'package:yssqc/model/responseModel.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  var _checkValue = false;
  var sex = 1;
  List submitKey = [];
  List<QuestionItem> questionItemList=[];
  List<QuestionRequestModel> questionRequestModel=[];
  Map<String,TextEditingController> controllerList={};
  Map<String,bool> checkBoxList={};
  Map<String,String> radioList={};
  Map<String,String> postContent={};
  List postAll=[];
  Map<String,List> checkBoxAll={};
  Map<String,String> radioAll = {};
  @override
  void initState() {
    _getData();
  }

  _getData() async{
    QuestionResponseModel questionResponseModel = await QuestionApi.getData(context: context);
    setState(() {
      questionItemList = questionResponseModel.data;
      if(questionItemList.length > 0){
        int index = 0;
        questionItemList.forEach((element) {
          if(element.sign == 1){
            controllerList[element.id.toString()] = TextEditingController();
          }else{
            if(element.type == 1){
              radioList[index.toString()] = "";
            }else{
              if(element.answerList.length > 0){
                element.answerList.forEach((v) {
                  checkBoxList[v.id.toString()] = false;
                });
              }

            }
          }
          index++;
        });
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWidget(context, '问答'),
      body: ListView(
        children: _getListItem(),
      ),
    );
  }

  _submitAll() async{
    showLoading(context, '正在提交');
    if(controllerList.length > 0){
      controllerList.forEach((key, value) {
        Map<String,String> postContent={};
        postContent['titleId'] = key;
        postContent['content'] =  value.value.text.toString();
        postAll.add(postContent);
      });
    }
    if(checkBoxAll.length > 0){
      checkBoxAll.forEach((key, value) {
        Map<String,String> postContent={};
        postContent['titleId'] = key;
        postContent['content'] =  value.toString();
        postAll.add(postContent);
      });
    }
    if(radioAll.length > 0){
      radioAll.forEach((key, value) {
        Map<String,String> postContent={};
        postContent['titleId'] = key;
        postContent['content'] =  value.toString();
        postAll.add(postContent);
      });
    }
    print('========提交前打印开始=========');
    print(postAll.toString());
    print('========提交前打印结束=========');
    QuestionSubmitRequestModel questionSubmitRequestModel = QuestionSubmitRequestModel(data: postAll.toString());
    postAll.clear();
    ResponseModel responseModel = await QuestionApi.postData(context: context, questionSubmitRequestModel: questionSubmitRequestModel);
    if(responseModel.error != 200){
      Navigator.pop(context);
      return showError(context,text: responseModel.message,times: 1000);
    }else{
      ExtendedNavigator.rootNavigator.pushNamed(Routes.tabsRoute);
    }
  }
  _getListItem(){
    List<Widget> list=[];
    if(questionItemList.length > 0){
      int i = 1;
      questionItemList.forEach((element) {
        //sign 1,问答,2,选择
        //type 1:单选,2,多选
        if(element.sign == 1){
          list.add(_getAnswer(i++,element));
        }else{
          if(element.type == 1){
            list.add(_getRadioBox(i,element));
          }else{
            list.add(_getCheckBox(i,element));
          }
        }
      });
      if(list.length > 0){
        list.add(_getButtonWidget());
      }
    }else{
      list.add(getLoadingWidget());
    }
    return list;
  }

  //获取单选完整布局
  _getCheckBox(int index,QuestionItem questionItem){
    return Container(
//      padding: EdgeInsets.all(10),
      child: Column(
          children: _checkBoxItemAll(index,questionItem)
      ),
    );
  }
  //单选完整布局方法
  _checkBoxItemAll(int index,QuestionItem questionItem){
    List<Widget> list = [];
    list.add(_ItemTitle(index,questionItem));
    if(questionItem.answerList.length > 0){
      questionItem.answerList.forEach((element) {
        list.add(_checkBoxItem(questionItem.id,index,element));
      });
    }
    return list;
  }

  //获取单选布局的每一项
  _checkBoxItem(int id ,int index,AnswerList answerList){
    return   Container(
      height: sySetHeight(100),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          '${answerList.content}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: sySetFontSize(28),
          ),
        ),
        value:  this.checkBoxList[answerList.id.toString()],
        selected: this.checkBoxList[answerList.id.toString()],
        onChanged: (value) {
          setState(() {
            this.checkBoxList[answerList.id.toString()] = value;
            //检测是否存在
            if(checkBoxAll.length > 0){
              checkBoxAll.forEach((key, value) {
                if(key == id.toString()){
                  List test = checkBoxAll[id.toString()];
                  if(test != null && test.length > 0){
                    var index = test.indexOf(answerList.id);
                    if(index != -1){
                      test.removeAt(index);
                    }else{
                      test.add(answerList.id);
                    }
                  }else{
                    test = [];
                    test.add(answerList.id);
                  }
                  checkBoxAll[id.toString()] = test;
                }
              });
            }else{
              List test = [];
              test.add(answerList.id);
              checkBoxAll[id.toString()] = test;
            }


          });
        },
      ),
    );
  }



  //答案完整布局
  _getAnswer(int index,QuestionItem questionItem) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text('${index}.${questionItem.title}'),
            margin: EdgeInsets.all(sySetWidth(20)),
            alignment: Alignment.centerLeft,
          ),
          Container(
            height: sySetHeight(300),
            padding: EdgeInsets.fromLTRB(
                sySetWidth(20), 0, sySetWidth(20), sySetWidth(10)),
            margin: EdgeInsets.fromLTRB(
                sySetWidth(24), sySetWidth(39), sySetWidth(24), 0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(205, 205, 205, 1),
                  width: sySetWidth(1)),
            ),
            child: TextField(
              controller: controllerList[questionItem.id.toString()],
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: '请输入答案...',
                  hintStyle: TextStyle(
                      fontSize: sySetFontSize(28),
                      color: Color.fromRGBO(153, 153, 153, 1)),
                  labelStyle: TextStyle(
                      fontSize: sySetFontSize(28),
                      color: Color.fromRGBO(51, 51, 51, 1)),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }


  //获取单选完整布局
  _getRadioBox(int index,QuestionItem questionItem){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: _radioItemAll(index,questionItem)
      ),
    );
  }
  //单选完整布局方法
  _radioItemAll(int index,QuestionItem questionItem){
    List<Widget> list = [];
    list.add(_ItemTitle(index,questionItem));
    if(questionItem.answerList.length > 0){
      questionItem.answerList.forEach((element) {
        list.add(_radioItemRadio(questionItem.id,index,element));
      });
    }
    return list;
  }
  ///所有布局标题
  _ItemTitle(int index,QuestionItem questionItem){
    return  Container(
      child: Text('${index}.${questionItem.title}'),
      margin: EdgeInsets.all(sySetWidth(20)),
      alignment: Alignment.centerLeft,
    );
  }
  //获取单选布局的每一项
  _radioItemRadio(int id,int index,AnswerList answerList){
    return RadioListTile(
        title: Text(
          '${answerList.content}',
          textAlign: TextAlign.start,
        ),
        value: answerList.id,
        groupValue: this.radioList[index.toString()],
        onChanged: (v) {
          setState(() {
            radioList[index.toString()] = v.toString();
            radioAll[id.toString()] = v.toString();
          });
        });
  }
  _getButtonWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          sySetWidth(30), sySetWidth(140), sySetWidth(30), sySetHeight(30)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: sySetHeight(96),
              child: FlatButton(
                child: Text(
                  '提交',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sySetFontSize(32),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                color: Color.fromRGBO(246, 159, 0, 1),
                onPressed: () {
                  _submitAll();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
