# Provider Creation Guidelines

This document outlines the standard practices for creating providers in the **Crafty Bay** project. Following these rules ensures consistency across the codebase.

## General Principles
1. **Inheritance**: All providers must extend `ChangeNotifier`.
2. **Encapsulation**: 
    - Keep state variables private (e.g., `_inProgress`, `_data`, `_errorMessage`).
    - Expose state via public getters.
3. **State Management**:
    - Always have a boolean flag for loading state (e.g., `_inProgress`).
    - Always have a nullable string for error messages (e.g., `_errorMessage`).
    - Call `notifyListeners()` when a state change occurs that the UI needs to reflect.
4. **Network Interaction**:
    - Use `getNetworkCaller()` from `core/network_caller/network_caller.dart`.
    - Use endpoints defined in `app/urls.dart`.
    - Return a `Future<bool>` from fetch methods to indicate success or failure to the UI (e.g., for showing SnackBar).

---

## 1. Simple Data Provider Template
Used for fetching a single object or a simple list without pagination (e.g., `HomeSliderProvider`, `ProductDetailsProvider`).

### Structure:
```dart
class MyDataProvider extends ChangeNotifier {
  bool _inProgress = false;
  MyModel? _data;
  String? _errorMessage;

  // Getters
  bool get inProgress => _inProgress;
  MyModel? get data => _data;
  String? get errorMessage => _errorMessage;

  Future<bool> fetchData() async {
    bool isSuccess = false;
    _inProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(Urls.myEndpoint);

    if (response.isSuccess) {
      _data = MyModel.fromJson(response.body!['data']);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
```

---

## 2. Pagination Provider Template
Used for long lists that require "Load More" functionality (e.g., `CategoryListProvider`, `ProductListProvider`).

### Rules:
1. **Pagination State**: Maintain `_currentPage` (starting at 0) and `_lastPage`.
2. **Dual Loading States**: Differentiate between `_initialDataInProgress` and `_moreDataInProgress`.
3. **Guard Clauses**: Check `isLoading` or `!hasMore` at the start of the fetch method.
4. **Rollback**: If the network request fails, decrement `_currentPage` so the user can retry the same page.
5. **Refresh Support**: Always provide a `refresh()` method that resets pagination state and clears the list.

### Structure:
```dart
class MyListProvider extends ChangeNotifier {
  final int _pageSize = 30;
  int _currentPage = 0;
  int? _lastPage;

  bool _initialDataInProgress = false;
  bool _moreDataInProgress = false;
  String? _errorMessage;
  final List<MyModel> _list = [];

  // Getters
  bool get initialDataInProgress => _initialDataInProgress;
  bool get moreDataInProgress => _moreDataInProgress;
  List<MyModel> get list => _list;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _initialDataInProgress || _moreDataInProgress;
  bool get hasMore => _lastPage == null || _currentPage < _lastPage!;

  Future<bool> getData() async {
    if (isLoading || !hasMore) return false;

    if (_currentPage == 0) {
      _initialDataInProgress = true;
    } else {
      _moreDataInProgress = true;
    }
    _currentPage++;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.getMyListUrl(_pageSize, _currentPage)
    );

    bool isSuccessful = false;
    if (response.isSuccess) {
      isSuccessful = true;
      _errorMessage = null;
      final responseData = response.body!['data'];
      _lastPage ??= responseData["last_page"];
      
      final List<dynamic> data = responseData['results'];
      _list.addAll(data.map((e) => MyModel.fromJson(e)).toList());
    } else {
      _errorMessage = response.errorMessage ?? 'Something Went Wrong';
      _currentPage--; // Rollback
    }

    _initialDataInProgress = false;
    _moreDataInProgress = false;
    notifyListeners();
    return isSuccessful;
  }

  Future<bool> refreshData() async {
    _currentPage = 0;
    _lastPage = null;
    _list.clear();
    return getData();
  }
}
```

---

## Error Handling & UI Notification
- Use the boolean return value of `fetchData()` in the View layer to trigger UI feedback (e.g., `if (!result) showSnackBar(provider.errorMessage)`).
- Ensure `notifyListeners()` is called in the `finally` block or at both success and failure exit points to stop loading spinners.
