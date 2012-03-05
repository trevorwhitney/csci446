# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Author.transaction do
	authors = { :Gisele_Bundchen => "db/seeds/gisele-bundchen.jpg",
							:Tom_Brady => "db/seeds/tom-brady.jpg",
							:Julia_Mancuso => "db/seeds/julia-mancuso.jpg",
							:Bode_Miller => "db/seeds/bode-miller.jpg" }
  authors.each do |key, value|
    author = Author.new name: key.to_s.gsub(/_+/, " "), photo: File.new(value)
    author.save
  end
end

Article.transaction do 
  (1..100).each do |i|
    Article.create(:title => "Fantastic Article #{i}",
      :body => %{Duis ad pitchfork 3 wolf moon odio, voluptate sartorial culpa. Eiusmod cred etsy excepteur occaecat sustainable +1. Consectetur thundercats banh mi gentrify mlkshk. Ullamco banksy brunch terry richardson fap esse officia, master cleanse blog cillum fugiat kogi et small batch. Freegan cillum irure, selvage shoreditch anim fap narwhal id twee aesthetic kale chips pickled. Williamsburg jean shorts high life beard non terry richardson reprehenderit, mcsweeney's master cleanse wayfarers. Small batch odd future seitan tattooed, voluptate incididunt tofu ethnic assumenda bicycle rights pork belly four loko velit.
        
Tempor high life fingerstache, raw denim seitan american apparel fixie eiusmod. Sustainable pitchfork keffiyeh hoodie pork belly post-ironic cupidatat deserunt, mumblecore ethical selvage ullamco photo booth bicycle rights godard. Nihil hoodie kale chips, elit photo booth cosby sweater freegan. Vice tofu synth ad, fixie elit delectus farm-to-table sunt authentic. Assumenda lomo post-ironic polaroid 3 wolf moon. Chambray mlkshk eiusmod, portland seitan whatever et quinoa forage. Dolor odd future fugiat locavore.

Tattooed skateboard pork belly, lo-fi banh mi pop-up consectetur biodiesel voluptate vice fingerstache wayfarers keffiyeh. Pork belly farm-to-table typewriter ut fixie, reprehenderit occupy sunt 8-bit adipisicing shoreditch sed semiotics. Magna letterpress etsy selvage aliqua 8-bit, aute sint pitchfork beard trust fund kogi gluten-free vice adipisicing. Exercitation skateboard cred, commodo fugiat mixtape keffiyeh seitan id terry richardson letterpress placeat food truck cardigan cliche. In odio art party proident. Velit pariatur hella seitan nihil. Hoodie est 8-bit sed enim, thundercats exercitation twee williamsburg.

Trust fund irure laboris, kale chips readymade mollit leggings food truck skateboard bespoke thundercats pork belly master cleanse 3 wolf moon in. Elit esse cosby sweater, terry richardson typewriter occaecat pariatur cillum nulla. Pickled veniam mcsweeney's tattooed excepteur, Austin PBR. Fixie cupidatat bushwick cardigan ennui. In consequat occaecat, non wes anderson mustache stumptown tumblr DIY post-ironic officia sriracha aute pop-up lo-fi. Dolor odd future shoreditch whatever, proident terry richardson labore pitchfork placeat nulla keytar pariatur. Austin kale chips pitchfork, wolf selvage chillwave brunch quis food truck shoreditch.
      },
      :author_id => i % 4 + 1)
  end
end
