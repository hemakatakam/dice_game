class Game {
  final List<int> playerDice;
  final List<int> computerDice;
  final int playerScore;
  final int computerScore;
  final int roundNumber;
  final int bet;

  const Game({
    this.playerDice = const [1, 1],
    this.computerDice = const [1, 1],
    this.playerScore = 0,
    this.computerScore = 0,
    this.roundNumber = 1,
    this.bet = 1,
  });

  Game copyWith({
    List<int>? playerDice,
    List<int>? computerDice,
    int? playerScore,
    int? computerScore,
    int? roundNumber,
    int? bet,
  }) => Game(
    playerDice: playerDice ?? this.playerDice,
    computerDice: computerDice ?? this.computerDice,
    playerScore: playerScore ?? this.playerScore,
    computerScore: computerScore ?? this.computerScore,
    roundNumber: roundNumber ?? this.roundNumber,
    bet: bet ?? this.bet,
  );
}
