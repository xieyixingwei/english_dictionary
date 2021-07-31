class GlobalQuerySet {
  num page_size = 10;
  num page_index = 1;
  String ordering = null;

  Map<String, dynamic> get queries => <String, dynamic>{
    'page_size': page_size,
    'page_index': page_index,
    'ordering': ordering,
  }..removeWhere((String key, dynamic value) => value == null);

  void clear() {
    page_size = null;
    page_index = null;
    ordering = null;
  }
}