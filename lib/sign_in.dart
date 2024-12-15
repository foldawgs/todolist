import 'package:flutter/material.dart';
import 'package:todolist/sign_up.dart';

void main() {
  runApp(SignInApp());
}

class SignInApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Bagian atas: Gambar ilustrasi
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/images/sign_up_sign_in.png', // Ganti dengan path gambar Anda
                  height: 280,
                ),
              ),
            ),
          ),

          // Bagian bawah: Form Sign In
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xFF002B5B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Judul "Sign In"
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Subtitle
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Masuk kembali ke akun Anda',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Input field: Username
                  _buildTextField(
                    controller: usernameController,
                    icon: Icons.person,
                    hintText: 'Username',
                  ),
                  SizedBox(height: 20),

                  // Input field: Password
                  _buildTextField(
                    controller: passwordController,
                    icon: Icons.lock,
                    hintText: 'Password',
                    isPassword: true,
                  ),

                  Spacer(), // Spacer untuk mendorong tombol ke bawah

                  // Tombol "Masuk"
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF002B5B),
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 150, // Lebar tombol sesuai desain
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25), // Sesuai desain
                      ),
                    ),
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Teks untuk Sign Up
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman Sign Up
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpApp(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Tidak Punya Akun? ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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

  // Widget untuk TextField
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
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Colors.white10,
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), // Sesuai desain
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Fungsi untuk submit form
  void _submitForm() {
    String username = usernameController.text;
    String password = passwordController.text;

    // Validasi sederhana
    if (username.isEmpty || password.isEmpty) {
      _showSnackBar('Username dan Password harus diisi!');
    } else {
      _showSnackBar('Berhasil masuk!');
    }
  }

  // Fungsi untuk menampilkan snackbar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
      ),
    );
  }
}
