import 'package:tabouk/providers/navigation_provider.dart';
import 'package:tabouk/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/ui/section_ads/section_ads_screen.dart';
import 'package:tabouk/utils/commons.dart';
import 'package:tabouk/custom_widgets/ad_item/ad_item.dart';
import 'package:tabouk/custom_widgets/no_data/no_data.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tabouk/models/ad.dart';
import 'package:tabouk/models/category.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/custom_widgets/buttons/custom_button.dart';
import 'package:tabouk/ui/ad_details/ad_details_screen.dart';
import 'package:tabouk/ui/home/widgets/category_item.dart';
import 'package:tabouk/ui/home/widgets/map_widget.dart';
import 'package:tabouk/ui/search/search_bottom_sheet.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/utils/error.dart';

import 'package:tabouk/providers/auth_provider.dart';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/utils/error.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/providers/about_app_provider.dart';
import 'dart:math' as math;
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;



class CategoriesScreen extends StatefulWidget {


  CategoriesScreen();
  @override
  State<StatefulWidget> createState() {
    return new _CategoriesScreenState();
  }
}


class _CategoriesScreenState extends State<CategoriesScreen> with TickerProviderStateMixin {
  double _height = 0, _width = 0;

  Future<List<CategoryModel>> _categoryList;
  bool _initialRun = true;
  HomeProvider _homeProvider;
  AnimationController _animationController;
  AuthProvider _authProvider;
  NavigationProvider _navigationProvider;



  _CategoriesScreenState();

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();


  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _homeProvider = Provider.of<HomeProvider>(context);
      _navigationProvider = Provider.of<NavigationProvider>(context);
      _categoryList = _homeProvider.getCategoryList123(categoryModel:  CategoryModel(isSelected:true ,catId: '0',catName:
      _homeProvider.currentLang=="ar"?"الكل":"All",catImage: 'assets/images/all.png'),enableSub: false);

    }


  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildBodyItem() {
    final orientation = MediaQuery.of(context).orientation;
    return ListView(
      children: <Widget>[
        Container(
            height: _height*.80,
            color: Colors.white,
            margin: EdgeInsets.all(_width*.01),
            child: FutureBuilder<List<CategoryModel>>(
                future: _categoryList,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    case ConnectionState.active:
                      return Text('');
                    case ConnectionState.waiting:
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Error(
                          errorMessage: snapshot.error.toString(),
                          //errorMessage: "حدث خطأ ما ",
                        );
                      } else {
                        if (snapshot.data.length > 0) {
                          return GridView.builder(
                              itemCount: snapshot.data.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: (3 / 2),
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                              ),

                              itemBuilder: (BuildContext context, int index) {

                                return Consumer<HomeProvider>(

                                    builder: (context, homeProvider, child) {

                                      return Container(


                                         alignment: Alignment.center,
                                        padding: EdgeInsets.all(_width*.01),

                                          child: InkWell(
                                              onTap: () {
                                                //_homeProvider.updateSelectedCategory(snapshot.data[index]);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => SectionAdsScreen(catId:snapshot.data[index].catId,adCatName: snapshot.data[index].catName))
                                                );

                                                _homeProvider.setSelectedCat(snapshot.data[index]);
                                                _homeProvider.setCatType(snapshot.data[index].catType);
                                                _homeProvider.setFromHome("1");

                                              },
                                              child: Stack(
                                                children: <Widget>[
                                              Container(


                                                decoration: BoxDecoration(
                                                  color: mainAppColor,
                                                  borderRadius: BorderRadius.circular(25.0),


                                                ),
                                                child:     ClipRRect(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  child:Image.network(snapshot.data[index].catImage,   fit: BoxFit.fill,
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                  ),
                                                ),

                                              ),
                                                  Positioned.fill(
                                                    top: _width*.2,

                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Text(snapshot.data[index].catName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 14,     shadows: [
                                                        Shadow(
                                                          blurRadius: 10.0,
                                                          color: Colors.red,
                                                          offset: Offset(3.0, 4.0),
                                                        ),
                                                      ],),),
                                                    ),
                                                  ),

                                                ],
                                              )
                                          ));



                                    });
                              });
                        } else {
                          return NoData(message: 'لاتوجد نتائج');
                        }
                      }
                  }
                  return Center(
                    child: SpinKitFadingCircle(color: mainAppColor),
                  );
                })),





      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    _authProvider = Provider.of<AuthProvider>(context);



    final appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,

      title:Text(_homeProvider.currentLang=="ar"?"الفئات":"Categories",style: TextStyle(fontSize: 15,color: omarColor),),
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
            onPressed: (){
              _navigationProvider.upadateNavigationIndex(0);
              Navigator.pushReplacementNamed(context,  '/navigation');
            }


        )



      ],
    );


    _height =  MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;


    return PageContainer(
      child: Scaffold(
        appBar: appBar,
        body: _buildBodyItem(),

      ),
    );
  }
}
