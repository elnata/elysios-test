# README

Esse é um pequeno projeto para avaliação, no qual, foi criado um sistema de criação de estoque, entradas e lots.

Para rodar o projeto é preciso realizar as seguintes comandos:

* bundle install
* rails db:create
* rails db:migrate
* rails db:seed

Para realizar os testes basta executar o seguinte comando:

* rake spec


A documentação da API pode ser acessado no link:

https://documenter.getpostman.com/view/3774026/UVsEV91g


O sistema aceita autenticação básica por token, para utilizar esse metodo basta a linha 4 do arquivo: api_controller.rb e seguir os seguintes passos:

* Rodar o comando: rails c
* Pegar os dados: authentication_token e o email e preencher no Headear
