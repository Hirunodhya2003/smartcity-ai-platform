import 'package:flutter_test/flutter_test.dart';
import 'package:smart_city_app/app.dart';

void main() {
  testWidgets('Smart City home screen displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SmartCityApp());

    expect(find.text('Smart City AI Platform'), findsOneWidget);
    expect(find.text('Welcome to Smart City!'), findsOneWidget);
    expect(find.text('Traffic'), findsOneWidget);
    expect(find.text('Waste'), findsOneWidget);
  });
}
