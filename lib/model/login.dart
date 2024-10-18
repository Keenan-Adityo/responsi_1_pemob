class Login {
  int? code;
  bool? status;
  String? token;
  int? id;
  String? userEmail;
  Login({this.code, this.status, this.token, this.id, this.userEmail});
  factory Login.fromJson(Map<String, dynamic> obj) {
    if (obj['code'] == 200) {
      return Login(
          code: obj['code'],
          status: obj['status'],
          token: obj['data']['token'],
          id: obj['data']['user']['id'],
          userEmail: obj['data']['user']['email']);
    } else {
      return Login(
        code: obj['code'],
        status: obj['status'],
      );
    }
  }
}
