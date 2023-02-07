# Time to Answer
## Sobre
![Apresentação do projeto](/public/screenshot-welcome.png)
O projeto **Time to Answer** é um site de perguntas e respostas desenvolvido durante o curso [**Ruby on Rails 5.x - Do início ao fim!**](https://www.udemy.com/course/rubyonrails-5x/) do Jackson Pires com o intuito de colocarmos em prática todo conteúdo estudado durante o curso.

## Tecnologias utilizadas
- [Ruby](https://www.ruby-lang.org/pt/) (2.5.0)
- [Rails](https://rubyonrails.org/) (5.2.8.1)
- [SQLite3](http://www.sqlite.org) (3.37.2)

## Ferramentas utilizadas
- [Devise](https://github.com/heartcombo/devise) para autenticação
- [Rails-I18n](https://github.com/svenfuchs/rails-i18n) para internacionalização
- [Kaminari](https://github.com/kaminari/kaminari) para paginação
- [Trix](https://trix-editor.org/) para editor WYSIWYG
- [Searchkick](https://github.com/ankane/searchkick) para ElasticSearch
- [Prawn-Rails](https://github.com/cortiz/prawn-rails) para gerar arquivo PDF

## Instruções para uso
Clone o projeto em sua máquina e instale as dependências do projeto com os comandos:
```bash
bundle
yarn
```

Logo após, crie o banco de dados com:
```bash
rails db:create
rails db:migrate
```

Para inicializar o banco de dados com dados, rode:
```bash
rails dev:setup
```

Levante e rode a aplicação com:
```bash
rails s
```
E, finalmente, acesse ```http://localhost:3000``` no seu navegador.
