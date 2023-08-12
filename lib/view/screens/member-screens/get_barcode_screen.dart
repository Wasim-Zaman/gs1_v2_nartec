import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hiring_task/constants/colors/app_colors.dart';
import 'package:hiring_task/models/member-registration/documents_model.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/view-model/member-registration/get_documents_service.dart';
import 'package:hiring_task/view/screens/member-screens/memeber_registration_screen.dart';
import 'package:hiring_task/widgets/custom_elevated_button.dart';
import 'package:hiring_task/widgets/required_text_widget.dart';

bool hasCrNumber = true;
bool isCompanyLocatedInKSA = true;

class GetBarcodeScreen extends StatefulWidget {
  const GetBarcodeScreen({super.key});
  static const String routeName = "get-barcode-screen";

  @override
  State<GetBarcodeScreen> createState() => _GetBarcodeScreenState();
}

class _GetBarcodeScreenState extends State<GetBarcodeScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _crNumberController = TextEditingController();
  String? selectedOption;
  int? selectedValue;
  String? document;
  List<String> documentList = [];

  @override
  void dispose() {
    _crNumberController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (hasCrNumber &&
        (_crNumberController.text.length < 10 ||
            _crNumberController.text.length > 10)) {
      return;
    } else if (document != null) {
      Navigator.of(context).pushNamed(
        MemberRegistrationScreen.routeName,
        arguments: {
          'cr_number': _crNumberController.text,
          'hasCrNumber': hasCrNumber,
          "document": document,
        },
      );
    } else if (document == null &&
        hasCrNumber &&
        _crNumberController.text.length == 10) {
      Navigator.of(context).pushNamed(
        MemberRegistrationScreen.routeName,
        arguments: {
          'cr_number': _crNumberController.text,
          'hasCrNumber': hasCrNumber,
          "document": document,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 171,
                    height: 74,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Image.asset('assets/images/barcode.png',
                        fit: BoxFit.fill),
                  ),
                  Divider(color: Theme.of(context).primaryColor, thickness: 4),
                  const SizedBox(height: 10),
                  const RequiredTextWidget(
                      title: 'Is your company located in Kingdom '),
                  YesNoRadioButtons(
                    onChanged: (value) {
                      setState(() {
                        isCompanyLocatedInKSA = value;
                      });
                    },
                    initialValue: isCompanyLocatedInKSA,
                  ),
                  const SizedBox(height: 30),
                  const RequiredTextWidget(title: 'Did you have CR number ? '),
                  YesNoRadioButtons(
                    onChanged: (value) {
                      setState(() {
                        hasCrNumber = value;
                      });
                    },
                    initialValue: hasCrNumber,
                  ),
                  const SizedBox(height: 30),
                  hasCrNumber
                      ? const RequiredTextWidget(title: 'CR Number')
                      : const RequiredTextWidget(title: 'Document'),
                  const SizedBox(height: 10),
                  hasCrNumber
                      ? CustomTextField(
                          controller: _crNumberController,
                          hintText: "Enter CR Number",
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Please enter CR Number";
                            }
                            if (p0.length < 10 || p0.length > 10) {
                              return "Please enter valid CR Number";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        )
                      : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: darkBlue),
                          ),
                          child: FutureBuilder(
                              future: DocumentServices.getDocuments(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: SizedBox(
                                      height: 40,
                                      child: LinearProgressIndicator(
                                        semanticsLabel: "Loading",
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Something went wrong, refresh the page",
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          icon: const Icon(Icons.refresh),
                                          label: const Text("Refresh"),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                final snap =
                                    snapshot.data as List<DocumentsModel>;
                                documentList.clear();
                                for (var doc in snap) {
                                  documentList.add(doc.name.toString());
                                }

                                return documentList.isEmpty
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.refresh))
                                    : SizedBox(
                                        width: double.infinity,
                                        height: 40,
                                        child: DropdownButton(
                                            value: document,
                                            isExpanded: true,
                                            items: documentList
                                                .map<DropdownMenuItem<String>>(
                                                  (String v) =>
                                                      DropdownMenuItem<String>(
                                                    value: v,
                                                    child: Column(
                                                      children: [
                                                        AutoSizeText(
                                                          v,
                                                          maxLines: 2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                document = newValue;
                                              });
                                            }),
                                      );
                              }),
                        ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    bgColor: darkBlue,
                    caption: "Validate",
                    buttonWidth: double.infinity,
                    onPressed: () {
                      _saveForm();
                    },
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.readOnly,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType ?? TextInputType.text,
      readOnly: readOnly ?? false,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText ?? 'Hint Text',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      validator: validator ??
          (value) {
            // if (value == null || value.isEmpty) {
            //   return 'Please provide value to the field';
            // }
            return null;
          },
    );
  }
}

class YesNoRadioButtons extends StatefulWidget {
  final void Function(bool) onChanged;
  final bool initialValue;

  const YesNoRadioButtons({
    super.key,
    required this.onChanged,
    required this.initialValue,
  });

  @override
  _YesNoRadioButtonsState createState() => _YesNoRadioButtonsState();
}

class _YesNoRadioButtonsState extends State<YesNoRadioButtons> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(
          value: true,
          groupValue: _value,
          onChanged: (bool? newValue) {
            setState(() {
              _value = newValue!;
              widget.onChanged(_value);
            });
          },
        ),
        const Text('Yes'),
        Radio(
          value: false,
          groupValue: _value,
          onChanged: (bool? newValue) {
            setState(() {
              _value = newValue!;
              widget.onChanged(_value);
            });
          },
        ),
        const Text('No'),
      ],
    );
  }
}

class SuggestionTextField extends StatefulWidget {
  @override
  _SuggestionTextFieldState createState() => _SuggestionTextFieldState();
}

class _SuggestionTextFieldState extends State<SuggestionTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _suggestions = ['Apple', 'Banana', 'Cherry', 'Durian'];

  String _selectedSuggestion = '';

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return _suggestions.where((suggestion) => suggestion
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (String suggestion) {
        _textEditingController.text = suggestion;
        setState(() {
          _selectedSuggestion = suggestion;
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: _textEditingController,
          decoration: const InputDecoration(
            hintText: 'Enter a suggestion',
          ),
          onChanged: (value) {
            setState(() {
              _selectedSuggestion = '';
            });
          },
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class NumericSuggestionBox extends StatefulWidget {
  @override
  _NumericSuggestionBoxState createState() => _NumericSuggestionBoxState();

  NumericSuggestionBox({
    this.selectedValue,
    this.suggestions,
    this.onSuggestionSelected,
  });
  final List<String>? suggestions;
  String? selectedValue;
  final Function? onSuggestionSelected;
}

class _NumericSuggestionBoxState extends State<NumericSuggestionBox> {
  // final List<int> suggestions = [1, 10, 20, 30, 50, 100, 500, 1000];
  // int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text('Select a number:'),
        const SizedBox(height: 10),
        TypeAheadFormField(
          getImmediateSuggestions: true,
          suggestionsCallback: (pattern) {
            return widget.suggestions!
                .where(
                    (suggestion) => suggestion.toString().startsWith(pattern))
                .toList();
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion.toString()),
            );
          },
          onSuggestionSelected: (suggestion) {
            setState(() {
              widget.selectedValue = suggestion;
              widget.onSuggestionSelected!(suggestion);
            });
          },
          textFieldConfiguration: const TextFieldConfiguration(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a number',
            ),
          ),
        ),
        const SizedBox(height: 10),
        // if (widget.selectedValue != null) Text('${widget.selectedValue}'),
      ],
    );
  }
}
