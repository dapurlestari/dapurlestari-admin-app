import 'package:admin/components/dialogs.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:get_storage/get_storage.dart';

import 'user.dart';

class AuthenticatedUser {
  AuthenticatedUser({
    required this.jwt,
    required this.user,
  });

  String jwt;
  User user;

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) => AuthenticatedUser(
    jwt: json["jwt"],
    user: User.fromJson(json["user"]),
  );

  factory AuthenticatedUser.fromStorage() {
    final box = GetStorage(ConstLib.userStorage);
    return AuthenticatedUser.fromJson(box.read(ConstLib.userAuth));
  }

  Map<String, dynamic> toJson() => {
    "jwt": jwt,
    "user": user.toJson(),
  };

  void logout({required Function onSuccess}) {
    Dialogs.general(
      title: 'Logout',
      contentText: 'Are you sure want to logout?',
      onConfirm: () {
        onSuccess();
        removeUserFromStorage();
      }
    );
  }

  void saveUserToStorage() {
    final box = GetStorage(ConstLib.userStorage);
    box.write(ConstLib.userAuth, toJson());
  }

  void removeUserFromStorage() {
    final box = GetStorage(ConstLib.userStorage);
    box.remove(ConstLib.userAuth);
  }
}