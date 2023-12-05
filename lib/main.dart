import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

import 'src/config/router/app_router.dart';
import 'src/config/themes/app_theme.dart';
import 'src/domain/repositories/api_repository.dart';
import 'src/locator.dart';
import 'src/presentation/cubits/alert/alert_cubit.dart';
import 'src/presentation/cubits/login/login_cubit.dart';
import 'src/presentation/cubits/logout/logout_cubit.dart';
import 'src/presentation/cubits/profile/profile_cubit.dart';
import 'src/presentation/cubits/remote_resources/remote_resources_cubit.dart';
import 'src/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'src/utils/constants/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RemoteResourcesCubit(
            locator<ApiRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => AlertCubit(
            locator<ApiRepository>(),
          )..getAlertMessages(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
            locator<ApiRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(
            locator<ApiRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(
            locator<ApiRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(
            locator<ApiRepository>(),
          ),
        ),
      ],
      child: OKToast(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
          title: appTitle,
          theme: AppTheme.light,
        ),
      ),
    );
  }
}
