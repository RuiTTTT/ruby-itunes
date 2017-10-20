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
			begin      # begin block with the next in rescue to continue the loop if error occur.
				MyErr.file_check(row[4])    # the method checking missing id
				songname, artist, album, time, id = row[0],row[1], row[2], row[3], row[4]
				MyErr.unique_check(ids,row[4])   # the method checking repeat id
				ids.push(row[4])     # saves all the id that have appeared, for checking repeated ids
				unless (songname =~ /#/)
					songs << Song.new(songname,album,artist,time.to_f,nil,id)
				end
			rescue
				MyErr.new("ID Exception in songs",csv_file_name,"read_in_songs").do_it  # print an error information
				next  # continue the loop
			end
	   end
	  songs
	end
	   
	# method to read in owners and the ids of the songs they own from the owners.csv file.
  # returns a hash table where the keys are song-ids and the values are the owners this song (a string)

	def read_in_ownership(csv_file_name, temp_hash = Hash.new)
		ids = []
	  CSV.foreach(csv_file_name, :headers => true) do |row|
			begin    # begin block with the next in rescue to continue the loop if error occur.
				MyErr.file_check(row[0])    # the method checking missing id
				song_id, owner_data = row[0], row[1]
				MyErr.unique_check(ids,row[0])   # the method checking repeat id
				ids.push(row[0])     # saves all the id that have appeared, for checking repeated ids
				unless (song_id =~ /#/)
					temp_hash[song_id] = owner_data
					end

			rescue
				MyErr.new("ID Exception in owners",csv_file_name,"read_in_ownership").do_it
				next   # continue the loop
			end

    end
    temp_hash
	end
end
