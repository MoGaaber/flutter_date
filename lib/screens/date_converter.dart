import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_date/logic/date_converter.dart';
import 'package:flutter_date/util/screen.dart';
import 'package:flutter_date/widgets/text_field.dart';
import 'package:provider/provider.dart';

class DateConverter extends StatelessWidget {
  static const route = '/dateConverter';

  @override
  Widget build(BuildContext context) {
    DateConverterLogic dateConverterLogic =
        Provider.of<DateConverterLogic>(context);

    Screen screen = Provider.of<Screen>(context);
    return SafeArea(
      child: Scaffold(
        appBar: dateConverterLogic.isKeyBoardVisible
            ? AppBar(
                backgroundColor: Colors.purple,
                title: Text(
                  dateConverterLogic.convertType ==
                          dateConverterLogic.convertToHijri
                      ? 'التحويل من الميلادي إلى الهجري'
                      : 'التحويل من الهجري إلى الميلادي',
                  style: TextStyle(fontSize: 15),
                ),
              )
            : PreferredSize(
                preferredSize:
                    Size.fromHeight(200 / screen.height * screen.height),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/background.jpg',
                      fit: BoxFit.cover,
                      width: screen.width,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                image: new AssetImage(
                                    'assets/images/background.jpg'),
                                fit: BoxFit.cover,
                              ),
                              border: new Border.all(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                        Center(
                            child: Text(
                          dateConverterLogic.convertType ==
                                  dateConverterLogic.convertToGregorian
                              ? 'التحويل من هجري إلى ميلادي'
                              : 'التحويل من ميلادي إلى هجري',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )),
                        Center(
                            child: Text(
                          'وفق تقويم أم القري',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 12),
                        )),
                      ],
                    )
                  ],
                ),
              ),
        backgroundColor: Color(0xffF2F2F6),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Builder(
              builder: (context) => Form(
                onWillPop: dateConverterLogic.onWillPop,
                key: dateConverterLogic.formKey,
                child: Flexible(
                  flex: dateConverterLogic.isKeyBoardVisible ? 19 : 12,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Spacer(),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'اليوم',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  MyTextField(
                                      fieldValidator: (String text) =>
                                          dateConverterLogic.dayValidator(
                                              text, context),
                                      isYearField: false,
                                      textEditingController: dateConverterLogic
                                          .dayTextFieldController)
                                ],
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'الشهر',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  MyTextField(
                                      fieldValidator: (String text) =>
                                          dateConverterLogic.monthValidator(
                                              text, context),
                                      isYearField: false,
                                      textEditingController: dateConverterLogic
                                          .monthTextFieldController)
                                ],
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'السنة',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  MyTextField(
                                      fieldValidator: (String text) {
                                        return dateConverterLogic.yearValidator(
                                            text, context);
                                      },
                                      isYearField: true,
                                      textEditingController: dateConverterLogic
                                          .yearTextFieldController)
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Divider(),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Text('نتيجة التحويل ',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                dateConverterLogic.result == null
                                    ? ''
                                    : dateConverterLogic.convertType ==
                                            dateConverterLogic
                                                .convertToGregorian
                                        ? '${(dateConverterLogic.result as DateTime).day} / ${dateConverterLogic.result.month} / ${dateConverterLogic.result.year}'
                                        : '${dateConverterLogic.result.hDay} / ${dateConverterLogic.result.hMonth} / ${dateConverterLogic.result.hYear}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            ButtonTheme(
              height: 50,
              minWidth: 250,
              child: Center(
                child: Builder(
                  builder: (BuildContext ctx) => FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Colors.purple,
                      onPressed: () {
                        dateConverterLogic.convertType(context);
                      },
                      child: Text(
                        dateConverterLogic.convertType ==
                                dateConverterLogic.convertToHijri
                            ? 'التحويل إلى هجري'
                            : 'التحويل إلى ميلادى',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
