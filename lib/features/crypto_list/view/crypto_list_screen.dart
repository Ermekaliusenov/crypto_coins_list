import 'dart:async';

import 'package:crypto_coins_list/features/crypto_list/blok/crypto_list_blok.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final cryptoListBlok = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());
  @override
  void initState() {
    cryptoListBlok.add(LoadCryptoList(completer: null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CryptoCurrenciesList'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          cryptoListBlok.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: cryptoListBlok,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemCount: state.coinsList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, i) {
                  final coin = state.coinsList[i];

                  return CryptoCoinTile(
                    coin: coin,
                  );
                },
              );
            }
            if (state is CryptoListLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Бир жерден ката кетти',
                      style: TextStyle(fontSize: 25),
                    ),
                    const Text(
                      'Сураныч, кийинчерээк кайра аракет кылыңыз',
                      style: TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                        onPressed: () {
                          cryptoListBlok.add(LoadCryptoList(completer: null));
                        },
                        child: const Text(
                          'Кайра аракет кылыныз',
                          style: TextStyle(color: Colors.amber),
                        ))
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      // (_cryptoCoinsList == null)
      //     ? const Center(child: CircularProgressIndicator())
      //     :
    );
  }
}
