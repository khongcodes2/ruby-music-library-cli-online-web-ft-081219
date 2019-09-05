

class Genre
   extend Concerns::Findable
   attr_accessor :name, :songs
   
   @@all=[]

   def initialize(name)
      @name=name
      @songs=[]
   end
   
   def self.all
      @@all
   end

   def save
      self.class.all.push(self)
   end

   def self.destroy_all
      @@all.clear
   end

   def self.create(name)
      self.new(name).tap {|a|a.save}
   end

   #through songs
   def artists
      songs.map{|a|a.artist}.uniq
   end

end