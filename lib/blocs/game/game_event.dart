abstract class GameEvent {}

class RollDiceEvent extends GameEvent {}

class ResetGameEvent extends GameEvent {}

class Updatebet extends GameEvent {
  final int bet;
  Updatebet(this.bet);
}

class ClearAlertEvent extends GameEvent {}
