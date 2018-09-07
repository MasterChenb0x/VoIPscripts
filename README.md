# VoIPscripts
VoIP admin scripts for easy living

### Summary

*queue-logoff.sh*: logs off forgetful users from the queue. Feature now exists in FreePBX.

*cleanrecord.sh*: deletes old audio recordings to conserve harddrive space.

*phone-migrate.sh*: replace old PBX IP with new PBX IP. (This would not be a problem if DNS was used. Will fix).

*trunkcreate.sh*: creates a SIP or IAX trunk depending on selection, with supplied informstion.

*grab_PBX_Updates.sh*: when transitioning from FreePBX 2.x to 12.x, this script grabbed the updates. Won't be needed in the future, but a quick time saver.

*DIDselect.sh*: Select a DID (phone number) from an Idle pool for assignment to new clients.

*DIDaudit.sh*: Automagically audit the Active and Idle pools of numbers (so that I didnt have to manually).

### CHANGELOG

#### 2018-09-06
All uploads are current to what I have programmed. Latest additions were DIDaudit.sh and DIDselect.sh. These two files can probably be combined, and DIDselect.sh can be written more efficiently. Definitely a work in progress.

All current files are alpha.
