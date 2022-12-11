
import 'package:tabouk/custom_widgets/ad_item/add_item1.dart';

import 'package:tabouk/ui/home/widgets/category_item1.dart';
import 'package:tabouk/ui/home/widgets/slider_images.dart';
import 'package:tabouk/ui/section_ads/section_ads_screen.dart';
import 'package:tabouk/ui/section_ads/section_ads_screen1.dart';
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
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';





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
  Future<List<CategoryModel>> _categoryList3;
  Future<List<CategoryModel>> _categoryList4;
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


      _categoryList = _homeProvider.getCategoryListHome(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      _homeProvider.currentLang=="ar"?"الكل":"All",catImage: 'assets/images/all.png'),enableSub: false);





      _categoryList4 = _homeProvider.getCategoryListHome4(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      _homeProvider.currentLang=="ar"?"الكل":"All",catImage: 'assets/images/all.png'),enableSub: false);


      _subList = _homeProvider.getSubList(enableSub: false,catId:_homeProvider.age!=''?_homeProvider.age:"6");




      _cityList = _homeProvider.getCityList(enableCountry: false);
      _markaList = _homeProvider.getMarkaList();
      _modelList = _homeProvider.getModelList();
      _initialRun = false;
    }
  }


  Widget myPhotoList(String MyImages) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              MyImages),
        ),
      ),

    );
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
         decoration: BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(50.0)),
         ),
         margin: EdgeInsets.only(right: _width*.04,left: _width*.04),
         child: SliderImages(),
       ),


          Container(
              height: _height*.64,
              color: Colors.white,
              margin: EdgeInsets.only(top: _width*.01,right: _width*.02,left: _width*.02),
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
                            return StaggeredGridView.countBuilder(
                                itemCount: snapshot.data.length,
                              crossAxisCount: 2,

                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              staggeredTileBuilder: (index) => StaggeredTile.count(index==4 || index==7 || index==10 || index==11 || index==12 || index==15?2:1,index==4 || index==7 || index==10 || index==11 || index==12 || index==15?0.8:.8),

                                itemBuilder: (BuildContext context, int index) {

                                  return Consumer<HomeProvider>(

                                      builder: (context, homeProvider, child) {

                                        return Container(


                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(_width*.02),

                                            child: InkWell(
                                                onTap: () {
                                                  //_homeProvider.updateSelectedCategory(snapshot.data[index]);
                                                  snapshot.data[index].catType=="2"?Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => SectionAdsScreen(catId:snapshot.data[index].catId,adCatName: snapshot.data[index].catName))
                                                  ):Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => SectionAdsScreen1(catId:snapshot.data[index].catId,adCatName: snapshot.data[index].catName))
                                                  );

                                                  snapshot.data[index].catType=="2"?_homeProvider.setSelectedCat(snapshot.data[index]):_homeProvider.setSelectedSub(snapshot.data[index]);
                                                  _homeProvider.setCatType(snapshot.data[index].catType);
                                                  _homeProvider.setFromHome("0");

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
                                                      top: _width*.23,

                                                      child: Align(
                                                        alignment: Alignment.center,
                                                        child: Text(snapshot.data[index].catName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15, shadows: [
                                                        Shadow(
                                                        blurRadius: 10.0,
                                                        color: Colors.red,
                                                        offset: Offset(3.0, 4.0),
                                                        ),
                                                          ]),),
                                                      ),
                                                    ),

                                                  ],
                                                )
                                            ));



                                      });
                                },


                                );
                          } else {
                            return NoData(message: 'لاتوجد نتائج');
                          }
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: mainAppColor),
                    );
                  }))


































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
