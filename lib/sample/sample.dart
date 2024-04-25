import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limoverse_widgets/sample/custom_drop_down.dart';

class Sem {
  String? id;
  String? name;
  Sem({this.id, this.name});
}

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  final List<Sem> sampleList = [
    Sem(id: "A", name: "A"),
    Sem(id: "B", name: "B"),
    Sem(id: "C", name: "C"),
    Sem(id: "D", name: "D"),
    Sem(id: "E", name: "E"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Title"),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomTextFormField(),
              const CustomTextFormField(),
              const SizedBox(height: 10),
              CustomDropdown(
                items: List.generate(
                    sampleList.length,
                    (index) => DropdownItem(
                          value: sampleList.elementAt(index),
                          child: Text(sampleList.elementAt(index).name ?? ""),
                        )),
                dropdownButtonStyle:
                    const DropdownButtonStyle(backgroundColor: Colors.white),
                dropdownStyle: DropdownStyle(color: Colors.grey.shade100),
                child: const Text("Sem"),
                onChange: (p0) {},
              ),
              const SizedBox(height: 1000),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final TextInputType? inputType;
  final Function(String?)? validator;
  final Function? onTap;
  final Function? onEditingComplete;
  final bool isObscure;
  final Widget? prefix;
  final TextStyle? hintFontStyle;
  final Function? onSaved;
  final Function? onChanged;
  final TextInputAction? inputAction;
  final int? maxLines;
  final int? maxLength;
  final bool autoFocus;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool defaultFont;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool readOnly;
  final bool? isDense;
  final bool isCollapsed;
  final TextStyle? style;
  final Widget? suffix;
  final Color? borderColor;
  final Color? focusBorderColor;
  final double? borderThickness;
  final double? borderRadius;
  final Color? fillColor;
  final Color? cursorColor;
  const CustomTextFormField({
    Key? key,
    this.hintText = '',
    this.labelText,
    this.prefix,
    this.inputType,
    this.validator,
    this.hintFontStyle,
    this.onTap,
    this.onEditingComplete,
    this.autoFocus = false,
    this.isObscure = false,
    this.onSaved,
    this.onChanged,
    this.inputAction,
    this.inputFormatters,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.defaultFont = true,
    this.prefixIcon,
    this.contentPadding,
    this.readOnly = false,
    this.style,
    this.suffix,
    this.borderColor,
    this.borderThickness,
    this.focusBorderColor,
    this.fillColor,
    this.cursorColor,
    this.borderRadius,
    this.isCollapsed = false,
    this.isDense,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool enableLabel = false;
  bool enableObscure = true;

  @override
  Widget build(BuildContext context) {
    final outlinedBorder = OutlineInputBorder(
        borderSide: BorderSide(
            color: widget.borderColor ?? const Color(0xFF272727),
            width: widget.borderThickness ?? 1.5),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12));
    final outlinedErrorBorder = OutlineInputBorder(
        borderSide: BorderSide(
            color: const Color(0xFFB80000),
            width: widget.borderThickness ?? 1.5),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12));
    final outlinedFocusedBorder = OutlineInputBorder(
        borderSide: BorderSide(
            color: widget.focusBorderColor ?? const Color(0xFF6D737D),
            width: widget.borderThickness ?? 1.5),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12));
    return Theme(
      data: ThemeData(
        hintColor: const Color(0xFF626465),
      ),
      child: TextFormField(
        readOnly: widget.readOnly,
        controller: widget.controller,
        style: widget.style,
        onChanged:
            widget.onChanged != null ? (val) => widget.onChanged!(val) : null,
        onTap: () => setState(() {
          enableLabel = true;
        }),
        validator: widget.validator == null
            ? (val) {
                return null;
              }
            : (val) {
                return widget.validator!(val);
              },
        autocorrect: false,
        enableSuggestions: false,
        obscureText: widget.isObscure ? enableObscure : false,
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        autofocus: widget.autoFocus,
        cursorColor: widget.cursorColor ?? const Color(0xFF626465),
        keyboardType: widget.inputType,
        maxLines: widget.maxLines ?? 1,
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            border: outlinedBorder,
            enabledBorder: outlinedBorder,
            counterText: "",
            focusedBorder: outlinedFocusedBorder,
            focusedErrorBorder: outlinedErrorBorder,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            errorBorder: outlinedErrorBorder,
            labelText: enableLabel ? widget.labelText : null,
            hintText: widget.hintText,
            hintStyle: widget.hintFontStyle,
            filled: true,
            fillColor: widget.fillColor ?? Colors.white,
            prefix: widget.prefix,
            isDense: widget.isDense,
            isCollapsed: widget.isCollapsed,
            suffixIcon: widget.suffix),
      ),
    );
  }
}
