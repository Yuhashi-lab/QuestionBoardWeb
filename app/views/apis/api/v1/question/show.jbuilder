
  json.id(@question.id)
  json.content(@question.content)
  json.questioner(@question.questioner)
  # json.id    question.id   と同じ 後ろに+"aaa"などをつけるとそれも出力される
  # questionが存在する限りjsonで出力
