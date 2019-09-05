class MusicImporter
   attr_accessor :path
   @@all=[]

   def initialize(path)
      @path=path
   end

   def files
      Dir.chdir(@path) do
         Dir.glob("*.mp3")
      end
   end

   def import
      files.each do |a|
         @@all << Song.create_from_filename(a)
      end
   end

end