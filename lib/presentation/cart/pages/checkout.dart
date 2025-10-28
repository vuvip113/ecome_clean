import 'package:ecome_clean/common/bloc/button/button_state_cubit.dart';
import 'package:ecome_clean/common/helper/cart/cart.dart';
import 'package:ecome_clean/common/helper/navigator/app_navigator.dart';
import 'package:ecome_clean/common/widgets/button/basic_reactive_button.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/entities/order_registration.dart';
import 'package:ecome_clean/domain/order/usecase/order_registration_usecase.dart';
import 'package:ecome_clean/presentation/cart/pages/order_placed.dart';
import 'package:ecome_clean/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/bloc/button/button_state.dart';
import '../../../common/widgets/appbar/app_bar.dart';

class CheckOutPage extends StatelessWidget {
  final List<OrderEntity> products;
  CheckOutPage({required this.products, super.key});

  final TextEditingController _addressCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(title: Text('Checkout')),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              AppNavigator.pushAndRemove(context, const OrderPlacedPage());
            }
            if (state is ButtonFailureState) {
              var snackbar = SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Builder(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _addressField(context),
                    BasicReactiveButton(
                      content: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${CartHelper.calculateCartSubtotal(products)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Text(
                              'Place Order',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        context.read<ButtonStateCubit>().executeUsecase(
                          OrderRegistrationUsecase(sl()),
                          OrderRegistration(
                            products: products,
                            createdDate: DateTime.now(),
                            itemCount: products.length,
                            totalAmount: CartHelper.calculateCartSubtotal(
                              products,
                            ),
                            shippingAddress: _addressCon.text,
                            orderId: '',
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _addressField(BuildContext context) {
    return TextField(
      controller: _addressCon,
      minLines: 2,
      maxLines: 4,
      decoration: const InputDecoration(hintText: 'Shipping Address'),
    );
  }
}
