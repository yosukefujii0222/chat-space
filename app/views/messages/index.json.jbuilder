json.array! @messages.each do |message|
  json.name       message.user.name
  json.updated_at message.updated_at.strftime("%Y年%m月%d日 %H時%M分")
  json.body       message.body
  json.image      message.image
  json.id         message.id
end
