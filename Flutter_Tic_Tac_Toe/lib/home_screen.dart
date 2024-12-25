import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
///home_class
class _HomeScreenState extends State<HomeScreen> {
  /// Keyto form input fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///the controllers to manage user's input
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();

  /// enter your name
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F87CA),
      body: Form(
        key: _formKey, ///to associate form key
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min, /// to minimize vertical spcae
              children: [
                const Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                const Text(
                  "សូមបញ្ចូលឈ្មោះរបស់អ្នក", ///In English: Please Enter your name
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildPlayerInputField(
                  controller: _player1Controller,
                  hintText: "អ្នកលេងទី១", /// "Player 1"in Khmer
                  validationMessage: "សូមបញ្ចូលឈ្មោះអ្នកលេងទី១",   ///In Eng: please inputer player 1 name
                ),
                const SizedBox(height: 15),
                _buildPlayerInputField(
                  controller: _player2Controller,
                  hintText: "អ្នកលេងទី២", /// "Player 2" in Khmer
                  validationMessage: "សូមបញ្ចូលឈ្មោះអ្នកលេងទី២",   ///Eng: Please input player 2 name
                ),
                const SizedBox(height: 20),
                _buildStartButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///create player's Widgets
  Widget _buildPlayerInputField({
    required TextEditingController controller,
    required String hintText,
    required String validationMessage,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }

  ///start_button widget

  Widget _buildStartButton() {
    return InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreen(
                player1: _player1Controller.text.trim(),
                player2: _player2Controller.text.trim(),
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
        child: const Text(
          "ចាប់ផ្តើម", /// "Start buttom" in Khmer
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
