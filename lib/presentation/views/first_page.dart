import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_camping_app/models/Visitors.dart';
import 'package:flutter_camping_app/networking/networking.dart';
import 'package:flutter_camping_app/presentation/widgets/visitorJourneyCard.dart';
import 'package:flutter_camping_app/utils/JourneyCalculator.dart';
import 'package:http/http.dart' as http;

class FirstPage extends StatefulWidget {
  FirstPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    var cumulativeWaitingTime = 0;

    return Scaffold(
      body: FutureBuilder<List<Visitors>>(
        future: GetData.fetchVisitors(http.Client()),
        // this is a code smell. Make sure that the future is NOT recreated when build is called. Create the future in initState instead.
        builder: (context, snapshot) {
          Widget visitorsListSliver;
          if (snapshot.hasData) {
            visitorsListSliver = SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              if (index == 0) cumulativeWaitingTime = 0;
              cumulativeWaitingTime = cumulativeWaitingTime +
                  journeyInformation(caravan: snapshot.data[index].caravan)
                      .journeyTime;
              return visitorJourneyCard(
                  snapshot.data[index], cumulativeWaitingTime);
            }, childCount: snapshot.data.length));
          } else {
            visitorsListSliver = SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text(widget.title),
                backgroundColor: Colors.green,
                floating: true,
                pinned: true,
                expandedHeight: 400.0,
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      Image.asset('assets/images/map.png', fit: BoxFit.cover),
                ),
              ),
              visitorsListSliver
            ],
          );
        },
      ),
    );
  }
}
