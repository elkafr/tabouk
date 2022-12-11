import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/ui/add_ad/add_ad_screen.dart';
import 'package:tabouk/utils/error.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/providers/about_app_provider.dart';
import 'dart:math' as math;
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class PackagesScreen extends StatefulWidget {
  @override
  _PackagesScreenState createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
double _height = 0 , _width = 0;
HomeProvider _homeProvider;
String omar1="";
String omar2="";
String omar3="";
String omar4="";


Widget _buildBodyItem(){
  return SingleChildScrollView(
    child: Container(

      width: _width,
      child: Row(
     
        children: <Widget>[
          Padding(padding: EdgeInsets.all(3)),

          Container(
            width: _width*.24,
            child:Column(
              children: <Widget>[

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5)),

                    color: Color(0xff898989),

                  ),

                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"الباقات":"Packages",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),

                  height: _width*.12,
                ),

                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"الاشتراك سنة":"year subscription",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),

                  height: _width*.15,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(".",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"البروفيل":"Profile",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"اعجاب":"Like",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"تعليق	":"Comment",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"رقم جوال	":"Phone number",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"طباعة	":"Print	",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(".",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"تعديل قالب الصفحة	":"Edit page template",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"اضافة المحتوى من قبل فريق الدليل	":"Added content by the guide team",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"اضافة خريطة	":"Add a map",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"استلام الطلب":"Receipt of the request",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"سوشيال ميديا	":"social media	",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"ادوات التواصل ( ايميل الموقع )	":"Communication tools (website email)	",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"واتساب	":"Whatsapp	",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"اضافة معرض فيديو	":"Add a video gallery",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(".	",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"حملات اعلانية SMS	":"SMS advertising campaigns	",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"وسائل تسويقية	":"Marketing media	",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"مقال":"article",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"الاكثر دعماً		":"most supportive",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"شعار فى الموقع	":"logo on the site",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"تسويق في السوشيال ميديا	":"Marketing in social media	",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"نشرات بريدية		":"Postcards	",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"عدد الزيارات والاعجاب		":"Number of visits and likes",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),



                Container(


                  height: _width*.07,

                )



              ],
            ),
          ),



         Padding(padding: EdgeInsets.all(3)),

// البلاتيني
          Container(
            width: _width*.17,
            child:Column(
              children: <Widget>[

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5)),

                    color: Color(0xffD99E6E),

                  ),

                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"البلاتيني":"Platinum",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),

                  height: _width*.12,
                ),

                                        Container(
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        width: _width,
                                        child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            FutureBuilder<String>(
                                                future: Provider.of<HomeProvider>(context,
                                                    listen: false)
                                                    .getPackage1Price2() ,
                                                builder: (context, snapshot) {
                                                  switch (snapshot.connectionState) {
                                                    case ConnectionState.none:
                                                      return Center(
                                                        child: SpinKitFadingCircle(color: Colors.black),
                                                      );
                                                    case ConnectionState.active:
                                                      return Text('');
                                                    case ConnectionState.waiting:
                                                      return Center(
                                                        child: SpinKitFadingCircle(color: Colors.black),
                                                      );
                                                    case ConnectionState.done:
                                                      if (snapshot.hasError) {
                                                        return Error(
                                                          //  errorMessage: snapshot.error.toString(),
                                                          errorMessage: AppLocalizations.of(context).translate('error'),
                                                        );
                                                      } else {
                                                         omar1=snapshot.data;

                                                        return Text("$omar1 "+AppLocalizations.of(context).translate("sr"),style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),);
                                                      }
                                                  }
                                                  return Center(
                                                    child: SpinKitFadingCircle(color: mainAppColor),
                                                  );
                                                }),
                                               Padding(padding: EdgeInsets.all(3)),
                                           Container(
                                             padding: EdgeInsets.all(5),
                                             color: Colors.green,
                                             child:  GestureDetector(
                                               child: Text(_homeProvider.currentLang=="ar"?"اختيار":"Select",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                               onTap: (){
                                                 _homeProvider.setPackageId("1");
                                                 _homeProvider.setPackagePeriod("12");
                                                 _homeProvider.setPackagePrice(omar1);

                                                 print(_homeProvider.packageId);
                                                 print(_homeProvider.packagePeriod);
                                                 print(_homeProvider.packagePrice);

                                                 Navigator.push(
                                                     context,
                                                     MaterialPageRoute(
                                                         builder: (context) => AddAdScreen()));


                                               },
                                             ),
                                           )
                                          ],
                                        ),

                                        height: _width*.15,
                                        ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"المميزات الاساسية	":"basic features	",style: TextStyle(color: Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"المميزات المتقدمة	":"Advanced Features	",style: TextStyle(color: Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"التسويق	":"Marketing	",style: TextStyle(color: Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),

                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.green,
                  child:  GestureDetector(
                    child: Text(_homeProvider.currentLang=="ar"?"اختيار":"Select",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    onTap: (){
                      _homeProvider.setPackageId("1");
                      _homeProvider.setPackagePeriod("12");
                      _homeProvider.setPackagePrice(omar1);

                      print(_homeProvider.packageId);
                      print(_homeProvider.packagePeriod);
                      print(_homeProvider.packagePrice);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAdScreen()));


                    },
                  ),
                )
              ],
            ),
          ),









          Padding(padding: EdgeInsets.all(3)),

