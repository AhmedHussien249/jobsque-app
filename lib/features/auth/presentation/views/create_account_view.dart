import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/auth/presentation/view_model/cubits/register_cubit/register_cubit.dart';
import 'package:jobsque/features/auth/presentation/views/create_account_content.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: BlocProvider(
                      create: (context) => sl<RegisterCubit>(),
                      child: CreateAccountContent(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
