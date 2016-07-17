# My series Companion
My Series Companion est une application Web faite avec Ruby on Rails permettant de gérer sa liste de séries.

![alt tag](https://github.com/jacquelotjeff/my-series-companion-ruby/blob/master/my-series-companion.png?raw=true)

Vous pouvez ajouter vos séries, voir les saisons et les épisodes de celle-ci.


Ainsi, elle permet de mettre à jour l'épisode/saison pour chacune des séries de façon intuitive.

# Installation
Ajouter dans le dossier config/ un fichier secrets.yml

```yaml
development:
  secret_key_base: *cle_secrete*
  api_access_key: *votre_cle_api_the_tvdb*

test:
  secret_key_base: *cle_secrete*
  api_access_key: *votre_cle_api_the_tvdb*

# Do not keep production secrets in the repository,
# instead read values from the environment.
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
  api_access_key: *votre_cle_api_the_tvdb*
```

Dans votre console pour installer les dépendances, mettre à jour la base de données, et lancer le serveur :

```{r, engine='bash', count_lines}
$ bundle install
$ rake db:migrate
$ rails s
```
