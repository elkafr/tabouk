import 'package:flutter/material.dart';
import 'package:tabouk/models/category.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/app_colors.dart';

class CategoryItem1 extends StatelessWidget {
  final CategoryModel category;
  final AnimationController animationController;
  final Animation animation;


  const CategoryItem1({Key key, this.category, this.animationController, this.animation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color  x= Color(0xff4C4C4C);


    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: constraints.maxHeight *0.05),
            width: constraints.maxWidth *0.80,
            height: constraints.maxHeight *0.48,

            decoration: BoxDecoration(
              color: category.isSelected ?  Color(0xff0098D3) : x,

              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            child:  category.catId != '0' ?
            ClipRRect(

                child: Image.network(category.catImage,fit: BoxFit.none,width: 37,height: 34,color: category.isSelected ?Colors.white:Colors.white,)) :
            Icon(Icons.more_horiz,color: category.isSelected ?omarColor:Colors.white,),
          ),
          Container(

            padding: EdgeInsets.only(top: 5),
            height: constraints.maxHeight *0.42,
            alignment: Alignment.center,
            width: constraints.maxWidth,
            child: Center(
              child: Text(category.catName,style: TextStyle(

                color: category.isSelected ?x:x,fontSize: category.catName.length > 1 ?13 : 13,

              ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,),
            ),
          ),

        ],
      );
    });
  }
}
