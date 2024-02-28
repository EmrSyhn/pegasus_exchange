
import '../../../model/exchange.dart';

extension ExchangeListExtension on List<Exchange> {
  List<Exchange> filterExchange() {
    Set<String> set = {};
    return where((element) => set.add(element.fromCur!)).toList();
  }

  List<Exchange> filterE({required Exchange exchange}) {
    return where((element) => element.fromCur != exchange.fromCur).toList();
  }

  // SADECE USD, EUR VE TRY
  List<Exchange> filterOnlyPrimary() {
    return where((element) =>
        element.fromCur == 'EUR' ||
        element.fromCur == 'USD' ||
        element.fromCur == 'TRY').toList();
  }
}
