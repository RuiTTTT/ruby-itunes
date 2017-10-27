#!/usr/bin/ruby -w
# iTUNES
# Copyright Mark Keane, All Rights Reserved, 2014

#This is the top level
require 'csv'
require_relative 'actor'
require_relative 'album'
require_relative 'song'
require_relative 'reader'
require_relative 'utilities'
require_relative 'error'
require_relative 'data'

#songs_file = ARGV[0]                  #for command line
#owners_file = ARGV[1]                 #for command line

reader = Reader.new
data = DataBit.new
songs_file = 'song.csv'             #in RubyMine
owners_file = 'owners.csv'           #in RubyMine

puts "\nProcessing Songs from file: #{songs_file}"
#$songs = reader.read_in_songs(songs_file)
data.songs = reader.read_in_songs(songs_file)

puts "Processing Ownership from file: #{owners_file}"
#$hash_owners = reader.read_in_ownership(owners_file)
data.hashes = reader.read_in_ownership(owners_file)

puts "Building all owners..."
#$actors = Actor.build_all()
data.actors = Actor.build_all(data)
puts data.actors

puts "Updating songs with ownership details..."
#$songs.each{|song| song.owners = $hash_owners[song.id]}
data.songs.each{|song| song.owners = data.hashes[song.id]}

puts "Building All Albums..."
#$albums = Album.build_all()
data.albums = Album.build_all(data)
puts data.albums

# Given the name of a song and a person; let them buy the song
puts "\nRui buys Pieces..."
song1 = Util.fetch(data,"Pieces")
rui =   Util.fetch(data, "rui")
rui.to_s
song1.to_s
rui.buys_song(song1)
song1.to_s

# What songs does Markk own
puts "\nHow many songs does Rui own..."
p rui.what_songs_does_he_own(data).size

puts "\nPlay Pieces..."
song1.play_song

# Print out all songs
puts "\nPrinting full details of all songs..."
data.songs.each{|song| p song}

# Call it like this in the command line.
# markkean% ruby itunes.rb songs.csv owners.csv

