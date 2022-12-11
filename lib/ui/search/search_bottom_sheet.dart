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

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({Key key}) : super(key: key);
  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> with ValidationMixin
{
  String _searchKey = '';
  String _priceFrom = '';
  String _priceTo = '';
  Future<List<City>> _cityList;
  Future<List<CategoryModel>> _categoryList;
  Future<List<CategoryModel>> _subList;
  City _selectedCity;
  Country _selectedCountry;
  CategoryModel _selectedCategory;
  bool _initialRun = true;
  HomeProvider _homeProvider;
  CategoryModel _selectedSub;

  List<String> _adsKind;
  String _selectedAdsKind;

  String _xx9="";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _homeProvider = Provider.of<HomeProvider>(context);
      _categoryList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:true ,catId: '0',catName:
      AppLocalizations.of(context).translate('all'),catImage: 'assets/images/all.png'),enableSub: false);

      _subList = _homeProvider.getSubList(enableSub: false,catId:_homeProvider.age!=''?_homeProvider.age:"6");

      _cityList = _homeProvider.getCityList(enableCountry: false);

      _adsKind = _homeProvider.currentLang=="ar"?["العلامات التجارية", "الاخبار", "معارض الصور"]:["Brands ", "News", "Galleries"];

      _initialRun = false;
    }
  }

  Widget build(BuildContext context) {

    var adsKind = _adsKind.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus( FocusNode());
            },
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: ListView(children: <Widget>[

                Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: mainAppColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    child: Text(
                      AppLocalizations.of(context).translate('search_now'),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),

                SizedBox(height: 35,),

                Container(
                  width: constraints.maxWidth,

                  child: CustomTextFormField(
                    hintTxt: _homeProvider.currentLang=="ar"?"رقم الاعلان او عبارة البحث":"Ad number or search term",
                    onChangedFunc: (text) {
                      _searchKey = text;
                    },
                    validationFunc: validateAdPrice,
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.04),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: constraints.maxHeight  * 0.01),
                      child: DropDownListSelector(

                        marg: .07,
                        dropDownList: adsKind,
                        hint:  _homeProvider.currentLang=="ar"?"القسم المطلوب":"Category",
                        onChangeFunc: (newValue) {



                          FocusScope.of(context).requestFocus( FocusNode());
                          setState(() {
                            _selectedAdsKind = newValue;
                          });
                        },
                        value: _selectedAdsKind,
                      ),
                    )),


                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.04),
                  child: FutureBuilder<List<City>>(
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
                          return DropDownListSelector(
                            dropDownList: cityList,
                            marg: .07,
                            hint: AppLocalizations.of(context).translate('choose_city'),
                            onChangeFunc: (newValue) {
                              setState(() {
                                _selectedCity = newValue;
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
                ),






                CustomButton(
                  btnLbl:  AppLocalizations.of(context).translate('search'),
                  onPressedFunction: () {

                    if(_selectedAdsKind=="العلامات التجارية"){
                      _xx9="1";
                    }else if(_selectedAdsKind=="الاخبار"){
                      _xx9="2";
                    }else if(_selectedAdsKind=="معارض الصور"){
                      _xx9="3";
                    }else if(_selectedAdsKind=="Brands"){
                      _xx9="1";
                    }else if(_selectedAdsKind=="News"){
                      _xx9="2";
                    }else if(_selectedAdsKind=="Galleries"){
                      _xx9="3";
                    }

                    _homeProvider.setSearchKey(_searchKey);
                    _homeProvider.setAdsKind(_xx9);
                    _homeProvider.setSelectedCity(_selectedCity);
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchScreen()));




                  },
                ),
              ]),
            ),
          ));
    });
  }
}
