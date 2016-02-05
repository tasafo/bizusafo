#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", :"xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Bizusafo"
    xml.description "Links e Ideias Compartilhadas pela Comunidade."
    xml.link root_url
    xml.language "pt-BR"
    xml.tag! "atom:link", :href => root_url, :rel => 'self', :type => "application/rss+xml"

    for article in @stories
      xml.item do
        xml.title article.description
        xml.description article.description
        xml.link story_url(article)
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.guid story_url(article)
      end
    end
  end
end
