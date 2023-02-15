
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'game_start_info_state.dart';

class GameStartInfoCubit extends Cubit<GameStartInfoState> {
  GameStartInfoCubit() : super(GameStartInfoInitial());

  calculateInitialLevelGameInfo(double odd, int amountToBet,double vatP,double balance) {

    if(amountToBet == 0){
      emit(GameStartInfoInitial());
      return;
    }

     String deposit = amountToBet.toStringAsFixed(2);
     String vat = getPercentage(amountToBet,vatP).toStringAsFixed(2);
     String placedBet=(amountToBet - (getPercentage(amountToBet,vatP))).toStringAsFixed(2);
     String totalOdd = "$odd";
     String toWin = (amountToBet*odd).toStringAsFixed(2);
     String accountAmount=balance.toStringAsFixed(2);
     String deducted=amountToBet.toStringAsFixed(2);
     String remaining=(balance-amountToBet).toStringAsFixed(2);

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

  double getPercentage(int total,double per){
    print("((total.toDouble()*per)/100).toInt() ${((total.toDouble()*per)/100)}");
    return ((total.toDouble()*per)/100);
  }
}
