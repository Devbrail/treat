import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:treat/api/api.dart';
import 'package:treat/models/filter_modal.dart';
import 'package:treat/models/response/search_response.dart';
import 'package:treat/shared/constants/common.dart';

class SearchController extends GetxController {
  final ApiRepository apiRepository;

  SearchController({required this.apiRepository});

  var searchTC = TextEditingController();
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    generateDropDow();
    searchTC.text = Get.arguments[1];
    if (searchTC.text.isNotEmpty) getResults();
    Future.delayed(Duration(seconds: 2)).then((value) => setLoading(false));
  }

  setLoading(bool value) {
    loading.value = value;
    update([0]);
    value.toString().printInfo();
  }

  @override
  void dispose() {
    super.dispose();
    searchTC.dispose();
  }

  Timer? t;

  Map get getSearchDatum {
    String searchText = searchTC.text;
    Map<String, dynamic> body = {
      ...Get.arguments[0] as Map,
      "searchText": searchText,
      "sortOption": "NONE",
      "rating": 0,
      "priceRange": 0,
      "amenities": [],
      "popularity": 0
    };

    for (int i = 0; i < filters.length; i++) {
      Filters filter = filters[i];
      switch (i) {
        case 0:
          for (int j = 0; j < filter.data.length; j++)
            if (filter.data[j].isSelected) {
              body['sortOption'] = filter.data[j].key;
            }
          break;
        case 1:
          List<String> cat = [];
          for (int j = 0; j < filter.data.length; j++) {
            if (filter.data[j].isSelected) cat.add(filter.data[j].id);
          }
          if (cat.length > 0) body['categories'] = cat;

          break;
        case 2:
          for (int j = 0; j < filter.data.length; j++) {
            if (filter.data[j].isSelected) {
              body['rating'] = num.parse(filter.data[j].key);
              break;
            }
          }
          break;
        case 3:
          for (int j = 0; j < filter.data.length; j++) {
            if (filter.data[j].isSelected) {
              body['priceRange'] = filter.data[j].key.length;
              break;
            }
          }
          break;
        case 4:
          List<int> amenities = [];
          for (int j = 0; j < filter.data.length; j++) {
            if (filter.data[j].isSelected) amenities.add(filter.data[j].id);
          }
          if (amenities.length > 0) body['amenities'] = amenities;

          break;
      }
    }

    jsonEncode(body).printInfo();
    return body;
  }

  Future<List<dynamic>> getSuggestion(String query) async {
    if (query.length < 3) return [];
    List result=await apiRepository.searchSuggestions(query);
    'dkvjsdn.kj ${result.length}'.printInfo();
    return result;

    // return datum;
  }

  Future<List<SearchResponses>> getResults() async {
    _searchResponses.value = [];
    Either<int, SearchResult>? value =
        await apiRepository.searchStores(getSearchDatum);
    value?.fold((l) => null, (r) {
      searchResponssse = r.searchResponses;
      setLoading(false);
    });
    return searchResponses;
    apiRepository.searchStores(getSearchDatum).then((value) {
      value?.fold((l) => null, (r) {
        searchResponssse = r.searchResponses;
        setLoading(false);
      });
    });
  }

  List<SearchResponses> get searchResponses => _searchResponses.value ?? [];

  set searchResponssse(value) {
    _searchResponses.value = value;
    _searchResponses.refresh();
  }

  var _searchResponses = Rxn<List<SearchResponses>>();

  void onSearched() {
    t?.cancel();

    t = Timer(Duration(milliseconds: 300), () {
      setLoading(true);

      getResults();
    });
  }

  List<Data> get filtersBody => filters[currentFilterIdx].data;

  late int _currentFilterIdx = 0;

  int get currentFilterIdx => _currentFilterIdx;

  List<Filters> get filters => _filters;

  void setCurrentTabIdx(Filters idx) {
    _currentFilterIdx = filters.indexOf(idx);
    _filters.forEach((e) {
      e.isSelected = false;
      if (idx.name == e.name) e.isSelected = true;
    });

    update(['T']);
  }

  late final List<Filters> _filters;

  updateFilters(Data e) {
    _filters[_currentFilterIdx].data.forEach((et) {
      if (_currentFilterIdx == 0) {
        et.isSelected = false;
        if (e.key == et.key) et.isSelected = !et.isSelected;
      } else if (_currentFilterIdx == 2) {
        if (double.parse(et.key) >= double.parse(e.key)) {
          et.isSelected = true;
        } else
          et.isSelected = false;
      } else if (_currentFilterIdx == 3) {
        if (et.key.length >= e.key.length) {
          et.isSelected = true;
        } else
          et.isSelected = false;
      } else if (e.key == et.key) et.isSelected = !e.isSelected;
    });
    update(["T"]);
  }

  void generateDropDow() {
    _filters = List.from(CommonConstants.FILTER_DATA)
        .map((e) => Filters.fromJson(e))
        .toList();

    apiRepository.storeAmenities().then((value) {
      value.fold((l) => null, (r) {
        List<Data> amenities = [];
        r.forEach((element) {
          Data data = Data(
              key: element['name'],
              isSelected: false,
              id: element['id'],
              assetId: element['assetId']);
          amenities.add(data);
        });
        _filters.add(
            Filters(name: 'Amenities', data: amenities, isSelected: false));
      });
    });
  }
}
