import 'package:charity_app/screens/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/resources/auth_methods.dart';
import 'package:charity_app/screens/signup_screen.dart';
import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/common/text_field_input.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    final isFormValid = _formKey.currentState!.validate();
    if (isFormValid == false) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final navigator = Navigator.of(context);
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'success') {
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const RootScreen(),
        ),
      );
    } else {
      Fluttertoast.showToast(
          msg: res, backgroundColor: Colors.red, textColor: Colors.white);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    Image.asset(
                      'assets/logo.png',
                      height: 160,
                    ),
                    const Spacer(),
                    Text(
                      'Sign in to your account',
                      style: GoogleFonts.urbanist(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.1,
                      ),
                    ),
                    const Spacer(),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFieldInput(
                            textEditingController: _emailController,
                            label: 'Email Address',
                            hintText: 'Enter your email',
                            textInputType: TextInputType.emailAddress,
                            isEmail: true,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 18),
                          TextFieldInput(
                            textEditingController: _passwordController,
                            label: 'Password',
                            hintText: 'Enter your password',
                            textInputType: TextInputType.text,
                            isPass: true,
                            textInputAction: TextInputAction.done,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    InkWell(
                      onTap: loginUser,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          color: primaryColor,
                        ),
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Sign in',
                                style: GoogleFonts.urbanist(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const Spacer(flex: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            'Don\'t have an account?',
                            style: GoogleFonts.urbanist(
                              fontSize: 15,
                              color: const Color.fromRGBO(30, 35, 44, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: navigateToSignup,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              ' Sign up.',
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                color: const Color.fromRGBO(30, 35, 44, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
