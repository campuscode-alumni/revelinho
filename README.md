# README

Esse projeto é uma réplica de funcionalidades do portal de posições da Revelo.

## Pré Requisitos

- Ruby 2.6.4
- Rails 6.0.0
- SQLite
- NodeJS
- Yarn

## Testes

Para rodar os testes, após executar `bin/setup`, execute `bundle exec rspec`

## Deploy

O deploy deve ser realizado via Heroku. Para isso crie uma conta na plataforma
(heroku.com)[heroku.com] e em seguida instale o Heroku CLI.

Em seu terminal faça login via `heroku login` e crie uma nova app dentro do
diretório da aplicação:

`heroku apps:create nome_da_app_no_heroku`

Isso vai criar um novo `remote` no seu repositório Git local.

Para fazer o primeiro deploy, execute: `git push heroku master`

Ao receber seu código, o Heroku executa uma receita de deploy. Comandos como
`db:create` e `bundle install` são executados automaticamente. Mas **atenção**,
o comando `rails db:migrate` deve ser executado manualmente. Para isso, em seu
terminal, execute:

`heroku run rails db:migrate`

Talvez seja necessário reiniciar sua aplicação para que o Rails detecte as
mudanças no banco de dados. Para isso basta executar: `heroku restart`
