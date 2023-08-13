import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiring_task/constants/colors/app_colors.dart';
import 'package:hiring_task/constants/images/drawer_images.dart';
import 'package:hiring_task/constants/images/other_images.dart';
import 'package:hiring_task/controllers/home/social_media_controller.dart';
import 'package:hiring_task/utils/app_url_launcher.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/view-model/home/home_services.dart';
import 'package:hiring_task/view/screens/home/help_desk/home_help_desk_screen.dart';
import 'package:hiring_task/view/screens/log-in/gs1_member_login_screen.dart';
import 'package:hiring_task/widgets/buttons/rectangular_text_button.dart';
import 'package:hiring_task/widgets/loading/loading_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> names = [
    'Help Desk',
    'Contact Us',
    'Chat with us',
    'Social Media',
  ];

  @override
  void initState() {
    super.initState();
  }

  socialMediaBottomSheet() {
    // showDialog(
    //   context: context,
    //   builder: (context) => Dialog(
    //     child: FutureBuilder(
    //       future: SocialMediaController.getSocialMedias(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return SizedBox(
    //             height: context.height * 0.4,
    //             child: const Center(
    //               child: LoadingWidget(),
    //             ),
    //           );
    //         } else if (snapshot.hasError) {
    //           return SizedBox(
    //             height: context.height * 0.4,
    //             child: Center(
    //               child: Text(snapshot.error.toString()),
    //             ),
    //           );
    //         }
    //         return Container(
    //           decoration: const BoxDecoration(
    //             color: AppColors.backgroundColor,
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(20),
    //               topRight: Radius.circular(20),
    //             ),
    //           ),
    //           height: context.height * 0.4,
    //           child: GridView.builder(
    //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 3,
    //               childAspectRatio: 1.5,
    //               crossAxisSpacing: 20,
    //               mainAxisSpacing: 20,
    //             ),
    //             itemBuilder: (context, index) => GestureDetector(
    //               onTap: () {
    //                 AppUrlLauncher.launchUrl(
    //                   Uri.parse(
    //                     snapshot.data!.socialLinks![index].socialLink
    //                         .toString(),
    //                   ),
    //                 );
    //               },
    //               child: CircleAvatar(
    //                   backgroundColor: AppColors.greyColor,
    //                   backgroundImage: NetworkImage(
    //                     "${snapshot.data!.imagePath}/${snapshot.data!.socialLinks![index].socialIcon}",
    //                   )),
    //             ),
    //             padding: const EdgeInsets.all(20),
    //             itemCount: snapshot.data?.socialLinks?.length,
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return FutureBuilder(
            future: SocialMediaController.getSocialMedias(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: context.height * 0.4,
                  child: const Center(
                    child: LoadingWidget(),
                  ),
                );
              } else if (snapshot.hasError) {
                return SizedBox(
                  height: context.height * 0.4,
                  child: Center(
                    child: Text(snapshot.error.toString()),
                  ),
                );
              }
              return Container(
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                height: context.height * 0.4,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      AppUrlLauncher.launchUrl(
                        Uri.parse(
                          snapshot.data!.socialLinks![index].socialLink
                              .toString(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                        backgroundColor: AppColors.greyColor,
                        backgroundImage: NetworkImage(
                          "${snapshot.data!.imagePath}/${snapshot.data!.socialLinks![index].socialIcon}",
                        )),
                  ),
                  padding: const EdgeInsets.all(20),
                  itemCount: snapshot.data?.socialLinks?.length,
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: whiteColor),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.backgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Image.asset(DrawerImages.select_language),
                  title: "Select Language"
                      .text
                      .color(AppColors.primaryColor)
                      .make(),
                ),
                // ListTile(
                //   leading: Image.asset(DrawerImages.staff_login),
                //   title:
                //       "Staff Login".text.color(AppColors.primaryColor).make(),
                // ),
                ListTile(
                  onTap: () {
                    HomeServices.productContentsClick(context);
                  },
                  leading: Image.asset(DrawerImages.product_contents),
                  title: "Product Contents"
                      .text
                      .color(AppColors.primaryColor)
                      .make(),
                ),
                ListTile(
                  onTap: () {
                    HomeServices.retailInformationClick(context);
                  },
                  leading: Image.asset(DrawerImages.retail_information),
                  title: "Retail information"
                      .text
                      .color(AppColors.primaryColor)
                      .make(),
                ),
                ListTile(
                  onTap: () {
                    HomeServices.verifiedByGS1Click(context);
                  },
                  leading: Image.asset(DrawerImages.verified_by_gs1),
                  title: "Verified by GS1"
                      .text
                      .color(AppColors.primaryColor)
                      .make(),
                ),
                ListTile(
                  onTap: () {
                    HomeServices.gtinReporterClick(context);
                  },
                  leading: Image.asset(DrawerImages.gtin_reporter),
                  title:
                      "GTIN Reporter".text.color(AppColors.primaryColor).make(),
                ),
                ListTile(
                  onTap: () {},
                  leading: Image.asset(DrawerImages.product_tracking),
                  title: "Product Tracking"
                      .text
                      .color(AppColors.primaryColor)
                      .make(),
                ),
                ListTile(
                  onTap: () {
                    HomeServices.regulatoryAffairsClick(context);
                  },
                  leading: Image.asset(DrawerImages.regulatory_affairs),
                  title: "Government / Regulatory Affairs"
                      .text
                      .color(AppColors.primaryColor)
                      .make(),
                ),
                ListTile(
                  leading: Image.asset(DrawerImages.help_desk),
                  title: "Help Desk".text.color(AppColors.primaryColor).make(),
                ),
                ListTile(
                  leading: Image.asset(DrawerImages.contact_us),
                  title: "Contact Us".text.color(AppColors.primaryColor).make(),
                ),
                ListTile(
                  leading: Image.asset(DrawerImages.chat_with_us),
                  title:
                      "Chat with us".text.color(AppColors.primaryColor).make(),
                ),
                ListTile(
                  leading: Image.asset(DrawerImages.social_media),
                  title:
                      "Social Media".text.color(AppColors.primaryColor).make(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(OtherImages.trans_logo)),
              const SizedBox(height: 30),
              "One Barcode, Infinite Possibility"
                  .text
                  .color(AppColors.primaryColor)
                  .bold
                  .size(20)
                  .make()
                  .centered(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RectangularButton(
                    caption: "Get a Barcode",
                    image: OtherImages.get_a_barcode,
                    onPressed: () => HomeServices.getBarCode(context),
                  ),
                  RectangularButton(
                    caption: "Member Login",
                    image: OtherImages.get_member_login,
                    onPressed: () => Navigator.of(context).pushNamed(
                      Gs1MemberLoginScreen.routeName,
                    ),
                  ),
                ],
              ).box.margin(const EdgeInsets.symmetric(horizontal: 10)).make(),
              "Explore how new 2D barcodes combined with the power of GS1 Digital Link, unlock new possibilities for consumers, brands, retailers, government, regulators and more."
                  .text
                  .semiBold
                  .color(AppColors.primaryColor)
                  .make()
                  .centered()
                  .p20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RectangularButton(
                    caption: "Product Contents",
                    image: OtherImages.product_contents,
                    onPressed: () => HomeServices.productContentsClick(context),
                  ),
                  RectangularButton(
                    caption: "Retail Information",
                    image: OtherImages.retail_information,
                    onPressed: () =>
                        HomeServices.regulatoryAffairsClick(context),
                  ),
                ],
              ).box.margin(const EdgeInsets.symmetric(horizontal: 10)).make(),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RectangularButton(
                    caption: "Verified by GS1",
                    image: OtherImages.verified_by_gs1,
                    onPressed: () => HomeServices.verifiedByGS1Click(context),
                  ),
                  RectangularButton(
                    caption: "GTIN Reporter",
                    image: OtherImages.gtin_reporter,
                    onPressed: () => HomeServices.gtinReporterClick(context),
                  ),
                ],
              ).box.margin(const EdgeInsets.symmetric(horizontal: 10)).make(),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RectangularButton(
                    caption: "Government/regulatory affairs",
                    image: OtherImages.regulatory_affairs,
                    onPressed: () =>
                        HomeServices.regulatoryAffairsClick(context),
                  ),
                  RectangularButton(
                    caption: "Product Tracking",
                    image: OtherImages.product_tracking,
                    onPressed: () {},
                  ),
                ],
              ).box.margin(const EdgeInsets.symmetric(horizontal: 10)).make(),
              "Support".text.color(AppColors.primaryColor).bold.make().p20(),
              SizedBox(
                height: context.height * 0.08,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return RectangularTextButton(
                      onPressed: () {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeHelpDeskScreen(),
                            ),
                          );
                        } else if (index == 1) {
                          AppUrlLauncher.call();
                        } else if (index == 2) {
                          AppUrlLauncher.whatsapp();
                        } else if (index == 3) {
                          // show modal bottm sheet and display social media icons like facebook, twitter, instagram, youtube and linked in

                          socialMediaBottomSheet();
                        }
                      },
                      caption: names[index],
                    );
                  },
                  itemCount: names.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}

class RectangularButton extends StatelessWidget {
  final String image;
  final String caption;
  final VoidCallback onPressed;
  const RectangularButton({
    super.key,
    required this.image,
    required this.caption,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: context.screenHeight * 0.1,
        width: context.screenWidth * 0.45,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Row(
          children: [
            Image.asset(image),
            10.widthBox,
            Expanded(
              child: AutoSizeText(
                caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
