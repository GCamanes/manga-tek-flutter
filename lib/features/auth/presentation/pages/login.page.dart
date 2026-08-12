import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangatek_flutter/core/di/injection.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';
import 'package:mangatek_flutter/core/extensions/build_context.extensions.dart';
import 'package:mangatek_flutter/core/helpers/config_holder.dart';
import 'package:mangatek_flutter/core/navigation/router.helper.dart';
import 'package:mangatek_flutter/core/presentation/cubits/base.state.dart';
import 'package:mangatek_flutter/core/presentation/widgets/custom_button.widget.dart';
import 'package:mangatek_flutter/core/presentation/widgets/custom_loader.widget.dart';
import 'package:mangatek_flutter/core/presentation/widgets/custom_text_field.widget.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';
import 'package:mangatek_flutter/features/auth/presentation/cubits/get_current_user.cubit.dart';
import 'package:mangatek_flutter/features/auth/presentation/cubits/login.cubit.dart';
import 'package:mangatek_flutter/generated/assets.gen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late final GetCurrentUserCubit _getCurrentUserCubit;
  late final LoginCubit _loginCubit;

  late final AnimationController _formAnimController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _getCurrentUserCubit = getIt<GetCurrentUserCubit>();
    _loginCubit = getIt<LoginCubit>();

    _formAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _formAnimController,
      curve: Curves.easeOut,
    ));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _formAnimController, curve: Curves.easeIn),
    );

    _getCurrentUserCubit.getCurrentUser();
  }

  @override
  void dispose() {
    _formAnimController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _getCurrentUserCubit.close();
    _loginCubit.close();
    super.dispose();
  }

  void _onCurrentUserState(BuildContext context, BaseState<UserEntity> state) {
    state.maybe(
      onSuccess: (_) => RouterHelper.goToHome(context),
      onError: (_) => _formAnimController.forward(),
    );
  }

  void _onLoginState(BuildContext context, BaseState<UserEntity> state) {
    state.maybe(
      onSuccess: (_) => RouterHelper.goToHome(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _getCurrentUserCubit),
        BlocProvider.value(value: _loginCubit),
      ],
      child: Scaffold(
        body: SafeArea(
          child: MultiBlocListener(
            listeners: [
              BlocListener<GetCurrentUserCubit, BaseState<UserEntity>>(
                listener: _onCurrentUserState,
              ),
              BlocListener<LoginCubit, BaseState<UserEntity>>(
                listener: _onLoginState,
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(),
                  _Logo(),
                  const Spacer(),
                  _LoaderOrForm(
                    slideAnimation: _slideAnimation,
                    fadeAnimation: _fadeAnimation,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    ConfigHolder.appVersion,
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Logo section
// ---------------------------------------------------------------------------

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.images.mangatekLogo.image(width: 160),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Manga',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                  fontFamily: 'Exo2',
                ),
              ),
              TextSpan(
                text: 'Tek',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: colors.secondary,
                  fontFamily: 'Exo2',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Loader or form — switches between loading state and animated form
// ---------------------------------------------------------------------------

class _LoaderOrForm extends StatelessWidget {
  const _LoaderOrForm({
    required this.slideAnimation,
    required this.fadeAnimation,
    required this.emailController,
    required this.passwordController,
  });

  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCurrentUserCubit, BaseState<UserEntity>>(
      builder: (context, state) {
        if (state.isLoading || state.isInitial) {
          return const SizedBox(height: 120, child: Center(child: CustomLoader()));
        }

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: _LoginForm(
              emailController: emailController,
              passwordController: passwordController,
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Login form
// ---------------------------------------------------------------------------

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final trad = context.trad;

    return BlocBuilder<LoginCubit, BaseState<UserEntity>>(
      builder: (context, loginState) {
        final isLoading = loginState.isLoading;
        final hasError = loginState.maybe(
              onError: (e) => e.type == ExceptionType.auth,
            ) ??
            false;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              label: trad.email,
              controller: emailController,
              isEnabled: !isLoading,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: trad.password,
              controller: passwordController,
              isEnabled: !isLoading,
              isObscure: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(context),
            ),
            if (hasError) ...[
              const SizedBox(height: 12),
              Text(
                trad.errorCredentials,
                style: TextStyle(color: context.colorTheme.error, fontSize: 13),
              ),
            ],
            const SizedBox(height: 24),
            CustomButton(
              label: trad.login,
              isLoading: isLoading,
              onPressed: () => _submit(context),
            ),
          ],
        );
      },
    );
  }

  void _submit(BuildContext context) {
    context.read<LoginCubit>().login(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
  }
}
