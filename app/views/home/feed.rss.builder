#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", :"xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Bizusafo"
    xml.description "Links e Ideias Compartilhadas pela Comunidade."
    xml.link "https://www.bizusafo.com.br"
    xml.language "pt-BR"
    xml.atom( :link, :href => feed_url, :rel => "self", :type => "application/rss+xml" )

    for article in @stories
      xml.item do
        xml.title article.description
        xml.description article.description
        xml.link "https://www.bizusafo.com.br" + "/stories/" + article.id.to_s
        xml.pubDate article.created_at.to_s(:db)
      end
    end
  end
end
