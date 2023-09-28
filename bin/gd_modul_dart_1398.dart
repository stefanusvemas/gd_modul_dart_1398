import 'dart:io';

import 'package:gd_modul_dart_1398/gd_modul_dart_1398.dart' as gd_modul_dart_1398;

void main() {
  print("Welcome to GD Modul Dart!");
  print("=========================");
  print("---------LOGIN-----------");
  stdout.write("Username: ");
  String? username = stdin.readLineSync();
  stdout.write("Password: ");
  String? password = stdin.readLineSync();

  LoginControler loginControler = LoginControler();
  loginControler.login(username: username?? '', password: password?? '');
}

class LoginControler{
  final LoginRepository loginRepository = LoginRepository();
  User userLogined = User();

  Future<void> login(
    {required String username, required String password}) async{
      try {
        userLogined = await loginRepository.login(username, password);
        print("Login success... Here your User data ${userLogined.toString()}");
      } on FailedLogin catch (e) {
        print(e.errorMessage());
      } on String catch (e) {
        print(e);
      } catch (e) {
        print(e);
      } finally {
        print("Login process has been completed");
      }
    }
}

class User{
  final String? name;
  final String? password;
  final String? token;

  User({this.name, this.password, this.token});

  @override
  String toString() {
    return 'User{name: $name, password: $password, token: $token}';
  }
}

class FailedLogin implements Exception{
  String errorMessage(){
    return 'Login failed';
  }
}

class LoginRepository{
  String username = 'User';
  String password = '123';

  Future<User> login(String username, String password) async{
    print("Logining...");
    User userData = User();
    await Future.delayed(Duration(seconds: 3), () {
      if(username == this.username && password == this.password){
        userData = User(
          name: username, 
          password: password, 
          token: '12345');
      }else if(username == '' || password == ''){
        throw "Username or password cannot be empty";
      }else{
        throw FailedLogin();
      }
    });
    return userData;
  }
}