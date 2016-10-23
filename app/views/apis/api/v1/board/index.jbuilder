json.users @boards do |board|
  json.id(board.id)
  json.name(board.name)
  json.category(board.category)
  json.detail(board.detail)
  # json.id    user.id   と同じ 後ろに+"aaa"などをつけるとそれも出力される
  # userが存在する限りjsonで出力
end
