import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';

class CalendarScreen extends StatefulWidget {
  final String selectedCuisine;
  final int recommendedCalories;

  const CalendarScreen({
    required this.selectedCuisine,
    required this.recommendedCalories,
    super.key,
  });

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Map<String, Map<String, List<Map<String, dynamic>>>> savedMeals;
  final Map<String, List<Map<String, dynamic>>> foodDatabase = const {
    '韓国料理': [
      {'food_name': 'カレイのグリル', 'calories': 76},
      {'food_name': 'カレイの煮付け', 'calories': 45.4},
      {'food_name': 'ナスのナムル', 'calories': 19},
      {'food_name': 'カルビのグリル', 'calories': 586},
      {'food_name': 'カルビの蒸し物', 'calories': 262.2},
      {'food_name': 'カルビタン', 'calories': 362.5},
      {'food_name': 'タチウオのグリル', 'calories': 110.4},
      {'food_name': 'タチウオの煮付け', 'calories': 37},
      {'food_name': 'タチウオチゲ', 'calories': 48.2},
      {'food_name': 'ジャガイモのスープ', 'calories': 55.1},
      {'food_name': 'ジャガイモの炒め物', 'calories': 36.2},
      {'food_name': 'ポテトサラダ', 'calories': 64},
      {'food_name': 'ジャガイモの煮物', 'calories': 39},
      {'food_name': 'サツマイモの蜜漬け', 'calories': 266},
      {'food_name': 'サツマイモの天ぷら', 'calories': 72.4},
      {'food_name': '肉餃子', 'calories': 348.1},
      {'food_name': 'サバのグリル', 'calories': 110.4},
      {'food_name': 'サバの煮付け', 'calories': 107},
      {'food_name': 'サバチゲ', 'calories': 66},
      {'food_name': 'サバのフライ', 'calories': 167.3},
      {'food_name': 'ワラビのナムル', 'calories': 25.5},
      {'food_name': '唐辛子とアンチョビの炒め物', 'calories': 30.3},
      {'food_name': '唐辛子の炒め物', 'calories': 16},
      {'food_name': '唐辛子の天ぷら', 'calories': 42},
      {'food_name': 'ゴムタン', 'calories': 119},
      {'food_name': 'クッパ', 'calories': 343.9},
      {'food_name': '焼き餃子', 'calories': 429},
      {'food_name': 'キムチチャーハン', 'calories': 480.8},
      {'food_name': 'キムチチゲ', 'calories': 88.1},
      {'food_name': 'コマクの蒸し物', 'calories': 34},
      {'food_name': 'サンマのグリル', 'calories': 98},
      {'food_name': 'サンマの煮付け', 'calories': 60},
      {'food_name': 'ナンイテンジャンスープ', 'calories': 43},
      {'food_name': '茶碗蒸し', 'calories': 50.3},
      {'food_name': 'ダクトリタン', 'calories': 201},
      {'food_name': 'チキン', 'calories': 328.4},
      {'food_name': 'トラジのナムル', 'calories': 62},
      {'food_name': 'トンカツ', 'calories': 287.5},
      {'food_name': '冬のスープ', 'calories': 60.5},
      {'food_name': '冬の煮付け', 'calories': 80},
      {'food_name': '冬のチゲ', 'calories': 71.1},
      {'food_name': '豚カルビのグリル', 'calories': 375},
      {'food_name': '豚カルビの蒸し物', 'calories': 324.4},
      {'food_name': 'カルビ', 'calories': 270},
      {'food_name': '豚肉のチゲ', 'calories': 136.2},
      {'food_name': '豚のプルコギ', 'calories': 256},
      {'food_name': 'テンジャンチゲ', 'calories': 60.2},
      {'food_name': '豆腐キムチ', 'calories': 156},
      {'food_name': '豆腐の焼き物', 'calories': 50.1},
      {'food_name': '豆腐の煮物', 'calories': 89.4},
      {'food_name': '豆乳飲料', 'calories': 144},
      {'food_name': '餅餃子スープ', 'calories': 470},
      {'food_name': 'トッポッキ', 'calories': 170},
      {'food_name': '餃子スープ', 'calories': 473},
      {'food_name': 'アンチョビ炒め', 'calories': 47},
      {'food_name': '干し大根', 'calories': 23.3},
      {'food_name': '冷麺', 'calories': 583},
      {'food_name': 'キノコの炒め物', 'calories': 26.1},
      {'food_name': '麦ご飯', 'calories': 380.6},
      {'food_name': 'プデチゲ', 'calories': 171.3},
      {'food_name': 'ニラのチヂミ', 'calories': 158},
      {'food_name': 'プルコギ', 'calories': 197.5},
      {'food_name': 'ビビン麺', 'calories': 599},
      {'food_name': 'ビビン冷麺', 'calories': 552},
      {'food_name': 'ビビンバ', 'calories': 588.9},
      {'food_name': 'サムギョプサルのグリル', 'calories': 610.4},
      {'food_name': 'サムゲタン', 'calories': 395},
      {'food_name': 'ソルロンタン', 'calories': 171.1},
      {'food_name': 'スジェビ', 'calories': 453.2},
      {'food_name': 'アグチム', 'calories': 89},
      {'food_name': 'ヤンニョムケジャン', 'calories': 39.2},
      {'food_name': 'レンコンの煮物', 'calories': 24},
      {'food_name': 'スンドゥブチゲ', 'calories': 88.2},
      {'food_name': 'ユッケジャン', 'calories': 86},
      {'food_name': 'チャンチグクス', 'calories': 638},
      {'food_name': 'チャプチェ', 'calories': 189.4},
      {'food_name': 'チャプチェご飯', 'calories': 447.4},
      {'food_name': 'ウナギのヤンニョム焼き', 'calories': 220},
      {'food_name': 'アワビのお粥', 'calories': 184.6},
      {'food_name': 'キスのグリル', 'calories': 112},
      {'food_name': 'キスの激辛スープ', 'calories': 80.1},
      {'food_name': 'キスの蒸し物', 'calories': 73},
      {'food_name': 'キスのフライ', 'calories': 73.4},
      {'food_name': 'チョルメン', 'calories': 580.3},
      {'food_name': 'ツナチゲ', 'calories': 83},
      {'food_name': '清国ジャンチゲ', 'calories': 79},
      {'food_name': 'カルグクス', 'calories': 425},
      {'food_name': 'コングクス', 'calories': 738},
      {'food_name': 'カボチャのナムル', 'calories': 32},
      {'food_name': 'カボチャのチヂミ', 'calories': 76},
      {'food_name': 'フェドンバプ', 'calories': 696.5},
      {'food_name': '黒米ご飯', 'calories': 387.2},
      {'food_name': 'パジョン', 'calories': 109.2}
    ],
    '和食': [
      {'food_name': 'カレーライス', 'calories': 954},
      {'food_name': '牛丼', 'calories': 909},
      {'food_name': 'ビーフシチュー', 'calories': 568},
      {'food_name': 'ハンバーグ', 'calories': 437},
      {'food_name': 'さつま芋天ぷら', 'calories': 305},
      {'food_name': 'ポテトサラダ', 'calories': 224},
      {'food_name': 'コーンスープ', 'calories': 210},
      {'food_name': 'ショートケーキ', 'calories': 292},
      {'food_name': '桃', 'calories': 99},
      {'food_name': 'シェイク（M）', 'calories': 315},
      {'food_name': 'かつどん', 'calories': 893},
      {'food_name': 'シーフードスパゲティ', 'calories': 731},
      {'food_name': 'かに玉', 'calories': 339},
      {'food_name': '豚肉しょうが焼き', 'calories': 330},
      {'food_name': 'フライドポテト', 'calories': 124},
      {'food_name': '里芋の煮ころがし', 'calories': 126},
      {'food_name': 'クラムチャウダー', 'calories': 200},
      {'food_name': 'チーズケーキ', 'calories': 281},
      {'food_name': 'マスカット10粒', 'calories': 80},
      {'food_name': '日本酒1合', 'calories': 193},
      {'food_name': 'オムライス', 'calories': 697},
      {'food_name': 'スパゲティミートソース', 'calories': 597},
      {'food_name': '八宝菜', 'calories': 319},
      {'food_name': 'ぶり照り焼き', 'calories': 295},
      {'food_name': 'かぼちゃ煮物', 'calories': 126},
      {'food_name': 'アスパラ塩ゆで', 'calories': 97},
      {'food_name': '豚汁', 'calories': 167},
      {'food_name': 'シュークリーム', 'calories': 229},
      {'food_name': 'マンゴー', 'calories': 73},
      {'food_name': '焼酎（乙）100ml', 'calories': 146},
      {'food_name': 'お好み焼き', 'calories': 553},
      {'food_name': 'ラーメン', 'calories': 443},
      {'food_name': '鶏のからあげ', 'calories': 284},
      {'food_name': '魚のフライ', 'calories': 272},
      {'food_name': 'きんぴら', 'calories': 93},
      {'food_name': 'トマトマリネ', 'calories': 91},
      {'food_name': 'さつま汁', 'calories': 100},
      {'food_name': '饅頭', 'calories': 227},
      {'food_name': 'バナナ', 'calories': 72},
      {'food_name': '牛乳200ml', 'calories': 134},
      {'food_name': 'サンドイッチ', 'calories': 389},
      {'food_name': 'きつねうどん', 'calories': 382},
      {'food_name': 'さんま塩焼き', 'calories': 248},
      {'food_name': 'しゅうまい6個', 'calories': 246},
      {'food_name': '金時豆煮', 'calories': 90},
      {'food_name': 'サラダ', 'calories': 81},
      {'food_name': '野菜スープ', 'calories': 90},
      {'food_name': 'どら焼き', 'calories': 226},
      {'food_name': 'すいか1切', 'calories': 56},
      {'food_name': 'ジュース（M）', 'calories': 120},
      {'food_name': 'おにぎり2個', 'calories': 342},
      {'food_name': '栗ごはん', 'calories': 326},
      {'food_name': '厚焼き玉子', 'calories': 142},
      {'food_name': '鮭ホイル焼き', 'calories': 139},
      {'food_name': '大根サラダ', 'calories': 80},
      {'food_name': 'ふろふき大根', 'calories': 74},
      {'food_name': '味噌汁', 'calories': 33},
      {'food_name': 'クッキー5枚', 'calories': 210},
      {'food_name': 'メロン', 'calories': 52},
      {'food_name': '野菜ジュース', 'calories': 85},
      {'food_name': 'かけそば', 'calories': 321},
      {'food_name': 'かけうどん', 'calories': 311},
      {'food_name': 'まぐろ刺身', 'calories': 138},
      {'food_name': 'オムレツ', 'calories': 133},
      {'food_name': 'ブロッコリーソテー', 'calories': 70},
      {'food_name': 'ひじき煮物', 'calories': 67},
      {'food_name': 'あさり味噌汁', 'calories': 30},
      {'food_name': 'ようかん', 'calories': 203},
      {'food_name': 'りんご3切れ', 'calories': 49},
      {'food_name': 'オレンジジュース', 'calories': 84},
      {'food_name': 'いなり寿司3個', 'calories': 309},
      {'food_name': 'ホットドッグ', 'calories': 294},
      {'food_name': 'かつおたたき', 'calories': 120},
      {'food_name': '鯛塩焼き', 'calories': 120},
      {'food_name': 'きのこホイル焼き', 'calories': 62},
      {'food_name': '枝豆', 'calories': 45},
      {'food_name': 'すまし汁', 'calories': 22},
      {'food_name': 'プリン', 'calories': 198},
      {'food_name': 'さくらんぼ', 'calories': 40},
      {'food_name': '赤ワイン100ml', 'calories': 73},
      {'food_name': 'ごはん1杯', 'calories': 252},
      {'food_name': 'バターロール2個', 'calories': 190},
      {'food_name': '冷奴', 'calories': 97},
      {'food_name': 'ゆで卵', 'calories': 83},
      {'food_name': 'とろろ汁', 'calories': 44},
      {'food_name': 'ほうれん草お浸し', 'calories': 23},
      {'food_name': '中華風スープ', 'calories': 16},
      {'food_name': 'カステラ', 'calories': 149},
      {'food_name': 'みかん1個', 'calories': 34},
      {'food_name': '白ワイン100ml', 'calories': 73},
      {'food_name': '食パン', 'calories': 177},
      {'food_name': 'おかゆ', 'calories': 158},
      {'food_name': '茶碗蒸し', 'calories': 61},
      {'food_name': 'ししゃも2尾', 'calories': 42},
      {'food_name': 'しいたけ網焼き', 'calories': 17},
      {'food_name': '小松菜煮浸し', 'calories': 11},
      {'food_name': '潮汁', 'calories': 15},
      {'food_name': 'みかんゼリー', 'calories': 145},
      {'food_name': 'いちご5粒', 'calories': 25},
      {'food_name': 'コーヒー200ml', 'calories': 4},
    ],
    '洋食': [
      {'food_name': 'チーズバーガー', 'calories': 303},
      {'food_name': 'ホットドッグ', 'calories': 290},
      {'food_name': 'フライドポテト', 'calories': 312},
      {'food_name': 'ピザ（ペパロニ）', 'calories': 298},
      {'food_name': 'フライドチキン', 'calories': 320},
      {'food_name': 'マカロニ＆チーズ', 'calories': 164},
      {'food_name': 'シーザーサラダ', 'calories': 180},
      {'food_name': 'グリルチキンサンドイッチ', 'calories': 400},
      {'food_name': 'ラザニア', 'calories': 135},
      {'food_name': 'タコス', 'calories': 226},
      {'food_name': 'ミートボールスパゲッティ', 'calories': 254},
      {'food_name': 'チキンアルフレード', 'calories': 220},
      {'food_name': 'ビーフシチュー', 'calories': 135},
      {'food_name': 'チリコンカーン', 'calories': 250},
      {'food_name': 'BLTサンドイッチ', 'calories': 298},
      {'food_name': 'クラムチャウダー', 'calories': 200},
      {'food_name': 'ミートローフ', 'calories': 149},
      {'food_name': 'パンケーキ', 'calories': 227},
      {'food_name': 'ワッフル', 'calories': 291},
      {'food_name': 'オムレツ', 'calories': 154},
      {'food_name': 'ステーキ（グリル）', 'calories': 271},
      {'food_name': 'ポークチョップ', 'calories': 196},
      {'food_name': 'ベイクドサーモン', 'calories': 206},
      {'food_name': 'シュリンプスキャンピ', 'calories': 241},
      {'food_name': 'ツナサラダ', 'calories': 194},
      {'food_name': 'チキンヌードルスープ', 'calories': 71},
      {'food_name': 'ビーフタコス', 'calories': 226},
      {'food_name': 'ファヒータ', 'calories': 270},
      {'food_name': 'ケサディーヤ', 'calories': 326},
      {'food_name': 'ナチョス', 'calories': 346},
      {'food_name': 'BBQリブ', 'calories': 290},
      {'food_name': 'プルドポークサンドイッチ', 'calories': 357},
      {'food_name': 'バッファローチキンウィング', 'calories': 165},
      {'food_name': 'ターキーサンドイッチ', 'calories': 210},
      {'food_name': 'スロッピージョー', 'calories': 290},
      {'food_name': 'チキンポットパイ', 'calories': 287},
      {'food_name': 'シェパーズパイ', 'calories': 170},
      {'food_name': 'チキンパルメザン', 'calories': 257},
      {'food_name': 'フィッシュ＆チップス', 'calories': 342},
      {'food_name': 'ビーフブリトー', 'calories': 290},
      {'food_name': 'ハム＆チーズサンドイッチ', 'calories': 352},
      {'food_name': 'グリルチーズサンドイッチ', 'calories': 291},
      {'food_name': 'コーンドッグ', 'calories': 180},
      {'food_name': 'チキンシーザーラップ', 'calories': 340},
      {'food_name': 'ベジーバーガー', 'calories': 124},
      {'food_name': 'エッグサラダ', 'calories': 234},
      {'food_name': 'ロブスターロール', 'calories': 407},
      {'food_name': 'BBQチキンピザ', 'calories': 260},
      {'food_name': 'ブルスケッタ', 'calories': 173},
      {'food_name': 'チキンファヒータ', 'calories': 345},
      {'food_name': 'ガーリックブレッド', 'calories': 350},
      {'food_name': 'モッツァレラスティック', 'calories': 318},
      {'food_name': 'ポテトサラダ', 'calories': 143},
      {'food_name': 'パスタサラダ', 'calories': 158},
      {'food_name': 'ほうれん草とアーティチョークのディップ', 'calories': 235},
      {'food_name': '詰めピーマン', 'calories': 190},
      {'food_name': 'ビーフエンチラーダ', 'calories': 236},
      {'food_name': 'コブサラダ', 'calories': 290},
      {'food_name': 'チキンケサディーヤ', 'calories': 330},
    ],
    'ビーガン': [
      {'food_name': 'ビーガンブリトー', 'calories': 300},
      {'food_name': 'ビーガンバーガー', 'calories': 250},
      {'food_name': '豆腐炒め', 'calories': 200},
      {'food_name': 'ビーガンピザ', 'calories': 270},
      {'food_name': 'ビーガンマカロニチーズ', 'calories': 180},
      {'food_name': 'ビーガンチリ', 'calories': 230},
      {'food_name': 'ファラフェルラップ', 'calories': 310},
      {'food_name': 'ビーガンスシ', 'calories': 200},
      {'food_name': 'ビーガンラザニア', 'calories': 280},
      {'food_name': 'ビーガンパッタイ', 'calories': 350},
      {'food_name': 'ビーガンシーザーサラダ', 'calories': 150},
      {'food_name': 'ビーガンタコス', 'calories': 250},
      {'food_name': 'ビーガンスパゲッティボロネーゼ', 'calories': 320},
      {'food_name': 'ビーガンミートボール', 'calories': 200},
      {'food_name': 'ビーガンシェパーズパイ', 'calories': 290},
      {'food_name': 'ビーガンブリトーボウル', 'calories': 400},
      {'food_name': 'ビーガンエンチラーダ', 'calories': 330},
      {'food_name': 'ビーガンケサディーヤ', 'calories': 280},
      {'food_name': 'ビーガンBBQジャックフルーツサンドイッチ', 'calories': 350},
      {'food_name': 'ビーガンBLTサンドイッチ', 'calories': 300},
      {'food_name': 'ビーガンラーメン', 'calories': 220},
      {'food_name': 'ビーガンフォー', 'calories': 180},
      {'food_name': 'ビーガンミネストローネスープ', 'calories': 150},
      {'food_name': 'ビーガン詰めピーマン', 'calories': 210},
      {'food_name': 'ビーガンコブサラダ', 'calories': 220},
      {'food_name': 'ビーガンなすパルメザン', 'calories': 310},
      {'food_name': 'ビーガンスイートポテトカレー', 'calories': 290},
      {'food_name': 'ビーガン黒豆バーガー', 'calories': 240},
      {'food_name': 'ビーガンファヒータ', 'calories': 260},
      {'food_name': 'ビーガン豆腐スクランブル', 'calories': 190},
      {'food_name': 'ビーガンレンズ豆スープ', 'calories': 160},
      {'food_name': 'ビーガンほうれん草アーティチョークディップ', 'calories': 150},
      {'food_name': 'ビーガンチョコレートケーキ', 'calories': 350},
      {'food_name': 'ビーガンパンケーキ', 'calories': 200},
      {'food_name': 'ビーガンワッフル', 'calories': 250},
      {'food_name': 'ビーガンバナナブレッド', 'calories': 220},
      {'food_name': 'ビーガンブルーベリーマフィン', 'calories': 180},
      {'food_name': 'ビーガンチョコレートチップクッキー', 'calories': 150},
      {'food_name': 'ビーガンブラウニー', 'calories': 300},
      {'food_name': 'ビーガンアイスクリーム', 'calories': 180},
      {'food_name': 'ビーガンスムージーボウル', 'calories': 300},
      {'food_name': 'ビーガンプロテインシェイク', 'calories': 200},
      {'food_name': 'ビーガンエナジーバー', 'calories': 250},
      {'food_name': 'ビーガングラノーラ', 'calories': 200},
      {'food_name': 'ビーガンオーバーナイトオーツ', 'calories': 180},
      {'food_name': 'ビーガンチアプディング', 'calories': 160},
      {'food_name': 'ビーガンアボカドトースト', 'calories': 220},
      {'food_name': 'ビーガン詰めアボカド', 'calories': 240},
      {'food_name': 'ビーガンブッダボウル', 'calories': 350},
      {'food_name': 'ビーガンケールサラダ', 'calories': 180},
    ],
  };
  Set<String> selectedFoods = {};

