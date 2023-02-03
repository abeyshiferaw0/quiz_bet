import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_category_page/category_page_bloc.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_presentation/common/app_error_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/layer_presentation/screen_all_categories/widgets/item_category.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({Key? key}) : super(key: key);

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    context.read<CategoryPageBloc>().add(GetAllCategoryEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: AppSizes.mp_v_1,
            ),

            ///BUILD APP BAR
            buildAppBar(),

            SizedBox(
              height: AppSizes.mp_v_2,
            ),

            ///BUILD BLOC BUILDER
            Expanded(
              child: BlocBuilder<CategoryPageBloc, CategoryPageState>(
                builder: (context, state) {

                  if (state is CategoryPageLoading) {
                    return const AppLoadingWidget();
                  }

                  if (state is CategoryPageLoadingError) {
                    return AppErrorWidget(
                      onTryAgain: () {
                        context.read<CategoryPageBloc>().add(GetAllCategoryEvent());
                      },
                    );
                  }

                  if (state is CategoryPageLoaded) {
                    return buildLoadedUi(context, state.categoryList);
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildLoadedUi(BuildContext context, List<Category> categoryList) {
    return Column(
      children: [
        ///BUILD SEARCH BAR
        buildSearchBar(),

        SizedBox(
          height: AppSizes.mp_v_1 / 2,
        ),

        ///BUILD CATEGORIES LIST
        buildCategoriesList(context, categoryList),
      ],
    );
  }

  Expanded buildCategoriesList(
      BuildContext context, List<Category> categoryList) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.mp_w_2,
        mainAxisSpacing: AppSizes.mp_v_1,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.mp_w_3,
          vertical: AppSizes.mp_v_1 / 2,
        ),
        children: List.generate(
          categoryList.length,
          (index) {
            return ItemCategory(
              category: categoryList.elementAt(index),
            );
          },
        ),
      ),
    );
  }

  buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.mp_v_1,
        horizontal: AppSizes.mp_w_4,
      ),
      margin: EdgeInsets.only(
        left: AppSizes.mp_w_4,
        right: AppSizes.mp_w_4,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(0, 0),
            blurRadius: 2.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BouncingButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              color: AppColors.gold,
              size: AppSizes.icon_size_6,
            ),
          ),
          Text(
            "Categories",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Row(
            children: [
              Text(
                "150 ETB",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.gold,
                      fontSize: AppSizes.font_10,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                width: AppSizes.mp_w_2,
              ),
              BouncingButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouterPaths.profilePage,
                  );
                },
                child: CircleAvatar(
                  radius: AppSizes.icon_size_6 * 0.9,
                  backgroundColor: AppColors.darkGold,
                  child: CircleAvatar(
                    radius: AppSizes.icon_size_6 * 0.83,
                    backgroundColor: AppColors.lightWhite,
                    backgroundImage: const NetworkImage(
                      "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildSearchBar() {
    return Container(
      margin: EdgeInsets.only(
        left: AppSizes.mp_w_3,
        right: AppSizes.mp_w_3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
        color: AppColors.lightWhite,
      ),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_4,
            vertical: AppSizes.mp_v_4 * 0.6,
          ),
          hintText: "Search for groups",
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.darkGrey,
                fontSize: AppSizes.font_12,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.radius_6,
            ),
            borderSide: BorderSide.none,
          ),
          fillColor: AppColors.lightWhite,
          suffixIcon: Icon(
            FontAwesomeIcons.lightMagnifyingGlass,
            size: AppSizes.icon_size_6 * 0.8,
            color: AppColors.darkGrey,
          ),
        ),
      ),
    );
  }
}
