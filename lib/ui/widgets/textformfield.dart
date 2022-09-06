import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final Icon? leadingIcon;
  final bool isTitle;
  final Color? color;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const TextFieldWidget(
      {Key? key,
      this.isTitle = false,
      required this.controller,
      required this.title,
      this.leadingIcon,
      this.validator,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.98,
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isTitle)
            Text(
              title,
              style: Theme.of(context).textTheme.headline1,
            ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
                controller: controller,
                validator: validator,
                // autovalidateMode: AutovalidateMode.always,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: leadingIcon,
                    hintText: title,
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: color ?? Theme.of(context).primaryColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: color ?? Theme.of(context).primaryColor,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: color ?? Theme.of(context).primaryColor,
                            width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: color ?? Theme.of(context).primaryColor,
                            width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)))),
          ),
        ],
      ),
    );
  }
}
