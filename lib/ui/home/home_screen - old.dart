

import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tabouk/shared_preferences/shared_preferences_helper.dart';
import 'package:tabouk/ui/drower/drower_screen.dart';
import 'package:tabouk/ui/home/home_map.dart';
import 'package:flutter/services.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'dart:math' as math;
import 'package:tabouk/custom_widgets/custom_text_form_field/custom_text_form_field1.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/ui/search/search_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/commons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

AuthProvider _authProvider;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double _height = 0, _width = 0;
  bool isDrawerOpen = false;
String _searchKey = '';
HomeProvider _homeProvider;
bool _initialRun = true;
  String _lang;
bool _isLoading = false;


Future<Null> _checkEnd() async {





}






@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (_initialRun) {
    _homeProvider = Provider.of<HomeProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);
    _initialRun = false;

  }
}


  Future<void> _getLanguage() async {
    String language = await SharedPreferencesHelper.getUserLang();
    setState(() {
      _lang = language;
    });
  }
  Widget _customAppBar() {
    return Container(


      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: isDrawerOpen
            ? Text("")
            : GestureDetector(
            child:
            _lang == 'ar' ?
            Image.asset( 'assets/images/menu.png', fit: BoxFit.contain,)

                : Transform.rotate(
              angle: -180 * math.pi / 180,
              child:  Image.asset(
                'assets/images/menu.png',
                fit: BoxFit.contain,
              ),
            ),
            onTap: () {
              setState(() {
                xOffset = (_lang == 'ar')? -200 : 290 ;
                yOffset = 80;
                scaleFactor = 0.8;
                isDrawerOpen = true;
              });
            }),
        title:  Container(
          padding: EdgeInsets.only(top: 2,bottom: 2),
          alignment: Alignment.center,
          child: Image.asset('assets/images/toplogo.png'),
        ),
        trailing:      GestureDetector(
            onTap: () {
              _homeProvider.setSelectedCat(null);
              _homeProvider.setSelectedSub(null);
              _homeProvider.setSelectedCity(null);
              _homeProvider.setAdsKind(null);
              showModalBottomSheet<dynamic>(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  context: context,
                  builder: (builder) {
                    return Container(
                        width: _width,
                        height: _height * 0.60,
                        child: SearchBottomSheet());
                  });
            },
            child: Image.asset('assets/images/search.png')),
      ),
    );
  }
  




  @override
  void initState() {
    super.initState();


    _getLanguage();



  }

  @override
  Widget build(BuildContext context) {

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              (isDrawerOpen == false) ? Brightness.dark : Brightness.light),
      child: Scaffold(
        body: Stack(
          children: [
            AppDrawer(),
           
            AnimatedContainer(
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor)
                ..rotateY(isDrawerOpen ? -0.5 : 0),
              duration: Duration(milliseconds: 250),
              decoration: BoxDecoration(
                color: Colors.white,
               borderRadius: BorderRadius.circular(isDrawerOpen?20:0.0)
              ),
              child: Container(


                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(
                      height: 5,
                    ),
                   _customAppBar(),
                    Container(

                      height: _height * 0.82,
                      width: _width,
                      child: Stack(children: [


                        HomeMap(),



                        isDrawerOpen
                            ? Container(
                          margin: EdgeInsets.all(0),
                          color: Colors.black,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios,size: 40,color: Colors.white,),
                            onPressed: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                scaleFactor = 1;
                                isDrawerOpen = false;
                              });
                            },
                          ),
                        ):Text(""),





                      ]),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
}