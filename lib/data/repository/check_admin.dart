import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:read_me/data/repository/hive_operation.dart';

import '../../domain/repository/admin.dart';

class CheckIfAdminImp extends CheckIfAdmin {
  @override
  bool checkIfAdmin(String email, String password) {
    if (email == dotenv.env['EMAIL'] && password == dotenv.env['PASSWORD']) {
      HiveOperationsImp().addUserDatailes('admin');
      return true;
    }
    return false;
  }
}
