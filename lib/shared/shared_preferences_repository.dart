import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _key = "tasks";
  late final SharedPreferences _prefs;
  List<String> _items = [];

  SharedPreferencesRepository() {
    init();
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _items = _prefs.getStringList(_key) ?? [];
  }

  @override
  Future<int> get itemCount async {
    return _items.length;
  }

  @override
  Future<List<String>> getItems() async {
    return _items;
  }

  @override
  Future<void> addItem(String item) async {
    if (item.isNotEmpty && !_items.contains(item)) {
        _items.add(item);
        await _prefs.setStringList(_key, _items);
    }
  }

  @override
  Future<void> deleteItem(int index) async {
    if (_items.length > index) {
      _items.removeAt(index);
    }
    await _prefs.setStringList(_key, _items);
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    if (newItem.isNotEmpty) {
      if (!_items.contains(newItem) && _items.length > index) {
        _items[index] = newItem;
      }
      await _prefs.setStringList(_key, _items);
    }
  }
}