// البلاتيني
          Container(
            width: _width*.17,
            child:Column(
              children: <Widget>[

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5)),

                    color: Color(0xff6FB640),

                  ),

                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"الذهبي":"golden",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),

                  height: _width*.12,
                ),

                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FutureBuilder<String>(
                          future: Provider.of<HomeProvider>(context,
                              listen: false)
                              .getPackage2Price2() ,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Center(
                                  child: SpinKitFadingCircle(color: Colors.black),
                                );
                              case ConnectionState.active:
                                return Text('');
                              case ConnectionState.waiting:
                                return Center(
                                  child: SpinKitFadingCircle(color: Colors.black),
                                );
                              case ConnectionState.done:
                                if (snapshot.hasError) {
                                  return Error(
                                    //  errorMessage: snapshot.error.toString(),
                                    errorMessage: AppLocalizations.of(context).translate('error'),
                                  );
                                } else {
                                  omar2=snapshot.data;

                                  return Text("$omar2 "+AppLocalizations.of(context).translate("sr"),style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),);
                                }
                            }
                            return Center(
                              child: SpinKitFadingCircle(color: mainAppColor),
                            );
                          }),
                      Padding(padding: EdgeInsets.all(3)),
                      Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.green,
                        child: GestureDetector(
                          child: Text(_homeProvider.currentLang=="ar"?"اختيار":"Select",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          onTap: (){
                            _homeProvider.setPackageId("2");
                            _homeProvider.setPackagePeriod("12");
                            _homeProvider.setPackagePrice(omar2);

                            print(_homeProvider.packageId);
                            print(_homeProvider.packagePeriod);
                            print(_homeProvider.packagePrice);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAdScreen()));


                          },
                        ),
                      )
                    ],
                  ),

                  height: _width*.15,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"المميزات الاساسية	":"basic features	",style: TextStyle(color: Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                  Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"المميزات المتقدمة	":"Advanced Features	",style: TextStyle(color: Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                  ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"التسويق	":"Marketing	",style: TextStyle(color: Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),

                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.green,
                  child: GestureDetector(
                    child: Text(_homeProvider.currentLang=="ar"?"اختيار":"Select",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    onTap: (){
                      _homeProvider.setPackageId("2");
                      _homeProvider.setPackagePeriod("12");
                      _homeProvider.setPackagePrice(omar2);

                      print(_homeProvider.packageId);
                      print(_homeProvider.packagePeriod);
                      print(_homeProvider.packagePrice);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAdScreen()));


                    },
                  ),
                )
              ],
            ),
          ),











          Padding(padding: EdgeInsets.all(3)),

// البلاتيني
          Container(
            width: _width*.17,
            child:Column(
              children: <Widget>[

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5)),

                    color: Color(0xffF9BB12),

                  ),

                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"الفضي":"silver",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),

                  height: _width*.12,
                ),

                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FutureBuilder<String>(
                          future: Provider.of<HomeProvider>(context,
                              listen: false)
                              .getPackage3Price2() ,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Center(
                                  child: SpinKitFadingCircle(color: Colors.black),
                                );
                              case ConnectionState.active:
                                return Text('');
                              case ConnectionState.waiting:
                                return Center(
                                  child: SpinKitFadingCircle(color: Colors.black),
                                );
                              case ConnectionState.done:
                                if (snapshot.hasError) {
                                  return Error(
                                    //  errorMessage: snapshot.error.toString(),
                                    errorMessage: AppLocalizations.of(context).translate('error'),
                                  );
                                } else {
                                  omar3=snapshot.data;

                                  return Text("$omar3 "+AppLocalizations.of(context).translate("sr"),style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),);
                                }
                            }
                            return Center(
                              child: SpinKitFadingCircle(color: mainAppColor),
                            );
                          }),
                      Padding(padding: EdgeInsets.all(3)),
                     Container(
                       color: Colors.green,
                       padding: EdgeInsets.all(5),
                       child:  GestureDetector(
                         child: Text(_homeProvider.currentLang=="ar"?"اختيار":"Select",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                         onTap: (){
                           _homeProvider.setPackageId("3");
                           _homeProvider.setPackagePeriod("12");
                           _homeProvider.setPackagePrice(omar3);

                           print(_homeProvider.packageId);
                           print(_homeProvider.packagePeriod);
                           print(_homeProvider.packagePrice);

                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => AddAdScreen()));


                         },
                       ),
                     )
                    ],
                  ),

                  height: _width*.15,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"المميزات الاساسية	":"basic features	",style: TextStyle(color: Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                  Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"المميزات المتقدمة	":"Advanced Features",style: TextStyle(color: Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                  ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"التسويق	":"Marketing	",style: TextStyle(color: Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),

                Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(5),
                  child:  GestureDetector(
                    child: Text(_homeProvider.currentLang=="ar"?"اختيار":"Select",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    onTap: (){
                      _homeProvider.setPackageId("3");
                      _homeProvider.setPackagePeriod("12");
                      _homeProvider.setPackagePrice(omar3);

                      print(_homeProvider.packageId);
                      print(_homeProvider.packagePeriod);
                      print(_homeProvider.packagePrice);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAdScreen()));


                    },
                  ),
                )
              ],
            ),
          ),





          Padding(padding: EdgeInsets.all(3)),

