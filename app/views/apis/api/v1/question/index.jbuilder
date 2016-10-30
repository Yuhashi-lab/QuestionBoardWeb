json.questions @questions do |question|
  json.id(question.id)
  json.content(question.content)
  json.questioner(question.questioner)
  json.answer(question.answer)
  if question.respond_to?(:empathy_count) == true
    json.empathy_count(question.empathy_count)
  else
    json.empathy_count(0)
  end
end
