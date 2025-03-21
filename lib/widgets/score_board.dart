import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/game/game_bloc.dart';
import '../blocs/game/game_state.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, GameState>(
    buildWhen: (previous, current) => 
        previous.game.playerScore != current.game.playerScore ||
        previous.game.computerScore != current.game.computerScore ||
        previous.game.roundNumber != current.game.roundNumber,
    builder: (context, state) => Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildScore('Player', state.game.playerScore, Colors.blue),
            Text(
              'Round ${state.game.roundNumber}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            _buildScore('Computer', state.game.computerScore, Colors.red),
          ],
        ),
      ),
    ),
  );

  Widget _buildScore(String label, int score, Color color) => Text(
    '$label: $score',
    style: TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    ),
  );
}
