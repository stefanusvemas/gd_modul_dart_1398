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
  stdout.write("NPM: ");
  String? npm = stdin.readLineSync();

  LoginControler loginControler = LoginControler();
  loginControler.login(username: username?? '', password: password?? '', npm: npm?? '');
}

class LoginControler{
  final LoginRepository loginRepository = LoginRepository();
  User userLogined = User();

  Future<void> login(
    {required String username, required String password, required String npm}) async{
      try {
        userLogined = await loginRepository.login(username, password, npm);
        print("Login success... Here your User data ${userLogined.toString()}");
        print("${userLogined.welcome()}");
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
  final String? npm;

  User({this.name, this.password, this.token, this.npm});

  @override
  String toString() {
    return 'User{name: $name, password: $password, token: $token, npm: $npm}';
  }

  String welcome(){
    return "Welcome $npm";
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
  String npm = '210711398';

  Future<User> login(String username, String password, String npm) async{
    print("Logining...");
    User userData = User();
    await Future.delayed(Duration(seconds: 3), () {
      if(username == this.username && password == this.password && npm == this.npm){
        userData = User(
          name: username, 
          password: password, 
          token: '12345',
          npm: npm);
      }else if(username == '' || password == '' || npm == ''){
        throw "Username or password cannot be empty";
      }else{
        throw FailedLogin();
      }
    });
    return userData;
  }
}