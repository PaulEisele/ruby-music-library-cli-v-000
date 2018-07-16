class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def save
    @@all << self
  end

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def artist(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre(genre)
    @genre = genre
    genre.song<<self unless genre.songs.include? self
  end

  def self.all
    @@all
  end

  def self.create(name, artist = nil, genre = nil)
      new(name, artist, genre).tap { |s| s.save }
  end

  def self.destroy_all
    @@all.clear
  end


  def self.new_from_filename(filename)
    parts = filename.split(" - ")
    artist_name, song_name, genre_name = parts.first, parts[1], parts[2].gsub(".mp3", "")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.create(song_name, artist, genre)
  end

  def self.find_or_create_by_name(filename)
    find_by_name(name) || create(name)
  end

  def self.create_from_filename(name)
    new_from_filename(name).save
  end

end
