import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/home_screen.dart';
import 'package:tic_tac_toe/welcome_screen.dart';

class GameScreen extends StatefulWidget {

  String player1;
  String player2;
  GameScreen({required this.player1, required this.player2});
  @override
  State<GameScreen> createState() => _GameScreenState();

}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
  }

  // Reset Game
  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ""));
      _currentPlayer = "X";
      _winner = "";
      _gameOver = false;
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] != "" || _gameOver) {
      return;
    }

    setState(() {
      _board[row][col] = _currentPlayer;


      ///The game mechanism
      // check for a winner
      if (_board[row][0] == _currentPlayer &&
          _board[row][1] == _currentPlayer &&
          _board[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][col] == _currentPlayer &&
          _board[1][col] == _currentPlayer &&
          _board[2][col] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][0] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][2] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }

      // switch players
      _currentPlayer = _currentPlayer == "X" ? "O" : "X";

      // check for a tie
      if (!_board.any((row) => row.any((cell) => cell == ""))) {
        _gameOver = true;
        _winner = "ស្មើគ្នា";
      }

      if (_winner != "") {

        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: "លេងម្តងទៀត",
          title: _winner == "X"
              ? widget.player1 + " ឈ្នះ!"
              : _winner == "O"
              ? widget.player2 + " ឈ្នះ!"
              : "ស្មើគ្នា",
          btnOkOnPress: () {
            _resetGame();
          },
        )..show();

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B80D6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 70),
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "វេន: ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _currentPlayer == "X"
                            ? widget.player1 + " ($_currentPlayer)"
                            : widget.player2 + " ($_currentPlayer)",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: _currentPlayer == "X"
                              ? Color(0xFFE8210D)
                              : Color(0xFF1335C6),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                ],
              ),
            ),
            SizedBox(height: 0),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFC57925),
                borderRadius: BorderRadius.circular(1),
              ),
              margin: EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => _makeMove(row, col),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: _board[row][col] == "X"
                                ? Color(0xFFDD2918)
                                : Color(0xFF1435DA),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                );
                widget.player1 = "";
                widget.player2 = "";
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                child: Text(
                  "ត្រឡប់ទៅអេក្រង់ដើមវិញ",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
