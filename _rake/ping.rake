task :default => :dev

desc 'Ping pingomatic'
task :pingomatic do
  begin
    require 'xmlrpc/client'
    puts '* Pinging ping-o-matic'
    XMLRPC::Client.new('rpc.pingomatic.com', '/').call('weblogUpdates.extendedPing', '#include' , 'http://wingie.github.com', 'http://wingie.github.com/atom.xml')
  rescue LoadError
    puts '! Could not ping ping-o-matic, because XMLRPC::Client could not be found.'
  end
end

desc 'Notify Google of the new sitemap'
task :sitemap do
  begin
    require 'net/http'
    require 'uri'
    puts '* Pinging Google about our sitemap'
    Net::HTTP.get('www.google.com', '/webmasters/tools/ping?sitemap=' + URI.escape('http://wingie.github.com/sitemap.xml'))
  rescue LoadError
    puts '! Could not ping Google about our sitemap, because Net::HTTP or URI could not be found.'
  end
end

desc "notify other blogs about ping"
task :ping do
  begin
    require "net/http"
    uri    = "http://wingie.github.com"
    params = "/ping/?title=&blogurl=#{URI.escape(uri)}&rssurl=&chk_weblogscom=on&chk_blogs=on&chk_technorati=on&chk_feedburner=on&chk_syndic8=on&chk_newsgator=on&chk_myyahoo=on&chk_pubsubcom=on&chk_blogdigger=on&chk_blogstreet=on&chk_moreover=on&chk_weblogalot=on&chk_icerocket=on&chk_newsisfree=on&chk_topicexchange=on"
    puts "pinging pingomatic"
    Net::HTTP.get("pingomatic.com", params)
    puts "pinging google"
    Net::HTTP.get("www.google.com" , "/ping?sitemap=" + URI.escape(uri+"/sitemap.xml"))
    puts "pinging feedburner"
    Net::HTTP.get("feedburner.google.com", "/fb/a/pingSubmit?bloglink=#{URI.escape(uri)}")
  end
end
