import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/models/ad.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/providers/favourite_provider.dart';
import 'package:tabouk/ui/favourite/favourite_screen.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/urls.dart';
import 'package:provider/provider.dart';

class AdItem extends StatefulWidget {
  
  final AnimationController animationController;
  final Animation animation;
  final bool insideFavScreen;
  final Ad ad;

  const AdItem({Key key, this.insideFavScreen = false, this.ad, this.animationController, this.animation}) : super(key: key);
  @override
  _AdItemState createState() => _AdItemState();
}

class _AdItemState extends State<AdItem> {
double _height = 0 ,_width = 0;
  bool _initialRun = true;
  AuthProvider _authProvider;
  FavouriteProvider _favouriteProvider;
  ApiProvider _apiProvider = ApiProvider();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _authProvider = Provider.of<AuthProvider>(context);
      _favouriteProvider = Provider.of<FavouriteProvider>(context);

      if (widget.ad.adsIsFavorite == 1 && _authProvider.currentUser != null) {
        _favouriteProvider.addItemToFavouriteAdsList(
            widget.ad.adsId, widget.ad.adsIsFavorite);
      }
      print('favourite' + widget.ad.adsIsFavorite.toString());
      _initialRun = false;
    }
  }

  Widget _buildItem(String title,String imgPath){
    return Row(
      children: <Widget>[
   Image.asset(imgPath,color: Colors.grey[400],
   height: _height *0.14,
   width: 20,
   ),
Consumer<AuthProvider>(
  builder: (context,authProvider,child){
    return  Container(
  margin: EdgeInsets.only(left: authProvider.currentLang == 'ar' ? 0 : 2,right:  authProvider.currentLang == 'ar' ? 2 : 0 ),
  child:   Text(title,style: TextStyle(
     fontSize: 13,color: omarColor
   ),
   overflow: TextOverflow.ellipsis,
   ));
  }
)
      ],
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return   AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation.value), 0.0),
            child:LayoutBuilder(builder: (context, constraints) {
      _height =  constraints.maxHeight;
      _width = constraints.maxWidth;
      return Container(

        margin: EdgeInsets.only(left: constraints.maxWidth *0.04,
        right: constraints.maxWidth *0.04,bottom: constraints.maxHeight *0.1),
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color:hintColor.withOpacity(0.4), width: 1)),

           color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 6,
            ),
          ],

        ),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
               Container(

                 
                 child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
    child: Image.network(widget.ad.adsPhoto ,height: constraints.maxHeight*.54,
                  width: constraints.maxWidth,
                   fit: BoxFit.cover,
                  )),
               ),
                Expanded(
                  child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[
                     Container(
                       margin: EdgeInsets.symmetric(
                         vertical: constraints.maxHeight *0.02,
                         horizontal: constraints.maxWidth *0.02
                       ),
                       width: constraints.maxWidth,
                       
                       child:  Text(widget.ad.adsTitle,style: TextStyle(
                         color: Colors.black,fontSize: 15,

                         height: 1.4
                       ),
                       maxLines: 2,
                       ),
                     ),

                    SizedBox(
                      height: 2,
                    ),



                      Row(
                        children: <Widget>[
                          Container(

                            margin: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth *0.02
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buildItem(widget.ad.adsVisits, 'assets/images/eye.png',),

                              ],
                            ),
                          ),

                          SizedBox(
                            height: 2,
                          ),

                          Container(

                            margin: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth *0.02
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                _buildItem(widget.ad.adsCityName!=null?widget.ad.adsCityName:"", 'assets/images/city.png'),

                              ],
                            ),
                          ),
                        ],
                      )


                    ],
                  ),
                )
                ],
            ),

          /*  Positioned(
              top: constraints.maxHeight *0.02,
             
              child: Container(
                height: _height *0.25,
                width: _width *0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,

                ),
                child: _authProvider.currentUser == null
                        ? GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/login_screen'),
                            child: Center(
                                child: Icon(
                              Icons.favorite_border,
                              size: 20,
                              color: Colors.white,
                            )),
                          )
                        : Consumer<FavouriteProvider>(
                            builder: (context, favouriteProvider, child) {
                            return GestureDetector(
                              onTap: () async {
                                if (favouriteProvider.favouriteAdsList
                                    .containsKey(widget.ad.adsId)) {
                                  favouriteProvider.removeFromFavouriteAdsList(
                                      widget.ad.adsId);
                                  await _apiProvider.get(Urls
                                          .REMOVE_AD_from_FAV_URL +
                                      "ads_id=${widget.ad.adsId}&user_id=${_authProvider.currentUser.userId}");
                                  if (widget.insideFavScreen) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FavouriteScreen()));
                                  }
                                } else {
                                  print(
                                      'user id ${_authProvider.currentUser.userId}');
                                  print('ad id ${widget.ad.adsId}');
                                  favouriteProvider.addToFavouriteAdsList(
                                      widget.ad.adsId, 1);
                                  await _apiProvider
                                      .post(Urls.ADD_AD_TO_FAV_URL, body: {
                                    "user_id": _authProvider.currentUser.userId,
                                    "ads_id": widget.ad.adsId
                                  });
                                }
                              },
                              child: Center(
                                child: favouriteProvider.favouriteAdsList
                                        .containsKey(widget.ad.adsId)
                                    ? SpinKitPumpingHeart(
                                        color: accentColor,
                                        size: 18,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                              ),
                            );
                          })
                         
              ) ,
            )
            */





          ],
        ),
      );
    })));
    });
  }
}
