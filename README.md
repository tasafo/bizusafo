[![Code Climate](https://codeclimate.com/github/tasafo/bizusafo/badges/gpa.svg)](https://codeclimate.com/github/tasafo/bizusafo) [![Test Coverage](https://codeclimate.com/github/tasafo/bizusafo/badges/coverage.svg)](https://codeclimate.com/github/tasafo/bizusafo/coverage) [![Build Status](https://travis-ci.org/tasafo/bizusafo.svg?branch=master)](https://travis-ci.org/tasafo/bizusafo)

# Notícias da Comunidade

## 1. Site oficial:
[bizusafo.com.br](http://bizusafo.com.br)

## 2. Configure a conexão com o banco de dados:
    cp config/database.yml.example config/database.yml

    vim config/database.yml

## 3. Crir os bancos de dados
    rake db:create

    rake db:migrate

    rake db:test:prepare

## 4. Rode os testes
    rake spec

## 5. Configure o aplicativo do Facebook através das variáveis de ambiente:
    ENV['FACEBOOK_APP_ID']

    ENV['FACEBOOK_APP_SECRET']

    ex: heroku config:set FACEBOOK_APP_ID=8N029N81 FACEBOOK_APP_SECRET=9s83109d3+583493190

## 6. Configure o envio de emails pelo SendGrid com variáveis de ambiente:
    ENV['SENDGRID_USERNAME']

    ENV['SENDGRID_PASSWORD']

    ex: heroku config:set SENDGRID_USERNAME=8N029N81 SENDGRID_PASSWORD=9s83109d3+583493190

## 7. Configure o Google Analytics com variáveis de ambiente: (opcional)
    ENV['GOOGLE_ANALYTICS_ID']

    ex: heroku config:set GOOGLE_ANALYTICS_ID=UA-165967323-14
