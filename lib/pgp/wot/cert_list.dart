import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/pgp/cert/cert_card.dart';
import 'package:kata/pgp/cert/cert_refresh_banner.dart';
import 'package:kata/pgp/cert/upload_confirm_dialog.dart';
import 'package:kata/pgp/identity_service.dart';
import 'package:kata/pgp/roots_provider.dart';
import 'package:kata/pgp/wot/cert_list_args.dart';
import 'package:kata/pgp/wot/graph_controller.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/db/connection.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:kata/src/rust/api/pgp/wot/network.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class _CertTrust {
  final PgpCertWithIds cert;
  final BigInt trust;
  final GraphController? graphController;
  const _CertTrust({
    required this.cert,
    required this.trust,
    this.graphController,
  });
}

class _CertListState extends State<CertList> {
  List<_CertTrust> certs = [];
  Watcher? watcher;
  _CertTrust? currentUpdate;
  ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>? banner;
  TextEditingController searchController = TextEditingController();
  final certRefreshController = CertRefreshController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    watcher?.dispose();
    watcher = null;
  }

  Future<List<_CertTrust>> addAllCerts(List<PgpCertWithIds> c) async {
    List<_CertTrust> n = [];
    final ActiveCert activeCert = context.read();
    final active = activeCert.cert;
    for (final cert in c) {
      try {
        final IdentityService service = context.read();
        if (active != null) {
          final graphController = await service.authenticate(
            roots: [active.cert.fingerprint.name()],
            fingerprint: cert.cert.fingerprint.name(),
            trust: 1,
          );

          final res = _CertTrust(
            cert: cert,
            trust: graphController.graph.trust,
            graphController: graphController,
          );

          n.add(res);
        } else {
          final res = _CertTrust(cert: cert, trust: BigInt.from(0));
          n.add(res);
        }
      } catch (e) {
        // Trust defaults to zero
      }
    }

    return n;
  }

  Future<void> refreshCertsFromNetwork() async {
    final IdentityService pgp = context.read();
    final sm = ScaffoldMessenger.of(context);

    if (this.banner != null) {
      return;
    }

    final banner = MaterialBanner(
      content: CertRefreshBanner(controller: certRefreshController),
      actions: [
        TextButton(
          onPressed: () {
            sm.clearMaterialBanners();
            this.banner = null;
          },
          child: const Text('Dismiss'),
        ),
      ],
    );
    final bannnerOut = sm.showMaterialBanner(banner);

    this.banner = bannnerOut;

    try {
      for (final key in certs) {
        certRefreshController.onUpdate(key.cert.ids.firstOrNull ?? "");
        await pgp.fillFromKeyserver(key.cert.cert.fingerprint.name());
        if (key.cert.cert.online) {
          await pgp.uploadToKeyserver(key.cert);
        }
      }
    } catch (e) {
      sm.showSnackBar(
        SnackBar(content: Text('Failed to update keyserver: $e')),
      );
    }

    this.banner = null;
    currentUpdate = null;
    sm.clearMaterialBanners();

    sm.showSnackBar(
      SnackBar(content: const Text('Updated certs from keyserver')),
    );
  }

  Future<void> updateCertsFromDb(StoreNetwork network) async {
    final PgpApp pgp = context.read();
    final Logger logger = context.read();
    List<_CertTrust> n = [];
    final searchText = searchController.text;
    final shouldSearch = searchText.trim().isNotEmpty;
    try {
      if (widget.args.fingerprint != null) {
        final c = await pgp.getKeyFromFingerprint(
          fingerprint: widget.args.fingerprint!,
        );
        n.addAll(await addAllCerts([c]));
      } else if (widget.args.owned) {
        final c = await pgp.allOwnedCerts();
        n.addAll(await addAllCerts(c));
      } else {
        if (widget.args.grep != null && !shouldSearch) {
          final c = await pgp
              .iterCertsSearchKeyid(pattern: widget.args.grep!)
              .toList();

          n.addAll(await addAllCerts(c));
        }

        if (widget.args.searchUserId != null && !shouldSearch) {
          final c = await pgp
              .iterCertsSearch(pattern: widget.args.searchUserId!)
              .toList();

          n.addAll(await addAllCerts(c));
        }

        if (widget.args.empty() && !shouldSearch) {
          final c = await pgp.iterCerts().toList();
          n.addAll(await addAllCerts(c));
        }

        if (shouldSearch) {
          final c = await pgp.iterCertsSearch(pattern: searchText).toList();
          n.addAll(await addAllCerts(c));
        }
      }
    } catch (e) {
      logger.e("exception in cert list: $e");
      certs.clear();
    }

    logger.d("update cert list ${certs.length}");
    setState(() {
      certs = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PgpApp pgp = context.read();
    final Logger logger = context.read();
    final ActiveCert activeCert = context.read();
    final cert = activeCert.cert;
    final shouldSearch = !widget.args.owned;

    return RootsProvider(
      builder: (ctx, roots) {
        logger.d("using roots $roots");

        if (roots != null) {
          final network = pgp.networkFromFingerprints(
            fingerprints: roots.map((v) => v.name()).toList(),
          );

          if (watcher == null) {
            final w = pgp.getWatcher();
            w.watch(
              table: "certs",
              cb: (db) async {
                await updateCertsFromDb(network);
              },
            );
            watcher = w;
          }
          return Column(
            children: [
              if (shouldSearch)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hint: const Text('Search'),
                        ),
                        onEditingComplete: () async =>
                            await updateCertsFromDb(network),
                      ),
                    ),
                    IconButton(
                      onPressed: () async => await refreshCertsFromNetwork(),
                      icon: Icon(Icons.refresh),
                    ),
                    IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (ctx) => UploadConfirmDialog(
                          certs: certs.map((v) => v.cert).toList(),
                        ),
                      ),
                      icon: Icon(Icons.upload),
                    ),
                  ],
                ),
              Expanded(
                child: ListView(
                  children: certs
                      .map(
                        (v) => CertCard(
                          pgpKey: v.cert,
                          trust: v.trust,
                          graphController: v.graphController,
                          active:
                              v.cert.cert.fingerprint == cert?.cert.fingerprint,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class CertList extends StatefulWidget {
  final CertListArgs args;
  const CertList({super.key, this.args = const CertListArgs()});

  @override
  State<StatefulWidget> createState() => _CertListState();
}
