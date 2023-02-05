import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  final log = Logger(
    printer: PrettyPrinter(colors: true),
  );

  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   super.onChange(bloc, change);
  //   log.i(change);
  // }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log.i("CURRENT STATE => ${transition.currentState}");
    log.i("NEXT STATE => ${transition.nextState}");
  }
}
