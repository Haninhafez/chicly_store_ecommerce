import 'package:chicly_store/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class WishlistIcon extends StatefulWidget {
  const WishlistIcon({super.key, required this.id});
  final int id;

  @override
  State<WishlistIcon> createState() => _WishlistIconState();
}

class _WishlistIconState extends State<WishlistIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<WishListCubit, WishlistState>(
        listener: (context, state) {
          final wishListCubit = context.read<WishListCubit>();
          bool isFavorite = wishListCubit.isInWishList(widget.id);
          if (isFavorite) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
        builder: (context, state) {
          final wishListCubit = context.read<WishListCubit>();
          bool isFavorite = wishListCubit.isInWishList(widget.id);
          return GestureDetector(
            onTap: () {
              context.read<WishListCubit>().toggleProduct(widget.id);
            },
            child: Lottie.asset(
              "assets/animation/Like.json",
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.15,
              fit: BoxFit.contain,
              controller: _controller,
              repeat: false,
              onLoaded: (composition) {
                _controller.duration = composition.duration ;

                if (isFavorite) {
                  _controller.value = 1.0;
                } else {
                  _controller.value = 0.0;
                }
              },
            ),
          );
        },
      ),
    );
  }
}
