import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import 'sign_in_notifier.dart';

@RoutePage()
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isLoading = ref.watch(signInLoadingProvider);

    return Scaffold(
      key: WidgetKeys.signInPage,
      backgroundColor: context.decluttrTheme.canvas,
      appBar: AppBar(
        leading: AppIconButton(
          icon: backIcon(),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          context.decluttrTheme.x7,
          context.decluttrTheme.x6,
          context.decluttrTheme.x7,
          context.decluttrTheme.x7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.signInTitle, style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: context.decluttrTheme.x8),
            AppTextField(
              label: l10n.signInEmail,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: context.decluttrTheme.x4),
            AppTextField(
              label: l10n.signInPassword,
              controller: _passwordController,
              obscureText: true,
            ),
            const Spacer(),
            PrimaryButton(
              label: l10n.signInButton,
              isLoading: isLoading,
              onPressed: () async {
                await ref.read(signInLoadingProvider.notifier).signIn();
                if (context.mounted) context.router.maybePop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
