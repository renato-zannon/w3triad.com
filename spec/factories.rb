Factory.define :post do |f|
  f.title "Lorem ipsum"
  f.content  "Lorem ipsum dolor sit amet"
  f.association :author, :factory => :user
end

Factory.define :user do |u|
  u.name                  "Renato Riccieri Santos Zannon"
  u.email                 "renato.riccieri@gmail.com"
  u.nickname              "Bill"
  u.bio                   "A metalhead geek"
  u.password              "StrongPassword"
  u.password_confirmation "StrongPassword"
end
