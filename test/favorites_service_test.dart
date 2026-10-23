import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookchaowalit_portfolio_mobile/services/favorites_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('starts empty when nothing was saved', () async {
    SharedPreferences.setMockInitialValues({});
    final service = await FavoritesService.init();
    expect(service.favorites, isEmpty);
    expect(service.count, 0);
  });

  test('toggling adds, then removes, a favorite and notifies listeners',
      () async {
    SharedPreferences.setMockInitialValues({});
    final service = await FavoritesService.init();
    var notifications = 0;
    service.addListener(() => notifications++);

    await service.toggleFavorite(2);
    expect(service.isFavorite(2), isTrue);
    expect(service.count, 1);

    await service.toggleFavorite(2);
    expect(service.isFavorite(2), isFalse);
    expect(service.count, 0);
    expect(notifications, 2);
  });

  test('favorites survive an app restart', () async {
    SharedPreferences.setMockInitialValues({});
    final first = await FavoritesService.init();
    await first.toggleFavorite(0);
    await first.toggleFavorite(5);

    final restarted = await FavoritesService.init();
    expect(restarted.favorites, [0, 5]);
    expect(identical(FavoritesService.instance, restarted), isTrue);
  });

  test('unreadable or negative saved entries are ignored', () async {
    SharedPreferences.setMockInitialValues({
      'favorite_project_indices': ['1', 'oops', '-3', '4'],
    });
    final service = await FavoritesService.init();
    expect(service.favorites, [1, 4]);
  });

  test('the favorites list cannot be changed from outside the service',
      () async {
    SharedPreferences.setMockInitialValues({});
    final service = await FavoritesService.init();
    expect(() => service.favorites.add(1), throwsUnsupportedError);
  });
}
