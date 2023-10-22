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
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          AWSBillingDashboardViewRoute.name,
          path: '/',
        )
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
