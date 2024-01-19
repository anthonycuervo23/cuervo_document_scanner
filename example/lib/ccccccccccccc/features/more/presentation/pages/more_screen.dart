import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/features/more/presentation/pages/more_widget.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends MoreWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        flexibleSpace: CommonWidget.commonLinearGradient(),
        automaticallyImplyLeading: false,
        title: CommonWidget.commonText(
          text: TranslationConstants.more.translate(context),
          color: appConstants.whiteBackgroundColor,
          fontWeight: FontWeight.w600,
          fontSize: 23,
        ),
      ),
      body: screenView(),
    );
  }
}
