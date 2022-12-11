
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

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> with TickerProviderStateMixin {
  double _height = 0, _width = 0;
  NavigationProvider _navigationProvider;
  Future<List<CategoryModel>> _categoryList;
  Future<List<CategoryModel>> _categoryList1;
  Future<List<CategoryModel>> _categoryList2;
  Future<List<CategoryModel>> _subList;
  Future<List<CategoryModel>> _subList1;
  bool _initialRun = true;
  HomeProvider _homeProvider;
  AnimationController _animationController;
  AuthProvider _authProvider;

  Future<List<City>> _cityList;
  City _selectedCity;

  Future<List<Marka>> _markaList;
  Marka _selectedMarka;

  Future<List<Model>> _modelList;
  Model _selectedModel;

  CategoryModel _selectedSub;
  CategoryModel _selectedSub1;
  String _selectedCat;
  bool _isLoading = false;

  String _xx=null;
  String omar="";



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
      _categoryList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:true ,catId: '0',catName:
      _homeProvider.currentLang=="ar"?"الكل":"All",catImage: 'assets/images/all.png'),enableSub: false);


      _categoryList1 = _homeProvider.getCategoryList1(categoryModel:  CategoryModel(isSelected:true ,catId: '0',catName:
      _homeProvider.currentLang=="ar"?"الكل":"All",catImage: 'assets/images/all.png'),enableSub: false);




      _categoryList2 = _homeProvider.getCategoryList2(categoryModel:  CategoryModel(isSelected:true ,catId: '0',catName:
      _homeProvider.currentLang=="ar"?"الكل":"All",catImage: 'assets/images/all.png'),enableSub: false);


      _subList = _homeProvider.getSubList(enableSub: false,catId:_homeProvider.age!=''?_homeProvider.age:"6");



      _subList1 = _homeProvider.getSubList1(enableSub: false,catId:_homeProvider.age!=''?_homeProvider.age:"6");


      _cityList = _homeProvider.getCityList(enableCountry: false);
      _markaList = _homeProvider.getMarkaList();
      _modelList = _homeProvider.getModelList();
      _initialRun = false;
    }
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildBodyItem() {
    print("Sssssssssssssssssssssssssss");
    print(_homeProvider.catId);
    print("Sssssssssssssssssssssssssss");
    return SingleChildScrollView(
      child: Column(

        children: <Widget>[






          Container(
              height: _height * 0.15,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(5,5,5,0),
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
                            //  errorMessage: snapshot.error.toString(),
                            errorMessage: "حدث خطأ ما ",
                          );
                        } else {
                          if (snapshot.data.length > 0) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {

                                  return Consumer<HomeProvider>(
                                      builder: (context, homeProvider, child) {
                                        return InkWell(
                                          onTap: (){


                                            homeProvider
                                                .updateChangesOnCategoriesList(index);

                                            homeProvider.setEnableSearch(true);

                                            _homeProvider.setSelectedCat(snapshot.data[index]);
                                            print(_homeProvider.selectedCat.catId+"ssssssssssssss");

                                            _selectedSub=null;
                                            _selectedCity=null;
                                            _homeProvider.setSelectedSub(_selectedSub);
                                            _homeProvider.setSelectedCity(_selectedCity);



                                            _homeProvider.setSelectedCat(snapshot.data[index]);
                                            _homeProvider.setCatId(snapshot.data[index].catId);
                                            _homeProvider.setCatName(snapshot.data[index].catName);
                                            _homeProvider.setAge(snapshot.data[index].catId);

                                            _homeProvider.setAge(snapshot.data[index].catId);

                                            _xx=_homeProvider.selectedCat.catId;
                                            _subList = _homeProvider.getSubList(enableSub: true,catId:_homeProvider.age!=''?_homeProvider.age:"6");



                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Color(0xffFCFCFC),
                                            width: _width * 0.25,
                                            child: CategoryItem(
                                              category: snapshot.data[index],
                                            ),
                                          ),
                                        );
                                      });
                                });
                          } else {
                            return NoData(message: _homeProvider.currentLang=="ar"?'لاتوجد نتائج':'No results');
                          }
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: mainAppColor),
                    );
                  })),
          Container(height: 5,),
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
                    hint: _homeProvider.currentLang=='ar'?'كل المدن':'All Regions',
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

          (_homeProvider.selectedCat!=null)?SizedBox(height: _width*.01,):Text(""),

          (_homeProvider.selectedCat!=null && _homeProvider.selectedCat.catId!="0")?FutureBuilder<List<CategoryModel>>(
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
          ):Text(' ',style: TextStyle(height: 0),),



          Consumer<HomeProvider>(builder: (context, homeProvider, child) {
            return FutureBuilder<List<Ad>>(
                future: homeProvider.enableSearch==true
                    ? Provider.of<HomeProvider>(context, listen: true)
                    .getAdsSearchList()
                    : Provider.of<HomeProvider>(context, listen: true)
                    .getAdsList(),
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

                          return Container(
                            alignment: Alignment.centerLeft,
                            width: _width*.98,
                            height: _height-(_height*.50),
                            child: GridView.builder(
                                itemCount: snapshot.data.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: (1 / 1),
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 1,
                                ),
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  var count = snapshot.data.length;
                                  var animation =
                                  Tween(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                      parent: _animationController,
                                      curve: Interval(
                                          (1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn),
                                    ),
                                  );
                                  _animationController.forward();
                                  return Container(
                                      height: _height,
                                      width: _width,
                                      child: InkWell(
                                          onTap: () {
                                            _homeProvider.setCurrentAds(snapshot
                                                .data[index].adsId);
                                            _homeProvider.setOmarKey(omar);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdDetailsScreen(
                                                          ad: snapshot
                                                              .data[index],
                                                        )));
                                          },
                                          child: AdItem(
                                            animationController:
                                            _animationController,
                                            animation: animation,
                                            ad: snapshot.data[index],
                                          )));
                                }),
                          );

                        } else {
                          return NoData(message: _homeProvider.currentLang=="ar"?'لاتوجد نتائج':'No results');
                        }
                      }
                  }
                  return Center(
                    child: SpinKitFadingCircle(color: mainAppColor),
                  );
                });
          }),


          CustomButton(
            btnLbl:_homeProvider.currentLang=="ar"?"المزيد":"More",
            onPressedFunction: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SectionAdsScreen(catId: _homeProvider.catId!=""?_homeProvider.catId:"0",adCatName: _homeProvider.catName!=""?_homeProvider.catName:"الكل",))
              );



            },
          ),



























         /* Container(
              height: _height * 0.15,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(5,5,5,0),
              child: FutureBuilder<List<CategoryModel>>(
                  future: _categoryList2,
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
                            //  errorMessage: snapshot.error.toString(),
                            errorMessage: "حدث خطأ ما ",
                          );
                        } else {
                          if (snapshot.data.length > 0) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {

                                  return Consumer<HomeProvider>(
                                      builder: (context, homeProvider, child) {
                                        return InkWell(
                                          onTap: (){


                                            homeProvider
                                                .updateChangesOnCategoriesList2(index);

                                            homeProvider.setEnableSearch2(true);
                                            homeProvider.setEnableSearch1(false);
                                            homeProvider.setEnableSearch(false);

                                            _homeProvider.setSelectedCat(snapshot.data[index]);
                                            print(_homeProvider.selectedCat.catId+"ssssssssssssss");

                                            _selectedSub=null;
                                            _selectedMarka=null;
                                            _selectedModel=null;
                                            _selectedCity=null;
                                            _homeProvider.setSelectedSub(_selectedSub);
                                            _homeProvider.setSelectedCity(_selectedCity);



                                            _homeProvider.setSelectedCat(snapshot.data[index]);
                                            _homeProvider.setCatId(snapshot.data[index].catId);
                                            _homeProvider.setCatName(snapshot.data[index].catName);
                                            _homeProvider.setAge(snapshot.data[index].catId);


                                            _homeProvider.setAge(snapshot.data[index].catId);

                                            _xx=_homeProvider.selectedCat.catId;
                                            _subList = _homeProvider.getSubList(enableSub: true,catId:_homeProvider.age!=''?_homeProvider.age:"6");



                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Color(0xffFCFCFC),
                                            width: _width * 0.25,
                                            child: CategoryItem1(
                                              category: snapshot.data[index],
                                            ),
                                          ),
                                        );
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




          Container(height: 5,),
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
                    hint: _homeProvider.currentLang=='ar'?'كل المدن':'All Regions',
                    marg: 0.02,
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        _selectedCity = newValue;
                        _homeProvider.setEnableSearch2(true);
                        _homeProvider.setEnableSearch1(false);
                        _homeProvider.setEnableSearch(false);
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
          ),*/

















        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _navigationProvider = Provider.of<NavigationProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);


    
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _navigationProvider = Provider.of<NavigationProvider>(context);

    return Stack(
      children: <Widget>[
        _buildBodyItem()
      ],
    );
  }
}
