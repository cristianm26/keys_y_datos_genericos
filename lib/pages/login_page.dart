import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '', _password = '';
  DateTime? _birthday;
  final _formKey = GlobalKey<FormState>();
  void _submit() {
    final isOk = _formKey.currentState!.validate();
    if (isOk) {
      _formKey.currentState!.save();
      // ignore: avoid_print
      print('$_email $_password $_birthday');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    onChanged: (text) => _email = text,
                    validator: (text) {
                      if (text!.contains("@")) return null;
                      return "Invalido email";
                    },
                  ),
                  const SizedBox(height: 10),
                  BirthdayFormField(
                    onChanged: (value) {
                      _birthday = value;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    onChanged: (value) => _password = value,
                    validator: (text) {
                      if (text!.trim().length > 5) {
                        return null;
                      }
                      return "Invalido password";
                    },
                  ),
                  TextButton(
                    onPressed: _submit,
                    child: const Text("Enviar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BirthdayFormField extends StatelessWidget {
  const BirthdayFormField({
    Key? key,
    DateTime? initialValue,
    this.onChanged,
  })  : _birthday = initialValue,
        super(key: key);

  final DateTime? _birthday;
  final void Function(DateTime value)? onChanged;
  void _pickBirthday(
      BuildContext context, FormFieldState<DateTime> state) async {
    final birthday = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (_birthday != null) {
      state.didChange(birthday);
      if (onChanged != null) onChanged!(birthday!);
      /*  _birthday = birthday; */
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => _pickBirthday(context, state),
            child: Text(
              _birthday == null
                  ? "Selecciona tu fecha de Cumpleaños"
                  : _birthday.toString(),
            ),
          ),
          if (state.hasError)
            Text(
              state.errorText!,
              style: const TextStyle(color: Colors.redAccent),
            ),
        ],
      ),
      validator: (date) {
        if (date == null) return "Selecciona una fecha Valida";
        return null;
      },
    );
  }
}
