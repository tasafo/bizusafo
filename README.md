[![Code Climate](https://codeclimate.com/github/tasafo/bizusafo/badges/gpa.svg)](https://codeclimate.com/github/tasafo/bizusafo) [![Test Coverage](https://codeclimate.com/github/tasafo/bizusafo/badges/coverage.svg)](https://codeclimate.com/github/tasafo/bizusafo/coverage) [![Build Status](https://travis-ci.org/tasafo/bizusafo.svg?branch=master)](https://travis-ci.org/tasafo/bizusafo) [![security](https://hakiri.io/github/tasafo/bizusafo/master.svg)](https://hakiri.io/github/tasafo/bizusafo/master)

# Notícias da Comunidade

## Site oficial:
[bizu.tasafo.org](https://bizu.tasafo.org)

## Ambiente de desenvolvimento

### Instale o Mailcatcher para testar e-mails no ambiente local
    gem install mailcatcher

#### Rode o Mailcatcher quando precisar testar e-mails
    mailcatcher

Abra o Mailcatcher http://127.0.0.1:1080 no navegador

### Configure usuário e senha da conexão com o banco de dados:
    cp .env.example .env

    vim .env

### Crie os bancos de dados
    rake db:create

    rake db:migrate

    rake db:test:prepare

### Rode os testes
    rake spec

## Ambiente de produção

### Configure o aplicativo do Facebook através das variáveis de ambiente:
    FACEBOOK_APP_ID

    FACEBOOK_APP_SECRET

    ex: heroku config:set FACEBOOK_APP_ID=8N029N81 FACEBOOK_APP_SECRET=9s83109d3+583493190

### Configure o envio de e-mails pelo SendGrid com variáveis de ambiente:
    SENDGRID_USERNAME

    SENDGRID_PASSWORD

    ex: heroku config:set SENDGRID_USERNAME=8N029N81 SENDGRID_PASSWORD=9s83109d3+583493190

### Configure o Google Analytics com variáveis de ambiente: (opcional)
    GOOGLE_ANALYTICS_ID

    ex: heroku config:set GOOGLE_ANALYTICS_ID=UA-165967323-14
