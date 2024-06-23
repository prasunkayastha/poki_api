import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:poki_api/models/page_data.dart';
import 'package:poki_api/models/pokemon.dart';
import 'package:poki_api/services/http_services.dart';

class HomePageConrtoller extends StateNotifier<HomePageData> {
  final GetIt _getIt = GetIt.instance;
  late HttpServices _httpServices;
  HomePageConrtoller(super._state) {
    _httpServices = _getIt<HttpServices>();
    _setup();
  }
  Future<void> _setup() async {
    loadData();
  }

  Future<void> loadData() async {
    if (state.data == null) {
      Response? res = await _httpServices
          .get('https://pokeapi.co/api/v2/pokemon?limit=20&offset=0');
      print(res!.data);
      if (res != null && res.data != null) {
        PokemonListData data = PokemonListData.fromJson(res.data);
        state = state.copyWith(data: data);
      }
    } else {}
  }
}
