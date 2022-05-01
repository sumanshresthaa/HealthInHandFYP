import 'dart:convert';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:health_in_hand/Models/view_appointment.dart';
import '../Models/get_details_of_Arthritis.dart';
import '../Models/get_details_of_HivMedication.dart';
import '../Models/get_details_of_TBMedication.dart';
import '../Models/get_details_of_covid.dart';
import '../Models/get_details_of_doctor.dart';
import '../Models/get_details_of_hiv.dart';
import '../Models/get_details_of_tb.dart';
import '../Models/hotline_numbers.dart';
import 'NetworkHelper.dart';

//This class downloads all the data from the api using api cache manager
class ApiData {
  //office 10.3.5.145
  // home192.168.254.15
  var baseUrl = 'http://192.168.254.15/cms/public';


  Future<ViewAppointment> getAppointmentDetails(String token) async {
    var jsonData = await NetworkHelper()
        .getDataWithToken('$baseUrl/api/getAppointments', token);
    print(jsonData);
    var jsonMap = jsonDecode(jsonData);
    print(jsonMap);
    var appointmentDetails = ViewAppointment.fromJson(jsonMap);
    return appointmentDetails;
  }


  //Details of HIV get api call and download
  Future<DetailsOfHiv> getDetailsOfHivDetails() async {
    var isCacheExist = await APICacheManager().isAPICacheKeyExist(
        "hiv_details"); //checking if api is already downloaded
    if (!isCacheExist) {
      //if api is not downloaded
      var jsonData = await NetworkHelper()
          .getData('http://103.109.230.18/api/getDetailsOfHIV');
      APICacheDBModel cacheDBModel =
          new APICacheDBModel(key: "hiv_details", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);
      var jsonMap = jsonDecode(jsonData);
      var detailsOfHiv =
          DetailsOfHiv.fromJson(jsonMap); //calling the model class
      print("url : hit");
      return detailsOfHiv;
    } else {
      var cacheData = await APICacheManager().getCacheData("hiv_details");
      var jsonMap = jsonDecode(cacheData.syncData);
      print("cache: hit");
      return DetailsOfHiv.fromJson(jsonMap);
    }
  }


  //Details of HIV get api call and download
  Future<DetailsOfArthritis> getDetailsOfArthritis() async {
    var isCacheExist = await APICacheManager().isAPICacheKeyExist(
        "arthritis_details"); //checking if api is already downloaded
    if (!isCacheExist) {
      //if api is not downloaded
      var jsonData = await NetworkHelper()
          .getData('$baseUrl/api/detailsOfArthritis');
      print(jsonData);
      APICacheDBModel cacheDBModel =
      new APICacheDBModel(key: "arthritis_details", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);
      var jsonMap = jsonDecode(jsonData);
      var detailsOfArthritis =
      DetailsOfArthritis.fromJson(jsonMap); //calling the model class
      print("url : hit");
      return detailsOfArthritis;
    } else {
      var cacheData = await APICacheManager().getCacheData("arthritis_details");
      var jsonMap = jsonDecode(cacheData.syncData);
      print("cache: hit");
      return DetailsOfArthritis.fromJson(jsonMap);
    }
  }



  //calling the medication link of hiv
  Future<HivMedication> getApiDataMedicationHiv() async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("hiv_treatments");
    if (!isCacheExist) {
      var jsonData = await NetworkHelper()
          .getData('http://103.109.230.18/api/getMedicationHiv');
      APICacheDBModel cacheDBModel =
          new APICacheDBModel(key: "hiv_treatments", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);
      var jsonMap = jsonDecode(jsonData);
      var detailsOfHiv = HivMedication.fromJson(jsonMap);
      print("url : hit");
      return detailsOfHiv;
    } else {
      var cacheData = await APICacheManager().getCacheData("hiv_treatments");
      var jsonMap = jsonDecode(cacheData.syncData);
      print("cache: hit");
      return HivMedication.fromJson(jsonMap);
    }
  }

  //Details of TB api link
  Future<DetailsOfTB> getApiDataTBDetails() async {
    var isCacheExist = await APICacheManager().isAPICacheKeyExist("tb_details");
    if (!isCacheExist) {
      var jsonData = await NetworkHelper()
          .getData('http://103.109.230.18/api/getDetailsOfTB');
      APICacheDBModel cacheDBModel =
          new APICacheDBModel(key: "tb_details", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);
      var jsonMap = jsonDecode(jsonData);
      var tbDetails = DetailsOfTB.fromJson(jsonMap);
      print("url : hit");
      return tbDetails;
    } else {
      var cacheData = await APICacheManager().getCacheData("tb_details");
      var jsonMap = jsonDecode(cacheData.syncData);
      print("cache: hit");
      http: //103.109.230.18/
      return DetailsOfTB.fromJson(jsonMap);
    }
  }

