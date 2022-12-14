import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:rocket_help/src/components/input.dart';
import 'package:rocket_help/src/components/loader.dart';
import 'package:rocket_help/src/components/primary_button.dart';
import 'package:rocket_help/src/model/order.dart';
import 'package:rocket_help/src/util/formaters.dart';

import '../core/constants/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ValueNotifier<String> chanalOrdersPath = ValueNotifier('');
  TextEditingController patrimonyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  void handdleRegiterOrder() {
    final db = FirebaseFirestore.instance;
    if(chanalOrdersPath.value.isEmpty) return;
    setState(() => isLoading = true);
    db
        .collection(chanalOrdersPath.value)
        .add(Order(
          patrimony: patrimonyController.text,
          description: descriptionController.text,
          when: format(DateTime.now()),
        ).toMap())
        .then((value) => Navigator.pop(context))
        .onError((error, stackTrace) => setState(() => isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    chanalOrdersPath.value =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      backgroundColor: AppColors.stone[600],
      appBar: AppBar(
        backgroundColor: AppColors.stone[600],
        leading: IconButton(
          icon: Icon(
            PhosphorIcons.caret_left,
            color: AppColors.stone[100],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Solicita????o',
          style: TextStyle(
              color: AppColors.stone[100],
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputText(
                hintText: 'N??mero do patrim??nio',
                controller: patrimonyController,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: InputText(
                  hintText: 'Descri????o do problema',
                  controller: descriptionController,
                  expands: true,
                  maxLines: null,
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                onPressed:isLoading ? null:handdleRegiterOrder,
                child: isLoading
                    ? Loader(color: AppColors.stone[100], weigth: 16)
                    : const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    patrimonyController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
