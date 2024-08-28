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

  List<Question> getRandomQuestions(String quizType, String unitName, int count) {
    Quiz targetQuiz = quizzes.firstWhere(
            (quiz) => quiz.type == quizType,
        orElse: () => throw Exception('Quiz type not found')
    );
    Unit targetUnit = targetQuiz.units.firstWhere(
            (unit) => unit.name == unitName,
        orElse: () => throw Exception('Unit not found')
    );

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
        Answer("05/09/1973", true),
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
      Question("استقلال سوريا و لبنان", [
        Answer("1946/04/17", true),
        Answer("1945/09/03", false),
        Answer("1946/08/22", false),
        Answer("1947/01/10", false),
      ]),
      Question("استقلال الهند ، بنغلادش و باكستان", [
        Answer("1947/08/15", true),
        Answer("1946/12/01", false),
        Answer("1947/11/23", false),
        Answer("1948/03/07", false),
      ]),
      Question("استقلال إندونيسيا", [
        Answer("1949/12/27", true),
        Answer("1948/09/15", false),
        Answer("1949/05/03", false),
        Answer("1950/04/11", false),
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
        Answer("1979/08/15", false),
        Answer("1980/03/09", false),
        Answer("1980/06/22", false),
      ]),
    ]),
    // Add more units here if needed
  ]),
  // Add more quiz types here if needed
]);

// Function to get random questions from a specific quiz type and unit
List<Question> getQuizQuestions(String quizType, String unitName) {
  return quizManager.getRandomQuestions(quizType, unitName, 10);
}