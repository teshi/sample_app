# En utilisant le symbole ':user', nous faisons que
# Factory Girl simule un modèle User.
Factory.define :user do |user|
  user.nom                  "Morgan Royer"
  user.email                 "morg@nroyer.com"
  user.password              "supinfo"
  user.password_confirmation "supinfo"
end
