import 'package:flutter/material.dart';
import 'package:food_delivery_and_grocery/constants.dart';
import 'package:get/get.dart';
import '../../../utils/categories.dart';
import '../../../utils/restaurants.dart';
import '../../widgets/category_item.dart';
import '../../widgets/search_card.dart';
import '../../widgets/slide_item.dart';
import 'categories.dart';
import 'trending.dart';

class FoodMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              buildSearchBar(context),
              const SizedBox(height: 20.0),
              buildRestaurantRow('Trending Restaurants', context),
              const SizedBox(height: 10.0),
              buildRestaurantList(context),
              const SizedBox(height: 10.0),
              buildCategoryRow('Category', context),
              const SizedBox(height: 10.0),
              buildCategoryList(context),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  buildRestaurantRow(String restaurant, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$restaurant",
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        MaterialButton(
          child: Text(
            "See all (9)",
            style: TextStyle(
              color: buttonColor,
            ),
          ),
          onPressed: () {
            Get.to(
              () => Trending(),
              transition: Transition.rightToLeft,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
          },
        ),
      ],
    );
  }

  buildCategoryRow(String category, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$category",
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        MaterialButton(
          child: Text(
            "See all (9)",
            style: TextStyle(
              color: buttonColor,
            ),
          ),
          onPressed: () {
            Get.to(
              () => Categories(),
              transition: Transition.rightToLeft,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
          },
        ),
      ],
    );
  }

  buildSearchBar(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0), child: SearchCard());
  }

  buildCategoryList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories == null ? 0 : categories.length,
        itemBuilder: (BuildContext context, int index) {
          Map cat = categories[index];

          return CategoryItem(
            cat: cat,
          );
        },
      ),
    );
  }

  buildRestaurantList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: restaurants == null ? 0 : restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          Map restaurant = restaurants[index];

          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SlideItem(
              img: restaurant["img"],
              title: restaurant["title"],
              address: restaurant["address"],
              rating: restaurant["rating"],
            ),
          );
        },
      ),
    );
  }
}
