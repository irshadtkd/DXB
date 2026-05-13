import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dxbproviderapp/app/app.dart';
import 'package:dxbproviderapp/core/di/service_locator.dart';
import 'package:dxbproviderapp/features/session/presentation/session_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await sl.reset();
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(prefs);
    configureDependencies();
    await sl<SessionCubit>().hydrate();
  });

  testWidgets('Provider app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderApp());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(ProviderApp), findsOneWidget);
  });
}
