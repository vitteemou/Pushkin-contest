namespace :db do
  task :parse_poems => :environment do

    URL = "http://ilibrary.ru/text/"
    mechanize = Mechanize.new { |agent| 
    agent.user_agent_alias = 'Linux Firefox'
    }

   page = mechanize.get("http://ilibrary.ru/author/pushkin/l.all/index.html")
   links = page.parser.css('.list a')
   id_poems = links.map { |l| l.attributes['href'].value.scan(/\d{3}/).join }

    id_poems = id_poems.drop(8) # drop links to categories
    num = 0
    size = id_poems.size

    id_poems = id_poems.drop(1200)

    
       id_poems.each do |id|
       link = URL + id + "/p.1/index.html"
       page = mechanize.get(link)
       title = page.parser.css('.title h1').text
       text = page.parser.css('.poem_main').text
	text.gsub!(/\u0097/, "\u2014") # replacement of unprintable symbol
	text.gsub!(/^\n/, "") # remove first \n

	poem = Poem.new
	poem.title = title
	poem.content = text
	poem.save

        line_arr = poem.content.split("\n").to_a
        #p line_arr

        line_arr.each do |l|
          elem =  Line.create(some_line: l)
          poem.lines << elem
	 # l = l.gsub!(/[^[:alnum:]]/, ' ').split(' ')#.to_a
     
         # l.each do |word|
         #   w = Word.create(some_word: word)
         #   w.lines << elem
         # end
        end
       end 
     end

       #li = 'Bye, bye, bye'
       #s = Line.create(some_line: li)
       
       #li = li.gsub!(/[^[:alnum:]]/, ' ').split(' ')
       # li.each do |word|
       #     if Word.any? { |elem| elem.some_word == word }
              
       #       Word.find(some_word: word).lines << s
       #     else

        #      w = Word.create(some_word: word)
        #      w.lines << s
        #    end
	#end
    end
  

