import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void showMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
