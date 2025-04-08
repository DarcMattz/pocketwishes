import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/wish.dart';

class WishStorage {
  static const _key = 'wishes';

  static Future<void> saveWishes(List<Wish> wishes) async {
    final prefs = await SharedPreferences.getInstance();
    final wishList = wishes.map((wish) => wish.toMap()).toList();
    prefs.setString(_key, jsonEncode(wishList));
  }

  static Future<List<Wish>> loadWishes() async {
    final prefs = await SharedPreferences.getInstance();
    final wishListString = prefs.getString(_key);
    if (wishListString == null) return [];
    final List decoded = jsonDecode(wishListString);
    return decoded.map((item) => Wish.fromMap(item)).toList();
  }
}
