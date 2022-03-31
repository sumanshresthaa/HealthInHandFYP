import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../../../Models/get_details_of_TBMedication.dart';
import '../../../../Textstyle/constraints.dart';
import '../../../../ViewModel/changenotifier.dart';
import '../../../Extracted Widgets/content_list_index.dart';
import '../../../Extracted Widgets/warning.dart';
import '../../../ScrollableAppBar/backappbar.dart';
import 'MedicationPageLayout.dart';

class MedicationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: ScrollAppBarNoLeftArrow(
        MedicationList(),
        context.watch<DataProvider>().data ? 'Medication' : 'औषधि',
      ),
    );
  }
}

class MedicationList extends StatefulWidget {
  @override
  _MedicationListState createState() => _MedicationListState();
}

class _MedicationListState extends State<MedicationList> {
  Future<TbMedication>? _tbMedicationID;

  Future<TbMedication> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("tb_medication");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return TbMedication.fromJson(jsonMap);
  }

  @override
  void initState() {
    super.initState();
    _tbMedicationID = getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Warning(context.watch<DataProvider>().data ? 'Medication' : 'सावधान',
              Colors.red),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16.0, bottom: 8),
            child: Text(
              context.watch<DataProvider>().data
                  ? 'Medicines for TB'
                  : 'क्षयरोग को औषधिहरु',
              style: kStyleTime.copyWith(fontSize: 16),
            ),
          ),
          FutureBuilder<TbMedication>(
              future: _tbMedicationID,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Column(
                      children: [
                        Text('Loading'),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  );
                } else
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.data.tbMedication.length,
                      itemBuilder: (BuildContext context, int index) {
                        var textContent =
                            snapshot.data!.data.tbMedication[index];
                        return ContentListIndex(
                            context.watch<DataProvider>().data
                                ? textContent.name
                                : textContent.nameNe,
                            Icons.chevron_right,
                            Color(0xff55C9F5),
                            index,
                            MedicationPageLayout(LayoutContent(
                                context.watch<DataProvider>().data
                                    ? textContent.name
                                    : textContent.nameNe,
                                index)));
                      });
              })
        ],
      ),
    );
  }
}
