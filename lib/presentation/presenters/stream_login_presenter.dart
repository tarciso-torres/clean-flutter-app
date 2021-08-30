

class LoginState {
  String email;
  String password;
  String emailError;
  String passwordError;
  String mainError;
  String navigateTo;
  bool isLoading = false;

  bool get isFormValid => emailError == null
    && passwordError == null
    && email != null
    && password != null;
}
