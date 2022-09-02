import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rocket_help/src/components/canal_card.dart';
import 'package:rocket_help/src/core/constants/colors.dart';
import 'package:rocket_help/src/model/canal.dart';

class CanaisScreen extends StatefulWidget {
  const CanaisScreen({Key? key}) : super(key: key);

  @override
  State<CanaisScreen> createState() => _CanaisScreenState();
}

class _CanaisScreenState extends State<CanaisScreen> {
  List<Canal> canais = [];

  Future<void> haddleSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> getCanais() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;
    final db = FirebaseFirestore.instance;

    final userPartiness = await db
        .collection('user-canal')
        .where('uid', isEqualTo: currentUser.uid)
        .get();

    final chanals = <Canal>[];

    userPartiness.docs.forEach(
      (partDoc) async {
        String cid = partDoc.data()['cid'] as String;
        final canalpDoc = await db.collection('canais').doc(cid).get();
        chanals.add(Canal.fromMap({
          'id': canalpDoc.id,
          ...?canalpDoc.data(),
        }));
        setState(() => canais = chanals);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getCanais();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.stone[700],
      appBar: AppBar(
        title: SvgPicture.asset('assets/svg/logo_secondary.svg'),
        backgroundColor: AppColors.stone[600],
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              PhosphorIcons.magnifying_glass,
              color: AppColors.stone[300],
            ),
          ),
          PopupMenuButton(
            icon: Icon(
              PhosphorIcons.dots_three_vertical_bold,
              color: AppColors.stone[300],
            ),
            color: AppColors.stone[500],
            elevation: 10,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
            itemBuilder: (_) => [
              PopupMenuItem(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.users_three,
                      color: AppColors.stone[200],
                      size: 18,
                    ),
                    Icon(
                      PhosphorIcons.plus,
                      color: AppColors.stone[200],
                      size: 10,
                    ),
                    const SizedBox(width: 8),
                    Text('Novo grupo',
                        style: TextStyle(color: AppColors.stone[200])),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: haddleSignOut,
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.sign_out,
                      color: AppColors.stone[200],
                    ),
                    const SizedBox(width: 8),
                    Text('Sair', style: TextStyle(color: AppColors.stone[200])),
                  ],
                ),
              ),
            ],
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Canais',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.stone[100],
                fontWeight: FontWeight.w700,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: AppColors.stone[700],
                color: AppColors.stone[100],
                strokeWidth: 1,
                onRefresh: getCanais,
                child: ListView(
                  children: [
                    ...canais
                        .map(
                          (canal) => CanalCard(
                            onTap: () {
                              Navigator.of(context).pushNamed('/orders',
                                  arguments: 'canais/${canal.id}/orders');
                            },
                            canal: canal,
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
