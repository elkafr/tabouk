import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/ad_item/ad_item.dart';
import 'package:tabouk/custom_widgets/no_data/no_data.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/models/ad.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/providers/section_ads_provider.dart';
import 'package:tabouk/ui/ad_details/ad_details_screen.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/utils/error.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'dart:math' as math;



import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/ad_item/ad_item.dart';
import 'package:tabouk/custom_widgets/no_data/no_data.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/models/ad.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/providers/section_ads_provider.dart';
import 'package:tabouk/ui/ad_details/ad_details_screen.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/utils/error.dart';
import 'package:tabouk/providers/home_provider.dart';


import 'package:tabouk/custom_widgets/ad_item/add_item1.dart';
import 'package:tabouk/ui/home/widgets/category_item1.dart';
import 'package:tabouk/ui/section_ads/section_ads_screen.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/ad_item/ad_item.dart';
import 'package:tabouk/custom_widgets/no_data/no_data.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';

import 'package:tabouk/models/ad.dart';
import 'package:tabouk/models/category.dart';
import 'package:tabouk/models/city.dart';
import 'package:tabouk/models/marka.dart';
import 'package:tabouk/models/model.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/providers/navigation_provider.dart';
import 'package:tabouk/ui/ad_details/ad_details_screen.dart';
import 'package:tabouk/ui/home/widgets/category_item.dart';
import 'package:tabouk/ui/home/widgets/map_widget.dart';
import 'package:tabouk/ui/search/search_bottom_sheet.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/ui/account/account_screen.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/utils/error.dart';
import 'package:tabouk/providers/navigation_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:tabouk/custom_widgets/drop_down_list_selector/drop_down_list_selector1.dart';
import 'package:tabouk/custom_widgets/MainDrawer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabouk/custom_widgets/buttons/custom_button.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:tabouk/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/models/category.dart';
import 'package:tabouk/models/city.dart';
import 'package:tabouk/models/country.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/ui/search/search_screen.dart';

import 'dart:math' as math;

class SectionAdsScreen1 extends StatefulWidget {
  final String catId;
  final String adCatName;

  const SectionAdsScreen1({Key key, this.catId, this.adCatName}) : super(key: key);
  @override
  _SectionAdsScreen1State createState() => _SectionAdsScreen1State();
}

class _SectionAdsScreen1State extends State<SectionAdsScreen1> with TickerProviderStateMixin{
double _height = 0 , _width = 0;

AnimationController _animationController;
HomeProvider _homeProvider;

Future<List<City>> _cityList;
Future<List<CategoryModel>> _subList;
City _selectedCity;
CategoryModel _selectedSub;
NavigationProvider _navigationProvider;
bool _initialRun = true;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (_initialRun) {

    _homeProvider = Provider.of<HomeProvider>(context);
    _navigationProvider = Provider.of<NavigationProvider>(context);

    _cityList = _homeProvider.getCityList(enableCountry: false);

    _subList = _homeProvider.getSubList(enableSub: true,catId:_homeProvider.selectedSub!=null?_homeProvider.selectedSub.catId:"0");

    _initialRun = false;
  }
}


Widget _buildBodyItem(){
  return ListView(
    children: <Widget>[
      FutureBuilder<List<City>>(
        future: _cityList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasData) {
              var cityList = snapshot.data.map((item) {
                return new DropdownMenuItem<City>(
                  child: new Text(item.cityName),
                  value: item,
                );
              }).toList();
              cityList.insert(0,DropdownMenuItem<City>(
                child: new Text(_homeProvider.currentLang=="ar"?"كل المدن":"All cities"),
              ));
              return DropDownListSelector1(

                dropDownList: cityList,
                hint: _homeProvider.currentLang=='ar'?'حدد المدينة':'Select city',
                marg: 0.02,
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    _selectedCity = newValue;
                    _homeProvider.setEnableSearch(true);
                    _homeProvider.setSelectedCity(newValue);
                  });
                },
                value: _selectedCity,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      SizedBox(height: _width*.02,),

      _homeProvider.catType!="2" && _homeProvider.fromHome=="1"?FutureBuilder<List<CategoryModel>>(
        future: _subList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasData) {
              var cityList = snapshot.data.map((item) {
                return new DropdownMenuItem<CategoryModel>(
                  child: new Text(item.catName),
                  value: item,
                );
              }).toList();

              return DropDownListSelector1(
                dropDownList: cityList,
                marg: 0.02,
                hint: _homeProvider.currentLang=='ar'?'القسم الفرعي':'Sub Category',
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    _selectedSub = newValue;
                    _homeProvider.setEnableSearch(true);
                    _homeProvider.setSelectedSub(newValue);
                  });
                },
                value: _selectedSub,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ):Text(""),

      SizedBox(height: _width*.02,),
              Container(
          height: _height - (_height*.17),
          width: _width,
          child: FutureBuilder<List<Ad>>(
                  future:  _homeProvider.enableSearch==true
                      ? Provider.of<HomeProvider>(context, listen: false)
                      .getAdsSearchList456()
                      :Provider.of<SectionAdsProvider>(context,
                          listen: false)
                      .getAdsList1(widget.catId) ,
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
                           // errorMessage: "حدث خطأ ما ",
                          );
                        } else {
                          if (snapshot.data.length > 0) {
                     return     GridView.builder(
                         itemCount: snapshot.data.length,
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 2,
                           childAspectRatio: (1 / 1),
                           crossAxisSpacing: 1,
                           mainAxisSpacing: 1,
                         ),
             itemBuilder: (BuildContext context, int index) {
               var count = snapshot.data.length;
                      var animation = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      _animationController.forward();
               return Container(
                 height: _height*.18,
                                        width: _width,
                 child: InkWell(
                   onTap: (){

                     _homeProvider.setCurrentAds(snapshot
                         .data[index].adsId);

                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdDetailsScreen(
                                  ad: snapshot.data[index],
                                  

                                )));
                   },
                   child: AdItem(
                     animationController: _animationController,
                     animation: animation,
                     ad: snapshot.data[index],
                   )));
             }
          );
                          } else {
                            return NoData(message: AppLocalizations.of(context).translate('no_results'));
                          }
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: mainAppColor),
                    );
                  }),
        )
    ],
  );
}

@override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _homeProvider = Provider.of<HomeProvider>(context);


    final appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,

      title:Text(widget.adCatName,style: TextStyle(fontSize: 15,color: omarColor),),
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
              _homeProvider.setSelectedCity(null);
              _homeProvider.setSelectedCat(null);
              _homeProvider.setSelectedSub(null);
              _homeProvider.setEnableSearch(false);
              _navigationProvider.upadateNavigationIndex(0);
              Navigator.pushReplacementNamed(context,  '/navigation');
            }


        )



      ],
    );



    return PageContainer(
      child: Scaffold(
          appBar: appBar,
          body: Stack(

        children: <Widget>[
          _buildBodyItem(),

        ],
      )),
    );
  }
}