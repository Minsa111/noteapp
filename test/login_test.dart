import 'package:test/test.dart';
import 'package:noteapp/routes/app_pages.dart';

void main() {
  group('AppPages', () {
    test('should have the correct initial route', () {
      expect(AppPages.INITIAL, equals(Routes.LOGIN));
    });

    test('should contain the correct routes', () {
      final expectedRoutes = [
        Routes.HOME,
        Routes.LOGIN,
        Routes.ADD,
        Routes.TUTORWEB,
      ];

      final actualRoutes = AppPages.routes.map((page) => page.name);

      expect(actualRoutes, equals(expectedRoutes));
    });
  });
}
