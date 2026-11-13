import 'package:flutter_test/flutter_test.dart';
import 'package:explore_ormawa_undiksha/main.dart';

void main() {
  testWidgets('Explore Ormawa app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ExploreOrmawaApp());

    expect(find.text('Explore Ormawa Undiksha'), findsWidgets);
  });
}