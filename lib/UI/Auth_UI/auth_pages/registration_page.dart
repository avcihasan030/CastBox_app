import 'package:final_year_project/DATA/Auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  final Function()? onTap;

  const RegistrationPage(this.onTap, {super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _formWasEdited = false;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "CastBox",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Fuel Your Mind with Sound!",
                      style: GoogleFonts.alexandria(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 30),

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
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'password',
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
                  const SizedBox(height: 25),

                  /// confirm password textfield
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.red),
                      ),
                      prefixIcon: const Icon(Icons.password_outlined),
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
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'confirm password',
                      //icon: Icon(Icons.password_outlined),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isVisible,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Şifre doğrulama alanı boş bırakılamaz!";
                      } else if (value.length < 6) {
                        return "Şifre en az 6 karakter olmalıdır!";
                      } else if (value != (_passwordController.text.trim())) {
                        return "Şifreler uyuşmuyor!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  /// sign up button
                  TextButton(
                    onPressed: () => _register(context),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login Now",
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

  void _register(BuildContext context) async {
    final _authService = AuthService();
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      /// password matched -> create user
      if (_passwordController.text.trim() ==
          _confirmPasswordController.text.trim()) {
        try {
          await _authService.signUpWithEmailAndPassword(email, password);
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ),
          );
        }
      }

      /// passwords don't match -> tell user to fix
      else {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Passwords don't match!"),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
    }
  }
}
