
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'game_start_info_state.dart';

class GameStartInfoCubit extends Cubit<GameStartInfoState> {
  GameStartInfoCubit() : super(GameStartInfoInitial());

  calculateInitialLevelGameInfo(double odd, int amountToBet) {

    if(amountToBet == 0){
      emit(GameStartInfoInitial());
      return;
    }

     String deposit = amountToBet.toStringAsFixed(2);
     String vat = (amountToBet - (amountToBet-1)).toStringAsFixed(2);
     String placedBet=(amountToBet-1).toStringAsFixed(2);
     String totalOdd = "$odd";
     String toWin = (amountToBet*odd).toStringAsFixed(2);
     String accountAmount=200.toStringAsFixed(2);
     String deducted=amountToBet.toStringAsFixed(2);
     String remaining=(200-amountToBet).toStringAsFixed(2);

    emit(
      InitialLevelGameInfoCalculated(
        deposit: deposit,
        vat: vat,
        placedBet: placedBet,
        totalOdd: totalOdd,
        toWin: toWin,
        accountAmount: accountAmount,
        deducted: deducted,
        remaining: remaining,
      ),
    );
  }
}
