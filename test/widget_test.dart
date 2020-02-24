import 'package:flutter_camping_app/utils/JourneyCalculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Testing route Timing',(){
    expect(journeyInformation(caravan: 8).journeyTime,6); // middle path
    expect(journeyInformation(caravan: 9).journeyTime,6); // left path
    expect(journeyInformation(caravan: 7).journeyTime,7); // right path
    expect(journeyInformation(caravan: 1).journeyTime,1); // short journey
  });

  test('Testing Routing', (){
    final journeyToCaravan8 = journeyInformation(caravan: 8).route;
    expect(journeyToCaravan8.length,7); // correct number of steps
    expect(journeyToCaravan8.contains(15), true); // goes via caravan 15
    expect(journeyToCaravan8.contains(7), false); // does no go via caravan 7
    expect(journeyToCaravan8.contains(9), false); // does no go via caravan 9

  });

  test('Directions', (){
    expect(journeyInformation(caravan: 1).directionsText.contains('north to Caravan 1'), true);

  });
}
