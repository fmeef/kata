import 'package:kata/pgp/wot/cert_list.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your identities', style: theme.textTheme.bodyLarge),
        Expanded(child: CertList(args: CertListArgs(owned: true))),
      ],
    );
  }
}
