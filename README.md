# AutoMute
Have a MacBook that you use both for work and personal use? Constantly trying to remember to mute your sound when you get to school or work? 

AutoMute allows you to tell your computer to mute or unmute your Macbook when you connect to certain wifi networks, eliminating the need to remember to mute and unmute your laptop every day and giving you the peace of mind that your laptop won't start playing sounds in the middle of class or in the office.

# Screenshots
<img alt="AutoMute Menu" src="http://i.imgur.com/RwcPhqf.png">

<img alt="AutoMute Setup" src="http://i.imgur.com/iyate5u.png">

# Setup
AutoMute has a super easy one-time setup. When you first launch the app, it shows a list of your most recently used wifi networks and you tell it what you want to happen when you connect to each one. Once everything is set up, you can close the preferences window and AutoMute will work in the background. 

As long as you see the AutoMute icon on your status bar, AutoMute is working. This is also where you can change the settings later on in the future.

# Developer Guide
AutoMute was written in Swift 2 using Xcode 7 beta 6.

- WifiManager - Monitors the current wifi network and the user's preferences and makes a delegate call when the wifi network changes.
- AppDelegate - Receives calls from the WifiManager and displays the status item and menu.
- SetupViewController - Essentially just a tableview that uses the WifiManager as a data source.
