import 'dart:async';
import 'dart:developer';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/helpers/messages.dart';
import 'package:expede/src/features/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 120 * _scale;

  var endAnimation = false;
  Timer? redirectTimer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1;
      });
    });
    super.initState();
  }

  void _redirect(String routName) {
    if (!endAnimation) {
      redirectTimer?.cancel();
      redirectTimer = Timer(const Duration(milliseconds: 300), () { 
        _redirect(routName);
      });
    } else {
      redirectTimer?.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(routName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          log('Erro ao validar o login', error: error, stackTrace: stackTrace);
          Messages.showError('Erro ao validar login', context);
          _redirect('/auth/login');
        },
        data: (data) {
          switch (data) {
            case SplashState.loggedADM:
              // Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false);
              _redirect('/home/adm');
            case SplashState.loggedEmployee:
              // Navigator.of(context).pushNamedAndRemoveUntil('/home/employee', (route) => false);
              _redirect('/home/employee');
            case _:
              // Navigator.of(context).pushNamedAndRemoveUntil('/auth/login', (route) => false);
              _redirect('/auth/login');
          }
        },
      );
    });

    return Scaffold(
        backgroundColor: Colors.black,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  ImageConstants.backgroundChair,
                ),
                opacity: 0.2,
                fit: BoxFit.cover),
          ),
          child: Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 4),
              curve: Curves.easeIn,
              opacity: _animationOpacityLogo,
              onEnd: () {
                setState(() {
                  endAnimation = true;
                });

                // Navigator.of(context).pushAndRemoveUntil(
                //     PageRouteBuilder(
                //       settings: const RouteSettings(name: '/auth/login'),
                //       pageBuilder: (
                //         context,
                //         animation,
                //         secondaryAnimation,
                //       ) {
                //         return const LoginPage();
                //       },
                //       transitionsBuilder: (_, animation, __, child) =>
                //           FadeTransition(
                //         opacity: animation,
                //         child: child,
                //       ),
                //     ),
                //     (route) => false);
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                width: _logoAnimationWidth,
                height: _logoAnimationHeight,
                curve: Curves.linearToEaseOut,
                child: Image.asset(
                  ImageConstants.imageLogo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ));
  }
}
