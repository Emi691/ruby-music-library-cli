require 'pry'

class MusicImporter

    def initialize(path)
        @path = path
    end

    def path
       @path 
    end

    def files
       files = Dir["#{self.path}/**/*.mp3"]
       filenames = files.collect{|file| file.gsub("#{self.path}/", "")}
    end

    def import
        files.each do |filename|
        Song.create_from_filename(filename)
        end
    end

end