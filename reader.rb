#!/usr/bin/ruby -w
# READER
# Copyright Mark Keane, All Rights Reserved, 2014

#  Class that reads in things from different files.
class Reader
	# method to read in songs from the songs.csv file.
  # returns an array of song objects.

	def read_in_songs(csv_file_name)
	  songs = []
		ids = []
	  CSV.foreach(csv_file_name, :headers => true) do |row|
			MyErr.file_check(row[4])
			songname, artist, album, time, id = row[0],row[1], row[2], row[3], row[4]
			catch :invalid_id do
				MyErr.new("Missing or Invalid ID", row, "read_in_songs").do_it
				songname += '#'
			end
			ids.push(row[4])
			MyErr.unique_check(ids,row[4])
			catch :repeated_id do
				MyErr.new("Repeated ID", id, "read_in_songs").do_it
				songname += '#'
			end
	 	 unless (songname =~ /#/)
	 	 	 songs << Song.new(songname,album,artist,time.to_f,nil,id)
	 	 end
	   end
	  songs
	end
	   
	# method to read in owners and the ids of the songs they own from the owners.csv file.
  # returns a hash table where the keys are song-ids and the values are the owners this song (a string)

	def read_in_ownership(csv_file_name, temp_hash = Hash.new)
		ids = []
	  CSV.foreach(csv_file_name, :headers => true) do |row|
			MyErr.file_check(row[0])
		  song_id, owner_data = row[0], row[1]
			catch :invalid_id do
				MyErr.new("Missing or Invalid ID", row, "read_in_ownership").do_it
				songname += '#'
			end
			ids.push(row[0])
			MyErr.unique_check(ids,row[0])
			catch :repeated_id do
				MyErr.new("Repeated ID", id, "read_in_ownership").do_it
				songname += '#'
			end
	 	  unless (song_id =~ /#/)
	 	 	     temp_hash[song_id] = owner_data
	 	      end
    end
    temp_hash
	end
end
