import 'dart:math';

String generateUuid() {
  var random = Random();
  var uuid = '';
  for (var i = 0; i < 12; i++) {
    if (i == 3 || i == 6 || i == 9) {
      uuid += '-';
    }
    var hex = random.nextInt(16).toRadixString(16);
    uuid += hex.toUpperCase();
  }
  return uuid;
}