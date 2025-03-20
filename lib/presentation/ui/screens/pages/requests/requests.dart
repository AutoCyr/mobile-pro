import 'package:autocyr_pro/domain/models/features/intervention.dart';
import 'package:autocyr_pro/presentation/notifier/partner_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/buttons/progress_button.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/helpers/state.dart';
import 'package:autocyr_pro/presentation/ui/organisms/loaders/loader.dart';
import 'package:autocyr_pro/presentation/ui/screens/helpers/request_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {

  int view = 0;
  bool _search = false;

  List<Intervention> requests = [];
  List<Intervention> filteredRequests = [];

  Map<String, dynamic> getParams(int view) {
    Map<String, dynamic> params = {
      "page": view,
      "limit": 50
    };
    return params;
  }

  retrieveRequests(int view, bool more) async {
    final partner = Provider.of<PartnerNotifier>(context, listen: false);

    Map<String, dynamic> params = getParams(view);
    await partner.retrieveRequests(context: context, params: params, more: more);
    filteredRequests = requests = partner.requests;
  }

  void filterList(String searchQuery) {
    List<Intervention> filtered = [];
    for (var value in requests) {
      if(value.demande.reference.toLowerCase().contains(searchQuery.toLowerCase()) || value.demande.article.name.toLowerCase().contains(searchQuery.toLowerCase()) || value.demande.typeEngin.libelle.toLowerCase().contains(searchQuery.toLowerCase())) {
        filtered.add(value);
      }
    }
    setState(() {
      filteredRequests = filtered;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      view++;
      retrieveRequests(view, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GlobalThemeData.lightColorScheme.primary),
        backgroundColor: GlobalThemeData.lightColorScheme.onPrimary,
        title: _search == false ?
          Label14(text: "Liste des demandes", color: GlobalThemeData.lightColorScheme.primaryContainer, weight: FontWeight.bold, maxLines: 1).animate().fadeIn()
            :
          SizedBox(
              height: 45,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1),
                    focusColor: GlobalThemeData.lightColorScheme.primary,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: GlobalThemeData.lightColorScheme.primary,
                            width: 2
                        )
                    ),
                    labelText: "Rechercher",
                    labelStyle: TextStyle(
                        color: GlobalThemeData.lightColorScheme.primary,
                        fontSize: 13
                    )
                ),
                style: const TextStyle(
                    fontSize: 13
                ),
                autofocus: true,
                onChanged: (value) => filterList(value),
                cursorColor: GlobalThemeData.lightColorScheme.primaryContainer,
              ),
          ).animate().fadeIn(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _search = !_search;
                filterList("");
              });
            },
            icon: _search ? const Icon(Icons.clear) : const Icon(Icons.search_sharp),
          ).animate().fadeIn(),
        ],
      ),
      body: Consumer<PartnerNotifier>(
          builder: (context, partner, child) {

            if(partner.loading) {
              return Loader(context: context, size: size, message: "Chargement des demandes...").animate().fadeIn();
            }

            if(partner.errorRequests.isNotEmpty && !partner.loading) {
              return StateScreen(icon: Icons.running_with_errors_sharp, message: partner.errorCommandes, isError: true, function: () => retrieveRequests(view, false));
            }

            if(partner.errorRequests.isEmpty && filteredRequests.isEmpty && !partner.loading) {
              return const StateScreen(icon: Icons.inbox_sharp, message: "Aucune demande trouvée.", isError: false,);
            }

            return RefreshLoadmore(
                onRefresh: () async {
                  setState(() {
                    view = 1;
                  });
                  retrieveRequests(view, false);
                },
                onLoadmore: () async {
                  setState(() {
                    view++;
                  });
                  retrieveRequests(view, true);
                },
                noMoreWidget: Center(
                  child: Label10(text: "Plus de demandes trouvées", color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.bold, maxLines: 2),
                ).animate().fadeIn(),
                loadingWidget: ProgressButton(
                    widthSize: size.width * 0.2,
                    context: context,
                    bgColor: GlobalThemeData.lightColorScheme.onPrimary,
                    shimmerColor: GlobalThemeData.lightColorScheme.primary
                ).animate().fadeIn(),
                isLastPage: partner.requestMeta.currentPage < partner.requestMeta.lastPage ? false : true,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Intervention request = filteredRequests[index];
                    return RequestWidget(demande: request.demande).animate().fadeIn();
                  },
                  itemCount: filteredRequests.length
                )
            );
          }
      ),
    );
  }
}
