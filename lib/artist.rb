require 'pry'

class Artist
    extend Concerns::Findable

    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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
        name = Artist.new(name)
        name.save
        name
    end

    def songs
       @songs
    end

    def add_song(song)
        if !song.artist
        song.artist= self
        end
        if !self.songs.include?(song)
        self.songs << song
        end
    end

    def genres
        #binding.pry
        self.songs.collect{|song| song.genre}.uniq
    end

end