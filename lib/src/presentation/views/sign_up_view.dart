import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../config/router/app_router.dart';
import '../../domain/models/requests/sign_up_request.dart';
import '../cubits/sign_up/sign_up_cubit.dart';

class SignUpView extends HookWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController(text: "");
    TextEditingController _pwdController = TextEditingController(text: "");
    TextEditingController _pwdCheckController = TextEditingController(text: "");
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 55, 106, 194),
            const Color.fromARGB(255, 233, 185, 114),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case SignUpInitial:
                return _buildSignUp(
                  _formkey,
                  _emailController,
                  _pwdController,
                  _pwdCheckController,
                  context,
                );
              case SignUpLoading:
                return const Center(child: CupertinoActivityIndicator());
              case SignUpFailed:
                return CupertinoAlertDialog(
                  title: const Text('회원가입 실패'),
                  content: const Text('회원가입에 실패했습니다.'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () {
                        context.read<SignUpCubit>().setInitial();
                        _emailController.clear();
                        _pwdController.clear();
                      },
                    ),
                  ],
                );
              case SignUpSuccess:
                return CupertinoAlertDialog(
                  title: const Text('회원가입 성공'),
                  content: const Text('회원가입에 성공했습니다.'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () {
                        appRouter.push(
                          const LoginViewRoute(),
                        );
                      },
                    ),
                  ],
                );
              default:
                return const Center(child: Icon(Icons.refresh));
            }
          },
        ),
      ),
    );
  }

  Widget _buildSignUp(
      GlobalKey<FormState> _formkey,
      TextEditingController _emailController,
      TextEditingController _pwdController,
      TextEditingController _pwdCheckController,
      BuildContext context) {
    return Padding(
      //container 세부 설정
      padding: const EdgeInsets.all(4),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/aws.png',
                    width: 120,
                    height: 120,
                  ),
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Form(
                key: _formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                              controller: _emailController,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Enter email address'),
                                EmailValidator(
                                    errorText: 'Please correct email filled'),
                              ]),
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  labelText: 'Email',
                                  prefixIcon: Icon(
                                    Icons.email,
                                    //color: Colors.green,
                                  ),
                                  errorStyle: TextStyle(fontSize: 18.0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(9.0)))))),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _pwdController,
                          obscureText: true,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter Password'),
                            MinLengthValidator(8,
                                errorText: 'Password must be atlist 8 digit'),
                            PatternValidator(r'(?=.*?[#!@$%^&*-])',
                                errorText:
                                    'Password must be atlist one special character')
                          ]),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.key,
                            ),
                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _pwdCheckController,
                          obscureText: true,
                          validator: (value) => MatchValidator(
                                  errorText: "Password does not match")
                              .validateMatch(value!, _pwdController.text),
                          decoration: InputDecoration(
                            hintText: 'Password Check',
                            labelText: 'Password Check',
                            prefixIcon: Icon(
                              Icons.key,
                            ),
                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CupertinoButton(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate() &&
                                    _pwdController.text ==
                                        _pwdCheckController.text) {
                                  context
                                      .read<SignUpCubit>()
                                      .signUp(SignUpRequest(
                                        email: _emailController.text,
                                        password: _pwdController.text,
                                      ));
                                }
                              },
                              color: Colors.blueGrey.withOpacity(0.2),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                          ),
                        ),
                      ),
                    ]),
              )),
        ],
      ),
    );
  }
}
