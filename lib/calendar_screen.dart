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
      {'food_name': 'キムチチゲ', 'calories': 200},
      {'food_name': 'プルコギ', 'calories': 300},
      {'food_name': 'ビビンバ', 'calories': 500},
      {'food_name': 'テンジャンチゲ', 'calories': 150},
      {'food_name': 'チャプチェ', 'calories': 400},
      {'food_name': 'サムギョプサル', 'calories': 600},
      {'food_name': 'キンパ', 'calories': 300},
      {'food_name': 'スンドゥブチゲ', 'calories': 250},
      {'food_name': 'カルビ', 'calories': 700},
      {'food_name': 'トッポッキ', 'calories': 400},
      {'food_name': 'ビンデトック', 'calories': 350},
      {'food_name': 'サムゲタン', 'calories': 600},
      {'food_name': 'カムジャタン', 'calories': 550},
      {'food_name': 'スンデ', 'calories': 450},
      {'food_name': 'ヘムルパジョン', 'calories': 500},
      {'food_name': 'ケランチム', 'calories': 200},
      {'food_name': 'ホットク', 'calories': 300},
      {'food_name': 'パッピンス', 'calories': 250},
      {'food_name': 'チュクミ', 'calories': 400},
      {'food_name': 'タッカルビ', 'calories': 500},
      {'food_name': 'プルコギトッポッキ', 'calories': 450},
      {'food_name': 'ケジャン', 'calories': 300},
      {'food_name': 'チョッパル', 'calories': 600},
      {'food_name': 'ナクチボックム', 'calories': 350},
      {'food_name': 'チャジャンミョン', 'calories': 500},
      {'food_name': 'タンミョン', 'calories': 200},
      {'food_name': 'サムパプ', 'calories': 400},
      {'food_name': 'ヘムルタン', 'calories': 300},
      {'food_name': 'チムタク', 'calories': 450},
      {'food_name': 'ピョンヤン冷麺', 'calories': 250},
      {'food_name': 'カルグクス', 'calories': 300},
      {'food_name': 'ムルヒャン', 'calories': 200},
      {'food_name': 'ヘムルパジョン', 'calories': 450},
      {'food_name': 'ミルミョン', 'calories': 400},
      {'food_name': 'テンジャングク', 'calories': 150},
      {'food_name': 'ヘムルタン', 'calories': 300},
      {'food_name': 'コムタン', 'calories': 350},
      {'food_name': 'クッパ', 'calories': 400},
      {'food_name': 'タクチ', 'calories': 500},
      {'food_name': 'パジョン', 'calories': 400},
      {'food_name': 'ホルモンチゲ', 'calories': 350},
      {'food_name': 'マンドゥグク', 'calories': 300},
      {'food_name': 'ユッケジャン', 'calories': 450},
      {'food_name': 'ホットク', 'calories': 300},
      {'food_name': 'シッケ', 'calories': 200},
      {'food_name': 'ヨンヤンス', 'calories': 300},
      {'food_name': 'ヘムルチム', 'calories': 350},
      {'food_name': 'メウンタン', 'calories': 400},
      {'food_name': 'テンジャンボックム', 'calories': 250},
      {'food_name': 'クァメギ', 'calories': 450},
      {'food_name': 'シンソルロ', 'calories': 600},
      {'food_name': 'チョングッチャン', 'calories': 150},
      {'food_name': 'トゥペギビビンバ', 'calories': 500},
      {'food_name': 'チャドルバギ', 'calories': 700},
      {'food_name': 'コッチョリ', 'calories': 100},
      {'food_name': 'ケジャンビビンバ', 'calories': 550},
      {'food_name': 'シレギ', 'calories': 150},
      {'food_name': 'オムッ', 'calories': 200},
      {'food_name': 'ムク', 'calories': 50},
      {'food_name': 'ピビンバム', 'calories': 500},
      {'food_name': 'セウタン', 'calories': 300},
      {'food_name': 'クルグクス', 'calories': 350},
      {'food_name': 'プルコギパプ', 'calories': 400},
      {'food_name': 'ケランマリ', 'calories': 200},
      {'food_name': 'ホンオフェ', 'calories': 150},
      {'food_name': 'コンビジチゲ', 'calories': 300},
      {'food_name': 'クァジャ', 'calories': 100},
      {'food_name': 'サムジャン', 'calories': 50},
      {'food_name': 'ヘムルパッタン', 'calories': 200},
      {'food_name': 'ポッサム', 'calories': 500},
      {'food_name': 'サムギョプサルキムチチゲ', 'calories': 400},
      {'food_name': 'コプチャン', 'calories': 300},
      {'food_name': 'ケランチム', 'calories': 200},
      {'food_name': 'タットリタン', 'calories': 400},
      {'food_name': 'テンジャングクス', 'calories': 350},
      {'food_name': 'マンドゥククス', 'calories': 300},
      {'food_name': 'ピョンヤンナクチ', 'calories': 200},
      {'food_name': 'ヘムルパプ', 'calories': 450},
      {'food_name': 'サムパブ', 'calories': 500},
      {'food_name': 'クッス', 'calories': 350},
      {'food_name': 'スンデクッパプ', 'calories': 300},
      {'food_name': 'オデン', 'calories': 150},
      {'food_name': 'ポリッチム', 'calories': 400},
      {'food_name': 'サムギョプサルチョルパン', 'calories': 600},
      {'food_name': 'チョンゴル', 'calories': 550},
      {'food_name': 'ユッケジャンバプ', 'calories': 450},
      {'food_name': 'ククス', 'calories': 300},
      {'food_name': 'テンジャンビビンバ', 'calories': 500},
      {'food_name': 'キムチジョン', 'calories': 350},
      {'food_name': 'カクテキ', 'calories': 150},
      {'food_name': 'ポッサムチョルパン', 'calories': 600},
      {'food_name': 'トゥペギスンドゥブ', 'calories': 250},
      {'food_name': 'ムルフェ', 'calories': 200},
      {'food_name': 'チャドルバギ', 'calories': 500},
      {'food_name': 'トゥペギテンジャンチゲ', 'calories': 350},
      {'food_name': 'スンドゥブビビンバ', 'calories': 450},
      {'food_name': 'チュオタン', 'calories': 300},
    ],
    '和食': [
      {'food_name': '寿司', 'calories': 300},
      {'food_name': 'ラーメン', 'calories': 500},
      {'food_name': '丼', 'calories': 450},
      {'food_name': '天ぷら', 'calories': 350},
      {'food_name': 'うどん', 'calories': 400},
      {'food_name': 'おにぎり', 'calories': 200},
      {'food_name': '焼き鳥', 'calories': 250},
      {'food_name': 'お好み焼き', 'calories': 400},
      {'food_name': 'たこ焼き', 'calories': 350},
      {'food_name': '刺身', 'calories': 200},
      {'food_name': 'そば', 'calories': 300},
      {'food_name': '天丼', 'calories': 500},
      {'food_name': 'カツ丼', 'calories': 600},
      {'food_name': '親子丼', 'calories': 450},
      {'food_name': '冷やし中華', 'calories': 400},
      {'food_name': '焼きそば', 'calories': 500},
      {'food_name': 'カレーライス', 'calories': 600},
      {'food_name': 'チャーハン', 'calories': 500},
      {'food_name': '味噌汁', 'calories': 100},
      {'food_name': '揚げ出し豆腐', 'calories': 200},
      {'food_name': 'すき焼き', 'calories': 700},
      {'food_name': 'しゃぶしゃぶ', 'calories': 600},
      {'food_name': 'もつ鍋', 'calories': 500},
      {'food_name': 'うな重', 'calories': 650},
      {'food_name': 'とんかつ', 'calories': 600},
      {'food_name': '魚の塩焼き', 'calories': 300},
      {'food_name': '鯖の味噌煮', 'calories': 400},
      {'food_name': '焼き餃子', 'calories': 300},
      {'food_name': '煮物', 'calories': 200},
      {'food_name': '肉じゃが', 'calories': 350},
      {'food_name': 'だし巻き卵', 'calories': 150},
      {'food_name': 'かつおのたたき', 'calories': 250},
      {'food_name': '豆腐サラダ', 'calories': 150},
      {'food_name': '海藻サラダ', 'calories': 100},
      {'food_name': '鶏の唐揚げ', 'calories': 400},
      {'food_name': 'えびフライ', 'calories': 450},
      {'food_name': '豚の生姜焼き', 'calories': 500},
      {'food_name': '魚のフライ', 'calories': 350},
      {'food_name': 'サバ缶', 'calories': 200},
      {'food_name': '豆腐ステーキ', 'calories': 200},
      {'food_name': '牛丼', 'calories': 600},
      {'food_name': 'さつまいもご飯', 'calories': 300},
      {'food_name': 'きんぴらごぼう', 'calories': 150},
      {'food_name': 'ごぼうの唐揚げ', 'calories': 200},
      {'food_name': '焼きナス', 'calories': 100},
      {'food_name': 'おでん', 'calories': 300},
      {'food_name': '海老天', 'calories': 150},
      {'food_name': 'かき揚げ', 'calories': 300},
      {'food_name': 'ひじき煮', 'calories': 100},
      {'food_name': '鶏もも照り焼き', 'calories': 350},
      {'food_name': 'たたききゅうり', 'calories': 50},
      {'food_name': '焼きもろこし', 'calories': 200},
      {'food_name': '里芋の煮物', 'calories': 150},
      {'food_name': '高野豆腐', 'calories': 100},
      {'food_name': 'かぶの煮物', 'calories': 100},
      {'food_name': 'ブリの照り焼き', 'calories': 350},
      {'food_name': 'ごま和え', 'calories': 150},
      {'food_name': '納豆巻き', 'calories': 250},
      {'food_name': '鶏ささみ', 'calories': 150},
      {'food_name': 'イカ焼き', 'calories': 200},
      {'food_name': '鮭の塩焼き', 'calories': 250},
      {'food_name': '茶碗蒸し', 'calories': 100},
      {'food_name': 'たけのこご飯', 'calories': 300},
      {'food_name': '天ぷらそば', 'calories': 400},
      {'food_name': 'いなり寿司', 'calories': 200},
      {'food_name': 'からし蓮根', 'calories': 150},
      {'food_name': 'うに丼', 'calories': 350},
      {'food_name': '刺身盛り合わせ', 'calories': 300},
      {'food_name': 'たこ刺身', 'calories': 200},
      {'food_name': 'ホタテバター焼き', 'calories': 300},
      {'food_name': 'カニクリームコロッケ', 'calories': 400},
      {'food_name': 'かに玉', 'calories': 300},
      {'food_name': '松前漬け', 'calories': 150},
      {'food_name': 'すじこ', 'calories': 200},
      {'food_name': 'かに鍋', 'calories': 400},
      {'food_name': 'なめこおろし', 'calories': 50},
      {'food_name': 'だし巻き卵', 'calories': 150},
      {'food_name': '山芋とろろ', 'calories': 100},
      {'food_name': '松茸ご飯', 'calories': 350},
      {'food_name': '松茸の土瓶蒸し', 'calories': 100},
      {'food_name': 'おから煮', 'calories': 200},
      {'food_name': 'しらすおろし', 'calories': 100},
      {'food_name': 'しらす丼', 'calories': 300},
      {'food_name': 'カニカマ', 'calories': 150},
      {'food_name': 'まぐろ漬け丼', 'calories': 350},
      {'food_name': '親子丼', 'calories': 450},
      {'food_name': '豚丼', 'calories': 600},
      {'food_name': '海鮮丼', 'calories': 500},
      {'food_name': '鉄火丼', 'calories': 300},
      {'food_name': '鮭のホイル焼き', 'calories': 350},
    ],
    '洋食': [
      {'food_name': 'パスタ', 'calories': 600},
      {'food_name': 'ステーキ', 'calories': 700},
      {'food_name': 'サラダ', 'calories': 200},
      {'food_name': 'ピザ', 'calories': 500},
      {'food_name': 'ハンバーガー', 'calories': 550},
      {'food_name': 'サンドイッチ', 'calories': 300},
      {'food_name': 'フライドポテト', 'calories': 350},
      {'food_name': 'チキンナゲット', 'calories': 300},
      {'food_name': 'スパゲッティ', 'calories': 400},
      {'food_name': 'マカロニチーズ', 'calories': 450},
      {'food_name': 'ペパロニピザ', 'calories': 500},
      {'food_name': 'シーザーサラダ', 'calories': 350},
      {'food_name': 'グリルチキンサラダ', 'calories': 300},
      {'food_name': 'ホットドッグ', 'calories': 400},
      {'food_name': 'バーベキューチキン', 'calories': 500},
      {'food_name': 'ポテトサラダ', 'calories': 250},
      {'food_name': 'コールスロー', 'calories': 200},
      {'food_name': 'クリームスープ', 'calories': 300},
      {'food_name': 'ガーリックブレッド', 'calories': 250},
      {'food_name': 'ラザニア', 'calories': 600},
      {'food_name': 'チーズバーガー', 'calories': 600},
      {'food_name': 'ビーフタコス', 'calories': 450},
      {'food_name': 'グリルチキン胸肉', 'calories': 400},
      {'food_name': 'オニオンリング', 'calories': 350},
      {'food_name': 'トマトスープ', 'calories': 150},
      {'food_name': 'アルフレードパスタ', 'calories': 700},
      {'food_name': 'クリームパスタ', 'calories': 650},
      {'food_name': 'ニューヨークストリップステーキ', 'calories': 750},
      {'food_name': 'リブアイステーキ', 'calories': 800},
      {'food_name': 'フレンチトースト', 'calories': 350},
      {'food_name': 'ワッフル', 'calories': 400},
      {'food_name': 'フライドチキン', 'calories': 500},
      {'food_name': 'クラムチャウダー', 'calories': 300},
      {'food_name': 'ベイクドビーンズ', 'calories': 200},
      {'food_name': 'ビスケット', 'calories': 250},
      {'food_name': 'アップルパイ', 'calories': 450},
      {'food_name': 'チョコレートブラウニー', 'calories': 400},
      {'food_name': 'チーズケーキ', 'calories': 500},
      {'food_name': 'ティラミス', 'calories': 400},
      {'food_name': 'ベーグル', 'calories': 300},
      {'food_name': 'クッキー', 'calories': 250},
      {'food_name': 'マフィン', 'calories': 350},
      {'food_name': 'クロワッサン', 'calories': 300},
      {'food_name': 'エクレア', 'calories': 350},
      {'food_name': 'パンケーキ', 'calories': 400},
      {'food_name': 'ベーコンエッグ', 'calories': 300},
      {'food_name': 'オムレツ', 'calories': 400},
      {'food_name': 'スクランブルエッグ', 'calories': 350},
      {'food_name': 'サーモンサラダ', 'calories': 250},
      {'food_name': 'カプレーゼサラダ', 'calories': 200},
      {'food_name': 'ミートローフ', 'calories': 450},
      {'food_name': 'バッファローチキンウィング', 'calories': 500},
      {'food_name': 'フリット', 'calories': 350},
      {'food_name': 'グリルドサーモン', 'calories': 500},
      {'food_name': 'シュリンプカクテル', 'calories': 150},
      {'food_name': 'カルボナーラ', 'calories': 700},
      {'food_name': 'リゾット', 'calories': 600},
      {'food_name': 'シーフードパエリア', 'calories': 550},
      {'food_name': 'フィッシュアンドチップス', 'calories': 600},
      {'food_name': 'ターキーブレストサンドイッチ', 'calories': 350},
      {'food_name': 'バーベキューポークサンドイッチ', 'calories': 500},
      {'food_name': 'チョップドサラダ', 'calories': 300},
      {'food_name': 'ローストビーフサンドイッチ', 'calories': 400},
      {'food_name': 'フムス', 'calories': 200},
      {'food_name': 'ナチョス', 'calories': 450},
      {'food_name': 'ガーリックシュリンプ', 'calories': 300},
      {'food_name': 'ビーフブリトー', 'calories': 500},
      {'food_name': 'チキンタコス', 'calories': 400},
      {'food_name': 'クラムカジノ', 'calories': 250},
      {'food_name': 'エッグベネディクト', 'calories': 450},
      {'food_name': 'ロブスタービスク', 'calories': 350},
      {'food_name': 'ステーキフリット', 'calories': 700},
      {'food_name': 'ムール貝', 'calories': 200},
      {'food_name': 'ロブスターテール', 'calories': 300},
      {'food_name': 'バーベキューリブ', 'calories': 600},
      {'food_name': 'チキンパルメザン', 'calories': 700},
      {'food_name': 'コブサラダ', 'calories': 400},
      {'food_name': 'シーフードアルフレド', 'calories': 750},
      {'food_name': 'フィレミニョン', 'calories': 800},
      {'food_name': 'ガンボ', 'calories': 400},
      {'food_name': 'ジャークチキン', 'calories': 450},
      {'food_name': 'フレンチオニオンスープ', 'calories': 350},
      {'food_name': 'ガスパチョ', 'calories': 200},
      {'food_name': 'クレームブリュレ', 'calories': 400},
      {'food_name': 'ガーリックシュリンプパスタ', 'calories': 650},
      {'food_name': 'シーフードガンボ', 'calories': 500},
      {'food_name': 'チキンエンチラーダ', 'calories': 600},
      {'food_name': 'ターキー', 'calories': 400},
      {'food_name': 'ビスケットグレイビー', 'calories': 500},
      {'food_name': 'ベイクドポテト', 'calories': 350},
      {'food_name': 'クリームドスピナッチ', 'calories': 250},
      {'food_name': 'ベイクドハム', 'calories': 400},
      // 추가 음식 데이터 생략
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
    List<Map<String, dynamic>> cuisineMeals = List.from(foodDatabase[widget.selectedCuisine] ?? []);
    List<Map<String, dynamic>> selectedMeals = [];

    int totalCalories = 0;
    Random random = Random();
    while (totalCalories < calories && cuisineMeals.isNotEmpty) {
      int randomIndex = random.nextInt(cuisineMeals.length);
      Map<String, dynamic> meal = cuisineMeals[randomIndex];
      int mealCalories = (meal['calories'] as num).toInt();
      if (!selectedFoods.contains(meal['food_name']) &&
          totalCalories + mealCalories <= calories + 100) {
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
                  leading: const Icon(Icons.food_bank, size: 40, color: Color(0xFF3EB489)),
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