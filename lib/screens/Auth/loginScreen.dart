import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../Homepage/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}
class _LoginScreenState
    extends State<LoginScreen> {
  final TextEditingController usernameController =TextEditingController();
  final TextEditingController passwordController =TextEditingController();

  bool isLoading = false;
  void handleLogin() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Username dan password wajib diisi",
          ),
        ),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    bool success = await AuthService().login(
      username: usernameController.text,
      password: passwordController.text,
    );
    setState(() {
      isLoading = false;
    });
    if (!mounted) return;
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login gagal"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeef2ff),
      body: Stack(
        children:[
          Positioned(
            top: -100,
            left: -80,
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    const Color(0xffc4b5fd).withOpacity(0.35),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -90,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    const Color(0xff93c5fd).withOpacity(0.30),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0f172a),
                        height: 1.1,
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Text(
                      "Mulai login untuk melanjutkan",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff64748b),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 45),
                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.75),
                        borderRadius:
                            BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.08),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              hintText: "Username",
                              filled: true,
                              fillColor:
                                  const Color(0xfff8fafc),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Password",
                              filled: true,
                              fillColor:
                                  const Color(0xfff8fafc),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 35),
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: ElevatedButton(
                              onPressed:
                                  isLoading
                                      ? null
                                      : handleLogin,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:
                                    const Color(0xff111827),
                                foregroundColor:
                                    Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(22),
                                ),
                              ),
                              child:
                                  isLoading
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child:
                                              CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          "LOGIN",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                                FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}