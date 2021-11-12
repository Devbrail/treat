class Filters {
  Filters({
    required this.name,
    required this.data,
    required this.isSelected,
  });

  late final String name;
  late final List<Data> data;
  late bool isSelected;

  Filters.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isSelected = json['isSelected'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['isSelected'] = isSelected;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.key,
    required this.isSelected,
    required this.id,
    required this.assetId,
  });

  late final String key;
  late final String assetId;
  late final dynamic id;
  late bool isSelected;

  Data.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'] ?? '';
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['key'] = key;
    _data['isSelected'] = isSelected;
    return _data;
  }
}
