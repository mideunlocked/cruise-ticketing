class FormatNumber {
  static String formatLargeNumber(int number) {
    const int billion = 1000000000;
    const int million = 1000000;
    const int thousand = 1000;

    if (number >= billion) {
      return '${(number / billion).toStringAsFixed(1)}B';
    } else if (number >= million) {
      return '${(number / million).toStringAsFixed(1)}M';
    } else if (number >= thousand) {
      return '${(number / thousand).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }
}
