import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:yemek_siparis_projem/data/entity/sepetyemekler.dart';
import 'package:yemek_siparis_projem/data/entity/sepetyemekler_cevap.dart';
import 'package:yemek_siparis_projem/data/entity/yemekler.dart';
import 'package:yemek_siparis_projem/data/entity/yemekler_cevap.dart';

class YemeklerDaoRepository {

  List<Yemekler> parseYemeklerCevap(String cevap) {
    return YemeklerCevap
        .fromJson(json.decode(cevap))
        .yemekler;
  }

  List<SepetYemekler> parseSepetYemeklerCevap(String cevap) {
       try{
      return SepetYemeklerCevap.fromJson(jsonDecode(cevap)).sepet_yemekler;
    }
    catch(e) {
      print(e);
      return [];
    }
  }

  Future<List<Yemekler>> YemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemeklerCevap(cevap.data.toString());
  }

  Future<void> Kaydet(String yemek_adi, String yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet,
      String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
      var veri = {
        "yemek_adi": yemek_adi,
        "yemek_resim_adi": yemek_resim_adi,
        "yemek_fiyat": yemek_fiyat,
        "yemek_siparis_adet": yemek_siparis_adet,
        "kullanici_adi": kullanici_adi,
      };
    print("XXXXX ${FormData.fromMap(veri)}");

    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Yemek Kaydet : ${cevap.data.toString()}");
  }

  Future<void> Sil(String sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Yemek Sil : ${cevap.data.toString()} ");
     SepetYemekleriGetir(kullanici_adi);
  }

  Future<List<SepetYemekler>> SepetYemekleriGetir (String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {
      "kullanici_adi": kullanici_adi };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    return parseSepetYemeklerCevap(cevap.data.toString());
  }

  Future<List<Yemekler>> Ara (String aramaKelimesi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    var yemekListesi = parseYemeklerCevap(cevap.data.toString());
    Iterable<Yemekler> arama = yemekListesi.where((aramaNesnesi) => aramaNesnesi.yemek_adi.toLowerCase().contains(aramaKelimesi.toLowerCase()));
    var liste = arama.toList();
    return liste;
  }

}