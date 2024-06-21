part of 'crypto_list_blok.dart';

abstract class CryptoListEvent extends Equatable {}

class LoadCryptoList extends CryptoListEvent {
  LoadCryptoList({required this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
