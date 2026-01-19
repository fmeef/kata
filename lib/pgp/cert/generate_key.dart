import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/pgp/cert/cert_card.dart';
import 'package:kata/pgp/identity_service.dart';
import 'package:kata/src/rust/api/pgp.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

extension IsEmail on String {
  bool isEmail() {
    return RegExp(
      r'''^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$''',
    ).hasMatch(this);
  }
}

class _GenerateKeyState extends State<GenerateKey> {
  final GlobalKey<FormState> _formState = GlobalKey();
  PgpCertWithIds? currentCert;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  bool _online = false;

  @override
  Widget build(BuildContext context) {
    final sm = ScaffoldMessenger.of(context);
    return Column(
      children: [
        if (currentCert != null)
          CertCard(pgpKey: currentCert!, trust: BigInt.from(100)),
        Form(
          key: _formState,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Email"),
                validator: (v) {
                  if (v?.isEmpty ?? true) {
                    return 'Empty emails are not allowed';
                  }

                  if (!(v?.isEmail() ?? false)) {
                    return 'The email field must be a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(hintText: 'Display Name'),
              ),

              TextFormField(
                controller: _commentController,
                decoration: InputDecoration(hintText: 'Comment'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Upload this card to servers'),

                  Checkbox(
                    value: _online,
                    onChanged: (checked) => setState(() {
                      _online = checked ?? false;
                    }),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (currentCert != null)
                      ElevatedButton(
                        onPressed: () => context.pop(),
                        child: const Text('Save'),
                      ),
                    TextButton(
                      onPressed: () async {
                        if (context.mounted) {
                          final IdentityService app = context.read();
                          final ActiveCert activeCert = context.read();
                          if (_formState.currentState!.validate()) {
                            final current = currentCert;
                            try {
                              if (current != null) {
                                await app.pgpApp.deletePrivateKey(
                                  fingerprint: UserHandle.fromHex(
                                    hex: current.cert.fingerprint,
                                  ),
                                );
                              }
                              final cert = await app.pgpApp
                                  .generateKey(email: _emailController.text)
                                  .name(name: _nameController.text)
                                  .comment(comment: _commentController.text)
                                  .online(online: _online)
                                  .generate();
                              if (_online) {
                                await app.uploadToKeyserver(cert);
                              }

                              if (activeCert.cert == null) {
                                await app.pgpApp.updateRole(
                                  fingerprint: UserHandle.fromHex(
                                    hex: cert.cert.fingerprint,
                                  ),
                                  role: "primary",
                                );
                              }

                              setState(() {
                                currentCert = cert;
                              });
                            } on Exception catch (e) {
                              sm.showSnackBar(
                                SnackBar(
                                  content: Text('Failed to generate card: $e'),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: currentCert == null
                          ? const Text("Generate")
                          : const Text('Regenerate'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GenerateKey extends StatefulWidget {
  const GenerateKey({super.key});

  @override
  State<GenerateKey> createState() => _GenerateKeyState();
}
