import 'package:final_year_project/DATA/Auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends ConsumerStatefulWidget {
  final Function()? onTap;

  const LoginPage(this.onTap, {super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final bool _formWasEdited = false;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: _formWasEdited
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// app logo.
                  const CircleAvatar(
                    backgroundImage: AssetImage('images/OIG01.jpeg'),
                    radius: 42,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "CastBox",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Welcome back to CastBox!",
                      style: GoogleFonts.alexandria(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 35),

                  /// email textfield
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'email',
                        prefixIcon: Icon(Icons.email_outlined)
                        //icon: Icon(Icons.email_outlined),
                        ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email alanı boş bırakılamaz!';
                      } else if (!isValidEmail(value)) {
                        return 'Geçerli bir email adresi girin!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),

                  /// password textfield
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.red),
                      ),
                      prefixIcon: const Icon(Icons.password_outlined),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      //icon: Icon(Icons.password_outlined),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isVisible,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Şifre alanı boş bırakılamaz!";
                      } else if (value.length < 6) {
                        return "Şifre en az 6 karakter olmalıdır!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: const Text(
                          "Forgot password ",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        onTap: () async {
                          String? email =
                              await _showForgotPasswordDialog(context);
                          if (email != null) {
                            await AuthService().resetPassword(email);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Şifre sıfırlama e-postası gönderildi. Lütfen e-posta kutunuzu kontrol edin."),
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// sign in button
                  TextButton(
                    onPressed: () => _signIn(context),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// register link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    /// Basit bir email doğrulama kontrolü için bir regex kullanılmıştır
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  void _signIn(BuildContext context) async {
    final _authService = AuthService();
    try {
      await _authService.signInWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim());
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  Future<String?> _showForgotPasswordDialog(BuildContext context) async {
    String? email;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Forgot Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                "Please enter your email address to reset your password:\n"),
            TextFormField(
              onChanged: (value) => email = value.trim(),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (email != null && email!.isNotEmpty) {
                Navigator.pop(context, email);
              }
            },
            child: const Text("Reset Password"),
          ),
        ],
      ),
    );

    return email;
  }
}
