TODO
====

Bugs
----

* Ice beam cannot freeze enemies that take more than one shot (because
    they do not take damage)
* It is not possible to farm with ice beam, and unfreezing an enemy with
    ice beam kills it
* Cannot run through pirates in croc speedway with speed (I am not sure
    whether this can be fixed in a general way and keep the enemies as
    solid)
* Screw attack does not work
* Speed hallway - it is too easy to get stuck under the crumbles
* E managed to trigger a crash from climb to pit room before getting
    morph, but I don't know how he did it (I cannot reproduce it - E
    came down left side, may have walked over elevator, but that
    shouldn't matter, and I don't think it's there before morph)
* Sometimes the top door in Climb is unlocked (it should be locked)
* door at top of climb before getting morph has peculiar scroll
* Spore spawn is brown if Samus leaves and comes back
* Caterpillar room statue is missing
* Enemies that pull Samus offscreen seem to not trigger scrolling (e.g.
    in acid snake room after getting ice)
    - ~~note this bug no longer gets triggered because the novas cannot
      pull Samus along, but that may change in the future~~
    - it is the future now, and this has changed, but I can no longer
      trigger the bug
* Geemers (and possibly other enemies) can pull Samus partially up into
    a block when she is morphed (though it is possible this can be
    triggered when she is not morphed)
* When riding a geemer up a slope, Samus loses just a little bit of X
    position relative to the geemer every now and then; this effect is
    amplified if Samus is morphed inside the geemer rather than riding
    on top.
* It is possible to spin jump up through a flying creature, but it is
    not possible jump straight up through one.
* It is currently not possible to exit ceres, because the cutscene jumps
    back to the intro

Incomplete
----------

* Potential softlock at Kraid (all boss fights should start with the
    door unlocked)
* Potential softlock in speed hallway (though this is less likely)
* Eye doors sometimes still close
* Now that Samus can ride crawling creatures up a wall/ceiling, there
    should be crawling creatures on the floors of tall-ish shafts (e.g.
    business center)
* Grapple beam is probably tricky for a child to use

Ideas
-----
* Ridley could somehow drain Samus's health to 1 to encourage player
    to pick up the e-tank (or maybe just have the door locked)
* Easier wall jumping? (or just wall-hanging ala spiderman?)

Probably Won't Fix
------------------

* Kraid fight is still mostly vanilla (I think it's fine)
* Ice beam gate room is hard without knowing how to use the run button
    (E. finally knows how to do this, and it's not required for beating
    the game)
* Dragons in rising tide should be intangible (E. takes the top
    route)
* it is no longer as easy to get on top of wavers as I would like
    (workaround: use morph ball)
* Samus can move through enemies going the opposite direction as she is,
    but she cannot move through enemies going the same direction
    (workaround: use bombs)
* WS attic enemies make it challenging after power is on (E. was able to
    do this room just fine)

Cosmetic
--------

* Easy blue suit should not produce echoes
* Pirate hitbox is noticeably tall
* Lights in the tourian escape rooms blink too fast
* Samus should wiggle during draygon "fight"
* Rename morph ball to spider ball?
* Broken tube in BT's room is not obvious it was holding a metroid (to
    fix this, I need to create a baby baby metroid enemy that runs away
    when Samus enter's BT's room)
* Geemers/zeelas/etc only pick samus up by one pixel, but it is a nice
    effect to pick her up by a few more pixels (three pixels less than
    the top of the enemy works well but needs more testing)
* Sometimes when using blue suit (I've seen this in Below Landing Site
    and Acid Snakes Room) Samus turns completely black for a moment like
    you just see her shadow
* The easy blue suit patch causes Samus to briefly be visible in color
    before the first flashback scene in the intro
* Disable Japanese text option
* Current position on HUD minimap shows up as black during transition
* If missiles are selected when pausing they temporarily turn white with
    a yellow border
* The pink color for missiles in the HUD is two-tone instead of
    three-tone (not easy to fix)
* Because Botwoon's movement is fixed on the first screen, it does not
    really look like Botwoon is breaking the wall, but rather that the
    wall is crumbling at random.

Feedback from E
---------------

* business center is hard
* hard to get out of construction zone
* hard to hit chozo orb (can I make power beam hitbox bigger?)
* dead people in ceres (wife noticed)
* hard to get up parlor - fixed?
* parlor bats are scary
* dachora room bats are scary
* alcatraz is intimidating
* geemers push samus off the ledge in parlor - fixed
* green pirates are a challenge
* fun to dance with big pink hoppers but they get in the way - fixed
* cacs are scary - remove them (E thinks they are spiders)
* it is hard to get on top of crabs in noob bridge - fixed?
* confusing to see samus statue in red tower before the clue is usable
* ditto warehouse entrance statue
* which block to bomb in red tower is hard
* there should be a gate in noob bridge otherwise it's a long trip back
    if you return to green hill zone
* frozen creatures were confusing (why were they there? will I get
    frozen?) - I did this before I was comfortable with level editing
* E did not know how to get on rippers in bat room - fixed?
* E thinks he can "push" enemies but it's really just a collision --
    maybe I can make enemies get a little push?
* (related idea - maybe grapple beam can "pull" enemies instead of just
    killing them - but only when samus is walking)
* norfair spiky room is too hard
* hard to get across acid in LN main hall
* hard to get out of acid in acid statue room
* Please shorten volcano room earthquake - fixed
* Hard to get back up in room next to frog speedway
* It's really hard to get through rooms when the enemies push Samus
    (e.g. business center or green brinstar shaft)

Tools
-----

* Script to generate room list in asm format
* Write out size as a word instead of as bytes
* Extract room data script should not include duplicate FX/graphics
    sets/population (see kraid room as example)
* Write out warnpc for room headers and enemy population/set
* Room extract writes out incorrect tilemap end for rooms with layer 2
    tilemap (double chamber)
* Extract room PLMs
* add warnpc for all enemy populations and graphics sets
* add doors
