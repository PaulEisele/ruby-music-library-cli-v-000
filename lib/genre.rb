class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    songs = []
  end

  def to_i
    self.name
  end

  def self.create(name)
    new(name).tap {|i| i.save}
  end

  def self.destroy_all
    @@all.clear
  end

  def artists
    self.songs.collect { |s| s.artist }.uniq
  end

end
