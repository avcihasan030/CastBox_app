
import 'package:easy_localization/easy_localization.dart';
import 'package:final_year_project/UI/pages/Home/show_dialog.dart';
import 'package:final_year_project/UI/utils/text_utils.dart';
import 'package:flutter/material.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: TextUtils.tooltipTitle,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text(TextUtils.regionTitle).tr(),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => ShowAlertDilaog(
                  parentContext: context,
                ),
              );
            },
          ),
        ];
      },
    );
  }
}
