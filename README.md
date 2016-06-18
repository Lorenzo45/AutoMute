# AutoMute - 📥[Download Version 1.1 Here](http://bit.ly/AutoMute1-1)📥

Have a MacBook that you use both for work and personal use? Constantly forgetting to mute your sound when you get to school or work?

![Closing Laptop](http://i.giphy.com/xT0GqzPXFvsoP8dnkk.gif)

AutoMute allows you to tell your computer to mute or unmute your MacBook when you connect to certain Wi-Fi networks, eliminating the need to remember to mute and unmute your laptop and giving you the peace of mind that your laptop won't start playing sounds in the middle of class or in the office.

# Screenshots
![AutoMute Menu](http://i.imgur.com/RwcPhqf.png)

![AutoMute Setup](http://i.imgur.com/nHRbwHH.png)

# Setup
AutoMute has a super easy one-time setup. When you first launch the app, it shows a list of your most recently used Wi-Fi networks and you tell it what you want to happen when you connect to each one. Once everything is set up, you can close the preferences window and AutoMute will work in the background. 

As long as you see the AutoMute icon on your status bar, AutoMute is working. This is also where you can change the settings any time you like.

# Version History
###1.0 (September 2015)
Initial release, core functionality included Wi-Fi monitoring and volume muting/unmuting based on user preferences, and a setup screen that shows the Wi-Fi networks that have been connected to by the user in reverse chronological order.

###1.1 (December 2015)
First update with the following changes:
- El Capitan support (the toggles on the setup screen broke)
- Added emojis to setup options for non-English speaking users
- Added "Not connected to any network" option to the setup menu
- Added a 10 second timer when Wi-Fi drops (to avoid detecting small drops in Wi-Fi)
- Changed setup window to always be on top to avoid losing it behind other windows

# Developer Guide
I've decided to make AutoMute open source and I welcome all feedback, issues, and pull requests. This is my first time making something open source, so if I'm doing something wrong or poorly please let me know!

AutoMute was written in Swift 2 using Xcode 7 beta 6. Here are some quick descriptions of the main classes in the app:

- WifiManager - Monitors the current Wi-Fi network and the user's preferences and makes a delegate call when the Wi-Fi network changes.
- AppDelegate - Receives calls from the WifiManager and displays the status item and menu.
- SetupViewController - Essentially just a tableview that uses the WifiManager as a data source.

# Licensing
See the file named "LICENSE".
