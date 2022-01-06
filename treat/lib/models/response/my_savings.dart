import 'dart:ui';

import 'package:treat/shared/constants/colors.dart';

class MySaving {
  String? currencySymbol;
  int? reqYear;
  int? reqMonth;
  List<Entries>? entries;

  MySaving({this.currencySymbol, this.reqYear, this.reqMonth, this.entries});

  MySaving.fromJson(Map<String, dynamic> json) {
    currencySymbol = json['currencySymbol'];
    reqYear = json['reqYear'];
    reqMonth = json['reqMonth'];
    if (json['entries'] != null) {
      entries = <Entries>[];
      json['entries'].forEach((v) {
        entries!.add(new Entries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currencySymbol'] = this.currencySymbol;
    data['reqYear'] = this.reqYear;
    data['reqMonth'] = this.reqMonth;
    if (this.entries != null) {
      data['entries'] = this.entries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Entries {
  int? month;
  int? year;
  num? amount;
  bool? isSelected = false;
  List<BreakUps>? breakUps;

  Entries({this.month, this.year, this.amount, this.breakUps});

  Entries.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    amount = json['amount'];
    if (json['breakUps'] != null) {
      breakUps = <BreakUps>[];
      json['breakUps'].forEach((v) {
        breakUps!.add(new BreakUps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['year'] = this.year;
    data['amount'] = this.amount;
    if (this.breakUps != null) {
      data['breakUps'] = this.breakUps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BreakUps {
  String? name;
  num? amount;
  Color? color;

  BreakUps({this.name, this.amount});

  BreakUps.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}
