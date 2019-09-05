class MusicLibraryController
   attr_accessor :path,:library

   def initialize(path="./db/mp3s")
      @path=path
      @library=MusicImporter.new(@path).import
   end

   def call
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      4.times do 
         case gets
            when 'list songs'
               list_songs
            when 'list artists'
               list_artists
            when 'list genres'
               list_genres
            when 'list artist'
               list_songs_by_artist
            when 'list genre'
               list_songs_by_genre
            when 'play song'
               play_song
         end

      end
   end

   def chomped_libr
      @library.map{|a|a.chomp(".mp3").split(" - ")}
   end

   def list_songs
      chomped_libr.sort{|a,b| a[1]<=>b[1]}.map{|a|a.join(" - ")}.each_with_index {|item,index|puts "#{index+1}. #{item}"}
   end

   def list_artists
      Artist.all.map{|a|a.name}.sort.each_with_index{|item,index|puts "#{index+1}. #{item}"}
   end

   def list_genres
      Genre.all.map{|a|a.name}.sort.each_with_index{|item,index|puts "#{index+1}. #{item}"}
   end

   def list_songs_by_artist
      puts "Please enter the name of an artist:"
      Song.all.map{|a|a if a.artist.name==gets}.compact.sort{|a,b|a.name<=>b.name}.each_with_index do |item,index|
         puts "#{index+1}. #{item.name} - #{item.genre.name}"
      end
   end

   def list_songs_by_genre
      puts "Please enter the name of a genre:"
      Song.all.map{|a|a if a.genre.name==gets}.compact.sort{|a,b|a.name<=>b.name}.each_with_index do |item,index|
         puts "#{index+1}. #{item.artist.name} - #{item.name}"
      end
   end

   def play_song
      puts "Which song number would you like to play?"
      inp=gets
      if inp.to_i<=@library.count&&inp.to_i>=1
         sel_song=chomped_libr.sort{|a,b| a[1]<=>b[1]}[inp.to_i-1]
         puts "Playing #{sel_song[1]} by #{sel_song[0]}" unless sel_song==nil
      end
   end



end