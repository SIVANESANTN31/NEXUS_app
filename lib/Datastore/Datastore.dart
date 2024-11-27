Map<String,String> LoginData = {};
class LoginDataStore{
  void Setusername(String username){
    LoginData.addAll({"email":username});
  }

  void SetPassword(String password){
    LoginData.addAll({"password":password});
    // print(LoginData);
  }
}


var patient_id ;
var Doctor_id;
var username;



