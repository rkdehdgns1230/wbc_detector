import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wbc_detector/components/default_button.dart';
import 'package:wbc_detector/components/text_form.dart';
import 'package:wbc_detector/constants.dart';
import 'package:wbc_detector/pages/login/login_page.dart';
import 'package:wbc_detector/share/authentication.dart';
import 'package:wbc_detector/theme.dart';

//회원가입 페이지
class SignUpPage extends StatefulWidget {
  static String routeName = "/login";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
//class SignUpPage extends StatelessWidget {
  static String routeName = "/sign";
  final _formKey = GlobalKey<FormState>();
  final _idFormKey = GlobalKey<FormState>();
  Authentication _auth = Authentication();

  late String _userId; //인증 데이터 보관
  late String _userPassword;

  String _message = "";
  String _userName = "";
  String _userPhoneNumber = "";

  @override
  void initState() {
    _auth = Authentication();
    super.initState();
  }

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  Widget idInput() {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextFormField(
          key: ValueKey(1),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: '아이디를 입력해주세요',
            enabledBorder: OutlineInputBorder(
              //기본 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              //터치시 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              //에러 발생시 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              //에러 발생 후 터치 시 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
          ), //입력칸 안에 써지는 글씨
          validator: (value) {
            if (value!.isEmpty || !value.contains('@')) {
              return 'Please enter a valid email address.';
            } else {
              return null;
            }
          },
          onSaved: (value) {
            _userId = value!;
          },
          onChanged: (value) {
            _userId = value;
          },
        ));
  }

  //비밀번호 입력
  Widget passwordInput() {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextFormField(
          key: ValueKey(1),
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
            hintText: '6글자 이상 비밀번호를 입력해주세요',
            enabledBorder: OutlineInputBorder(
              //기본 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              //터치시 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              //에러 발생시 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              //에러 발생 후 터치 시 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          //입력칸 안에 써지는 글씨
          validator: (value) {
            if (value!.isEmpty || value != _userPassword) {
              return 'Password is not same.';
            } else {
              return null;
            }
          },
          onSaved: (value) {
            _userPassword = value!;
          },
          onChanged: (value) {
            _userPassword = value;
          },
        ));
  }

  //회원가입 버튼
  Widget signupButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: PrimaryColor,
            padding: EdgeInsets.all(16),
          ),
          onPressed: () async {
            _tryValidation();
            _userId = (await _auth.signUp(_userId, _userPassword))!;
            print("Sign up for user $_userId");
            Navigator.pop(context);
          },
          child: Center(
            child: Text(
              '가입',
              style: textTheme().subtitle1,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("회원 가입"),
        //뒤로 가기 버튼
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('아이디'),
              Form(
                key: _idFormKey,
                child: idInput(),
              ),
              SizedBox(height: 20),
              //중복확인 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: PrimaryColor,
                  padding: EdgeInsets.all(10),
                ),
                onPressed: () {
                  // validator를 따로 코딩해줘야 할 듯 (구현하려면)
                  if (_idFormKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          content: Text('사용가능한 아이디입니다.'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('확인'),
                            )
                          ],
                        );
                    });
                  }
                },
                child: Center(
                  child: Text('중복확인'),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('비밀번호'),
                    passwordInput(),

                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text('- 개인정보 입력'),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text("이름"), //text_form에 작성된 class에 사용자 이름 전달
                    TextFormField(
                      key: ValueKey(3),
                      decoration: InputDecoration(
                        hintText: "이름을 입력해주세요.",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length > 9) {
                          return 'Please enter a valid name.';
                        }
                      },
                    ),
                    SizedBox(height: l_gap),
                    Text("핸드폰 번호 (-제외)"), //text_form에 작성된 class에 사용자 전화번호 전달
                    TextFormField(
                      key: ValueKey(4),
                      decoration: InputDecoration(
                        hintText: "핸드폰 번호 (-제외)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length != 11) {
                          return 'Please enter a valid phone number.';
                        }
                      },
                    ),
                    SizedBox(height: l_gap),
                    signupButton(),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    DefaultButton(
                      //default_button.dart에 정의한 함수 이용해 취소 버튼 생성
                      text: "취소",
                      press: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
