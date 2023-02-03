part of 'game_start_info_cubit.dart';

abstract class GameStartInfoState extends Equatable {
  const GameStartInfoState();
}

class GameStartInfoInitial extends GameStartInfoState {
  @override
  List<Object> get props => [];
}

class InitialLevelGameInfoCalculated extends GameStartInfoState {
  final String deposit;
  final String vat;
  final String placedBet;
  final String totalOdd;
  final String toWin;
  final String accountAmount;
  final String deducted;
  final String remaining;

  const InitialLevelGameInfoCalculated({
    required this.deposit,
    required this.vat,
    required this.placedBet,
    required this.totalOdd,
    required this.toWin,
    required this.accountAmount,
    required this.deducted,
    required this.remaining,
  });

  @override
  List<Object> get props => [
        deposit,
        vat,
        placedBet,
        totalOdd,
        toWin,
        accountAmount,
        deducted,
        remaining,
      ];
}
