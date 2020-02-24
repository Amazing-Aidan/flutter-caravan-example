import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_camping_app/models/Visitors.dart';
import 'package:flutter_camping_app/utils/JourneyCalculator.dart';

Widget visitorJourneyCard(Visitors groupData, int timeToDestination) {
  var journey = journeyInformation(caravan: groupData.caravan);
  return Card(
    elevation: 10,
    margin: EdgeInsets.all(8.0),
    color: Colors.cyan[50],
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Caravan: ${groupData.caravan}",
                textScaleFactor: 2,
                textAlign: TextAlign.start,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Journey time: ${journey.journeyTime} Mins",
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    "Waiting time: ${timeToDestination - journey.journeyTime} Mins",
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              journey.route.join('➡').replaceFirst('0','Gate'),
              textAlign: TextAlign.center,
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Route ',
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: "${journeyInformation(caravan: groupData.caravan).directionsText}", style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black45)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
