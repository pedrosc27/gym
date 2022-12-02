import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/ui/utils/colors.dart';

class InputText extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType type;
  final Function? onSubmit;
  final Function? onChange;
  final bool isPassword;
  final String? Function(String?)? validate;
  final String label;
  final IconData prefix;
  final IconData? suffix;
  final Function? suffixPressed;
  final int? lines;

  const InputText({
    Key? key,
    required this.controller,
    required this.type,
    this.onSubmit,
    this.onChange,
    this.isPassword = false,
    this.validate,
    required this.label,
    required this.prefix,
    this.suffix,
    this.suffixPressed, this.lines,
  }) : super(key: key);

  @override
  InputTextState createState() => InputTextState();
}

class InputTextState extends State<InputText> {
  late bool _obscureText;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _onVisibleChanged() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.lines == null ? 1 : widget.lines,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontFamily: 'NeoRegular',
      ),
      controller: widget.controller,
      keyboardType: widget.type,
      obscureText: _obscureText,
      validator: widget.validate,
      
      //initialValue: widget.controller.text  ,
      decoration: InputDecoration(
        
        enabledBorder: const OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
          
        ),
        filled: true, //<-- SEE HERE
        fillColor: degradado,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: widget.isPassword
            ? CupertinoButton(
                minSize: 25,
                padding: const EdgeInsets.all(10),
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: primary,
                ),
                onPressed: _onVisibleChanged,
              )
            : Icon(
                widget.prefix,
                color: primary,
              ),
      ),
    );
  }
}
