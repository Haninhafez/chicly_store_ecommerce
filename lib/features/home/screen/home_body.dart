import 'package:chicly_store/features/home/widgets/home_content.dart';
import 'package:chicly_store/features/home/screen/home_loading_screen.dart';
import 'package:chicly_store/features/product/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBodyScreen extends StatelessWidget {
  const HomeBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return HomeLoadingScreen();
         
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else if (state is ProductSuccess) {
          return HomeContent(state: state,);
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        }
      },
    );
  }
}



