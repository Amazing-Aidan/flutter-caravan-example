class JourneyData {
  var journeyTime;
  var directionsText;
  var route;

  JourneyData(String directionsText, int journeyTime, List<int> route) {
    this.directionsText = directionsText;
    this.journeyTime = journeyTime;
    this.route = route;
  }
}