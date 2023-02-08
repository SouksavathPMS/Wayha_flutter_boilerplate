// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import 'package:sic_management_app/constants/constant_color.dart';
import 'package:sic_management_app/models/user_model.dart';
import 'package:sic_management_app/providers/user_provider.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({
    Key? key,
    this.userInfo,
    this.isEditMode = false,
  }) : super(key: key);

  final UserModel? userInfo;
  final bool isEditMode;

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isCanAdd = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white.withOpacity(0),
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
      child: Container(
        padding: const EdgeInsets.all(30),
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: FormBuilder(
          initialValue: widget.userInfo == null
              ? {}
              : {
                  'name': widget.userInfo!.name,
                  'surname': widget.userInfo!.surname,
                  'tel': widget.userInfo!.tel,
                },
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                autofocus: true,
                autovalidateMode: AutovalidateMode.always,
                cursorColor: ConstantColors.secondary,
                name: 'name',
                style: const TextStyle(color: ConstantColors.secondary),
                decoration: const InputDecoration(
                    focusColor: ConstantColors.secondary,
                    hoverColor: ConstantColors.secondary,
                    hintText: "Kye..",
                    labelText: 'Name',
                    labelStyle: TextStyle(color: ConstantColors.secondary),
                    hintStyle: TextStyle(color: ConstantColors.secondary),
                    border: OutlineInputBorder()),
                onChanged: (val) {
                  setState(() {
                    if (_formKey.currentState!.validate()) {
                      _isCanAdd = true;
                    } else {
                      _isCanAdd = false;
                    }
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.always,
                cursorColor: ConstantColors.secondary,
                name: 'surname',
                style: const TextStyle(color: ConstantColors.secondary),
                decoration: const InputDecoration(
                    focusColor: ConstantColors.secondary,
                    hoverColor: ConstantColors.secondary,
                    hintText: "phommaseng..",
                    labelText: 'surname',
                    labelStyle: TextStyle(color: ConstantColors.secondary),
                    hintStyle: TextStyle(color: ConstantColors.secondary),
                    border: OutlineInputBorder()),
                onChanged: (val) {
                  setState(() {
                    if (_formKey.currentState!.validate()) {
                      _isCanAdd = true;
                    } else {
                      _isCanAdd = false;
                    }
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.always,
                cursorColor: ConstantColors.secondary,
                name: 'tel',
                style: const TextStyle(color: ConstantColors.secondary),
                decoration: const InputDecoration(
                    focusColor: ConstantColors.secondary,
                    hoverColor: ConstantColors.secondary,
                    hintText: "02056789012..",
                    labelText: 'Telephone',
                    labelStyle: TextStyle(color: ConstantColors.secondary),
                    hintStyle: TextStyle(color: ConstantColors.secondary),
                    border: OutlineInputBorder()),
                onChanged: (val) {
                  setState(() {
                    if (_formKey.currentState!.validate()) {
                      _isCanAdd = true;
                    } else {
                      _isCanAdd = false;
                    }
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                textInputAction: TextInputAction.next,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'.toUpperCase()),
                  ),
                  const SizedBox(width: 10),
                  !_isCanAdd && !widget.isEditMode
                      ? const SizedBox()
                      : ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            _formKey.currentState!.save();

                            final name =
                                _formKey.currentState!.fields['name']!.value;
                            final surname =
                                _formKey.currentState!.fields['surname']!.value;
                            final tel =
                                _formKey.currentState!.fields['tel']!.value;

                            if (widget.isEditMode) {
                              final id = widget.userInfo!.id;
                              UserModel userInfo = UserModel(
                                  id: id,
                                  name: name,
                                  surname: surname,
                                  tel: tel);

                              context
                                  .read<UserProvider>()
                                  .updateUser(userInfo: userInfo)
                                  .then(
                                    (value) => Navigator.popUntil(
                                        context, (route) => route.isFirst),
                                  );
                            } else {
                              UserModel userInfo = UserModel(
                                  name: name, surname: surname, tel: tel);
                              context
                                  .read<UserProvider>()
                                  .addUser(userInfo: userInfo)
                                  .then(
                                    (value) => Navigator.popUntil(
                                        context, (route) => route.isFirst),
                                  );
                            }
                          },
                          child: Text(
                            widget.userInfo == null
                                ? 'Add'.toUpperCase()
                                : 'Update'.toUpperCase(),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
