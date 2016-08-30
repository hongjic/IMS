IMS
=============================
[![Code Climate](https://codeclimate.com/github/hongjic/IMS/badges/gpa.svg)](https://codeclimate.com/github/hongjic/IMS)
[![Issue Count](https://codeclimate.com/github/hongjic/IMS/badges/issue_count.svg)](https://codeclimate.com/github/hongjic/IMS)

ims is a text baased Interactive music shell with simple commands

use ``ruby ims.rb`` to start the program

###Commands

***exit***
Save state and exit

***help***
Display a simpe help screen. 

***info***
Display a high level summary of the state

***all tracks***  
Display all tracks information

***all artists***
Display all artists information

***info track***   
Display info about a certain track by number

***info artist***
Display info about a certain artist, by id

``info artist "artist_id"``

***add artist***
Adds a new artist to storage and assign an artist id

``add artist "artist_name"``

***add track***
Add a new track to storage

``add track "track_name" by "artist_id"``

***play track***
Record that an existing track was played at the current time

``play tack "trackid"``

***count tracks***
Display how many tracks are known by a certain artist

``count tracks by "artist_id"``

***list tracks***
Display the tracks played by a certain artist

``list tracks by "artist_id"``

***clear***
Clear all data

#####Notice: all keywords in above commands should be quoted.


###Data Persistency
data persistency is based on PStore. 

<li> array of artists
<li> array of tracks
<li> array of playlist

###Classes

class | discription | 
:----:|:------:|
Ims | the main class for the program. The ``run`` method in it is exactly what it will do when you type in ``ruby ims.rb``  | 
Track | class for a track. contains ``times``(the times this track has been played), ``name``(the track name), ``artist``(the artist of this track) and ``lastplayed``(the last time this track was played)| 
Artist | class for artists. contains variables: ``name`` and ``id``(default id is the initials of the artist, but if the same id exists, use ``name`` as ``id``)  |
Storage | class for data persistency. it is responsible for the saving and reading from file. To avoid conflicts between two instances, **Singleton** mode is included|
Command | This is just a **interpreter** for user commands. Extract keywords from the command by **regular expression**.| 

