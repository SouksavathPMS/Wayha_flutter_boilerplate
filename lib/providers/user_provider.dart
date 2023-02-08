import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:sic_management_app/models/user_model.dart';
import 'package:sic_management_app/utils/hasura_helper.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> _userData = [];
  bool _isGettingUserInfo = false;
  Snapshot<dynamic>? _amount;
  Snapshot<dynamic>? get amount => _amount;

  bool get isGettingUserInfo => _isGettingUserInfo;
  List<UserModel> get userData => _userData;

  Future<void> getUserInfo() async {
    _isGettingUserInfo = true;
    _userData = await _fetchUser();
    _isGettingUserInfo = false;
    notifyListeners();
  }

  Future<void> getUserAmount() async {
    _amount = await _userAmout();
    notifyListeners();
  }

  Future<void> addUser({required UserModel userInfo}) async {
    await _addUser(userInfo: userInfo).then((value) => getUserInfo());
    notifyListeners();
  }

  Future<void> updateUser({required UserModel userInfo}) async {
    await _updateUser(userInfo: userInfo).then((value) => getUserInfo());
    notifyListeners();
  }

  Future<void> deleteUser({required String id}) async {
    await _deleteUser(id: id).then((value) => getUserInfo());
    notifyListeners();
  }
}

Future<void> _addUser({required UserModel userInfo}) async {
  HasuraConnect connection = HasuraHelper.hasuraHelper;
  String addUser = """
      mutation MyMutation(\$name: String, \$surname: String, \$tel: String) {
        insert_user(objects: {name: \$name, surname: \$surname, tel: \$tel}) {
          affected_rows
        }
      }
      """;
  await connection.mutation(addUser, variables: {
    "name": userInfo.name,
    "surname": userInfo.surname,
    "tel": userInfo.tel
  });
}

Future<void> _updateUser({required UserModel userInfo}) async {
  HasuraConnect connection = HasuraHelper.hasuraHelper;
  String updateUser = """
      mutation MyMutation(\$id: uuid, \$name: String, \$surname: String, \$tel: String) {
        update_user(where: {id: {_eq: \$id}}, _set: {name: \$name, surname: \$surname, tel: \$tel}) {
          affected_rows
        }
      }
      """;
  await connection.mutation(updateUser, variables: {
    "id": userInfo.id,
    "name": userInfo.name,
    "surname": userInfo.surname,
    "tel": userInfo.tel
  });
}

Future<void> _deleteUser({required String id}) async {
  HasuraConnect connection = HasuraHelper.hasuraHelper;
  String addUser = """
      mutation MyMutation(\$id: uuid) {
        delete_user(where: {id: {_eq: \$id}}) {
          affected_rows
        }
      }
      """;
  await connection.mutation(addUser, variables: {
    "id": id,
  });
}

Future<List<UserModel>> _fetchUser() async {
  HasuraConnect connection = HasuraHelper.hasuraHelper;
  String request = """
       query GetUser {
          user(order_by: {updated_at: desc}) {
            id
            name
            surname
            tel
          }
        }

      """;
  var data = await connection.query(request);
  List<dynamic> res = data['data']['user'];
  return res.map((e) => UserModel.fromJson(e)).toList();
}

Future<Snapshot<dynamic>> _userAmout() async {
  HasuraConnect connection = HasuraHelper.hasuraHelper;
  String userAmout = """
      subscription MySubscription {
        user_aggregate {
          aggregate {
            count
          }
        }
      }
      """;
  final amoutOfUser = await connection.subscription(userAmout);
  final amount = amoutOfUser.map(
    (value) => value["data"]["user_aggregate"]["aggregate"]["count"],
  );
  return amount;
}
