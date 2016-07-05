require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = Song.new
    song.save
    song
  end

  #create -> saves it to all

  def self.new_by_name(song)
    song_object = Song.new
    song_object.name = song
    song_object
    #directions explain to return the INSTANCE(object) of the song created
    #not the string name
  end

  def self.create_by_name(string_name)
    song_instance = Song.new
    song_instance.name = string_name
    song_instance.save
    song_instance
  end

  def self.find_by_name(song_name)
    @@all.each do |song_instance|
      if song_instance.name == song_name
          return song_instance
        #why does this not work when return is not in the last line
        #each would return the original array, evaluate the line of code, but not do anything with that
        #explicitly writing return stops loop on that iteration and returns the value we're asking it to evaluate
        #is there a list of class methods, methods for class, why grep detect select methods dont work
        #^^^basically what active record is for, accessing things from a database, methods already there. @@all is a stand in for a database, not an array we're shoveling into it'd be a database
        #detect or find iterator method would be best in this situation
        #detect/find unwrap element from the array, returns element itself vs an array with that element
      end
    end
  end

  def self.find_or_create_by_name(song_name)
    self.all.detect {|song| song.name == song_name} || self.create_by_name(song_name)
  end
  #if the left side evaluates to false, relying on the fact that detect returns nil if not found, nil evaluates to falsey,
  # and only if it evaluates to falsey will the right side be run
  #
  #   self.find_by_name(song_name) || self.create_by_name(song_name)
  # end
    # what is making this one not work? vvv this works now, have to jump out of iteration for the last line of code
    # to be executed so that it can look at every element of the array
  #   @@all.each do |instance|
  #     if instance.name == song_name
  #       return instance
  #     end
  #   end
  #   create_by_name(song_name)
  # end

  def self.new_from_filename(filename)
    array_of_words = filename.split(" - ")
    song_instance = Song.new
    # binding.pry
    song_instance.artist_name = array_of_words[0].to_s
    song_instance.name = array_of_words[1].to_s.gsub!(/(.mp3)/, '')
    # binding.pry
    song_instance
  end

  def self.create_from_filename(filename)
    array_of_words = filename.split(" - ")
    song_instance = Song.new
    # binding.pry
    song_instance.artist_name = array_of_words[0].to_s
    song_instance.name = array_of_words[1].to_s.gsub!(/(.mp3)/, '')
    # binding.pry
    song_instance.save
    song_instance
  end




# "Taylor Swift - Blank Space.mp3"

  def self.alphabetical
    @@all.sort_by { |song| song.name }
  end


  def self.destroy_all
    @@all.clear
  end


end

# binding.pry
# # ""
