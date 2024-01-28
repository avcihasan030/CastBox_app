import 'package:easy_localization/easy_localization.dart';
import 'package:final_year_project/UI/utils/text_utils.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class ShowAlertDilaog extends StatefulWidget {
  final BuildContext parentContext;

  const ShowAlertDilaog({super.key, required this.parentContext});

  @override
  State<ShowAlertDilaog> createState() => _ShowAlertDilaogState();
}

class _ShowAlertDilaogState extends State<ShowAlertDilaog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(TextUtils.selectRegion).tr(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('United States'),
            leading: Flag.fromCode(
              FlagsCode.US,
              height: 20,
              width: 30,
            ),
            onTap: () {
              widget.parentContext.setLocale(const Locale('en', 'US'));
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('Türkiye'),
            leading: Flag.fromCode(
              FlagsCode.TR,
              height: 20,
              width: 30,
            ),
            onTap: () {
              widget.parentContext.setLocale(const Locale('tr', 'TR'));
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('España'),
            leading: Flag.fromCode(
              FlagsCode.ES,
              height: 20,
              width: 30,
            ),
            onTap: () {
              widget.parentContext.setLocale(const Locale('es', 'ES'));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
