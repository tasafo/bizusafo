#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Bizusafo"
    xml.author "Tá Safo!"
    xml.description "Links e Ideias Compartilhadas pela Comunidade."
    xml.link "https://www.bizusafo.com.br"
    xml.language "pt-BR"

    for article in @stories
      xml.item do
        xml.text article.description
        xml.link "https://www.bizusafo.com.br" + "/stories/" + article.id.to_s
        xml.author article.user.username
        xml.pubDate article.created_at.to_s(:db)
        xml.guid article.id
      end
    end
  end
end