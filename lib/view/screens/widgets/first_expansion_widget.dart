import 'package:flutter/material.dart';

import 'expansion_row_widget.dart';

class FirstExpansionWidget extends StatelessWidget {
  final String? companyName;
  final String? companyAddress;
  final String? companyWebsite;
  final String? licenseType;
  final String? licenseKey;
  final String? globalLocationNumber;
  final String? licenseMemberOrganization;

  const FirstExpansionWidget(
      {super.key,
      this.companyName,
      this.companyAddress,
      this.companyWebsite,
      this.licenseType,
      this.licenseKey,
      this.globalLocationNumber,
      this.licenseMemberOrganization});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          "Information about the company that licensed this GTIN",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ExpansionRowWidget(
          keyy: 'Company Name',
          value: companyName ?? 'Dal Giardino Ltd.',
        ),
        const Divider(color: Colors.grey, thickness: 1),
        ExpansionRowWidget(
          keyy: 'Address',
          value: companyAddress ?? "null",
        ),
        const Divider(color: Colors.grey, thickness: 1),
        ExpansionRowWidget(
          keyy: 'Website',
          value: companyWebsite ?? 'www.dalgiardino.com',
        ),
        const Divider(color: Colors.grey, thickness: 1),
        ExpansionRowWidget(
          keyy: 'License Type',
          value: licenseType ?? 'GS1 US License',
        ),
        const Divider(color: Colors.grey, thickness: 1),
        ExpansionRowWidget(
          keyy: 'License Key',
          value: licenseKey ?? '123456789',
        ),
        const Divider(color: Colors.grey, thickness: 1),
        ExpansionRowWidget(
          keyy: 'Global Location\nNumber (GLN)',
          value: globalLocationNumber ?? '123456789',
        ),
        const Divider(color: Colors.grey, thickness: 1),
        ExpansionRowWidget(
          keyy: 'Licensing GS1\nMember\nOrganization',
          value: licenseType ?? 'GS1 US Office',
        ),
        const SizedBox(
          height: 20,
          child: Divider(color: Colors.grey, thickness: 1),
        ),
        const Text(
            "This license iformation is provided by GS1 Global Office and last updated 30 Jan 2023"),
      ],
    );
  }
}
