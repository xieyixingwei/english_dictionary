
enum StringType { english, chinese}

StringType strType(String str) {
  var isEngishRex = RegExp(r'[a-zA-Z]+');

  if(isEngishRex.allMatches(str).isNotEmpty) {
    return StringType.english;
  }

  return StringType.chinese;
}
