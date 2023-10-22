import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../presentation/views/aws_billing_dashboard_view.dart';

part 'app_router.gr.dart';

@AdaptiveAutoRouter(
  routes: [
    AutoRoute(page: AWSBillingDashboardView, initial: true),
  ],
)
class AppRouter extends _$AppRouter {}

final appRouter = AppRouter();
