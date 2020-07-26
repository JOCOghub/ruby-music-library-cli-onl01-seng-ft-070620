class Artist 
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    save
  end

  def self.all
    @@all
  end

  def save 
    @@all << self
  end   

  def add_song
    song = Song.new
    Artist.class.all << song 
  end   
    
end 

class Genre 
  attr_accessor :name  
   @@all = []

  def initialize(name)
    @name = name
    save
    @songs = []
  end

  def self.all
    @@all
  end

  def save 
    @@all << self
  end 
  
end   

class Song 
  attr_accessor :name
  attr_reader :artist, :genre
   @@all = []

  def initialize(name, artist, genre)
    @name = name
    @artist = artist
    @genre = genre
    save
  end

  def self.all
    @@all
  end
  
  def save 
    @@all << self
  end  
  
  def self.destroy_all
    all.clear
  end
  
  def self.create 
    new(name).tap{ |s| s.save }
  end   
  
  def self.find_by_name
    @@all.detect{&:name}
  end
  
  def self.find_or_create_by_name
    find_by_name(name) || create(name)   
  end
  
  def self.new_from_filename(filename)
    parts = filename.split(" - ")
    artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    new(song_name, artist, genre)
   end  
   
   def self.create_from_filename(filename)
    new_from_filename(filename).tap{ |s| s.save }
   end
end 


