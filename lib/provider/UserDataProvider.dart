import 'package:flutter/cupertino.dart';
import 'package:homebinder/model/home_model.dart';

import '../model/user_model.dart';

class UserDataProvider extends ChangeNotifier {
  UserModel? userData;
  HomeModel? home;

  void setUserData(UserModel user) {
    this.userData = user;
    notifyListeners();
  }

  void setHomeModel(HomeModel model) {
    this.home = model;
    notifyListeners();
  }
}
