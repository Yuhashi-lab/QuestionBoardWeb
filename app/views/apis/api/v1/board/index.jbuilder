json.users @boards do |boards|
  json.id(boards.id)
  json.name(boards.name)
  json.category(boards.category)
  json.detail(boards.detail)
  # json.id    user.id   と同じ 後ろに+"aaa"などをつけるとそれも出力される
  # userが存在する限りjsonで出力
end
