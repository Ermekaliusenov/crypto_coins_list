import 'package:crypto_coins_list/features/crypto_coin/view/crypto_coin_screen.dart';
import 'package:crypto_coins_list/features/crypto_list/view/crypto_list_screen.dart';

final routes = {
        '/': (context) => const CryptoListScreen(),
        '/coin': (context) => const CryptoCoinScreen(),
      };