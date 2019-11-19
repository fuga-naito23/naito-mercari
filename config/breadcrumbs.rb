crumb :root do
  link "Home", root_path
end

crumb :mypage do
  link 'マイページ', user_path(current_user.id)
  parent :root
end

crumb :card do
  link "支払い方法", new_card_path
  parent :mypage
end