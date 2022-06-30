String interpolate(String string, List<String> params) {
  String result = string;
  for (int i = 0; i < params.length; i++) {
    result = result.replaceAll('%$i\$', params[i - 1]);
  }

  return result;
}

extension StringFormat on String {
  String format(List<String> params) => interpolate(this, params);
}
