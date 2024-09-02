import 'dart:math';

class Quiz {
  final String type;
  final List<Unit> units;

  Quiz(this.type, this.units);
}

class Unit {
  final String name;
  final List<Question> questions;

  Unit(this.name, this.questions);
}

class Question {
  final String questionText;
  List<Answer> answersList;

  Question(this.questionText, this.answersList);

  void shuffleAnswers() {
    answersList.shuffle(Random());
  }
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

class QuizManager {
  final List<Quiz> quizzes;
  final Random _random = Random();

  QuizManager(this.quizzes);

  List<Question> getRandomQuestions(
      String quizType, String unitName, int count) {
    Quiz targetQuiz = quizzes.firstWhere((quiz) => quiz.type == quizType,
        orElse: () => throw Exception('Quiz type not found'));
    Unit targetUnit = targetQuiz.units.firstWhere(
        (unit) => unit.name == unitName,
        orElse: () => throw Exception('Unit not found'));

    List<Question> allQuestions = List.from(targetUnit.questions);
    allQuestions.shuffle(_random);
    List<Question> selectedQuestions = allQuestions.take(count).toList();

    for (var question in selectedQuestions) {
      question.shuffleAnswers();
    }

    return selectedQuestions;
  }
}

// Initialize QuizManager with hardcoded questions
QuizManager quizManager = QuizManager([
  Quiz("تواريخ", [
    Unit("الوحدة الأولى", [
      Question("تأسيس هيأة الأمم المتحدة", [
        Answer("1945/10/24", true),
        Answer("ماي 1972", false),
        Answer("1946/11/02", false),
        Answer("1947/02/15", false),
      ]),
      Question("مشروع مارشال", [
        Answer("1947/06/05", true),
        Answer("1991/07/01", false),
        Answer("1946/03/02", false),
        Answer("1947/04/05", false),
      ]),
      Question("تأسيس الكومنفورم", [
        Answer("1947/10/06", true),
        Answer("1947/09/22", false),
        Answer("1945/01/02", false),
        Answer("1947/07/21", false),
      ]),
      Question("الخط الأحمر بين موسكو و واشنطن", [
        Answer("1963/06/20", true),
        Answer("1959/04/04", false),
        Answer("1966/03/02", false),
        Answer("1962/02/15", false),
      ]),
      Question("قمة حركة عدم الانحياز في الجزائر ", [
        Answer("1973/09/05", true),
        Answer("1972/05/14", false),
        Answer("1971/11/02", false),
        Answer("1976/09/09", false),
      ]),
      Question("حل الكوميكون", [
        Answer("1991/06/28", true),
        Answer("1991/07/01", false),
        Answer("1989/03/19", false),
        Answer("1991/02/25", false),
      ]),
      Question("قنبلة الو.م.أ في هيروشيما", [
        Answer("1945/08/06", true),
        Answer("1945/08/09", false),
        Answer("1946/12/06", false),
        Answer("1945/02/18", false),
      ]),
      Question("زوال الاتحاد السوفييتي", [
        Answer("1991/12/25", true),
        Answer("1991/07/01", false),
        Answer("1987/09/22", false),
        Answer("1990/12/15", false),
      ]),
      Question("تصفية حلف وارسو", [
        Answer("1991/07/01", true),
        Answer("1990/12/15", false),
        Answer("1977/11/02", false),
        Answer("1989/02/15", false),
      ]),
      Question("قنبلة الو.م.أ في ناكازاكي", [
        Answer("1945/08/09", true),
        Answer("1966/02/11", false),
        Answer("1945/01/02", false),
        Answer("1937/11/15", false),
      ]),
      Question("مؤتمر يالطا", [
        Answer("1945/02/04", true),
        Answer("1944/11/15", false),
        Answer("1945/05/20", false),
        Answer("1946/01/30", false),
      ]),
      Question("مؤتمر بوتسدام", [
        Answer("1945/08/02", true),
        Answer("1945/06/18", false),
        Answer("1945/09/10", false),
        Answer("1946/03/05", false),
      ]),
      Question("المصادقة على ميثاق الأمم المتحدة", [
        Answer("1945/06/26", true),
        Answer("1945/04/12", false),
        Answer("1945/08/15", false),
        Answer("1946/01/10", false),
      ]),
      Question("إنشاء الكوميكون", [
        Answer("1949/01/25", true),
        Answer("1948/11/03", false),
        Answer("1949/05/17", false),
        Answer("1950/02/08", false),
      ]),
      Question("تأسيس حلف الناتو", [
        Answer("1949/04/04", true),
        Answer("1948/09/12", false),
        Answer("1949/07/20", false),
        Answer("1950/03/15", false),
      ]),
      Question("تأسيس حلف جنوب شرق آسيا", [
        Answer("1954/09/08", true),
        Answer("1953/11/22", false),
        Answer("1954/12/01", false),
        Answer("1955/04/18", false),
      ]),
      Question("تأسيس حلف بغداد", [
        Answer("1955/02/24", true),
        Answer("1954/10/11", false),
        Answer("1955/05/30", false),
        Answer("1956/01/07", false),
      ]),
      Question("تأسيس حلف وارسو", [
        Answer("1955/05/14", true),
        Answer("1954/12/03", false),
        Answer("1955/08/22", false),
        Answer("1956/03/09", false),
      ]),
      Question("مبدأ ترومان", [
        Answer("1947/03/12", true),
        Answer("1946/11/25", false),
        Answer("1947/06/05", false),
        Answer("1948/01/18", false),
      ]),
      Question("قيام جمهورية ألمانيا الغربية", [
        Answer("1949/05/08", true),
        Answer("1948/10/14", false),
        Answer("1949/08/23", false),
        Answer("1950/02/01", false),
      ]),
      Question("قيام ألمانيا الشرقية", [
        Answer("1949/10/07", true),
        Answer("1949/07/15", false),
        Answer("1950/01/22", false),
        Answer("1950/04/11", false),
      ]),
      Question("إقامة جدار برلين", [
        Answer("1961/08/13", true),
        Answer("1960/11/27", false),
        Answer("1961/12/05", false),
        Answer("1962/03/19", false),
      ]),
      Question("اتفاقية سالت 1", [
        Answer("1972/05/26", true),
        Answer("1971/09/18", false),
        Answer("1972/08/10", false),
        Answer("1973/02/03", false),
      ]),
      Question("اتفاقية سالت 2", [
        Answer("1979/06/18", true), // Using "جانفي 1979" as January 1979
        Answer("1978/07/14", false),
        Answer("1979/04/22", false),
        Answer("1980/03/08", false),
      ]),
      Question("تهديم جدار برلين", [
        Answer("1989/11/09", true),
        Answer("1989/08/21", false),
        Answer("1990/01/15", false),
        Answer("1990/04/30", false),
      ]),
      Question("توحيد الألمانيتين", [
        Answer("1990/10/03", true),
        Answer("1990/07/18", false),
        Answer("1991/01/25", false),
        Answer("1991/05/09", false),
      ]),
      Question("مؤتمر باندونغ", [
        Answer("1955/04/18", true), // Using start date
        Answer("1954/11/30", false),
        Answer("1955/07/05", false),
        Answer("1956/02/12", false),
      ]),
      Question("اتفاقية بروتن وودز", [
        Answer("1944/07/22", true),
        Answer("1943/11/08", false),
        Answer("1944/10/15", false),
        Answer("1945/03/27", false),
      ]),
      Question("مشروع ايزنهاور", [
        Answer("1957/01/05", true),
        Answer("1956/09/20", false),
        Answer("1957/04/18", false),
        Answer("1958/02/03", false),
      ]),
      Question("زيارة نيكسون لموسكو", [
        Answer("1972/05/22", true),
        Answer("1971/11/14", false),
        Answer("1972/08/07", false),
        Answer("1973/02/19", false),
      ]),
      Question("زيارة بريجنيف للو.م.أ", [
        Answer("1973/07/09", true),
        Answer("1972/10/05", false),
        Answer("1971/09/22", false),
        Answer("1974/03/11", false),
      ]),
      Question("اتفاقية هلسنكي", [
        Answer("1975/08/01", true),
        Answer("1974/11/23", false),
        Answer("1975/12/09", false),
        Answer("1976/04/17", false),
      ]),
      Question("استقلال الهند ، بنغلادش و باكستان", [
        Answer("1947/08/15", true),
        Answer("1946/12/01", false),
        Answer("1949/11/23", false),
        Answer("1948/03/07", false),
      ]),
      Question("استقلال إندونيسيا", [
        Answer("1949", true),
        Answer("1948", false),
        Answer("1947", false),
        Answer("1950", false),
      ]),
      Question("مبدأ جدانوف", [
        Answer("1947/09/22", true),
        Answer("1947/04/08", false),
        Answer("1947/12/15", false),
        Answer("1948/02/29", false),
      ]),
      Question("وصول غورباتشوف للسلطة", [
        Answer(" مارس 1985", true),
        Answer(" سبتمبر 1984", false),
        Answer(" جوان 1985", false),
        Answer("سبتمبر 1986", false),
      ]),
      Question("تفجير أول قنبلة سوفييتية في سيبيريا", [
        Answer("1949/08/29", true),
        Answer("1948/11/12", false),
        Answer("1949/12/05", false),
        Answer("1950/03/18", false),
      ]),
      Question("انتصار الثورة الشيوعية في الصين", [
        Answer("1949/10/01", true),
        Answer("1949/05/14", false),
        Answer("1950/01/23", false),
        Answer("1950/07/09", false),
      ]),
      Question("وفاة ستالين و الدعوة للتعايش السلمي", [
        Answer("1953/03/05", true),
        Answer("1952/11/19", false),
        Answer("1953/07/22", false),
        Answer("1954/01/08", false),
      ]),
      Question("إطلاق سبوتنك أول قمر صناعي سوفييتي", [
        Answer("1957/10/04", true),
        Answer("1957/06/18", false),
        Answer("1958/01/29", false),
        Answer("1958/05/12", false),
      ]),
      Question("تدخل الاتحاد السوفييتي في أفغانستان", [
        Answer("1979/12/27", true),
        Answer("1971/08/15", false),
        Answer("1980/03/09", false),
        Answer("1980/06/22", false),
      ]),
      // Add these new questions to the existing list in the QuizManager initialization
      Question("قمة مالطا", [
        Answer("1989/12/03", true), // Using the start date
        Answer("1989/10/15", false),
        Answer("1990/01/22", false),
        Answer("1989/11/07", false),
      ]),
      Question("مشروع حرب النجوم", [
        Answer("1983/03/23", true), // Using a specific date in March 1983
        Answer("1982/11/10", false),
        Answer("1983/06/05", false),
        Answer("1984/01/17", false),
      ]),
      Question("خروج فرنسا من حلف الناتو", [
        Answer("1966/03/07", true), // Using a specific date in 1966
        Answer("1965/11/22", false),
        Answer("1966/07/14", false),
        Answer("1967/01/30", false),
      ]),
      Question("غاغارين يدور حول الأرض", [
        Answer("1961/04/12", true),
        Answer("1960/09/28", false),
        Answer("1961/07/20", false),
        Answer("1962/02/03", false),
      ]),
      Question("حل مكتب الكومنفورم", [
        Answer("1956/04/17", true),
        Answer("1955/12/01", false),
        Answer("1956/08/22", false),
        Answer("1957/01/09", false),
      ]),
      Question("مؤتمر التعاون الاقتصادي الدولي", [
        Answer("1975/12/16", true), // Using a specific date in December 1975
        Answer("1975/09/30", false),
        Answer("1976/03/05", false),
        Answer("1975/11/22", false),
      ]),
      Question("تأسيس جامعة الدول العربية", [
        Answer("1945/03/22", true),
        Answer("1944/11/07", false),
        Answer("1945/06/15", false),
        Answer("1946/01/30", false),
      ]),
      Question("وصول أرمسترونغ لسطح القمر", [
        Answer("1969/07/20", true),
        Answer("1968/12/05", false),
        Answer("1972/04/13", false),
        Answer("1970/01/28", false),
      ]),
      Question("قيام الو.م.أ بإنشاء جسر جوي لفك الحصار على برلين", [
        Answer("1948/06/28", true),
        Answer("1948/04/15", false),
        Answer("1948/09/10", false),
        Answer("1949/01/22", false),
      ]),
      Question("حصار الاتحاد السوفييتي لبرلين الغربية", [
        Answer("1948/06/23", true), // Using the start date
        Answer("1948/03/10", false),
        Answer("1948/09/05", false),
        Answer("1949/02/17", false),
      ]),
      Question("اندلاع الحرب الأهلية بين الكوريتين", [
        Answer("1950/06/25", true),
        Answer("1950/03/12", false),
        Answer("1950/09/08", false),
        Answer("1951/01/17", false),
      ]),
      Question("انتهاء الحرب الأهلية الكورية", [
        Answer("1953/07/27", true),
        Answer("1953/04/15", false),
        Answer("1953/10/09", false),
        Answer("1954/01/22", false),
      ]),
      Question("تأسيس حركة عدم الانحياز", [
        Answer("1961/09/01", true), // Using the start date
        Answer("1961/06/15", false),
        Answer("1961/11/22", false),
        Answer("1962/02/07", false),
      ]),
      Question("هيمنة الاتحاد السوفييتي على القسم الشمالي لكوريا", [
        Answer("1948/08/25", true),
        Answer("1948/05/10", false),
        Answer("1948/11/30", false),
        Answer("1949/02/14", false),
      ]),
      Question("الإعلان عن قيام الجمهورية الديمقراطية الكورية", [
        Answer("1948/09/09", true),
        Answer("1948/06/23", false),
        Answer("1948/12/01", false),
        Answer("1949/03/15", false),
      ]),
    ]),
    Unit('الوحدة الثانية', [
      Question("تأسيس حزب نجم شمال إفريقيا", [
        Answer("1926/06/20", true),
        Answer("1926/10/23", false),
        Answer("1927/03/11", false),
        Answer("1925/12/15", false),
      ]),
      Question("تأسيس حزب الشعب", [
        Answer("1937/03/11", true),
        Answer("1936/05/20", false),
        Answer("1937/06/15", false),
        Answer("1938/01/01", false),
      ]),
      Question("تأسيس حركة انتصار الحريات الديمقراطية", [
        Answer("1946/11/02", true),
        Answer("1946/09/15", false),
        Answer("1947/01/10", false),
        Answer("1945/12/25", false),
      ]),
      Question("دستور 1947", [
        Answer("1947/09/20", true),
        Answer("1947/07/15", false),
        Answer("1947/11/01", false),
        Answer("1948/01/01", false),
      ]),
      Question("إنشاء المنظمة الخاصة", [
        Answer("1947/02/15", true),
        Answer("1947/05/01", false),
        Answer("1947/09/20", false),
        Answer("1946/12/31", false),
      ]),
      Question("إنشاء اللجنة الثورية للوحدة والعمل", [
        Answer("1954/03/23", true),
        Answer("1954/01/15", false),
        Answer("1954/06/01", false),
        Answer("1953/12/31", false),
      ]),
      Question("اكتشاف المنظمة الخاصة", [
        Answer("1950/03/28", true),
        Answer("1950/02/15", false),
        Answer("1950/05/01", false),
        Answer("1949/12/31", false),
      ]),
      Question("اجتماع مجموعة 22", [
        Answer("1954/06/25", true),
        Answer("1954/05/15", false),
        Answer("1954/07/10", false),
        Answer("1954/04/01", false),
      ]),
      Question("اجتماع لجنة الستة", [
        Answer("1954/10/10", true),
        Answer("1954/09/01", false),
        Answer("1954/11/15", false),
        Answer("1954/08/20", false),
      ]),
      Question("كتابة بيان أول نوفمبر", [
        Answer("1954/10/24", true),
        Answer("1954/10/15", false),
        Answer("1954/11/01", false),
        Answer("1954/10/31", false),
      ]),
      Question("مؤتمر الصومام", [
        Answer("1956/08/20", true),
        Answer("1956/07/15", false),
        Answer("1956/09/01", false),
        Answer("1956/10/05", false),
      ]),
      Question("ميثاق طرابلس", [
        Answer("1962/05/27", true),
        Answer("1962/04/15", false),
        Answer("1962/06/10", false),
        Answer("1962/03/01", false),
      ]),
      Question("أزمة حركة الانتصار", [
        Answer("1953", true),
        Answer("1952", false),
        Answer("1954", false),
        Answer("1951", false),
      ]),
      Question("الانقلاب العسكري التصحيح الثوري", [
        Answer("1965/06/19", true),
        Answer("1965/05/01", false),
        Answer("1965/07/15", false),
        Answer("1965/04/30", false),
      ]),
      Question("تأسيس منظمة الوحدة الإفريقية", [
        Answer("1963/05/25", true),
        Answer("1963/04/15", false),
        Answer("1963/06/10", false),
        Answer("1963/03/01", false),
      ]),
      Question("بدأ مفاوضات إيفيان الأولى", [
        Answer("1961/05/20", true),
        Answer("1961/04/15", false),
        Answer("1961/06/01", false),
        Answer("1961/03/01", false),
      ]),
      Question("استفتاء تقرير المصير", [
        Answer("1962/07/01", true),
        Answer("1962/06/15", false),
        Answer("1962/07/15", false),
        Answer("1962/05/30", false),
      ]),
      Question("معركة وهران", [
        Answer("1958/08/01", true),
        Answer("1958/07/15", false),
        Answer("1958/08/15", false),
        Answer("1958/06/30", false),
      ]),
      Question("تأسيس الحكومة المؤقتة", [
        Answer("1958/09/19", true),
        Answer("1958/08/15", false),
        Answer("1958/10/01", false),
        Answer("1958/07/30", false),
      ]),
      Question("هجومات الشمال القسنطيني", [
        Answer("1955/08/20", true),
        Answer("1955/07/15", false),
        Answer("1955/09/01", false),
        Answer("1955/06/30", false),
      ]),
      Question("رئاسة ديغول للحكومة الفرنسية", [
        Answer("1958/06/01", true),
        Answer("1958/05/15", false),
        Answer("1958/06/15", false),
        Answer("1958/04/30", false),
      ]),
      Question("رئاسة ديغول للجمهورية الفرنسية", [
        Answer("1959/01/08", true),
        Answer("1958/12/15", false),
        Answer("1959/02/01", false),
        Answer("1958/11/30", false),
      ]),
      Question("مشروع قسنطينة", [
        Answer("1958/10/03", true),
        Answer("1958/09/15", false),
        Answer("1958/10/15", false),
        Answer("1958/08/30", false),
      ]),
      Question("اقتراح فرنسا للاستفتاء", [
        Answer("1959/09/16", true),
        Answer("1959/08/15", false),
        Answer("1959/10/01", false),
        Answer("1959/07/30", false),
      ]),
      Question("تأسيس حزب نجم شمال إفريقيا", [
        Answer("1958/10/23", true),
        Answer("1958/09/15", false),
        Answer("1958/11/01", false),
        Answer("1958/08/30", false),
      ]),
      Question("مفاوضات إيفيان الثانية", [
        Answer("من 07/03/1962 إلى 18/03/1962", true),
        Answer("من 01/03/1962 إلى 15/03/1962", false),
        Answer("من 10/03/1962 إلى 20/03/1962", false),
        Answer("من 05/03/1962 إلى 16/03/1962", false),
      ]),
      Question("فترة رئاسة أحمد بن بلة", [
        Answer("من 1962 إلى 19/06/1965", true),
        Answer("من 1962 إلى 15/06/1965", false),
        Answer("من 1963 إلى 19/06/1965", false),
        Answer("من 1962 إلى 19/06/1966", false),
      ]),
      Question("فترة رئاسة الهواري بومدين", [
        Answer("من 1965 إلى 27/12/1978", true),
        Answer("من 1965 إلى 27/12/1977", false),
        Answer("من 1966 إلى 27/12/1978", false),
        Answer("من 1965 إلى 27/12/1979", false),
      ]),
      Question("فترة رئاسة الشاذلي بن جديد", [
        Answer("من 07/02/1979 إلى 11/01/1992", true),
        Answer("من 07/02/1979 إلى 11/01/1991", false),
        Answer("من 07/02/1980 إلى 11/01/1992", false),
        Answer("من 07/02/1979 إلى 11/01/1993", false),
      ]),
      Question("إنشاء المجالس الشعبية البلدية", [
        Answer("1967", true),
        Answer("1966", false),
        Answer("1968", false),
        Answer("1965", false),
      ]),
      Question("إنشاء المجالس الشعبية الولائية", [
        Answer("1969", true),
        Answer("1968", false),
        Answer("1970", false),
        Answer("1967", false),
      ]),
      Question("ترأس الجزائر لمؤتمر حركة عدم الانحياز", [
        Answer("1973", true),
        Answer("1972", false),
        Answer("1974", false),
        Answer("1971", false),
      ]),
      Question("تأسيس الاتحاد العام للعمال الجزائريين", [
        Answer("1956/02/24", true),
        Answer("1956/01/15", false),
        Answer("1956/03/10", false),
        Answer("1955/12/31", false),
      ]),
      Question("القرصنة الجوية (اختطاف 5 مناضلين)", [
        Answer("1956/10/22", true),
        Answer("1956/09/15", false),
        Answer("1956/11/01", false),
        Answer("1956/08/30", false),
      ]),
      Question("قنبلة ساقية سيدي يوسف (تونس)", [
        Answer("1958/02/08", true),
        Answer("1958/01/15", false),
        Answer("1958/03/01", false),
        Answer("1957/12/31", false),
      ]),
      Question("بداية إضراب الثمانية أيام", [
        Answer("1957/01/28", true),
        Answer("1957/01/15", false),
        Answer("1957/02/01", false),
        Answer("1956/12/31", false),
      ]),
      Question("بداية مؤتمر باندونغ", [
        Answer("1955/04/18", true),
        Answer("1955/03/15", false),
        Answer("1955/05/01", false),
        Answer("1955/02/28", false),
      ]),
      Question("مظاهرات شعبية في الجزائر", [
        Answer("1960/12/11", true),
        Answer("1960/11/15", false),
        Answer("1960/12/25", false),
        Answer("1960/10/31", false),
      ]),
      Question("مظاهرات المهاجرين في فرنسا", [
        Answer("1961/10/17", true),
        Answer("1961/09/15", false),
        Answer("1961/11/01", false),
        Answer("1961/08/31", false),
      ]),
      Question("محادثات مولان", [
        Answer("1960/06/27", true),
        Answer("1960/05/15", false),
        Answer("1960/07/10", false),
        Answer("1960/04/30", false),
      ]),
      Question("لقاء لوسيرن بسويسرا", [
        Answer("1961/02/20", true),
        Answer("1961/01/15", false),
        Answer("1961/03/01", false),
        Answer("1960/12/31", false),
      ]),
      Question("محاولة العسكريين للانقلاب", [
        Answer("1962/04/22", true),
        Answer("1962/03/15", false),
        Answer("1962/05/01", false),
        Answer("1962/02/28", false),
      ]),
      Question("الإعلان عن قيام الجمهورية الجزائرية", [
        Answer("1962/09/26", true),
        Answer("1962/08/15", false),
        Answer("1962/10/01", false),
        Answer("1962/07/31", false),
      ]),
      Question("تمرد الجيش الفرنسي بقيادة ساسو", [
        Answer("1958/05/13", true),
        Answer("1958/04/15", false),
        Answer("1958/06/01", false),
        Answer("1958/03/31", false),
      ]),
      Question("إضراب الطلبة الجزائريين", [
        Answer("1956/05/19", true),
        Answer("1956/04/15", false),
        Answer("1956/06/01", false),
        Answer("1956/03/31", false),
      ]),
      Question("اعتراف ديغول باستقلال الجزائر", [
        Answer("1962/07/03", true),
        Answer("1962/06/15", false),
        Answer("1962/07/15", false),
        Answer("1962/05/31", false),
      ]),
      Question("إعلان حالة الطوارئ في الجزائر", [
        Answer("1955/04/03", true),
        Answer("1955/03/15", false),
        Answer("1955/05/01", false),
        Answer("1955/02/28", false),
      ]),
      Question("استعادة جمعية العلماء المسلمين نشاطها", [
        Answer("1946/07/21", true),
        Answer("1946/06/15", false),
        Answer("1946/08/01", false),
        Answer("1946/05/31", false),
      ]),
    ]),
    Unit('الوحدة الثالثة', [
      Question("تأميم قناة السويس", [
        Answer("1956/07/26", true),
        Answer("1956/06/15", false),
        Answer("1956/08/10", false),
        Answer("1956/05/30", false),
      ]),
      Question("العدوان الثلاثي على مصر", [
        Answer("1956/10/29", true),
        Answer("1956/09/15", false),
        Answer("1956/11/10", false),
        Answer("1956/08/30", false),
      ]),
      Question("معركة ديان بيان فو", [
        Answer("من 13/03/1954 إلى 07/05/1954", true),
        Answer("من 13/02/1954 إلى 07/04/1954", false),
        Answer("من 13/04/1954 إلى 07/06/1954", false),
        Answer("من 13/01/1954 إلى 07/03/1954", false),
      ]),
      Question("قيام الثورة المصرية (الانقلاب)", [
        Answer("1952/07/23", true),
        Answer("1952/06/15", false),
        Answer("1952/08/10", false),
        Answer("1952/05/30", false),
      ]),
      Question("الحرب العربية الإسرائيلية", [
        Answer("1973/10/06", true),
        Answer("1973/09/15", false),
        Answer("1973/11/01", false),
        Answer("1973/08/30", false),
      ]),
      Question("قرار وقف إطلاق النار بين العرب و إسرائيل", [
        Answer("1973/10/22", true),
        Answer("1973/10/15", false),
        Answer("1973/11/01", false),
        Answer("1973/09/30", false),
      ]),
      Question("تأسيس الحركة الصهيونية", [
        Answer("1897", true),
        Answer("1896", false),
        Answer("1898", false),
        Answer("1895", false),
      ]),
      Question("انطلاق الثورة الكوبية", [
        Answer("1958", true),
        Answer("1957", false),
        Answer("1959", false),
        Answer("1956", false),
      ]),
      Question("إطلاق سراح فيدال كاسترو", [
        Answer("1955", true),
        Answer("1954", false),
        Answer("1956", false),
        Answer("1953", false),
      ]),
      Question("دخول الثوريين هافانا (كوبا)", [
        Answer("1959", true),
        Answer("1958", false),
        Answer("1960", false),
        Answer("1957", false),
      ]),
      Question("توقيع اتفاقية الجلاء كامب ديفيد", [
        Answer("1978/09/17", true),
        Answer("1978/08/15", false),
        Answer("1978/10/01", false),
        Answer("1978/07/30", false),
      ]),
      Question("معاهدة السلام بين مصر و إسرائيل", [
        Answer("1979/03/26", true),
        Answer("1979/02/15", false),
        Answer("1979/04/10", false),
        Answer("1979/01/30", false),
      ]),
      Question("الهجوم الإسرائيلي على القوات المصرية في غزة و سيناء", [
        Answer("1956/10/29", true),
        Answer("1956/09/15", false),
        Answer("1956/11/10", false),
        Answer("1956/08/30", false),
      ]),
      Question("بداية الاستعمار الفرنسي للفيتنام", [
        Answer("1858", true),
        Answer("1857", false),
        Answer("1859", false),
        Answer("1856", false),
      ]),
      Question("استيلاء موبوتو على الحكم", [
        Answer("1965/01/24", true),
        Answer("1964/12/15", false),
        Answer("1965/02/10", false),
        Answer("1964/11/30", false),
      ]),
      Question("إعلان النظام الجمهوري في مصر", [
        Answer("1953/01/18", true),
        Answer("1952/12/15", false),
        Answer("1953/02/10", false),
        Answer("1952/11/30", false),
      ]),
      Question("مذبحة دير ياسين", [
        Answer("1949/04/19", true),
        Answer("1949/03/15", false),
        Answer("1949/05/01", false),
        Answer("1949/02/28", false),
      ]),
      Question("الغارات الجوية الإسرائيلية على المطارات المصرية", [
        Answer("1967/06/05", true),
        Answer("1967/05/15", false),
        Answer("1967/07/01", false),
        Answer("1967/04/30", false),
      ]),
      Question("زيارة أنور السادات للقدس", [
        Answer("1977/11/19", true),
        Answer("1977/10/15", false),
        Answer("1977/12/01", false),
        Answer("1977/09/30", false),
      ]),
      Question("إعلان هو شي منه استقلال دولته (فيتنام الشمالية)", [
        Answer("سبتمبر 1945", true),
        Answer("أغسطس 1945", false),
        Answer("أكتوبر 1945", false),
        Answer("يوليو 1945", false),
      ]),
      Question("بداية الحرب الفيتنامية ضد فرنسا", [
        Answer("1946", true),
        Answer("1945", false),
        Answer("1947", false),
        Answer("1944", false),
      ]),
      Question("انهزام الو.م.أ ضد الفيتنام", [
        Answer("1973/01/27", true),
        Answer("1972/12/15", false),
        Answer("1973/02/10", false),
        Answer("1972/11/30", false),
      ]),
      Question("توحيد الفيتنام", [
        Answer("1975/04/30", true),
        Answer("1975/03/15", false),
        Answer("1975/05/15", false),
        Answer("1975/02/28", false),
      ]),
      Question("بداية الاستعمار البريطاني للهند", [
        Answer("1857", true),
        Answer("1856", false),
        Answer("1858", false),
        Answer("1855", false),
      ]),
      Question("استقلال الهند", [
        Answer("1947/08/15", true),
        Answer("1947/07/01", false),
        Answer("1947/09/01", false),
        Answer("1947/06/15", false),
      ]),
      Question("انفصال الهند و باكستان", [
        Answer("1965", true),
        Answer("1964", false),
        Answer("1966", false),
        Answer("1963", false),
      ]),
      Question("انفصال باكستان و بنغلادش", [
        Answer("1971", true),
        Answer("1970", false),
        Answer("1972", false),
        Answer("1969", false),
      ]),
      Question("ظهور تنظيم الضباط الأحرار", [
        Answer("1948", true),
        Answer("1947", false),
        Answer("1949", false),
        Answer("1946", false),
      ]),
      Question("نجاح كاسترو في الإطاحة بنظام الحكم", [
        Answer("1959", true),
        Answer("1958", false),
        Answer("1960", false),
        Answer("1957", false),
      ]),
      Question("مؤتمر جنيف المتعلق بالهند الصينية", [
        Answer("1954/07/20", true),
        Answer("1954/06/15", false),
        Answer("1954/08/10", false),
        Answer("1954/05/30", false),
      ]),
      Question("خضوع مصر للاحتلال البريطاني", [
        Answer("1881", true),
        Answer("1880", false),
        Answer("1882", false),
        Answer("1879", false),
      ]),
      Question("قصف بورسعيد من طرف فرنسا و بريطانيا", [
        Answer("1956/11/05", true),
        Answer("1956/10/15", false),
        Answer("1956/11/20", false),
        Answer("1956/09/30", false),
      ]),
      Question("قيام منظمة الفرنكفونية", [
        Answer("1970/03/20", true),
        Answer("1970/02/15", false),
        Answer("1970/04/10", false),
        Answer("1970/01/30", false),
      ]),
      Question("قيام جمهورية الكونغو", [
        Answer("1885/08/01", true),
        Answer("1885/07/15", false),
        Answer("1885/08/15", false),
        Answer("1885/06/30", false),
      ]),
      Question("تأسيس منظمة التحرير الفلسطينية", [
        Answer("1964/05/28", true),
        Answer("1964/04/15", false),
        Answer("1964/06/10", false),
        Answer("1964/03/30", false),
      ]),
      Question("معركة الكرامة", [
        Answer("1968/03/21", true),
        Answer("1968/02/15", false),
        Answer("1968/04/10", false),
        Answer("1968/01/30", false),
      ]),
      Question("مجازر صبرا و شاتيلا", [
        Answer("1982/09/18", true),
        Answer("1982/08/15", false),
        Answer("1982/10/01", false),
        Answer("1982/07/30", false),
      ]),
    ])
    // Add more units here if needed
  ]),
  Quiz("شخصيات", [
    Unit('الوحدة الأولى', [
      Question(
          "رئيس الوزراء (1945، 1953)، الأكثر شعبية وديمقراطية ومؤيد للهجرة اليهودية إلى فلسطين منفجر الحرب الباردة بإعلانه لسياسة الاحتواء المتمثلة في تقديم الدعم العسكري والاقتصادي للدول غير الشيوعية والتي تطورت إلى سياسة ملء الفراغ خارج أوربا (المبدأ الشهير)، صاحب مبدأ ترومان 1947.",
          [
            Answer("هاري ترومان", true),
            Answer("جوزيف ستالين", false),
            Answer("أندري جدانوف", false),
          ]),
      Question(
          "رجل دولة سوفيتي قاد الاتحاد من 1924-1953 حاملاً معه القوة الثانية عالمياً بعد ح ع II، تميزت فترة حكمه بالزعامة والتشدد في نظر الغرب واجه المخططات الأمريكية بمخططات مضادة، حرر أوروبا الشرقية من النازية.",
          [
            Answer("جوزيف ستالين", true),
            Answer("هاري ترومان", false),
            Answer("أندري جدانوف", false),
          ]),
      Question(
          "رجل سياسي سوفيتي صاحب أطروحة (الكتلتين) (الكتلة الشرقية، الكتلة الغربية)، من الذين ساهموا في التشدد الأيديولوجي في الاتحاد السوفيتي، مهندس الخطة الخماسية (1939) وصاحب المشروع المعروف باسمه.",
          [
            Answer("أندري جدانوف", true),
            Answer("نيكيتا خروتشوف", false),
            Answer("جون كينيدي", false),
          ]),
      Question(
          "رئيس للو.م.أ (1961، 1963) على المستوى الداخلي أعلن عن سياسة الأفاق الجديدة والتي تهدف إلى تحسين أوضاع السود ومحاربة الفقر المدقع، والتي يرجع أنها كانت السبب الأساسي في اغتياله، شهدت فترة حكمه أزمة الصواريخ في كوبا 1962.",
          [
            Answer("جون كينيدي", true),
            Answer("نيكيتا خروتشوف", false),
            Answer("رونالد ريغن", false),
          ]),
      Question(
          "رجل سياسي سوفيتي خليفة ستالين صاحب مبادرة التعايش السلمي وأول رئيس سوفيتي يزور الو.م.أ، ربما حدثت في عهده عدة أزمات أخطرها أزمة الصواريخ في كوبا 1962، أحد قيادات التروبكا.",
          [
            Answer("نيكيتا خروتشوف", true),
            Answer("ميخائيل غورباتشوف", false),
            Answer("رونالد ريغن", false),
          ]),
      Question(
          "الرئيس الأربعون للو.م.أ (1981-1989) مؤسس التيار المحافظ المعتمد على فكرة استعادة أمجاد و قيم المجتمع الأمريكي انتهج سياسة خارجية متشددة في 1983 أطلق ما عرف بمبادرة الدفاع الاستراتيجي ضد الاتحاد السوفيتي - حرب النجوم -.",
          [
            Answer("رونالد ريغن", true),
            Answer("ريتشارد نيكسون", false),
            Answer("فرانكلين روزفلت", false),
          ]),
      Question(
          "رئيس الولايات المتحدة الأمريكية خلال الحرب العالمية الثانية (1939-1945)، الوحيد الذي تولى الرئاسة لثلاث عهدات، كان له الفضل في حل أزمة 1929.",
          [
            Answer("فرانكلين روزفلت", true),
            Answer("ريتشارد نيكسون", false),
            Answer("جورج مارشال", false),
          ]),
      Question(
          "آخر رئيس للاتحاد منذ مارس 1985، اشتهر بسياسة البيروسترويكا والغلاسنوست يعتبر في الغرب الصانع الحقيقي لسياسة الوفاق الدولي منح جائزة نوبل للسلام 1990، وقع العديد من الاتفاقيات التي ستؤدي إلى إنهاء الحرب الباردة، تفكيك السوفيات خلال مرحلة حكمه.",
          [
            Answer("ميخائيل غورباتشوف", true),
            Answer("ليونيد بريجنيف", false),
            Answer("جورج بوش الأب", false),
          ]),
      Question(
          "رجل دولة وبرلماني سوفيتي خلف خروتشوف على رأس الاتحاد السوفيتي اشتهر بالمبدأ المعروف باسمه (مبدأ بريجنيف) كان وراءه الحد من التدخلات العسكرية السوفيتية في الخارج مثل: ربيع براغ 1968، ودعم الثوار الماركسيين في العالم ، غزو أفغانستان ...",
          [
            Answer("ليونيد بريجنيف", true),
            Answer("ميخائيل غورباتشوف", false),
            Answer("جورج مارشال", false),
          ]),
      Question(
          "جنرال ورجل سياسة أمريكي، رئيس الأركان أثناء ح ع II، كاتب للدولة (وزير) بين 1947- 1949 كان المستشار العسكري لروزفلت حيث وضع خطة دعم أوربا المعروف بالمشروع الذي سمي باسمه. نال جائزة نوبل للسلام بعد نهاية الحرب الكبرى 1953.",
          [
            Answer("جورج مارشال", true),
            Answer("جورج بوش الأب", false),
            Answer("ونستون تشرشل", false),
          ]),
      Question(
          "رئيس الولايات المتحدة الأمريكية، وقع مع الزعيم السوفياتي غورباتشوف اتفاقيات التعاون والإعلان عن نهاية الحرب الباردة، أعلن عن النظام العالمي الجديد، ثم قاد غزو العراق 1993.",
          [
            Answer("جورج بوش الأب", true),
            Answer("أيزنهاور", false),
            Answer("جوزيف بروز تيتو", false),
          ]),
      Question(
          "رئيس الولايات المتحدة الأمريكية من 1953 - 1961 أول قائد لقوات الحلف الأطلسي 1949، حدثت في فترة حكمه أزمة كوريا 1950-1953 ونجح في إنهاء الأزمة، صاحب مشروع إيزنهاور للاستعمار في الشرق الأوسط.",
          [
            Answer("أيزنهاور", true),
            Answer("ونستون تشرشل", false),
            Answer("جواهر لال نهرو", false),
          ]),
      Question(
          "رئيس وزراء بريطانيا للفترتين 1940-1955 ساهم في صمود بلاده أمام ألمانيا النازية خلال الحرب ع 2، وهو صاحب مصطلح الستار الحديدي للدلالة على انقسام أوروبا إلى معسكرين.",
          [
            Answer("ونستون تشرشل", true),
            Answer("أيزنهاور", false),
            Answer("جوزيف بروز تيتو", false),
          ]),
      Question(
          "ثوري وعسكري ورجل دولة يوغسلافي شغل العديد من المناصب منذ 1943، قاده للثورة خلال الحرب العالمية الثانية، زعيم الحزب الشيوعي اليوغسلافي، من مؤسسي حركة عدم الانحياز وداعمي حركات التحرر في العالم.",
          [
            Answer("جوزيف بروز تيتو", true),
            Answer("جواهر لال نهرو", false),
            Answer("ونستون تشرشل", false),
          ]),
      Question(
          "رجل سياسة هندي تلميذ غاندي رئيس المؤتمر الوطني الهندي منذ 1929، واحد من صانعي استقلال الهند، شغل منصب الوزير الأول (1947-1964) كان من أقطاب عدم الانحياز حيث لعب الأدوار الأولى خلال انعقاد مؤتمر باندونغ 1955.",
          [
            Answer("جواهر لال نهرو", true),
            Answer("جوزيف بروز تيتو", false),
            Answer("ونستون تشرشل", false),
          ]),
    ]),
    Unit("الوحدة الثانية", [
      Question(
        "سياسي جزائري زعيم التيار الاستقلالي مؤسس نجم شمال إفريقيا ثم حزب الشعب و حركة الإنتصار للحريات الديمقراطية.",
        [
          Answer("مصالي الحاج", true),
          Answer("فرحات عباس", false),
          Answer("أحمد بن بلة", false),
        ],
      ),
      Question(
        "سياسي جزائري أول رئيس للحكومة المؤقتة 1958 أحد قادة التيار الإدماجي شارك في صياغة بيان فيفري 1943 أسس الاتحاد الديمقراطي للبيان الجزائري.",
        [
          Answer("فرحات عباس", true),
          Answer("يوسف بن خدة", false),
          Answer("زيغود يوسف", false),
        ],
      ),
      Question(
        "شخصية جزائرية وطنية رئيس الحكومة المؤقتة الجزائرية مناضل في حزب الشعب و حركة الإنتصار للحريات الديمقراطية.",
        [
          Answer("يوسف بن خدة", true),
          Answer("حسين آيت أحمد", false),
          Answer("محمد خيضر", false),
        ],
      ),
      Question(
        "شهيد جزائري مناضل في حزب الشعب و عضو في المنظمة الخاصة و اللجنة الثورية للوحدة و العمل من مفجري الثورة نظم هجوم الشمال القسنطيني 20 أوت 1955.",
        [
          Answer("زيغود يوسف", true),
          Answer("عبان رمضان", false),
          Answer("محمد بلوزداد", false),
        ],
      ),
      Question(
        "سياسي جزائري و أحد قادة الثورة الجزائرية في جبهة التحرير الوطني، منظم للصفوف حزب الشعب و عضو في المنظمة الخاصة.",
        [
          Answer("حسين آيت أحمد", true),
          Answer("محمد خيضر", false),
          Answer("العربي بن مهيدي", false),
        ],
      ),
      Question(
        "سياسي جزائري و أحد قادة الثورة الجزائرية منظم صفوف نجم شمال إفريقيا ثم حزب الشعب الجزائري أصبح مندوبا لحركة انتصار الحريات الديمقراطية أحد عناصر المنظمة الخاصة.",
        [
          Answer("محمد خيضر", true),
          Answer("عبان رمضان", false),
          Answer("مصطفى بن بولعيد", false),
        ],
      ),
      Question(
        "مجاهد جزائري منظم لحزب الشعب و عضو في المنظمة الخاصة و مخطط لمؤتمر الصومام 1956 أحد مفجري الثورة.",
        [
          Answer("عبان رمضان", true),
          Answer("محمد بلوزداد", false),
          Answer("أحمد بن بلة", false),
        ],
      ),
      Question(
        "شخصية ثورية جزائرية و أحد مهندسي ثورة نوفمبر 1954 أول قائد للمنظمة الخاصة منظم للصفوف حزب الشعب الجزائري و عضو في المنظمة السرية.",
        [
          Answer("محمد بلوزداد", true),
          Answer("العربي بن مهيدي", false),
          Answer("كريم بلقاسم", false),
        ],
      ),
      Question(
        "أول رئيس للجزائر المستقلة مناضل في حزب الشعب و حركة الانتصار للحريات الديمقراطية و كان على رأس المنظمة الخاصة و من مفجري الثورة التحريرية.",
        [
          Answer("أحمد بن بلة", true),
          Answer("هواري بومدين", false),
          Answer("رابح بيطاط", false),
        ],
      ),
      Question(
        "أحد شهداء الثورة الجزائرية هو شخصية أحد البارزين في لجنة الستة قائد المنطقة الخامسة من مهندسي مؤتمر الصومام 1956 منظم لصفوف حزب الشعب الجزائري و من مفجري الثورة.",
        [
          Answer("العربي بن مهيدي", true),
          Answer("ديدوش مراد", false),
          Answer("عميروش", false),
        ],
      ),
      Question(
          "شهيد جزائري ناضل في صفوف حزب الشعب الجزائري ثم المنظمة الخاصة ثم اللجنة الثورية للوحدة والعمل و عضو في لجنة 22 ومجموعة 06 من مفجري الثورة وقائد المنطقة الأولى الأوراس",
          [
            Answer("مصطفى بن بولعيد", true),
            Answer("محمد بوضياف", false),
            Answer("كريم بلقاسم", false),
          ]),
      Question(
          "شخصية جزائرية مناضل في حزب الشعب ثم حركة انتصار الحريات الديمقراطية عضو بالمنظمة الخاصة قاد اللجنة الثورية للوحدة والعمل عضو في مجموعة 22 منسق بين الداخل و الخارج وأحد مفجري الثورة",
          [
            Answer("محمد بوضياف", true),
            Answer("مصطفى بن بولعيد", false),
            Answer("ديدوش مراد", false),
          ]),
      Question(
          "أحد شهداء الثورة الجزائرية كان عضو في حزب الشعب، المنظمة الخاصة، اللجنة الثورية للوحدة و العمل، مجموعة 22، مجموعة الست، قائد المنطقة الثانية",
          [
            Answer("ديدوش مراد", true),
            Answer("محمد بوضياف", false),
            Answer("كريم بلقاسم", false),
          ]),
      Question(
          "مجاهد جزائري و قائد تاريخي في جبهة التحرير الوطني أثناء الثورة الجزائرية انخرط في صفوف حزب الشعب كان أحد مفجريها وشارك في الاجتماعات التي سبقت الثورة و هو عضو في مجموعة 6 قاد العمليات في منطقة القبائل",
          [
            Answer("كريم بلقاسم", true),
            Answer("رابح بيطاط", false),
            Answer("هواري بومدين", false),
          ]),
      Question(
          "رجل سياسي جزائري ناضل في صفوف حركة الانتصار للحريات الديمقراطية عضو في اللجنة الثورية للوحدة والعمل و هو عضو في مجموعة 22 تولى رئاسة المجلس الشعبي الوطني",
          [
            Answer("رابح بيطاط", true),
            Answer("كريم بلقاسم", false),
            Answer("هواري بومدين", false),
          ]),
      Question(
          "مناضل و رجل دولة جزائري قائد الولاية الخامسة ثم قائد الأركان. وزير للدفاع بعد استقلال الجزائر. نظم العملية التي أطاحت ببن بلة والتي حملت اسم التصحيح الثوري في 19 جوان 1965. و أصبح رئيسا للدولة اشتهر بنشاطه في إطار حركة عدم الانحياز و أحد أقطابها",
          [
            Answer("هواري بومدين", true),
            Answer("رابح بيطاط", false),
            Answer("عميروش", false),
          ]),
      Question(
          "سياسي و عسكري جزائري مناضل في الحركة الوطنية عضو في المنظمة السرية مسؤول ناحية الصومام ثم قائد الولاية الثالثة سنة 1957",
          [
            Answer("عميروش", true),
            Answer("هواري بومدين", false),
            Answer("الحواس", false),
          ]),
      Question(
          "هو مناضل و ثوري جزائري عضو في حركة الإنتصار للحريات الديمقراطية و شارك في مؤتمر الصومام 1956 و هو من مفجري الثورة الجزائرية و قاد الولاية 6 ساهم في نقل الثورة إلى الصحراء",
          [
            Answer("الحواس", true),
            Answer("عميروش", false),
            Answer("شارل ديغول", false),
          ]),
      Question(
          "سياسي وجنرال ورجل دولة فرنسي، تزعم مقاومة الاحتلال الألماني لفرنسا أثناء الحرب ع 2. مؤسس الجمهورية الفرنسية الخامسة عام 1958 بعد أحداث 13 ماي حيث تميزت سياسته بالخبث و جمعت بين القمع والإغراء ومحاولة اختراق صفوف الثورة وقع هذا الأخير اتفاقيات ايفيان مع جبهة التحرير الوطني",
          [
            Answer("شارل ديغول", true),
            Answer("جاك سوستال", false),
            Answer("منداس فرانس", false),
          ]),
      Question(
          "سياسي فرنسي عين واليا عاما على الجزائر في 1955 وهو صاحب مشروع سوستال نصب نفسه مدافعا عن الجزائر الفرنسية و سياسة الإدماج عينه ديغول سنة 1958 بوزارة الإعلام ثم الوزارة المنتدبة للصحراء",
          [
            Answer("جاك سوستال", true),
            Answer("شارل ديغول", false),
            Answer("منداس فرانس", false),
          ]),
      Question(
          "سياسي فرنسي تولى رئاسة حكومة بلاده في 1954 فشل في مواجهة الثورة الجزائرية سقطت حكومته في 1955",
          [
            Answer("منداس فرانس", true),
            Answer("جاك سوستال", false),
            Answer("شارل موريس", false),
          ]),
      Question(
          "سياسي و جنرال فرنسي إستدعاه (ديغول) لقيادة الجيش الفرنسي بالجزائر 1959، صاحب فكرة الخطوط المكهربة على الحدود الغربية و الشرقية للجزائر، مع بداية المفاوضات الجزائرية الفرنسية إنقلب على ديغول 22 افريل 1961",
          [
            Answer("شارل موريس", true),
            Answer("منداس فرانس", false),
            Answer("جاك سوستال", false),
          ])
    ]),
    Unit('الوحدة الثالثة', [
      Question(
          "أحد كبار القادة السياسيين في القرن 20 ، ساهم في تحرير الهند ، مهندس فلسفة اللاعنف اشتهر بلقب المهاتما بعد استقلال الهند ، يعتبر من زعماء حركة عدم الانحياز والعالم الثالث.",
          [
            Answer("غاندي", true),
            Answer("نهرو", false),
            Answer("مانديلا", false),
          ]),
      Question(
          "أحد مؤسسي منظمة الضباط الأحرار وزعيم الثورة في مصر ، رئيس الجمهورية المصرية 1954-1970 مؤمم قناة السويس 1956 ، من مؤسسي حركة عدم الانحياز 1961 والشخصيات البارزة في العالم الثالث ومدعمي حركات التحرر.",
          [
            Answer("جمال عبد الناصر", true),
            Answer("أنور السادات", false),
            Answer("محمد نجيب", false),
          ]),
      Question(
          "1889 -1964 زعيم سياسي هندي رئيس وزراء الهند 1947-1964 ، من مؤسسي حركة عدم الانحياز 1961 ومدعمي حركات التحرر في العالم.",
          [
            Answer("جواهر لال نهرو", true),
            Answer("غاندي", false),
            Answer("إنديرا غاندي", false),
          ]),
      Question(
          "1928 -1967 أرجنتيني الأصل ، من مناضلي الحركات الثورية في أمريكا اللاتينية ، قائد الثورة الكوبية إلى جانب كاسترو شارك في ثورات عدة بأمريكا الجنوبية وإفريقيا ، اغتيل ببوليفيا.",
          [
            Answer("تشي غيفارا", true),
            Answer("فيدل كاسترو", false),
            Answer("سيمون بوليفار", false),
          ]),
      Question(
          "سياسي فيتنامي ، قائد الحركة التحررية في الهند الصينية ضد الاستعمار الفرنسي والأمريكي ، مؤسس الحزب الشيوعي الفيتنامي 1931، أسس جمهورية فيتنام الشمالية بعد الاستقلال.",
          [
            Answer("هوشي منه", true),
            Answer("فو نغوين جياب", false),
            Answer("نغو دينه ديم", false),
          ]),
      Question(
          "الجنرال جياب: عسكري فيتنامي ، وقائد القوات الفيتنامية في معركة ديان بيان فو ضد القوات الفرنسية عام 1954 قاوم بعدها الاحتلال الأمريكي للمنطقة 1964-1973.",
          [
            Answer("الجنرال جياب", true),
            Answer("هوشي منه", false),
            Answer("نغوين فان ثيو", false),
          ]),
      Question(
          "قائد كفاح شعبه من أجل الاستقلال، أول رئيس لأندونيسيا المستقلة، ترأس مؤتمر باندونغ 1955، من أبرز مؤسسي حركة عدم الانحياز 1961 وشخصيات العالم العالم الثالث.",
          [
            Answer("أحمد سوكارنو", true),
            Answer("محمد هاتا", false),
            Answer("سوهارتو", false),
          ]),
      Question(
          "مناضل وثوري باكستاني ناضل في إطار الرابطة الإسلامية لتحرير شبه القارة الهندية من الوجود البريطاني، كان شريكا لجانب غاندي ونهرو و من أجل إقامة دولة مستقلة للهنود المسلمين عن الهندوس، شغل منصب رئيس باكستان منذ استقلالها عام 1947",
          [
            Answer("محمد علي جناح", true),
            Answer("لياقت علي خان", false),
            Answer("محمد علي بوغرا", false),
          ]),
      Question(
          "سياسي فلسطيني ومن رموز النضال الفلسطيني من أجل الاستقلال، قاد حركة فتح عام 1969 أحد مؤسسي منظمة التحرير الفلسطينية وترأسها بعد الشقيري، رئيس السلطة الوطنية الفلسطينية 1994، حاصل على جائزة نوبل للسلام عام 1994 توفي في ظروف غامضة في نوفمبر 2004",
          [
            Answer("ياسر عرفات", true),
            Answer("محمود عباس", false),
            Answer("أحمد الشقيري", false),
          ]),
      Question(
          "من الشخصيات اليهودية ذات الأصول الروسية ، رجل سياسي إسرائيلي لعب دورا خطيرا في تأسيس دولة الاحتلال الإسرائيلي ، عين رئيسا للوزراء ، مؤسس ومتزعم الحركة الصهيونية.",
          [
            Answer("مناحم بيغن", true),
            Answer("ديفيد بن غوريون", false),
            Answer("غولدا مائير", false),
          ]),
      Question(
          "ثالث رئيس للجمهورية المصرية، انضم إلى حركة الضباط الأحرار ضد نظام الملك فاروق ، تقلد العديد من المناصب ، شهدت فترة حكمه توقيع معاهدة كامب ديفيد للسلام بهدف استرجاع سيناء المحتلة بعد نكسة 1967 ، لذلك تحصل على جائزة نوبل للسلام .",
          [
            Answer("أنور السادات", true),
            Answer("جمال عبد الناصر", false),
            Answer("حسني مبارك", false),
          ]),
      Question(
          "سياسي إسرائيلي وجنرال عسكري سابق في الجيش الإسرائيلي ورئيس وزراء إسرائيل، يعد من أبرز الشخصيات الإسرائيلية وأحد أشهر متخذي القرارات في الشؤون الخارجية والعسكرية والأمنية في إسرائيل ، ويعتبر أبرز الشخصيات التي بحثت في إمكانية الحروب العربية الإسرائيلية ، ومعاهدات السلام المزعومة .",
          [
            Answer("إسحاق رابين", true),
            Answer("شمعون بيريز", false),
            Answer("أرييل شارون", false),
          ]),
      Question(
          "زعيم ثوري كوبي أطاح بنظام باتيستا وأصبح رئيسا لكوبا سنة 1959 واجه الهيمنة الأمريكية بكوبا وشهدت فترة أزمة الصواريخ 1963 تخلى عن السلطة لأسباب صحية .",
          [
            Answer("فيدال كاسترو", true),
            Answer("تشي غيفارا", false),
            Answer("راؤول كاسترو", false),
          ]),
      Question(
          "رجل دولة وسياسي كوبي ، رئيس كوبا ، عرف نظامه بمعاداة مفتاح الإمبريالية الأمريكية ، تأثر بأفكار الضباط العسكريين بقيادة كاسترو وأنجزوا حكمه ، وتعهد كاسترو الحكم من محله .",
          [
            Answer("فولغنسيو باتيستا", true),
            Answer("راؤول كاسترو", false),
            Answer("أوسفالدو دورتيكوس", false),
          ]),
    ])
  ]),
  Quiz('مصطلحات التاريخ', [
    Unit('الوحدة الأولى', [
      Question(
          "صراع ايديولوجي بين املعسكرين الشرقي بزعامة االتحاد السوفياتي والغربي بزعامة الواليات املتحدة االمريكية 1945-1989، استعملت فيه كل الوسائل باستثناء الحرب املباشرة بين العمالقين.",
          [
            Answer("الحرب الباردة", true),
            Answer("الصراع الأيديولوجي", false),
            Answer("سباق التسلح", false),
          ]),
      Question(
          "سياسة اتبعتها الواليات بهدف منع انتشار وتوسع نفوذ االتحاد السوفياتي في العالم اثناء الحرب الباردة عن طريق املشاريع االقتصادية واألحالف العسكرية.",
          [
            Answer("سياسة التطويق", true),
            Answer("سياسة الاحتواء", false),
            Answer("سياسة الردع", false),
          ]),
      Question(
          "أسلوب اتبعته بعض الدول الغربية بهدف إعادة فرض الهيمنة بشتى الوسائل على دول العالم الثالث (استعمال الضغط االقتصادي، املنظمات غير الحكومية، الشركات املتعددة الجنسيات).",
          [
            Answer("الاستعمار الجديد", true),
            Answer("العولمة", false),
            Answer("الإمبريالية", false),
          ]),
      Question(
          "صراع عقائدي مذهبي فكري بين النظامين الشيوعي والرأسمالي، يقوم على مبدأ استحالة تعايشهما في عالم واحد.",
          [
            Answer("الصراع الايديولوجي", true),
            Answer("الحرب الباردة", false),
            Answer("سباق التسلح", false),
          ]
      ),

      Question(
          "نظام سياسي مستبد يقوم على القوة والسلطة الفردية، وهو استفراد فرد أو جماعة من األفراد على سلطة القرار مثل النازية األملانية، الفاشية االيطالية ... الخ.",
          [
            Answer("الديكتاتورية", true),
            Answer("الاستبداد", false),
            Answer("الشمولية", false),
          ]
      ),

      Question(
          "الفترات التي تميزت فيها العالقات بين املعسكرين بالتوتر الحاد ومن ابرزها الازمة الكوبية والكورية، هددت خاللها األمن الدولي وكادت ان تؤدي الى حرب عاملية.",
          [
            Answer("الأزمات الدولية", true),
            Answer("فترات التوتر", false),
            Answer("الحرب الباردة", false),
          ]
      ),

      Question(
          "سياسة الترغيب بواسطة جملة املشاريع االقتصادية واالجتماعية مثل: (مشروع قسنطينة، سلم الشجعان) في فترة حكم شارل دغول لإغراء الجزائريين وضرب الثورة وعزل الشعب عنها.",
          [
            Answer("سياسة الإغراء", true),
            Answer("سياسة الإصلاح", false),
            Answer("سياسة التهدئة", false),
          ]
      ),

      Question(
          "سياسة انتهجت من طرف الدول املستقلة بعد الحرب العاملية الثانية، معناها عدم االنضمام ألي من املعسكرين املتصارعين والدعوة للتعايش بينهما، ظهرت رسميا في مؤتمر بلغراد بيوغسالفيا 1961.",
          [
            Answer("عدم الانحياز", true),
            Answer("الحياد", false),
            Answer("التعايش السلمي", false),
          ]
      ),
      Question(
          "حركة قومية عنصرية يهودية تعمل على لم شمل اليهود واتخاذ فلسطين وطنا قوميا لهم، ظهرت في مؤتمر بال 1897 لقيت دعما من القوى الغربية.",
          [
            Answer("الصهيونية", true),
            Answer("اليهودية", false),
            Answer("الحركة القومية", false),
          ]
      ),

      Question(
          "شكل من أشكال الاستعمار الجديد، تعني سيطرة دولة على دولة أو دول أخرى، وقد تكون السيطرة اقتصادية، مالية وثقافية دون القضاء على النظام السياسي للدولة الخاضعة.",
          [
            Answer("الامبريالية", true),
            Answer("الاستعمار التقليدي", false),
            Answer("الهيمنة", false),
          ]
      ),

      Question(
          "تحقيق الاستقلال والانعتاق وإقامة سلطة سياسية وقدرة الدولة في تسيير شؤونها السياسية، لكن دون التحكم التام في الشؤون الاقتصادية.",
          [
            Answer("التحرر السياسي", true),
            Answer("الاستقلال التام", false),
            Answer("السيادة الوطنية", false),
          ]
      ),

      Question(
          "النظام الذي أعلن عنه الرئيس الأمريكي بوش بعد نهاية الحرب الباردة والذي يقوم على هيمنة الولايات المتحدة الأمريكية على العالم من خلال مؤسسات ومنظمات عالمية مثل هيئة الأمم وهياكلها.",
          [
            Answer("النظام الدولي الجديد", true),
            Answer("العولمة", false),
            Answer("الهيمنة الأمريكية", false),
          ]
      ),

      Question(
          "مصطلح سياسي، اقتصادي واجتماعي يضم الدول حديثة العهد بالاستقلال، التي تعاني مشاكل في مختلف المجالات، وقد اطلقه الفرنسي الفريد صوفي.",
          [
            Answer("العالم الثالث", true),
            Answer("الدول النامية", false),
            Answer("دول الجنوب", false),
          ]
      ),

      Question(
          "هيئة أممية تأسست بعد الحرب العالمية الثانية في 24 أكتوبر 1945، تضم الدول المستقلة مقرها نيويورك تعمل على تحقيق الأمن والسلم في العالم والحفاظ على العلاقات العالمية.",
          [
            Answer("منظمة الأمم المتحدة", true),
            Answer("عصبة الأمم", false),
            Answer("منظمة التعاون الدولي", false),
          ]
      ),

      Question(
          "الجهاز التنفيذي في هيئة الأمم المتحدة يتكون من 15 عضوا 5 دائمين يمتلكون حق الفيتو (الرفض او الامتناع) و10 ينتخبون لمدة سنتين.",
          [
            Answer("مجلس الأمن", true),
            Answer("الجمعية العامة", false),
            Answer("مجلس الوصاية", false),
          ]
      ),

      Question(
          "امتياز تتمتع به الدول دائمة العضوية في مجلس الأمن بالامتناع أو الاعتراض على أي قرار صادر منه (الولايات المتحدة–بريطانيا–فرنسا–روسيا–الصين).",
          [
            Answer("حق الفيتو", true),
            Answer("حق النقض", false),
            Answer("الامتياز الدبلوماسي", false),
          ]
      ),

      Question(
          "السياسة العسكرية المنتهجة من طرف المعسكرين بهدف التفوق في المجال العسكري لمختلف انواع الاسلحة من توفير الردع العسكري.",
          [
            Answer("سباق التسلح", true),
            Answer("التوازن العسكري", false),
            Answer("الردع النووي", false),
          ]
      ),

      Question(
          "رد فعل وطني شامل بأساليب وأشكال مختلفة يلجأ إليه الشعب لتغيير واقع استعماري مفروض، مثل ثورة الشعب الجزائري ضد الاستعمار الفرنسي الغاشم بهدف نيل الاستقلال.",
          [
            Answer("الثورة", true),
            Answer("المقاومة", false),
            Answer("الانتفاضة", false),
          ]
      ),

      Question(
          "تنظيم سياسي ثوري (الجناح السياسي للثورة) ظهر في 1 نوفمبر 1954، وهي الممثل الشرعي والوحيد للشعب الجزائري، تهدف إلى تحرير الجزائر من الاستعمار.",
          [
            Answer("جبهة التحرير الوطني", true),
            Answer("حزب الشعب الجزائري", false),
            Answer("حركة انتصار الحريات الديمقراطية", false),
          ]
      ),

      Question(
          "تنظيم سياسي نشأ في 19 سبتمبر 1958 بالقاهرة برئاسة فرحات عباس ثم بن خدة بن يوسف لتمثيل الثورة على الصعيدين الداخلي والخارجي والتحضير لمرحلة المفاوضات.",
          [
            Answer("الحكومة المؤقتة", true),
            Answer("المجلس الوطني للثورة", false),
            Answer("لجنة التنسيق والتنفيذ", false),
          ]
      ),

      Question(
          "مجموعة الدول التي تبنت الاشتراكية واصبحت كتلة بزعامة الإتحاد السوفيتي بعد الحرب العالمية الثانية مثل دول أوروبا الشرقية.",
          [
            Answer("المعسكر الشرقي", true),
            Answer("الكتلة الشيوعية", false),
            Answer("دول حلف وارسو", false),
          ]
      ),

      Question(
          "نظام دولي جديد ظهر بعد تفكك المعسكر الشرقي وزوال الثنائية القطبية يقوم على قيادة العالم وتوجيه العلاقات الدولية من طرف واحد وهي الولايات المتحدة الأمريكية.",
          [
            Answer("الأحادية القطبية", true),
            Answer("الهيمنة الأمريكية", false),
            Answer("العولمة", false),
          ]
      ),
    ])
    // Add more quiz types here if needed
  ])
]);

// Function to get random questions from a specific quiz type and unit
List<Question> getQuizQuestions(String quizType, String unitName) {
  return quizManager.getRandomQuestions(quizType, unitName, 10);
}
