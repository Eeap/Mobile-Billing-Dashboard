import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

import 'src/config/router/app_router.dart';
import 'src/config/themes/app_theme.dart';
import 'src/domain/models/requests/user_key_request.dart';
import 'src/domain/repositories/api_repository.dart';
import 'src/locator.dart';
import 'src/presentation/cubits/alert/alert_cubit.dart';
import 'src/presentation/cubits/profile/profile_cubit.dart';
import 'src/presentation/cubits/remote_resources/remote_resources_cubit.dart';
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
          )..getAwsResources(),
        ),
        BlocProvider(
          create: (context) => AlertCubit(
            locator<ApiRepository>(),
          )..getAlertMessages(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(
            locator<ApiRepository>(),
          )..setProfileKey(UserKeyRequest()),
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
