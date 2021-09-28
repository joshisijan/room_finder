import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/src/values/constants.dart';

class AdDetail extends StatelessWidget {
  final Map<String, dynamic> adDetail;

  const AdDetail({
    Key key,
    @required this.adDetail,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {},
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
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                ),
                items: adDetail['images'],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              AdDetailColumn(
                title: 'Rent',
                value: adDetail['rent'].toString(),
              ),
              AdDetailColumn(
                title: 'Deposit',
                value: adDetail['deposit'].toString(),
              ),
              AdDetailColumn(
                title: 'Type',
                value: adDetail['type'] == 0
                    ? 'Room/Flat'
                    : adDetail['type'] == 1
                        ? 'Flatmate'
                        : 'Paying Guest',
              ),
              AdDetailColumn(
                title: 'Terms',
                value: adDetail['terms'],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class AdDetailColumn extends StatelessWidget {
  final String title;
  final String value;

  const AdDetailColumn({
    Key key,
    @required this.title,
    @required this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 2.5,
          ),
          Text(
            value == '' ? 'none' : value,
          ),
        ],
      ),
    );
  }
}
