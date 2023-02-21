import 'package:flutter/material.dart';
import 'package:pay_crypto/model/client_model.dart';
import 'package:pay_crypto/pages/home_page.dart';
import 'package:pay_crypto/preference/shared_preference.dart';
import 'package:pay_crypto/utils/permissions.dart' as permissions;
import 'package:pay_crypto/wigets/modal_progress_hub.dart';
import 'package:pay_crypto/utils/custom_style.dart' as style;
import 'package:pay_crypto/utils/button.dart' as btn;
import 'package:pay_crypto/utils/validators.dart' as validator;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final PreferenceUser preferenceUser = PreferenceUser();

  bool isTyC = false;
  bool isErrorTerm = false;
  bool _saving = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ClientModel user = ClientModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      permissions.checkLogin(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgresState(
        inAsyncCall: _saving,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: style.widthForm,
              child: _body(),
            ),
          ),
        ),
      ),
    );
  }

  Column _body() {
    return Column(
      children: [
        const SizedBox(height: 5.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/icon.png'),
              ),
              const SizedBox(height: 20.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _createAlias(),
                    const SizedBox(height: 10.0),
                    _createWallet(),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: isTyC,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      isTyC = value!;
                      isErrorTerm = !isTyC;
                      setState(() {});
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      isTyC = !isTyC;
                      isErrorTerm = !isTyC;
                      setState(() {});
                    },
                    child: Text(
                      'Acepto los términos y condiciones',
                      style: TextStyle(
                        color: isErrorTerm ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _viewTyC,
                    child: const Icon(
                      Icons.info,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              btn.btn("Registrar", _resgister),
              const SizedBox(height: 10.0),
              const Center(child: Text("¿Ya tienes una cuenta?")),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _createAlias() {
    return TextFormField(
      maxLength: 70,
      initialValue: user.alias,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: style.inputDecoration("Alias", null),
      validator: validator.validatorAlias,
      onSaved: (value) {
        user.alias = value!.trim();
      },
    );
  }

  Widget _createWallet() {
    return TextFormField(
      maxLength: 70,
      initialValue: user.wallet,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: style.inputDecoration("Wallet", null),
      validator: validator.validatorsAddress,
      onSaved: (value) {
        user.wallet = value!.trim();
      },
    );
  }

  void _viewTyC() {}

  void _resgister() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (!isTyC) {
      isErrorTerm = true;
      setState(() {});
      return;
    }
    _saving = true;
    setState(() {});
    preferenceUser.clientModel = user;
    preferenceUser.auth = user.wallet;

    _saving = false;
    setState(() {});
    logIn(context, user);
  }

  void logIn(BuildContext context, ClientModel user) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