//TB Medication api call
  Future<TbMedication> getApiDataTBMedication() async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("tb_medication");
    if (!isCacheExist) {
      var jsonData = await NetworkHelper()
          .getData('http://103.109.230.18/api/getTbMedication');
      APICacheDBModel cacheDBModel =
          new APICacheDBModel(key: "tb_medication", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);
      var jsonMap = jsonDecode(jsonData);
      var tbMedication = TbMedication.fromJson(jsonMap);
      print("url : hit");
      return tbMedication;
    } else {
      var cacheData = await APICacheManager().getCacheData("tb_medication");
      var jsonMap = jsonDecode(cacheData.syncData);
      print("cache: hit");
      return TbMedication.fromJson(jsonMap);
    }
  }

  //Covid details api call
  Future<DetailsOfCovid> getApiDataCovidDetails() async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("covid_details");
    if (!isCacheExist) {
      var jsonData = await NetworkHelper()
          .getData('$baseUrl/api/detailsOfCovid');
      APICacheDBModel cacheDBModel =
          new APICacheDBModel(key: "covid_details", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);
      var jsonMap = jsonDecode(jsonData);
      var covidDetails = DetailsOfCovid.fromJson(jsonMap);
      print("url : hitcovid");
      return covidDetails;
    } else {
      var cacheData = await APICacheManager().getCacheData("covid_details");
      var jsonMap = jsonDecode(cacheData.syncData);
      print("cache: hitcovid");
      return DetailsOfCovid.fromJson(jsonMap);
    }
  }

  //Hotline numbers api call
  Future<HotlineNumbers> getApiHotlineNumbers() async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("hotline_numbers");
    if (!isCacheExist) {
      var jsonData =
          await NetworkHelper().getData('$baseUrl/api/emergencynumber');
      APICacheDBModel cacheDBModel =
          new APICacheDBModel(key: "hotline_numbers", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);
      var jsonMap = jsonDecode(jsonData);
      var hotlineNumbers = HotlineNumbers.fromJson(jsonMap);
      print("url : hit");
      return hotlineNumbers;
    } else {
      var cacheData = await APICacheManager().getCacheData("hotline_numbers");
      var jsonMap = jsonDecode(cacheData.syncData);
      print("cache: hit");
      return HotlineNumbers.fromJson(jsonMap);
    }
  }
//Doctor List api
  Future<DetailsOfDoctor> getApiDetailsOfDoctor() async {
    var isCacheExist =
    await APICacheManager().isAPICacheKeyExist("doctor_list");
    if (!isCacheExist) {
      var jsonData =
      await NetworkHelper().getData('$baseUrl/api/detailsOfDoctor');
      APICacheDBModel cacheDBModel =
      new APICacheDBModel(key: "doctor_list", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);
      var jsonMap = jsonDecode(jsonData);
      print(jsonMap);
      var doctorsList = DetailsOfDoctor.fromJson(jsonMap);
      print("url : hit doctor");
      return doctorsList;
    } else {
      var cacheData = await APICacheManager().getCacheData("doctor_list");
      var jsonMap = jsonDecode(cacheData.syncData);
      print("cache: hit doctor");
      return DetailsOfDoctor.fromJson(jsonMap);
    }
  }


  //call comes from select language since it is the initial screen.
  Future downloadData() async {
   /* await getDetailsOfHivDetails();
    await getApiDataTBDetails();
    await getApiDataMedicationHiv();
    await getApiDataTBMedication();
     await getApiHotlineNumbers();*/
    await getApiDetailsOfDoctor();
    await getApiDataCovidDetails();
    await getDetailsOfArthritis();
  }

  //Call comes from update button in settings
  Future updateContent() async {
    await APICacheManager().emptyCache();
    await downloadData();
    print("Updated everything");
  }
}
