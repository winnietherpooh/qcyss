import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yssqc/common/apis/SignSalary.dart';
import 'package:yssqc/common/util/screen.dart';
import 'package:yssqc/common/widgets/appbarWidget.dart';
import 'package:yssqc/common/widgets/toast.dart';
import 'package:yssqc/model/SignSalaryRequestModel.dart';
import 'package:yssqc/model/responseModel.dart';
import 'package:yssqc/common/router/router.gr.dart';

class SignViewPage extends StatefulWidget {
  Uint8List imageData;
  final SignSalaryRequestModel salaryRequestModel;
  SignViewPage(this.imageData,this.salaryRequestModel);

  @override
  _SignViewPageState createState() => _SignViewPageState();
}

class _SignViewPageState extends State<SignViewPage> {


  _comfimUpload(){
    showConfim(context,'确认工资无误?',_doUploadImg);
  }

  _doUploadImg(){
     showLoading(context,"正在提交");
    _shareUiImage();
  }
  _shareUiImage() async {

    Uint8List sourceBytes = widget.imageData;
    Directory tempDir = await getTemporaryDirectory();
    String storagePath = tempDir.path;
    File file = new File('$storagePath/sign.png');
    //this.widget.salaryRequestModel.signIMg = file.toString();
    this.widget.salaryRequestModel.signIMg = '/sign.png';
    bool isDirExist = await Directory(storagePath).exists();

    if(!isDirExist) Directory(storagePath).create();
    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsBytesSync(sourceBytes);
    ResponseModel responseModel =await SignImageUploadApi.getData(
        context: context,
        salaryRequestModel: this.widget.salaryRequestModel,
        file: file);
    if(responseModel.error == 200){
      Navigator.pop(context);
       showSuccessRoute(context,_gotoCenter,text: responseModel.message,times:500);
    }else{
      showError(responseModel.message);
    }
  }
  _gotoCenter(){
    ExtendedNavigator.rootNavigator.pushTabsRoute(index: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWidget(context,'签名确认'),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(
                  sySetWidth(24), sySetWidth(70), sySetWidth(24), 0),
                width: sySetWidth(700),
                height: sySetHeight(300),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/signbg.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: RotatedBox(
                quarterTurns: 3,
                child: Image.memory(
                  widget.imageData,

                  fit: BoxFit.fill,
                ),
              )
            ),
            SizedBox(
              height: sySetHeight(60),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: sySetHeight(96),
                    padding: EdgeInsets.fromLTRB(
                        sySetWidth(32), 0, sySetWidth(32), 0),
                    //因为有他,所以可以设置宽高
                    child: FlatButton(
                      child: Text(
                        '确认',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sySetFontSize(32),
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      color: Color.fromRGBO(246, 159, 0, 1),
                      onPressed: () {
                        _comfimUpload();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
