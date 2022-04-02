import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_and_grocery/constants.dart';

class HomeBody extends StatefulWidget {
  HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

double _height = 200;
var _currPageValue = 0.0;
double _scaleFactor = 0.8;

class _HomeBodyState extends State<HomeBody> {
  PageController pageController = PageController(viewportFraction: 0.850);

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    print('Dispose Successfully');
  }

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        print("Current Page Value is " + _currPageValue.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // color: Colors.red,
          height: 320,
          child: PageView.builder(
              controller: pageController,
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildPageItem(index);
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        DotsIndicator(
          dotsCount: 6,
          position: _currPageValue,
          decorator: DotsDecorator(
            color: Colors.white,
            // Inactive color
            activeColor: buttonColor,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Popular'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                '.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Food Pairing',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        //List of Food & Images
        SizedBox(
          height: 700,
          child: ListView.builder(
              // shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://source.unsplash.com/1600x900/?food,fruit,vegetables'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Text Section
                      Expanded(
                        child: Container(
                          height: 110,
                          // width: Get.width * 0.65,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(25),
                            ),
                            color: Color.fromARGB(255, 220, 220, 220),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                // const SizedBox(height: 5),
                                const Text(
                                  'Food Name',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // const SizedBox(height: 15),
                                Text(
                                  'with chinese characterstics'.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                // const SizedBox(height: 10),
                                Row(
                                  children: [
                                    _iconAndText(Icons.food_bank, 'Spicy'),
                                    _iconAndText(Icons.location_city, '1.9 KM'),
                                    _iconAndText(Icons.lock_clock, '30 Mins'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

Widget _buildPageItem(int index) {
  Matrix4 matrix = Matrix4.identity();
  if (index == _currPageValue.floor()) {
    var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
    var currTrans = _height * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else if (index == _currPageValue.floor() + 1) {
    var currScale =
        _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
    var currTrans = _height * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1);
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else if (index == _currPageValue.floor() - 1) {
    var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);

    var currTrans = _height * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1);
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else {
    var currScale = 0.8;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
  }
  return Transform(
    transform: matrix,
    child: Stack(
      children: [
        Container(
          height: 220,
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color: Colors.yellow,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://source.unsplash.com/1600x900/?food,resturant'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 120,
            margin: const EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 25,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  offset: Offset(0, 5),
                ),
                BoxShadow(
                  color: Colors.white,
                  // blurRadius: 2.0,
                  offset: Offset(5, 0),
                ),
              ],
              // boxShadow: BoxShadow()
              // image: DecorationImage(
              // fit:BoxFit.cover,
              //   image: AssetImage(''),
              // ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Resturant Name',
                    style: TextStyle(
                      fontSize: 28,
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 0.0,
                    height: 10,
                  ),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: buttonColor,
                            size: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '4.5',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '1202 Comments',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 0.0,
                    height: 10,
                  ),
                  Row(
                    children: [
                      _iconAndText(Icons.food_bank, 'Spicy'),
                      _iconAndText(Icons.location_city, '1.9 KM'),
                      _iconAndText(Icons.lock_clock, '30 Mins'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Row _iconAndText(icon, text) {
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.black,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      const SizedBox(
        width: 15,
      ),
    ],
  );
}
