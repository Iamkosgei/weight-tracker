import 'package:fitness/core/blocs/add_edit_weight_cubit/add_edit_weight_cubit.dart';
import 'package:fitness/core/blocs/delete_weight_cubit/delete_weight_cubit.dart';
import 'package:fitness/core/data/models/weight.dart';
import 'package:fitness/core/data/repositories/weights_repostory.dart';
import 'package:fitness/core/di/injector.dart';
import 'package:fitness/utils/validators.dart';
import 'package:fitness/views/common_widgets/common_snackbar.dart';
import 'package:fitness/views/common_widgets/primary_button.dart';
import 'package:fitness/views/common_widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBottomSheet extends StatefulWidget {
  final Weight? weight;
  const AddBottomSheet({Key? key, this.weight}) : super(key: key);

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  String? _weight;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditWeightCubit(inject.get<WeightsRepository>()),
      child: BlocConsumer<AddEditWeightCubit, AddEditWeightState>(
        listener: (context, state) {
          if (state is AddEditWeightSuccess) {
            inject.get<CommonSnackbar>().show(context, 'Success');
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.weight != null ? 'Edit' : 'Add'} weight",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PrimaryTextField(
                      initialValue: '${widget.weight?.weight ?? ''}',
                      label: 'Weight',
                      onSaved: (String? val) {
                        _weight = val;
                      },
                      validator: validateNotEmpty,
                      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PrimaryButton(
                      loading: state is AddEditWeightLoading,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();

                          final weight = widget.weight == null
                              ? Weight(weight: int.parse(_weight ?? '0'))
                              : widget.weight!.copyWith(
                                  weight: int.parse(_weight ?? '0'),
                                );

                          context.read<AddEditWeightCubit>().addEditWeight(
                                weight,
                                isEdit: widget.weight != null,
                              );
                        }
                      },
                      text: widget.weight != null ? 'UPDATE' : 'SAVE',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (widget.weight != null)
                      BlocProvider(
                        create: (context) =>
                            DeleteWeightCubit(inject.get<WeightsRepository>()),
                        child:
                            BlocConsumer<DeleteWeightCubit, DeleteWeightState>(
                          listener: (context, state) {
                            if (state is DeleteWeightSuccess) {
                              inject.get<CommonSnackbar>().show(context,
                                  'Successfully deleted ${state.weight.weight} KG entry');
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            return TextButton.icon(
                                onPressed: () {
                                  if (widget.weight == null ||
                                      state is DeleteWeightLoading) return;
                                  context
                                      .read<DeleteWeightCubit>()
                                      .deleteWeight(widget.weight!);
                                },
                                icon: state is DeleteWeightLoading
                                    ? const CircularProgressIndicator()
                                    : const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                label: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ));
                          },
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
