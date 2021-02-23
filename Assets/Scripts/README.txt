User.cs

and 

Remote.cs

demostrate the command pattern.

From a Mark Zaku lesson.



Think about a combination of Command and Broker:

A Command like BuyGemPack() or UpgradeTower() could contain all the logic for the client.
And by also sending the Command to a Broker (a central event handler, you remember?), you could also Update your Savegame.
And later also send an event to the server, so the server knows that the user purchased something.
// -----------------------------
Upgrade Button on Tower 2 ==== UpgradeEvent(Tower2) =====> Broker <==== Subscribed to the event: ServerClient, SaveGame, GameplayCommands / CommandExecutor or so
Everything that changes your game in the long term (so, also after reloading the game) should be easily extensible.
In other words:
If you're making a tower defense
And a monster is spawned. Then that probably doesn't need a command, because you do not want to load this monster after restarting the app.
But if the round is won and the player receives permanent gold rewards, then that should probably fire a "WinRound"-Command or something like that.
