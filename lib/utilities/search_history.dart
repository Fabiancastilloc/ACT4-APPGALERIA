
class SearchHistory {
  List<String> _history = [];

  List<String> get history => _history;

  void addToHistory(String query) {
    if (!_history.contains(query)) {
      _history.insert(0, query);
    }
  }
}

final SearchHistory _searchHistory = SearchHistory();
