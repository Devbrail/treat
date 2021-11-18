class CommonConstants {
  static const String test = 'test';
  static const String INTIAL_TOKEN = 'intial_token';
  static const num testNum = 1;
  static const double largeText = 40.0;
  static const double normalText = 22.0;
  static const double smallText = 16.0;
  static const double buttonHeight = 45.0;

  static const String successMessage = 'success';
  static const String errorCode = 'errorCode';
  static const String responseData = 'respData';
  static const String errorMessage = 'message';

  static const String fromEmail = 'fromEmail';
  static const String fromOtp = 'fromOtp';

  static const String retail = 'retail';
  static const String dine = 'dine';
  static const String SIMPLE = 'SIMPLE';
  static const String ADVANCED = 'ADVANCED';

  static const FILTER_DATA = [
    {
      "name": "Sort By",
      "isSelected": true,
      "data": [
        {"id": 'POPULARITY', "key": "Popularity", "isSelected": false},
        {
          "id": 'RATING_HIGH',
          "key": "Rating: High to Low",
          "isSelected": false
        },
        {"id": "COST_HIGH", 'key': "Price: Low to High", "isSelected": false},
        {"id": "COST_LOW", 'key': "Price: High to Low", "isSelected": false},
        {"id": "DISTANCE", 'key': "Distance  Nearest", "isSelected": false}
      ]
    },
    {
      "name": "Category",
      "isSelected": false,
      "data": [
        {"id": "retail", "key": "Retail", "isSelected": false},
        {"id": "everyday", "key": "Everyday ", "isSelected": false},
        {"id": "dining", "key": "Dining", "isSelected": false}
      ]
    },
    {
      "name": "Rating",
      "isSelected": false,
      "data": [
        {"key": "1", "isSelected": true},
        {"key": "2", "isSelected": true},
        {"key": "3", "isSelected": true},
        {"key": "4", "isSelected": true},
        {"key": "5", "isSelected": true}
      ]
    },
    {
      "name": "Price Range",
      "isSelected": false,
      "data": [
        {"key": "\$", "isSelected": true},
        {"key": "\$\$", "isSelected": true},
        {"key": "\$\$\$", "isSelected": true},
        {"key": "\$\$\$\$", "isSelected": true}
      ]
    },
  ];
}

enum couponLayout { SIMPLE, ADVANCED }

const String IMAGE_PATH = 'assets/images';
