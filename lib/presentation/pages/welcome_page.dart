import "package:flutter/material.dart";
import "package:miabe_quiz/core/extensions/index.dart";
import "package:miabe_quiz/core/theme/app_spacing.dart";
import "package:miabe_quiz/presentation/widgets/app_elevated_button.dart";
import "package:miabe_quiz/presentation/widgets/app_responsive_builder.dart";
import "package:miabe_quiz/presentation/widgets/index.dart"
    show AppScaffold, AppTextFormField;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final border = UnderlineInputBorder(
      borderSide: BorderSide(color: colorScheme.outline, width: 2),
    );
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: .spaceEvenly,
        children: [
          RichText(
            textAlign: .center,
            text: TextSpan(
              text: "Bienvenue sur\n",
              style: textTheme.headlineLarge,
              children: [
                TextSpan(
                  text: "Miabe Quiz",
                  style: textTheme.headlineMedium?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          ResponsiveLayout(
            builder: (type) {
              var pad = EdgeInsets.zero;
              switch (type) {
                case ScreenType.desktop:
                  pad = const EdgeInsets.symmetric(
                    horizontal: AppSpacing.yotta,
                  );
                  break;
                case ScreenType.tablet:
                  pad = const EdgeInsets.symmetric(horizontal: AppSpacing.mega);
                  break;
                default:
                  pad = EdgeInsets.zero;
                  break;
              }
              return AppTextFormField(
                controller: _nameController,
                isRequired: true,
                filled: false,
                autoFocus: true,
                padding: pad,
                textAlign: .center,
                keyboardType: .name,
                textCapitalization: .words,
                hintText: "Votre nom",
                hintStyle: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                onEditingComplete: submit,
                border: border,
                focusBorder: border,
              );
            },
          ),
          ResponsiveLayout(
            builder: (type) {
              if (type == ScreenType.mobile) return const SizedBox();
              return AppElevatedButton(
                onPressed: submit,
                buttonMaxSize: Size(
                  context.screenWidth * 0.4,
                  AppSpacing.buttonHeightLg,
                ),
                text: "VALIDER",
              );
            },
          ),
        ],
      ),
    );
  }

  void submit() {
    final name = _nameController.text;
    if (name.isEmpty) return;
    context.goToHome(name);
  }
}