  @override
  void initState() {
    super.initState();
    savedMeals = {};
    _selectedDay = _focusedDay;
    _generateMealPlans(_selectedDay!);
  }

  void _generateMealPlans(DateTime date) {
    if (savedMeals.containsKey(date.toString())) return;

    selectedFoods.clear(); // 중복 방지 집합 초기화
    int caloriesPerMeal = (widget.recommendedCalories / 3).round();
    Map<String, List<Map<String, dynamic>>> dailyMeals = {
      '朝ご飯': _getMealsForCalories(caloriesPerMeal),
      '昼ご飯': _getMealsForCalories(caloriesPerMeal),
      '夜ご飯': _getMealsForCalories(caloriesPerMeal),
    };
    setState(() {
      savedMeals[date.toString()] = dailyMeals;
    });
  }

  List<Map<String, dynamic>> _getMealsForCalories(int calories) {
    List<Map<String, dynamic>> cuisineMeals =
        List.from(foodDatabase[widget.selectedCuisine] ?? []);
    List<Map<String, dynamic>> selectedMeals = [];

    int totalCalories = 0;
    Random random = Random();
    while (totalCalories < calories && cuisineMeals.isNotEmpty) {
      int randomIndex = random.nextInt(cuisineMeals.length);
      Map<String, dynamic> meal = cuisineMeals[randomIndex];
      int mealCalories = (meal['calories'] as num).toInt();
      if (!selectedFoods.contains(meal['food_name']) &&
          totalCalories + mealCalories <= calories - 100) {
        selectedMeals.add(meal);
        totalCalories += mealCalories;
        selectedFoods.add(meal['food_name']);
        cuisineMeals.removeAt(randomIndex);
      } else {
        cuisineMeals.removeAt(randomIndex);
      }
    }

    return selectedMeals;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime firstDay = DateTime.now().subtract(const Duration(days: 30));
    final DateTime lastDay = DateTime.now().add(const Duration(days: 90));

    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: firstDay,
            lastDay: lastDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
              _generateMealPlans(selectedDay);
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: const Color(0xFF3EB489),
                shape: BoxShape.circle,
              ),
            ),
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
          ),
          const SizedBox(height: 8.0),
          if (_selectedDay != null) ...[
            Text(
              '選択した日付: ${_selectedDay!.toLocal().toIso8601String().substring(0, 10)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView(
                children: [
                  _buildMealCard('朝ご飯'),
                  _buildMealCard('昼ご飯'),
                  _buildMealCard('夜ご飯'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMealCard(String mealTime) {
    final meals = savedMeals[_selectedDay.toString()]?[mealTime] ?? [];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mealTime,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Column(
              children: meals.map((meal) {
                return ListTile(
                  leading: const Icon(Icons.food_bank,
                      size: 40, color: Color(0xFF3EB489)),
                  title: Text(
                    meal['food_name'],
                    style: const TextStyle(color: Color(0xFF3EB489)),
                  ),
                  subtitle: Text(
                    '${meal['calories']} kcal',
                    style: const TextStyle(color: Color(0xFF3EB489)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
