// import 'dart:developer';

// import 'package:flutter/material.dart';

// import 'services/auth_service.dart';
// import 'services/database_service.dart';

// class FavoriteRoutes with ChangeNotifier {
//   AuthService _authService = AuthService();
//   DatabaseService _db = DatabaseService();
//   final List<Map<String, String>> _favorites = [];
//   String? _recordId;

//   String _collectionName = "favorites";

//   List<Map<String, String>> get favorites => _favorites;

//   void addFavorite(Map<String, String> route) {
//     if (!_favorites.contains(route)) {
//       _favorites.add(route);
//       notifyListeners();
//     }
//   }

//   void removeFavorite(Map<String, String> route) {
//     if (_favorites.contains(route)) {
//       _favorites.remove(route);
//       notifyListeners();
//     }
//   }

//   Future<void> initFavorites() async {
//     if (_authService.currentUser == null || _recordId != null) {
//       return;
//     }

//     _recordId = _authService.currentUser!.uid;
//     await _loadFavorites();

//     notifyListeners();
//   }

//   void closeFavorites() {
//     _favorites.clear();
//     notifyListeners();
//   }

//   Future<void> _loadFavorites() async {
//     if (_authService.currentUser == null || _recordId == null) {
//       return;
//     }

//     if (!await _db.hasCollection(
//       _collectionName,
//     )) {
//       return;
//     }

//     try {
//       var querySnapshot = await _db
//           .find(
//             _collectionName,
//             limit: 20,
//           )
//           .then((value) => value.get());

//       if (querySnapshot.docs.isNotEmpty) {
//         _favorites.clear();

//         for (var doc in querySnapshot.docs) {
//           log('Task data loaded: ${doc.data()}');
//         }
//       }
//     } catch (e) {
//       throw Exception(e);
//     }

//     notifyListeners();
//   }
// }