// البلاتيني
          Container(
            width: _width*.17,
            child:Column(
              children: <Widget>[

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5)),

                    color: Color(0xff3CBEE8),

                  ),

                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"البرونزي":"bronze",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),

                  height: _width*.12,
                ),

                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FutureBuilder<String>(
                          future: Provider.of<HomeProvider>(context,
                              listen: false)
                              .getPackage4Price2() ,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Center(
                                  child: SpinKitFadingCircle(color: Colors.black),
                                );
                              case ConnectionState.active:
                                return Text('');
                              case ConnectionState.waiting:
                                return Center(
                                  child: SpinKitFadingCircle(color: Colors.black),
                                );
                              case ConnectionState.done:
                                if (snapshot.hasError) {
                                  return Error(
                                    //  errorMessage: snapshot.error.toString(),
                                    errorMessage: AppLocalizations.of(context).translate('error'),
                                  );
                                } else {
                                  omar4=snapshot.data;

                                  return Text("$omar4 "+AppLocalizations.of(context).translate("sr"),style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),);
                                }
                            }
                            return Center(
                              child: SpinKitFadingCircle(color: mainAppColor),
                            );
                          }),
                      Padding(padding: EdgeInsets.all(3)),
                      Container(
                        color: Colors.green,
                        padding: EdgeInsets.all(5),
                        child: GestureDetector(
                          child: Text(_homeProvider.currentLang=="ar"?"اختيار":"Select",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          onTap: (){
                            _homeProvider.setPackageId("4");
                            _homeProvider.setPackagePeriod("12");
                            _homeProvider.setPackagePrice(omar4);

                            print(_homeProvider.packageId);
                            print(_homeProvider.packagePeriod);
                            print(_homeProvider.packagePrice);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAdScreen()));

                          },
                        ),
                      )
                    ],
                  ),

                  height: _width*.15,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"المميزات الاساسية	":"basic features",style: TextStyle(color:Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.check,color: Color(0xffFEA100),size: 25,),
                  height: _width*.12,
                ),
                  Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"المميزات المتقدمة	":"Advanced Features",style: TextStyle(color: Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                  ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Text(_homeProvider.currentLang=="ar"?"التسويق	":"Marketing	",style: TextStyle(color: Color(0xffFEA100),fontSize: 12,fontWeight: FontWeight.bold),),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  width: _width,
                  child:Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: _width,
                  child: Icon(Icons.close,color: Colors.red,size: 25,),
                  height: _width*.12,
                ),

                Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                    child: Text(_homeProvider.currentLang=="ar"?"اختيار":"Select",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    onTap: (){
                      _homeProvider.setPackageId("4");
                      _homeProvider.setPackagePeriod("12");
                      _homeProvider.setPackagePrice(omar4);

                      print(_homeProvider.packageId);
                      print(_homeProvider.packagePeriod);
                      print(_homeProvider.packagePrice);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAdScreen()));

                    },
                  ),
                )
              ],
            ),
          )











        ],
      ),
    ),
  );
}

@override
  Widget build(BuildContext context) {
  _height =
      _height =  MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  _width = MediaQuery.of(context).size.width;
  _homeProvider = Provider.of<HomeProvider>(context);


  final appBar = AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,

    title:Text(_homeProvider.currentLang=="ar"?"الباقات":"Packages",style: TextStyle(fontSize: 15,color: omarColor),),
    actions: <Widget>[


      IconButton(
          icon: Consumer<AuthProvider>(
            builder: (context,authProvider,child){
              return authProvider.currentLang == 'ar' ? Image.asset(
                'assets/images/left.png',
                color: omarColor,
              ): Transform.rotate(
                  angle: 180 * math.pi / 180,
                  child:  Image.asset(
                    'assets/images/left.png',
                    color: omarColor,
                  ));
            },
          ),
          onPressed: () =>
              Navigator.pop(context)

      )



    ],
  );





    return PageContainer(

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,

        body: _buildBodyItem(),
      ),
    );
  }
}