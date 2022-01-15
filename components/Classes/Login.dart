// Class - LoginResponseModel
// Functionality - Like explained before in other code files pertaining to the login screen, the code written here is from a youtube tutorial,
//                and I take no credit for the design of this code. To be honest the code is far cleaner for API calls than what I have written,
//                but I wrote the login screen at the very end of the project, so it's not like I could go and change all my calls and ensure everything works as before
//                in the time I had left. Other than that the code is pretty easy to read. You take in json data and make it to the appropriate variables.
//                Extra logical sugar was sprinkled in to take care of null data, but other than that its not complicated.



class LoginResponseModel {
  final String token;
  final String refreshToken;
  final String result;


  LoginResponseModel({required this.token, required this.refreshToken, required this.result});
  
  factory LoginResponseModel.fromJson(Map<String,dynamic> json) {
    return LoginResponseModel(
        token: json["token"]["session"] != null ? json["token"]["session"]: "",
        refreshToken: json["token"]["refresh"] != null ? json["token"]["refresh"]: "",
        result: json["result"] != null ? json["result"]: "");
  }

}

// Class - LoginRequestModel
// Functionality - Same stuff as before except this class takes in the email and password given to us by the form in our login page.
class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel( {required this.email, required this.password} );

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = {'email': email.trim(), 'password': password.trim()};
    return map;
  }
}