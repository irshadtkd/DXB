import 'package:flutter_test/flutter_test.dart';

import 'package:dxb/app.dart';
import 'package:dxb/core/di/service_locator.dart';
import 'package:dxb/core/router/app_router.dart';

void main() {
  testWidgets('MultiServe app builds', (WidgetTester tester) async {
    await configureDependencies();
    final router = createAppRouter();
    await tester.pumpWidget(MultiServeApp(router: router));
    await tester.pump();
    expect(find.textContaining('Multi'), findsWidgets);
  });
}
