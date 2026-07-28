import "package:flutter/material.dart";
import "package:miabe_quiz/core/extensions/index.dart";
import "package:miabe_quiz/core/theme/app_spacing.dart";
import "package:miabe_quiz/domain/entities/index.dart";
import "package:miabe_quiz/presentation/providers/index.dart";
import "package:miabe_quiz/presentation/widgets/app_elevated_button.dart";
import "package:miabe_quiz/presentation/widgets/app_scaffold.dart";
import "package:miabe_quiz/presentation/widgets/app_text_form_field.dart";
import "package:miabe_quiz/presentation/widgets/app_topbar.dart";
import "package:provider/provider.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Student student;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _schoolController = TextEditingController();
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final student = context.read<StudentProvider>().student;
      _fullNameController = TextEditingController(text: student.fullName);
      _emailController = TextEditingController(text: student.email);
      _phoneController = TextEditingController(text: student.phone);
      _schoolController = TextEditingController(text: student.school);
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final student = context.read<StudentProvider>().student;
    return AppScaffold(
      scrollable: true,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          AppTopbar(
            title: "Profil",
            centerTitle: context.isMobile,
            showLeading: context.isMobile,
            onPop: () => context.goToHome(student.fullName),
          ),
          AppSpacing.gapVMd,
          CircleAvatar(
            radius: AppSpacing.giga,
            child: Text(
              student.fullName[0],
              style: const TextStyle(fontSize: 54, fontWeight: .bold),
            ),
          ),
          AppSpacing.gapVXl,
          Form(
            key: _formKey,
            child: Column(
              spacing: AppSpacing.lg,
              children: [
                AppTextFormField(
                  isRequired: true,
                  controller: _fullNameController,
                  labelText: "Nom complet",
                  textCapitalization: .words,
                  keyboardType: .name,
                  textInputAction: .next,
                ),
                AppTextFormField(
                  isRequired: true,
                  controller: _emailController,
                  labelText: "Adresse mail",
                  keyboardType: .emailAddress,
                  textInputAction: .next,
                ),
                AppTextFormField(
                  isRequired: true,
                  controller: _phoneController,
                  labelText: "Téléphone",
                  keyboardType: .phone,
                  textInputAction: .done,
                ),
                AppTextFormField(
                  isRequired: true,
                  controller: _schoolController,
                  labelText: "École",
                  textCapitalization: .words,
                  textInputAction: .next,
                ),
              ],
            ),
          ),
          AppSpacing.gapVXxxl,
          // const Spacer(),
          AppElevatedButton(onPressed: submit, text: "VALIDER"),
        ],
      ),
    );
  }

  void submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<StudentProvider>().updateProfile(
      fullName: _fullNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      school: _schoolController.text,
    );
  }
}
