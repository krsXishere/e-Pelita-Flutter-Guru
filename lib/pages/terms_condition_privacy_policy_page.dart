import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../common/theme.dart';

class TermsConditionPrivacyPolicyPage extends StatefulWidget {
  const TermsConditionPrivacyPolicyPage({super.key});

  @override
  State<TermsConditionPrivacyPolicyPage> createState() =>
      _TermsConditionPrivacyPolicyPageState();
}

class _TermsConditionPrivacyPolicyPageState
    extends State<TermsConditionPrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Syarat dan Ketentuan\ndan Kebijakan Privasi",
          textAlign: TextAlign.center,
          style: secondaryTextStyle.copyWith(
            fontSize: 14,
          ),
        ),
      ),
      body: SfPdfViewer.asset(
        "assets/pdf/syarat_ketentuan_kebijakan_privasi.pdf",
      ),
    );
  }
}
