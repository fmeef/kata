import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/pgp/cert/cert_card.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:kata/src/rust/api/pgp/sign.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class _SignKeyViewState extends State<SignKeyView> {
  TrustLevel currentTrust = TrustLevel.partial();

  Widget trustRadioGroup(BuildContext context, PgpCertWithIds activeCert) {
    final PgpApp pgpApp = context.read();

    return RadioGroup(
      onChanged: (v) => setState(() {
        currentTrust = v as TrustLevel;
      }),
      groupValue: currentTrust,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CertCard(
            pgpKey: widget.target,
            signable: false,
            trust: BigInt.from(255),
          ),
          Column(
            children: [
              Text('How much do you trust ${widget.target.ids.first}'),

              ListTile(
                title: const Text('Ultimate'),
                leading: Radio<TrustLevel>(value: TrustLevel.ultimate()),
              ),
              ListTile(
                title: const Text('Fully'),
                leading: Radio<TrustLevel>(value: TrustLevel.full()),
              ),
              ListTile(
                title: const Text('Partial'),
                leading: Radio<TrustLevel>(value: TrustLevel.partial()),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await pgpApp.signWithTrustLevel(
                    signer: activeCert.cert.fingerprint,
                    signee: widget.target.cert.fingerprint,
                    level: 1,
                    trust: currentTrust,
                  );

                  if (context.mounted && context.canPop()) context.pop();
                },
                child: const Text('Sign'),
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ActiveCert activeCert = context.read();
    final cert = activeCert.cert;
    if (cert != null) {
      return trustRadioGroup(context, cert);
    } else {
      return const Text('No active cards');
    }
  }
}

class SignKeyView extends StatefulWidget {
  final PgpCertWithIds target;
  const SignKeyView({super.key, required this.target});

  @override
  State<SignKeyView> createState() => _SignKeyViewState();
}
