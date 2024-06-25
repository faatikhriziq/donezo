abstract class Params {}

class NoParams extends Params {}

class SignUpParams extends Params {
  String email;
  String password;

  SignUpParams({
    required this.email,
    required this.password,
  });
}

class SignInParams extends Params {
  String email;
  String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}
