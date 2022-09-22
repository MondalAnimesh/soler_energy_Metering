class Apis {
  String api = "http://192.168.10.99:8080";
}

class Routes {
  String register = "/register";
  String login(phone, pass) => "/login?phoneNumber=$phone&password=$pass";
  String userinfo = "/getCurrentUserInfo";
  String adddevice = "/addDeviceToUserAccount";
}
