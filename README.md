# munki-dnd
A 'do not disturb' menubar app for Munki for Yosemite and above.

![Active](https://github.com/grahamgilbert/munki-dnd/blob/master/images/active.png)

![Inactive](https://github.com/grahamgilbert/munki-dnd/blob/master/images/disabled.png)

## Usage

By default, this will suppress user notifications from MSC for 24 hours. To adjust this period, use the following:

``` bash
$ defaults write /Library/Preferences/com.grahamgilbert.mscdnd DNDHours -int 1
```

Where ``1`` is the number of hours you want to allow the user to suppress notifications for.

## What's happening?

The package installs two things: the client application that allows users to suppress notifications, and a Munki preflight script that will read in a file created by the app (in ``/Users/Shared/.msc-dnd.plist`` if you care about such things) and the change the ``SuppressUserNotification`` in Munki appropriately depending on whether the specified time has elapsed or not.

## Troubleshooting

This tool sets ``SuppressUserNotification`` in ``/Library/Preferences/ManagedInstalls.plist``. If you are setting this preference via a Profile or MCX, this application will have no effect.

This app is written in Swift, so requires OS X 10.10 or later.

The preflight script assumes you have some method of running scripts in ``/usr/local/munki/preflight.d``. If you are using Sal, or munkireport-php, you will have everything you need to just use the package as is. If you are not, you will need to move the script to ``/usr/local/munki/preflight``.

Thanks to [Icons8](https://icons8.com) for the app icon.
