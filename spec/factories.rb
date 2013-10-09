#En utilisant le symbole ':user', nous faisons que Factory_Girl simule un modèle User
require 'factory_girl_rails'
FactoryGirl.define do
  factory :user do
   nom                   "bri pic"
   email                 "bri@pic.com"
   password              "foobar"
   password_confirmation "foobar"
  end
end
