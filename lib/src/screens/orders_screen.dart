import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rocket_help/src/components/filter_button.dart';
import 'package:rocket_help/src/components/loader.dart';
import 'package:rocket_help/src/components/order_card.dart';
import 'package:rocket_help/src/components/primary_button.dart';
import 'package:rocket_help/src/core/constants/colors.dart';
import 'package:rocket_help/src/model/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  ValueNotifier<FilterType> filterSelected = ValueNotifier(FilterType.open);
  ValueNotifier<String> chanalOrdersPath = ValueNotifier('');
  Stream<List<Order>>? ordersStrem;

  Future<void> haddleSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> getOrders() async {
    if (chanalOrdersPath.value.isEmpty) return;
    setState(
      () => ordersStrem = FirebaseFirestore.instance
          .collection(chanalOrdersPath.value)
          .where('status', isEqualTo: filterSelected.value.name)
          .snapshots()
          .map(
        (docsSnapshots) {
          return docsSnapshots.docs.map<Order>(
            (doc) {
              return Order.fromMap({
                'id': doc.id,
                ...doc.data(),
              });
            },
          ).toList();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    chanalOrdersPath.addListener(getOrders);
    filterSelected.addListener(getOrders);
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    chanalOrdersPath.value =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      backgroundColor: AppColors.stone[700],
      appBar: AppBar(
        title: SvgPicture.asset('assets/svg/logo_secondary.svg'),
        backgroundColor: AppColors.stone[600],
        elevation: 0,
      ),
      body: StreamBuilder<List<Order>>(
        stream: ordersStrem,
        builder: (context, snapshot) {
          int ordersCount = snapshot.data?.length ?? 0;
          List<Order> orders = snapshot.hasData ? snapshot.data! : [];
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Solicitações',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.stone[100],
                        fontWeight: FontWeight.w700,
                        height: 1.6,
                      ),
                    ),
                    Text(
                      '$ordersCount',
                      style: TextStyle(
                        color: AppColors.stone[300],
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilterButoon(
                        onPressed: () => setState(
                            () => filterSelected.value = FilterType.open),
                        text: 'Em andamento',
                        filterType: FilterType.open,
                        isActive: filterSelected.value == FilterType.open,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilterButoon(
                        onPressed: () => setState(
                            () => filterSelected.value = FilterType.closed),
                        text: 'Finalizadas',
                        filterType: FilterType.closed,
                        isActive: filterSelected.value == FilterType.closed,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    children: [
                      if (snapshot.connectionState == ConnectionState.waiting)
                        Loader(
                            key: const Key('order.loader'),
                            weigth: 20,
                            color: AppColors.stone[300]),
                      if (snapshot.connectionState == ConnectionState.active &&
                          orders.isEmpty)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(PhosphorIcons.chat_teardrop_text,
                                color: AppColors.stone[300], size: 32),
                            const SizedBox(height: 6),
                            Text(
                              filterSelected.value == FilterType.open
                                  ? 'Pare que você ainda não possui\n solicitações em andamento'
                                  : 'Pare que você ainda não tem\n solicitações encerradas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.stone[300],
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      if (snapshot.connectionState == ConnectionState.active &&
                          orders.isNotEmpty)
                        ...snapshot.data!.map<Widget>(
                          (order) {
                            return Padding(
                              key: Key(order.id!),
                              padding: const EdgeInsets.all(8.0),
                              child: OrderCard(
                                order: order,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/datalhes',
                                  arguments:
                                      '${chanalOrdersPath.value}/${order.id}',
                                ),
                              ),
                            );
                          },
                        ).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: 'Nova Solicitação',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register',
                        arguments: chanalOrdersPath.value);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    filterSelected.removeListener(getOrders);
    filterSelected.dispose();
    super.dispose();
  }
}
