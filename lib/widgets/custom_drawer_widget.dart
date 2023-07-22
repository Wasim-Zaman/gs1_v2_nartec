import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:hiring_task/models/login-models/dashboard_model.dart';
import 'package:hiring_task/view-model/login/after-login/subscription_list_services.dart';
import 'package:hiring_task/view/screens/home/home_screen.dart';
import 'package:hiring_task/view/screens/log-in/after-login/create_ticket_screen.dart';
import 'package:hiring_task/view/screens/log-in/after-login/dashboard/dashboard.dart';
import 'package:hiring_task/view/screens/log-in/after-login/help_desk_screen.dart';
import 'package:hiring_task/view/screens/log-in/after-login/member_gln_screen.dart';
import 'package:hiring_task/view/screens/log-in/after-login/member_profile_screen.dart';
import 'package:hiring_task/view/screens/log-in/after-login/products.dart';
import 'package:hiring_task/view/screens/log-in/after-login/sscc_screen.dart';
import 'package:hiring_task/view/screens/log-in/after-login/subscribe_products_screen.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    super.key,
    this.userId,
    this.response,
  });
  final int? userId;
  final DashboardModel? response;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),
          ListTile(
            leading: Image.asset('assets/images/dashboard_icon.png'),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Dashboard.routeName,
                arguments: {
                  'response': response,
                  'userId': response?.memberData?.user?.id,
                },
              );
            },
          ),
          const Divider(thickness: 2),
          ListTile(
            leading: Image.asset('assets/images/membership_icon.png'),
            title: const Text("Membership Details"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                MemberProfileScreen.routeName,
                arguments: {
                  'response': response,
                  'userId': response?.memberData?.user?.id,
                },
              );
            },
          ),
          const Divider(thickness: 2),
          FutureBuilder(
              future: SubscriptionListServices.getSubscriptionList(userId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ExpansionTile(
                    title: const Text('Manage Products'),
                    leading: Image.asset('assets/images/products_icon.png'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: SizedBox.shrink(),
                  );
                }
                if (snapshot.hasError) {
                  return const SizedBox.shrink();
                }
                final subscriptionList = snapshot.data;
                return ExpansionTile(
                  title: const Text('Manage Products'),
                  leading: Image.asset('assets/images/products_icon.png'),
                  children: List.generate(
                      subscriptionList?.products?.length ?? 0,
                      (index) => ListTile(
                            title: subscriptionList?.products?[index]
                                        .toString()
                                        .startsWith('Category') ==
                                    true
                                ? const Text("GTIN")
                                : Text(
                                    '${subscriptionList?.products?[index]}',
                                  ),
                            onTap: () {
                              if (subscriptionList?.products?[index]
                                      .toString()
                                      .startsWith('Category') ==
                                  true) {
                                // navigate to gtin
                                Navigator.of(context).pushReplacementNamed(
                                    Products.routeName,
                                    arguments: {
                                      'response': response,
                                      'userId': response?.memberData?.user?.id,
                                    });
                              }
                              if (subscriptionList?.products?[index]
                                      .toLowerCase() ==
                                  'gln') {
                                Navigator.of(context).pushReplacementNamed(
                                    MemberGLNScreen.routeName,
                                    arguments: {
                                      'response': response,
                                      'userId': response?.memberData?.user?.id,
                                    });
                              } else if (subscriptionList?.products?[index]
                                      .toLowerCase() ==
                                  'sscc') {
                                Navigator.of(context).pushReplacementNamed(
                                    SSCCScreen.routeName,
                                    arguments: {
                                      'response': response,
                                      'userId': response?.memberData?.user?.id,
                                    });
                              } else if (subscriptionList?.products?[index]
                                      .toLowerCase() ==
                                  'udi') {
                                // UDI.....
                              } else if (subscriptionList?.products?[index]
                                      .toLowerCase() ==
                                  'gtin products') {
                                Navigator.of(context).pushReplacementNamed(
                                    Products.routeName,
                                    arguments: {
                                      'response': response,
                                      'userId': response?.memberData?.user?.id,
                                    });
                              }
                            },
                          )),
                );
              }),
          const Divider(thickness: 2),
          ListTile(
            leading: Image.asset('assets/images/help_desk_icon.png'),
            title: const Text("Help Desk"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(HelpDeskScreen.routeName, arguments: {
                'response': response,
                'userId': response?.memberData?.user?.id,
              });
            },
          ),
          const Divider(thickness: 2),
          ListTile(
            leading: Image.asset('assets/images/create_tickets_icon.png'),
            title: const Text("Create Ticket"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  CreateTicketScreen.routeName,
                  arguments: {
                    'response': response,
                    'userId': response?.memberData?.user?.id,
                  });
            },
          ),
          const Divider(thickness: 2),
          ListTile(
            leading: Image.asset('assets/images/subscribed_products_icon.png'),
            title: const Text("Subscribe Products"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  SubscribeProductsScreen.routeName,
                  arguments: {
                    'response': response,
                    'userId': response?.memberData?.user?.id,
                  });
            },
          ),
          const Divider(thickness: 2),
          ListTile(
            leading: Image.asset('assets/images/home_icon.png'),
            title: const Text("Home"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          const Divider(thickness: 2),
          ListTile(
            leading: Image.asset('assets/images/logout_icon.png'),
            title: const Text("Log Out"),
            onTap: () {
              // call this to exit app
              FlutterExitApp.exitApp();
            },
          ),
          const Divider(thickness: 2),
        ],
      ),
    );
  }
}
