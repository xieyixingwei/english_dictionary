
List<T> insertList<T>(List<T> children, T insert) {
  if(insert == null) return children.where((e) => e != null).toList();
  children = children.where((e) => e != null).toList();
  final int end = children.length - 1;
  List<T> ret = [];
  children.asMap().forEach(
    (int i, T e) {
      ret.add(e);
      if(i != end) ret.add(insert);
    }
  );
  return ret;
}
