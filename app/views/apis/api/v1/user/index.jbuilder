json.users @users do |user|
  json.id(user.id)
  json.email(user.email)
  # json.id    user.id   と同じ 後ろに+"aaa"などをつけるとそれも出力される
  # userが存在する限りjsonで出力
end
