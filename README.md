#ims
ims is a text baased Interactive music shell with simple commands:

exit         - Save state and exit
help         - Display a simpe help screen. 
info         - Display a high level summary of the state",
all tracks   - Display all tracks information",
all artists  - Display all artists information",
info track   - Display info about a certain track by number",
               usage: info track \"trackid\"  ",
info artist  - Display info about a certain artist, by id",
               usage: info artist \"artistid\"",
add artist   - Adds a new artist to storage and assign an artist id",
               usage: add artist \"artistname\"",
add track    - Add a new track to storage",
               usage: add track \"trackname\" by \"artistid\"",
play track   - Record that an existing track was played at the current time",
               usage: play track \"trackid\"",
count tracks - Display how many tracks are known by a certain artist",
               usage: count tracks by \"artistid\"",
list tracks  - Display the tracks played by a certain artist" ,
               usage: list tracks by \"artistid\"",
clear        - Clear all data"

Notice: all keywords in above commands should be quoted.
For example: add track "watching the sky turn green" by "jo"

use "ruby ims.rb" to start the program

data