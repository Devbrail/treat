class AGUrls {
  // static final _baseUrl = 'https://amblegene.herokuapp.com/';
  //static final _baseUrl = 'http://amble-dev-lb-627101243.ap-south-1.elb.amazonaws.com/';

  // static final _baseUrl = 'http://ec2-13-233-12-23.ap-south-1.compute.amazonaws.com/';
  // static final _baseUrl = 'http://amble-dev-lb-627101243.ap-south-1.elb.amazonaws.com/';
  // static final _baseUrl = 'http://65.0.80.148/';
  // static final _baseUrl = 'http://15.206.254.244:8000/';
  // static final _baseUrl = 'http://dev.amblegene.com/';
  static final _baseUrl = 'http://dev.amblegene.com/';
  // static final _baseUrl = 'http://15.206.254.244/';
  //static final _baseUrl = 'http://65.0.80.148/';
  static final _userDetails = 'api/users/me/';
  static final _userLogin = 'api/jwt/create/';
  static final _userNameAvailability = 'api/users/check_username/';
  static final _createPassword = 'api/users/create_password/';
  static final _resetPassword = 'api/users/reset_password_confirm/';
  static final _tokenRefresh = 'api/jwt/refresh/';
  static final _users = 'api/users/';
  static final _posts = 'api/feed/';
  static final _follow = 'api/follow/';
  static final _tags = 'api/tags/';
  static final _devices = 'api/devices/';
  static final _comments = 'api/comments/';
  static final _blog = 'api/blog/';
  static final _events = 'api/event/';
  static final _notifications = 'api/notifications/';
  static final _story = 'api/story/';
  static final _places = 'api/places/';
  static final _world = 'api/world/';
  static final _globalSearch = 'api/globalsearch/';
  static final _getLiveURL = 'api/story/live/';
  static final _goLiveURL = 'api/story/go_live/';
  static final _walletURL = 'api/wallet/';
  static final _paymentURL = 'api/payment/';
  static final _media = 'api/media/';
  static final _reviews = 'api/reviews/';
  static final _saveAsStory = 'api/story/end_live';
  static final _report = 'api/report/';
  static final _block = 'api/blocked_users/';
  static final _logout = 'api/users/logout';

  /* Base URl*/
  static String get uRlBase => _baseUrl;

  /* URL to get user details from server*/
  static String get uRlUserDetails => _userDetails;

  /* URL to login user using username and password*/
  static String get uRlLogin => _userLogin;

  /* URL to login user using username and password*/
  static String get uRlRefresh => _tokenRefresh;

  /* URL to create a password for user*/
  static String get uRlCreatePassword => _createPassword;

  /* URL to create a password for user*/
  static String get uRlResetPassword => _resetPassword;

  /* URL to search for username availability*/
  static String get uRlUserNameAvailable => _userNameAvailability;

  /* URL to get users list*/
  static String get uRlSearchUser => _users;

  /* URL to get posts list*/
  static String get uRlPosts => _posts;

  /* URL to follow/unfollow users*/
  static String get uRlFollow => _follow;

  /* URL to get tags list*/
  static String get uRlSearchTags => _tags;

  /* URL to get tags list*/
  static String get uRlFCMReg => _devices;

  /* URL to get tags list*/
  static String get uRlComments => _comments;

  /* URL to get blogs list*/
  static String get uRlBlogs => _blog;

  /* URL to get tags list*/
  static String get uRlEvents => _events;

  /* URL to get posts list*/
  static String get uRlNotifications => _notifications;

  /* URL to get posts list*/
  static String get uRlStory => _story;

  /* URL to get places list*/
  static String get uRlPlaces => _places;

  /* URL to get places list*/
  static String get uRlWorld => _world;

  /* URL to get places list*/
  static String get uRlGlobalSearch => _globalSearch;

  /* URL to get live playback url*/
  static String get getLiveURL => _getLiveURL;

  /* URL to get stream  key url*/
  static String get goLiveURL => _goLiveURL;

  /* URL to get stream  key url*/
  static String get walletURL => _walletURL;

  /* URL to get stream  key url*/
  static String get paymentURL => _paymentURL;

  /* URL to get stream  key url*/
  static String get mediaURL => _media;

  /* URL to get tags list*/
  static String get uRlReviews => _reviews;

  static String get saveAsStory => _saveAsStory;

  /* URL to report content*/
  static String get uRlReport => _report;

  /* URL to report content*/
  static String get uRlBlock => _block;

  /* URL to report content*/
  static String get uRlLogout => _logout;
}
