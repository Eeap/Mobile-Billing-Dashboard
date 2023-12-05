import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../config/router/app_router.dart';
import '../../domain/models/requests/aws_resources_request.dart';
import '../../domain/models/requests/login_request.dart';
import '../cubits/login/login_cubit.dart';
import '../cubits/remote_resources/remote_resources_cubit.dart';

class LoginView extends HookWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController(text: "");
    TextEditingController _pwdController = TextEditingController(text: "");
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
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case LoginSuccess:
                  return CupertinoAlertDialog(
                    title: const Text('로그인 성공'),
                    content: const Text('로그인에 성공했습니다.'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () {
                          context.read<RemoteResourcesCubit>().getAwsResources(
                              AwsResourceRequest(
                                  email:
                                      context.read<LoginCubit>().state.email));
                          appRouter.push(
                            const AWSBillingDashboardViewRoute(),
                          );
                        },
                      ),
                    ],
                  );
                case LoginLoading:
                  return const Center(child: CupertinoActivityIndicator());
                case LoginFailed:
                  return CupertinoAlertDialog(
                    title: const Text('로그인 실패'),
                    content: const Text('이메일 or 패스워드를 다시 입력해주세요.'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () {
                          context.read<LoginCubit>().setInitial();
                          _emailController.clear();
                          _pwdController.clear();
                        },
                      ),
                    ],
                  );
                case LoginInitial:
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
                                Text(
                                  "Mobile Billing Dashboard",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 249, 169, 49),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
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
                                                  errorText:
                                                      'Enter email address'),
                                              EmailValidator(
                                                  errorText:
                                                      'Please correct email filled'),
                                            ]),
                                            decoration: InputDecoration(
                                                hintText: 'Email',
                                                labelText: 'Email',
                                                prefixIcon: Icon(
                                                  Icons.email,
                                                  //color: Colors.green,
                                                ),
                                                errorStyle:
                                                    TextStyle(fontSize: 18.0),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                9.0)))))),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: TextFormField(
                                        controller: _pwdController,
                                        obscureText: true,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  'Please enter Password'),
                                          MinLengthValidator(8,
                                              errorText:
                                                  'Password must be atlist 8 digit'),
                                          PatternValidator(
                                              r'(?=.*?[#!@$%^&*-])',
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
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(9.0))),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: CupertinoButton(
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            onPressed: () {
                                              if (_formkey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<LoginCubit>()
                                                    .login(
                                                      LoginRequest(
                                                        email: _emailController
                                                            .text,
                                                        password:
                                                            _pwdController.text,
                                                      ),
                                                    );
                                              }
                                            },
                                            color: Colors.blueGrey
                                                .withOpacity(0.2),
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: CupertinoButton(
                                            child: Text(
                                              'Sign up',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            onPressed: () {
                                              appRouter.push(
                                                const SignUpViewRoute(),
                                              );
                                            },
                                            color: Colors.blueGrey
                                                .withOpacity(0.2),
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                  ]),
                            )),
                      ],
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          )),
    );
  }
}
