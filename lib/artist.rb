
class Artist
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

   #phase2

   #switch this to find_or_create_by_name
   def add_song(name)   
      name.artist||=self
      @songs.push(name) unless @songs.include?(name)
      #@songs.push(Song.find_or_create_by_name(name))
   end

   #through songs
   def genres
      songs.map{|a|a.genre}.uniq
   end
   
end