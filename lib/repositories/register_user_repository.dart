import '../model/User.dart';
import '../sqlight/DatabaseHelper.dart';
import '../utils/showToast.dart';

class UserRepository {
  final dbHelper = DatabaseHelper();
  Future<void> registerUser(User user) async {await dbHelper.insertUser(user);}
  Future<bool> loginUser(String email, String password) => dbHelper.loginUser(email,password);
  Future<List<User>> getAllUsers() => dbHelper.getAllUsers();
}
