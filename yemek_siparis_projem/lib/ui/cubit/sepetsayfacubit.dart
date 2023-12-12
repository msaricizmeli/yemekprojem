import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_projem/data/entity/sepetyemekler.dart';
import 'package:yemek_siparis_projem/data/entity/yemekler.dart';
import 'package:yemek_siparis_projem/data/repo/yemekler_dao_repo.dart';
class SepetsayfaCubit extends Cubit<List<SepetYemekler>>{
  SepetsayfaCubit():super(<SepetYemekler>[]);

  var mrepo = YemeklerDaoRepository();

  Future<void> sepetYemekler() async {
    var liste = await mrepo.SepetYemekleriGetir("mert");
    emit(liste);
  }

  Future<void> sil(String sepet_yemek_id,String kullanici_adi) async {
    await mrepo.Sil(sepet_yemek_id, "mert");
    sepetYemekler();
  }
}

  /*
  Future<void> duzenle(Yemekler yemek, int adet, String kullanici_adi) async {
// Ürünün zaten sepette olup olmadığını kontrol edin
    var mevcutyemek = state.first.Where((item) => item.yemek_adi == yemek.yemek_adi, Else: () => null,);
    if (mevcutyemek != null) {
      // Ürün zaten sepette mevcutsa miktarı güncelleyin
      await mrepo.Kaydet( yemek.yemek_adi, yemek.yemek_resim_adi, int.parse(yemek.yemek_fiyat), int.parse(mevcutyemek.yemek_siparis_adet) + (adet), kullanici_adi, );
    } else {
// Ürün sepette yoksa ekleyin
      await mrepo.Kaydet( yemek.yemek_adi, yemek.yemek_resim_adi, int.parse(yemek.yemek_fiyat), adet, kullanici_adi, );
    }
// Sepetteki öğeleri yenile
    sepetYemekler();
  }
*/

