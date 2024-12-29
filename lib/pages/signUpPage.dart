import 'package:flutter/material.dart';
import 'package:todolist/auth.dart';
import 'package:todolist/pages/signInPage.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/images/sign_up_sign_in.png',
                  height: 280,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xFF002B5B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context); // Kembali ke layar sebelumnya
                      },
                    ),
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Buat akun Anda - nikmati layanan kami dengan fitur-fitur terbaik',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 25),
                  _buildTextField(
                    controller: emailController,
                    icon: Icons.email,
                    hintText: 'Email',
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: usernameController,
                    icon: Icons.person,
                    hintText: 'Username',
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: jobController,
                    icon: Icons.work,
                    hintText: 'Pekerjaan',
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: passwordController,
                    icon: Icons.lock,
                    hintText: 'Password',
                    isPassword: true,
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF002B5B),
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Buat Akun Saya',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white10,
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _submitForm() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();
  String username = usernameController.text.trim();
  String job = jobController.text.trim();

  if (email.isEmpty || password.isEmpty || username.isEmpty || job.isEmpty) {
    _showSnackBar('Semua field harus diisi!');
    return;
  }

  try {
    // Mendaftar dan menyimpan data ke Firestore
    await Auth().signUpWithEmailAndPassword(
      email: email,
      password: password,
      username: username,
      job: job,
    );

    // Berhasil mendaftar
    _showSnackBar('Akun berhasil dibuat!');

    // Navigasi ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  } catch (e) {
    // Tangani kesalahan jika pendaftaran gagal
    _showSnackBar('Terjadi kesalahan. Coba lagi.');
  }
}


  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
      ),
    );
  }
}
