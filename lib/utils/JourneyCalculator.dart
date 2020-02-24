import 'package:flutter/foundation.dart';
import 'package:flutter_camping_app/models/JourneyData.dart';
import 'package:flutter_camping_app/models/Junctions.dart';

JourneyData journeyInformation({@required int caravan}) {
  const gate = 0, includeDestination = 1;

  const _routes = {
    {gate, 1, 13, 16, 15, 14, 8}, // middle route
    {gate, 1, 2, 3, 4, 5, 6, 7}, // right route
    {gate, 1, 13, 12, 11, 10, 9}, // left route
  };

  var branch = _routes.firstWhere((route) => route.contains(caravan));
  var indexOfDestination = branch.toList().indexOf(caravan);
  List<int> route =
    branch.take(indexOfDestination + includeDestination).toList();

  var journeyText = journeyPlanner(caravan: caravan,route: route);

  return JourneyData(
      journeyText,
      _routes
          .firstWhere((route) => route.contains(caravan))
          .toList()
          .indexOf(caravan),
      route);
}

journeyPlanner({@required int caravan, @required List<int> route}) {
  const noRouteFound = 1,
      includeDestination = 1;
  const rightBranchJunctionsLength = 2,
      leftBranchJunctionsLength = 3;
  const firstCaravanOnRightRoute = 2,
      firstCaravanOnMiddleRoute = 16,
      firstCaravanOnFirstLeftRoute = 13,
      firstCaravanOnSecondLeftRoute = 12;

  var _junctions = {
    Junctions(firstCaravanOnFirstLeftRoute, "turn left and head towards"),
    Junctions(firstCaravanOnSecondLeftRoute, "continue straight towards"),
    Junctions(firstCaravanOnMiddleRoute, "turn right and head towards"),
    Junctions(firstCaravanOnRightRoute, "turn right and head towards")
  };

  var indexOfDestination = route.toList().indexOf(caravan);
  List<int> actualRoute =
  route.take(indexOfDestination + includeDestination).toList();

  String journeyPlanner = "There are no directions for caravan $caravan";
  if (actualRoute.length > noRouteFound) {
    journeyPlanner = "Proceede north to Caravan 1";
    _junctions.forEach((caravanNumberAtJunction) =>
    (actualRoute
        .contains(caravanNumberAtJunction.number)
        ? journeyPlanner =
    "$journeyPlanner then ${caravanNumberAtJunction
        .directionString} towards caravan ${caravanNumberAtJunction.number}"
        : null));

    if (actualRoute.contains(firstCaravanOnRightRoute)) {
      if (actualRoute.length > rightBranchJunctionsLength)
        journeyPlanner =
        "$journeyPlanner continue for ${actualRoute.length -
            rightBranchJunctionsLength} more caravans";
    } else if (actualRoute.length > leftBranchJunctionsLength)
      journeyPlanner =
      "$journeyPlanner continue for ${actualRoute.length -
          leftBranchJunctionsLength} more caravans";

    journeyPlanner =
    "$journeyPlanner and you will then reach your destination of Caravan $caravan";
  }
  return journeyPlanner;
}