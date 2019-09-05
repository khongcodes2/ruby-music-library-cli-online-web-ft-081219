

class Song
   extend Concerns::Findable
   attr_accessor :name
   attr_reader :artist, :genre
   @@all=[]

   def initialize(name,artist=nil,genre=nil)
      @name=name
      self.artist=artist unless artist==nil
      self.genre=genre unless genre==nil
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
      self.new(name).tap {|s|s.save}
   end

   #phase2

   def artist=(a_name)
      @artist=a_name
      a_name.add_song(self)
   end

   def genre=(genre_n)
      @genre=genre_n
      genre_n.songs.push(self) unless genre_n.songs.include?(self)
   end

   #phase3

   def self.new_from_filename(filename)
      new_name=filename.chomp('.mp3').split(" - ")
      n_artist=Artist.find_or_create_by_name(new_name[0])
      n_genre=Genre.find_or_create_by_name(new_name[2])
      Song.new(new_name[1],n_artist,n_genre)
   end

   def self.create_from_filename(filename)
      new_from_filename(filename).save
   end

end