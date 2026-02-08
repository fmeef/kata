import 'package:kata/pgp/wot/cert_list.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CertList(args: CertListArgs(owned: true));
  }
}
