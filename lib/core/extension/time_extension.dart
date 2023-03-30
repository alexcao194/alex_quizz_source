extension TimeExtension on DateTime {
  String toLocalTimeString() {
    int day = toLocal().day;
    int month = toLocal().month;
    int year = toLocal().year;
    return '${day < 10 ? '0$day' : day}-${month < 10 ? '0$month' : month}-$year';
  }
}