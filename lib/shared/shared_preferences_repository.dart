import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _key = "tasks";
  late final SharedPreferences prefs;

  SharedPreferencesRepository() {
    init();
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<int> get itemCount async {
    int itemCount = 0;
    if (prefs.getStringList(_key) != null) {
      itemCount = prefs.getStringList(_key)!.length;
    }
    return itemCount;
  }

  @override
  Future<List<String>> getItems() async {
    return prefs.getStringList(_key) ?? [];
  }

  @override
  Future<void> addItem(String item) async {
    List<String> tasks = prefs.getStringList(_key) ?? [];
    tasks.add(item);
    await prefs.setStringList(_key, tasks);
  }

  @override
  Future<void> deleteItem(int index) async {
    List<String> tasks = prefs.getStringList(_key) ?? [];
    if (tasks.length > index) {
      tasks.removeAt(index);
    }
    await prefs.setStringList(_key, tasks);
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    List<String> tasks = prefs.getStringList(_key) ?? [];

    if (tasks.length > index) {
      tasks[index] = newItem;
    }
    await prefs.setStringList(_key, tasks);
  }
}
