import 'package:google_sign_in/google_sign_in.dart';
class GoogleSignInApi {
  static final __clientIDWeb ='49783711688-q6n9o91frtb6kcvib7k73quvbde6rn7q.apps.googleusercontent.com';
  static final __googleSignIn = GoogleSignIn(clientId: __clientIDWeb);
  static Future<GoogleSignInAccount?> login() => __googleSignIn.signIn();
  static Future logout() =>__googleSignIn.disconnect();
  

}