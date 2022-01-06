class SearchResult {
  SearchResult({
    required this.searchResponses,
  });

  late final List<SearchResponses> searchResponses;

  SearchResult.fromJson(Map<String, dynamic> json) {
    searchResponses = List.from(json['searchResponses'])
        .map((e) => SearchResponses.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['searchResponses'] = searchResponses.map((e) => e.toJson()).toList();
    return _data;
  }
}

class SearchResponses {
  SearchResponses({
    required this.storeId,
    required this.assetId,
    required this.title,
    required this.desc,
    required this.category,
    required this.couponLayout,
    required this.subCategory,
    required this.rating,
    required this.priceRange,
    required this.promoted,
    required this.distance,
    required this.popularity,
  });

  late final int storeId;
  late final String assetId;
  late final String title;
  late final String desc;
  late final String category;
  late final String subCategory;
  late final String couponLayout;
   var rating;
  late final int priceRange;
  late final bool promoted;
  late final dynamic distance;
  late final int popularity;

  SearchResponses.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    assetId = json['assetId'];
    title = json['title'];
    desc = json['desc'];
    category = json['category'];
    couponLayout = json['couponLayout'];
    subCategory = json['subCategory'];
    print('json[');
    print(json['rating'].runtimeType);
    rating = json['rating'];
    priceRange = json['priceRange'];
    promoted = json['promoted'];
    distance = json['distance'];
    popularity = json['popularity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['storeId'] = storeId;
    _data['assetId'] = assetId;
    _data['title'] = title;
    _data['desc'] = desc;
    _data['category'] = category;
    _data['couponLayout'] = couponLayout;
    _data['subCategory'] = subCategory;
    _data['rating'] = rating;
    _data['priceRange'] = priceRange;
    _data['promoted'] = promoted;
    _data['distance'] = distance;
    _data['popularity'] = popularity;
    return _data;
  }
}
