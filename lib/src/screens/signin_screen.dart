import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rocket_help/src/components/input.dart';
import 'package:rocket_help/src/components/loader.dart';
import 'package:rocket_help/src/components/primary_button.dart';
import 'package:rocket_help/src/core/constants/colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final auth = FirebaseAuth.instance;
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool passwordHiden = true;

  Future<void> haddleSignIn() async {
    setState(() => isLoading = true);
    try {
      await auth.signInWithEmailAndPassword(
        email: loginController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      late String menssage;
      if (e.code == 'user-not-found') {
        menssage = 'Usuário não encontrado';
      } else if (e.code == 'wrong-password') {
        menssage = 'O usuário/senha incorretos';
        print('Wrong password provided for that user.');
      }
      await Fluttertoast.cancel();
      await Fluttertoast.showToast(
        msg: menssage,
        fontSize: 14,
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.red.shade600,
        backgroundColor: Colors.red.shade50,
      );
      print(e);
      setState(() => isLoading = false);
    }catch (e){
      print(e);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.stone[600],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/logo_primary.svg'),
                const SizedBox(height: 32),
                Text(
                  'Acesse a sua conta',
                  style: TextStyle(
                      color: AppColors.stone[100],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 18),
                Form(
                  key: formStateKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InputText(
                        controller: loginController,
                        hintText: 'E-mail',
                        icon: Icon(PhosphorIcons.envelope,
                            color: AppColors.stone[300]),
                      ),
                      const SizedBox(height: 12),
                      InputText(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: passwordHiden,
                          icon: Icon(PhosphorIcons.key,
                              color: AppColors.stone[300]),
                          suffixIcon: IconButton(
                            icon: Icon(
                                passwordHiden
                                    ? PhosphorIcons.eye_closed
                                    : PhosphorIcons.eye,
                                color: AppColors.stone[300]),
                            onPressed: () {
                              setState(() => (passwordHiden = !passwordHiden));
                            },
                          )),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (formStateKey.currentState != null &&
                                    formStateKey.currentState!.validate()) {
                                  haddleSignIn();
                                }
                              },
                        child: isLoading
                            ? Loader(weigth: 16, color: AppColors.stone[100])
                            : const Text('Entrar'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
