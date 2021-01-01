import 'package:intl/intl.dart';

String priceConvertor(int amount) {
  NumberFormat formatter = new NumberFormat('#,##,000');
  return formatter.format(amount);
}
