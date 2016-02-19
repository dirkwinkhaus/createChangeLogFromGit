# createChangeLogFromGit
a bash script creating a change log file. listing tags and commits even modified files if wanted.
use it this way: ```./createChangeLogFromGit``` within your git repository and it will create a
file with the name you may configure in the script. the file will contain data like this:

tag 0.1.1
---------
  
     b96206c60a1f0769439df53f6fc6796a022458c2 commitmessage
  


tag 0.0.10
---------
  
     b96206c60a1f0769439df53f6fc6796a022458c2 commitmessage


  
tag 0.0.1
---------
  
     b96206c60a1f0769439df53f6fc6796a022458c2 commitmessage



