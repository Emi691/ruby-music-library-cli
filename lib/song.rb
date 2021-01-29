require 'pry'

class Song

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        if genre != nil
            self.genre= genre
        end
        if artist != nil
            self.artist= artist
        end
        #binding.pry
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear 
    end

    def self.create(name)
        name = Song.new(name)
        name.save
        name
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        if genre.songs.find{|song| song == self}
        else
        genre.songs << self
        end
    end

    def self.find_by_name(name)
        self.all.find{|song| song.name == name} 
    end

    def self.find_or_create_by_name(name)
        if self.find_by_name(name) == nil
            name = self.create(name) 
        else
            self.find_by_name(name)
        end
    end

    def self.new_from_filename(filename)
        new_filename = filename.split(/\ - |\./)
        song_name = new_filename[1]
        song_genre = new_filename[2]
        song_artist = new_filename[0]
        a= Artist.find_or_create_by_name(song_artist)
        g= Genre.find_or_create_by_name(song_genre)
        self.new(song_name, a, g)
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        self.all << song
    end

end