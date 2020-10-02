import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/src/values/constants.dart';

class AdDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: (){

            },
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: (){

            },
          ),
          SizedBox(
            width: kDefaultPadding / 2,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: CarouselSlider(
                options: CarouselOptions(),
                items: <Widget>[
                  Image.network('https://picsum.photos/300'),
                  Image.network('https://picsum.photos/300'),
                ],
              ),
            ),

          ),
          SliverList(
            delegate: SliverChildListDelegate(List.generate(
                100,
                    (i){
                  return Text(i.toString());
                }
            )),
          ),
        ],
      ),
    );
  }
}
