class CommonConstants {
  static const String test = 'test';
  static const String INTIAL_TOKEN = 'intial_token';
  static const num testNum = 1;
  static const double largeText = 40.0;
  static const double normalText = 22.0;
  static const double smallText = 16.0;
  static const double buttonHeight = 45.0;

  static String successMessage = 'success';
  static String errorCode = 'errorCode';
  static String responseData = 'respData';
  static String errorMessage = 'message';

  static String fromEmail = 'fromEmail';
  static String fromOtp = 'fromOtp';

  static String retail = 'retail';
  static String dine = 'dine';

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
        {"id": '2', "COST_HIGH": "Price: Low to High", "isSelected": false},
        {"id": '2', "COST_LOW": "Price: High to Low", "isSelected": false},
        {"id": '2', "DISTANCE": "Distance  Nearest", "isSelected": false}
      ]
    },
    {
      "name": "Category",
      "isSelected": false,
      "data": [
        {"key": "Retail", "isSelected": false},
        {"key": "Grocery", "isSelected": false},
        {"key": "Dining", "isSelected": false}
      ]
    },
    {
      "name": "Rating",
      "isSelected": false,
      "data": [
        {"key": "1", "isSelected": false},
        {"key": "2", "isSelected": false},
        {"key": "3", "isSelected": false},
        {"key": "4", "isSelected": false},
        {"key": "5", "isSelected": false}
      ]
    },
    {
      "name": "Price Range",
      "isSelected": false,
      "data": [
        {"key": "\$", "isSelected": false},
        {"key": "\$\$", "isSelected": false},
        {"key": "\$\$\$", "isSelected": false},
        {"key": "\$\$\$\$", "isSelected": false}
      ]
    },
  ];
}

const String IMAGE_PATH = 'assets/images';
