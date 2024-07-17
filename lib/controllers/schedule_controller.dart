import 'dart:developer';

import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../services/database_service.dart';

class ScheduleController extends GetxController {
  final AuthService _authService = AuthService();
  final DatabaseService _db = DatabaseService();

  // Favorites and Schedules
  final RxList<Map<String, dynamic>> _favorites = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> _schedules = <Map<String, dynamic>>[].obs;

  String? _recordId;

  RxList<Map<String, dynamic>> get schedules => _schedules;
  RxList<Map<String, dynamic>> get favorites => _favorites;

  Future<void> addSchedule(Map<String, dynamic> route) async {
    route["userId"] = _recordId!;

    var data = await _db.addData("schedules", route);
    route["id"] = data.id;
    await data.update(route);

    _schedules.add(route);

    log('Schedule added: $route');
  }

  Future<void> removeSchedule(Map<String, dynamic> route) async {
    route["userId"] = _recordId!;

    await _db.findOneAndDelete('schedules',
        field: 'id', isEqualTo: route['id']!);

    _schedules.remove(route);

    log('Schedule removed: $route');
  }

  Future<void> initSchedule() async {
    if (_authService.currentUser == null || _recordId != null) {
      return;
    }

    _recordId = _authService.currentUser!.uid;

    await _loadSchedules();
    await _initFavorites();
  }

  Future<void> closeSchedule() async {
    if (_authService.currentUser != null || _recordId == null) {
      return;
    }
    _schedules.clear();
    await _closeFavorites();
    _recordId = null;
  }

  Future<void> addFavorite(Map<String, dynamic> route) async {
    if (_favorites.contains(route)) return;

    route["userId"] = _recordId!;

    var data = await _db.addData("favorites", route);
    route["id"] = data.id;

    await data.update(route);

    _favorites.add(route);

    log('Favorite added: $route');
  }

  Future<void> removeFavorite(Map<String, dynamic> route) async {
    try {
      await _db.findOneAndDelete(
        "favorites",
        field: 'route',
        isEqualTo: route['route'],
      );

      if (_favorites.any((element) => element['route'] == route['route'])) {
        _favorites.remove(route);
      }

      log('Favorite removed: $route');
    } catch (e) {
      log('Error removing favorite: $e');
    }
  }

  bool isFavorite(String route) {
    return _favorites.any((element) => element['route'] == route);
  }

  Future<void> _loadSchedules() async {
    if (_authService.currentUser == null) {
      return;
    }

    try {
      var querySnapshot =
          await _db.find("schedules").then((value) => value.get());

      var docs = querySnapshot.docs.toList().where((doc) {
        return doc.data()['userId'] == _recordId;
      });

      _schedules.addAll(docs.map((doc) => doc.data()));

      for (var schedule in querySnapshot.docs) {
        log('Schedule: ${schedule.data()}');
      }

      log('Schedules data loaded: ${_schedules.length}');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _initFavorites() async {
    if (_authService.currentUser == null) {
      return;
    }

    await _loadFavorites();
  }

  Future<void> _closeFavorites() async {
    if (_authService.currentUser != null) {
      return;
    }

    _favorites.clear();
  }

  Future<void> _loadFavorites() async {
    if (_authService.currentUser == null) {
      return;
    }

    try {
      var querySnapshot =
          await _db.find("favorites").then((value) => value.get());

      var docs = querySnapshot.docs.toList().where((doc) {
        return doc.data()['userId'] == _recordId;
      });

      _favorites.addAll(docs.map((doc) => doc.data()));

      log('Favorites data loaded: ${_favorites.length}');
    } catch (e) {
      log('Error loading favorites: $e');
      throw Exception(e);
    }
  }
}
