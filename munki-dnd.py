#!/usr/bin/python

import sys
# try to import from the default place Munki installs it
try:
    from munkilib import FoundationPlist, munkicommon
except:
    sys.path.append('/usr/local/munki')
    from munkilib import FoundationPlist, munkicommon

import os
from datetime import datetime

FILE_LOCATION = "/Users/Shared/.msc-dnd.plist"

# Does the file exist?
if not os.path.isfile(FILE_LOCATION):
    # File isn't here, set the Munki pref to False
    munkicommon.set_pref('SuppressUserNotification', False)
    sys.exit(0)

    # If it does, get the current date?
else:
    plist = FoundationPlist.readPlist(FILE_LOCATION)
    if 'DNDEndDate' not in plist:
        # The key we need isn't in there, remove the file, set pref and exit
        os.remove(FILE_LOCATION)
        munkicommon.set_pref('SuppressUserNotification', False)
        sys.exit(0)
    else:
        # Is the current date greater than the DND date?
        saved_time = datetime.strptime(str(plist['DNDEndDate']), "%Y-%m-%d %H:%M:%S +0000")
        current_time = datetime.now()
        if saved_time > current_time:
            # print "Current time is greater"
            # If yes, remove the file and set the Munki pref for suppress notifications to False
            os.remove(FILE_LOCATION)
            munkicommon.set_pref('SuppressUserNotification', False)
            sys.exit(0)
        else:
            # print "Saved Time in greater"
            munkicommon.set_pref('SuppressUserNotification', True)
            sys.exit(0)
            # If no, make sure suppress notifications is True
