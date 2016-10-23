json.users @results do |result|
  json.id(result.id)
  json.name(result.name)
  json.category(result.category)
  json.detail(result.detail)
  # json.id    user.id   と同じ 後ろに+"aaa"などをつけるとそれも出力される
  # userが存在する限りjsonで出力
end
