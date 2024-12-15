import 'package:flutter/material.dart';

void main() {
  runApp(SignUpApp());
}

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

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
          // Bagian atas (ilustrasi di tengah halaman)
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/images/sign_up_sign_in.png', // Ganti dengan path ilustrasi Anda
                  height: 280, // Sesuaikan ukuran ilustrasi
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Bagian bawah (form sign up)
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xFF002B5B), // Warna biru sesuai pada gambar
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul "Sign Up"
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Deskripsi di bawah judul
                  Text(
                    'Buat akun Anda - nikmati layanan kami dengan fitur-fitur terbaik',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 25),

                  // Input field untuk Email
                  _buildTextField(
                    controller: emailController,
                    icon: Icons.email,
                    hintText: 'Email',
                  ),
                  SizedBox(height: 20),

                  // Input field untuk Username
                  _buildTextField(
                    controller: usernameController,
                    icon: Icons.person,
                    hintText: 'Username',
                  ),
                  SizedBox(height: 20),

                  // Input field untuk Pekerjaan
                  _buildTextField(
                    controller: jobController,
                    icon: Icons.work,
                    hintText: 'Pekerjaan',
                  ),
                  SizedBox(height: 20),

                  // Input field untuk Password
                  _buildTextField(
                    controller: passwordController,
                    icon: Icons.lock,
                    hintText: 'Password',
                    isPassword: true,
                  ),
                  SizedBox(height: 30),

                  // Tombol submit
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.9, // Lebar 80% layar
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
                            borderRadius:
                                BorderRadius.circular(25), // Radius tombol
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
    String email = emailController.text;
    String username = usernameController.text;
    String job = jobController.text;
    String password = passwordController.text;

    if (email.isEmpty || username.isEmpty || job.isEmpty || password.isEmpty) {
      _showSnackBar('Semua field harus diisi!');
    } else {
      _showSnackBar('Akun berhasil dibuat!');
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
