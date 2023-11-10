// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    AWSBillingDashboardViewRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const AWSBillingDashboardView(),
      );
    },
    AlertViewRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const AlertView(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          AWSBillingDashboardViewRoute.name,
          path: '/',
        ),
        RouteConfig(
          AlertViewRoute.name,
          path: '/alert-view',
        ),
      ];
}

/// generated route for
/// [AWSBillingDashboardView]
class AWSBillingDashboardViewRoute extends PageRouteInfo<void> {
  const AWSBillingDashboardViewRoute()
      : super(
          AWSBillingDashboardViewRoute.name,
          path: '/',
        );

  static const String name = 'AWSBillingDashboardViewRoute';
}

/// generated route for
/// [AlertView]
class AlertViewRoute extends PageRouteInfo<void> {
  const AlertViewRoute()
      : super(
          AlertViewRoute.name,
          path: '/alert-view',
        );

  static const String name = 'AlertViewRoute';
}
