# Notes on the game

Personal notes from past discussions and from looking at the code.  Not necessarily complete or accurate.

## Nomenclature

There are 3 types of notes in the game interface:
* The **lane notes** move from the left/right/top of the screen toward a **catcher** in the middle.  The path that each follows is called a **lane**? These notes are the most common ones, at least if things follow similarly to GVH.  These notes are  easy to hit, as one lane catcher  can be held open at a time, with no timing required to hit notes exactly.
* The **chord notes**, if they correspond to the GVH ones, are probably the collapsing rings that have to be triggered as soon as the rings reach an inner circle.  These might be a different shape though... if I recall one mock-up I saw used a diamond shape.
* The **drop notes** probably correspond to the GVH "V" shapes that drop down simultaneously from the left/right sides of the screen.  Probably the least common note type, maybe reserved for finale or crescendos?

The last two note types aren't implemented as of the writing of this note, so I'm mostly guessing about what they would be.

## Project architecture

I think it's a "pipe" architecture?  My memory is a little fuzzy on that point, and the reference information is now lost.

Game mechanics are all event-based, controlled by signals.  Signals and global variables are all defined within the **Overseer**, which is a global module accessible from everywhere else. Within the Overseer are functions for controlling the global state and triggering the signals.  It is up to the other scenes to connect themselves to the Overseer's signals.

## Scenes and scripts

### Inputs

User inputs are handled by LaneInputCatcher, ChordInputCatcher, and DropInputCatcher.  These ultimately invoke signals from the Overseer.

### Visuals

So far, the scenes for game visuals are the **LaneNote** (the little circles), which travel along a **Lane** toward the **Catcher**.

There's a "FailNote" scene, but it's not referenced by anything.  Maybe left over from a previous iteration of code?

### Animations

Some animations for the visual elements are handled by **CatcherSpriteStateManager**, **CenterLineSpriteStateManager**, and **CenterSpriteAnimator**.  These interact with AnimationPlayers from the Catcher scene.

### Custom data types

These are stored in the "tools" directory.
* The **Stack** type is self-explanatory.  It's used in LaneInputCatcher to handle the case where multiple Lanes are triggered by the user.  Since only one Lane should actually be active at a time, this determines which Lane that is.  In this case, it will be the Lane for the last key pressed down.  If that key is released (but other keys are still held down) then it will switch to activating the second-last key, etc.
* The **Queue** type is not currently used by anything.   Perhaps it was an alternative to the Stack for controlling which Lane to make active?
* The **NoteType** seems to be a way to enumerate the different types of notes.  Instances of this type are created in the **NoteTypes** script, one for each type (LEFT\_LANE, TOP\_LANE, etc.)

## Charts

There is nothing in the project (as of writing this note) to handle the charts (timing and types of notes for the songs).

If I recall correctly, the game will be using the same chart format that's used in Clone Hero.  Some documentation on the file spec is [here](https://github.com/TheNathannator/GuitarGame_ChartFormats).

Some sample charts can be downloaded [here](https://customsongscentral.com/).

Some points of interest:
* There are two ways to encode the charts, either in a `.mid` or a `.chart` file.  The latter seems more common from the samples I've looked at, and it's also an easier format to parse since it's in text format.
* Most audio files seem to be in `.ogg` format, which should play natively from Godot.  However, sometimes chart audio is in `.opus` format, and Godot 4.x doesn't (yet) have support for that.  Some more information in [this GitHub issue](https://github.com/godotengine/godot-proposals/issues/6440).
* Someone already made a [Godot plugin](https://github.com/Lewin225/GodotHeroPlugin) for reading chart files.  No license on on it, though.  Could contact the developer for permission to include it.  Or, could be fun to build a reader from scratch.

I'm curious how the notes in the chart files will get mapped to the game.  The songs could include a 5- or 6-string guitar, possibly bassline and drums.  How would these get mapped to the lanes, chords, and drops?

