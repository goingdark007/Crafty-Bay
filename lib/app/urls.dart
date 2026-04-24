class Urls {

  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static const String signUpUrl = '$_baseUrl/auth/signup';
  static const String signInUrl = '$_baseUrl/auth/login';

  static const String verifyOTP = '$_baseUrl/auth/verify-otp';
  static const String resendOTP = '$_baseUrl/auth/resend-otp';


  static const String slidesUrl = '$_baseUrl/slides';
  static const String categoryList = '$_baseUrl/categories';
  static const String productList = '$_baseUrl/products';

  static String getCategoriesUrl(int pageSize, int page) => '$categoryList?count=$pageSize&page=$page';

  static String getProductsUrl({required int pageSize, required int page, String? categoryId}) =>
      categoryId != null ? '$productList?count=$pageSize&page=$page&category=$categoryId' : '$productList?count=$pageSize&page=$page';

}