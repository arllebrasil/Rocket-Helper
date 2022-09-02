import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:rocket_help/src/components/input.dart';
import 'package:rocket_help/src/components/order_info.dart';
import 'package:rocket_help/src/components/primary_button.dart';
import 'package:rocket_help/src/model/order.dart';
import 'package:rocket_help/src/util/formaters.dart';
import '../core/constants/colors.dart';

class DetalhesScreen extends StatefulWidget {
  const DetalhesScreen({Key? key}) : super(key: key);

  @override
  State<DetalhesScreen> createState() => _DetalhesScreenState();
}

class _DetalhesScreenState extends State<DetalhesScreen> {
  ValueNotifier<String?> orderPath = ValueNotifier(null);
  Stream<Order>? orderStream;
  late TextEditingController solutionController;
  late GlobalKey<FormState> solutionKey;

  Future<void> getOrder() async {
    if (orderPath.value == null) return;
    String orderPathState = orderPath.value!;
    setState(
      () => orderStream =
          FirebaseFirestore.instance.doc(orderPathState).snapshots().map(
        (doc) {
          return Order.fromMap(
            {
              'id': doc.id,
              ...?doc.data(),
            },
          );
        },
      ),
    );
  }

  Future<void> handleSolution(Order order) async {
    if (orderPath.value == null) return;
    if (!solutionKey.currentState!.validate()) return;
    final db = FirebaseFirestore.instance;
    db.runTransaction<bool>((transaction) async {
      try {
        await transaction.update(db.doc(orderPath.value!), {
          ...order.toMap(),
          'solution': solutionController.text,
          'status': Status.closed.name,
          'closedAt': format(DateTime.now()),
        });
        return true;
      } catch (e) {
        return false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    orderPath.addListener(getOrder);
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    orderPath.value = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      backgroundColor: AppColors.stone[700],
      appBar: AppBar(
        backgroundColor: AppColors.stone[600],
        leading: IconButton(
          icon: Icon(
            PhosphorIcons.caret_left,
            color: AppColors.stone[100],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Solicitação',
            style: TextStyle(
                color: AppColors.stone[100],
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<Order>(
        stream: orderStream,
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.stone[500],
                  padding: const EdgeInsets.all(16),
                  child: AnimatedOpacity(
                    opacity: snapshot.hasData ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          (snapshot.data?.status == Status.open)
                              ? PhosphorIcons.hourglass
                              : PhosphorIcons.circle_wavy_check,
                          color: (snapshot.data?.status == Status.open)
                              ? AppColors.orange[700]
                              : AppColors.green[300],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Em andamento'.toUpperCase(),
                          style: TextStyle(
                            color: (snapshot.data?.status == Status.open)
                                ? AppColors.orange[700]
                                : AppColors.green[300],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 8),
                          OrderInfo(
                            headerIcon: PhosphorIcons.desktop_tower,
                            title: 'Equipamento',
                            description:
                                'Patrimônio ${snapshot.data?.patrimony}',
                          ),
                          const SizedBox(height: 8),
                          OrderInfo(
                            headerIcon: PhosphorIcons.clipboard_text,
                            title: 'Descrição',
                            description: '${snapshot.data?.description}',
                            footer: 'Registrado em ${snapshot.data?.when}',
                          ),
                          const SizedBox(height: 8),
                          if (snapshot.data?.status == Status.open) ...[
                            Builder(builder: (context) {
                              solutionKey = GlobalKey<FormState>();
                              solutionController = TextEditingController();

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Form(
                                    key: solutionKey,
                                    child: OrderInfo(
                                      headerIcon:
                                          PhosphorIcons.circle_wavy_check,
                                      title: 'Solução',
                                      child: InputText(
                                        controller: solutionController,
                                        hintText: 'Digíte a solução',
                                        minLines: 5,
                                        maxLines: null,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  PrimaryButton(
                                    text: 'Finalizar',
                                    onPressed: () {
                                      if (snapshot.hasData) {
                                        handleSolution(snapshot.data!);
                                      }
                                    },
                                  ),
                                ],
                              );
                            }),
                          ],
                          if (snapshot.data?.status == Status.closed)
                            OrderInfo(
                              headerIcon: PhosphorIcons.circle_wavy_check,
                              title: 'Solução',
                              description: '${snapshot.data?.solution}',
                              footer:
                                  'Registrado em ${snapshot.data?.closedAt}',
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    orderPath.dispose();
  }
}
