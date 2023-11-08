import 'package:asyncstate/asyncstate.dart';
import 'package:expede/src/core/ui/app_nav_global_key.dart';
import 'package:expede/src/core/ui/app_theme.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/features/auth/login/login_page.dart';
import 'package:expede/src/features/auth/register/company/company_register_page.dart';
import 'package:expede/src/features/auth/register/user/user_register_page.dart';
import 'package:expede/src/features/customers/browser_customers/browser_customers_page.dart';
import 'package:expede/src/features/customers/register/customer_register_page.dart';
import 'package:expede/src/features/employee/browser_employees/browser_employees_page.dart';
import 'package:expede/src/features/employee/register/employee_register_page.dart';
import 'package:expede/src/features/employee/schedule/employee_schedule_page.dart';
import 'package:expede/src/features/home/adm/home_adm_page.dart';
import 'package:expede/src/features/home/employee/home_employee_page.dart';
import 'package:expede/src/features/schedule/schedule_page.dart';
import 'package:expede/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ExpedeApp extends StatelessWidget {
  const ExpedeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const AppLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'DW Barbershoip',
          theme: AppTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: AppNavGlobalKey.instance.navKey,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserRegisterPage(),
            '/auth/register/company': (_) => const CompanyRegisterPage(),
            '/home/adm': (_) => const HomeAdmPage(),
            '/home/browser/employees': (_) => const BrowserEmployeesPage(),
            '/employee/register': (_) => const EmployeeRegisterPage(),
            '/home/browser/customers': (_) => const BrowserCustomersPage(),
            '/customer/register': (_) => const CustomerRegisterPage(),
            
            '/home/browser/shipments': (_) => const Text('shipment/register'),
            '/shipment/register': (_) => const Text('shipment/register'),
            '/home/browser/items_shipment': (_) => const Text('home/browser/items_shipment'),
            '/item_shipment/register': (_) => const Text('/item_shipment/register'),
            
            '/home/employee': (_) => const HomeEmployeePage(),
            '/employee/schedule': (_) => const EmployeeSchedulePage(),
            '/schedule': (_) => const SchedulePage(),
          },
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [Locale('pt', 'BR')],
          locale: const Locale('pt', 'BR'),
        );
      },
    );
  }
}
