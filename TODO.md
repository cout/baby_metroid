TODO
====

Bugs
----

* Enemies that pull Samus offscreen seem to not trigger scrolling (e.g.
    in acid snake room after getting ice)
    - ~~note this bug no longer gets triggered because the novas cannot
      pull Samus along, but that may change in the future~~
    - it is the future now, and this has changed, ~~but I can no longer
      trigger the bug~~, and I have been able to trigger the bug.
* Geemers (and possibly other enemies) can pull Samus partially up into
    a block when she is morphed (though it is possible this can be
    triggered when she is not morphed)
* When riding a geemer up a slope, Samus loses just a little bit of X
    position relative to the geemer every now and then; this effect is
    amplified if Samus is morphed inside the geemer rather than riding
    on top.

Crashes
-------

* E managed to trigger a crash from climb to pit room before getting
    morph, but I don't know how he did it (I cannot reproduce it - E
    came down left side, may have walked over elevator, but that
    shouldn't matter, and I don't think it's there before morph)
* I was able to make spore spawn crash but I am not sure how

Softlocks
---------

* Kraid - run out of missiles
* Speed hallway - run out of missiles

Incomplete
----------

* Eye doors sometimes still close
* It is possible to spin jump up through a flying creature, but it is
    not possible jump straight up through one.
* Pirates still explode when shot twice with ice - do any other enemies
    do this?
* Escape music in Climb feels out of place?
* Samus loses easy blue suit when taking damage, which can be
    frustrating when trying to shine spark to get through single chamber
* The baby should move more quickly toward Samus if it is very far away
    from Samus
* Norfair spiky room is intimidating
* Hard to get out of acid in acid statue room


Ideas
-----
* Easier wall jumping? (or just wall-hanging ala spiderman?)
* Change names of items (morph ball -> spider ball, speed booster ->
    blue suit)

Cosmetic
--------

* Easy blue suit should not produce echoes
* Lights in the tourian escape rooms blink too fast
* Samus should wiggle during draygon "fight"
* Geemers/zeelas/etc only pick samus up by one pixel, but it is a nice
    effect to pick her up by a few more pixels (three pixels less than
    the top of the enemy works well but needs more testing)
* Sometimes when using blue suit (I've seen this in Below Landing Site
    and Acid Snakes Room) Samus turns completely black for a moment like
    you just see her shadow
* Current position on HUD minimap shows up as black during transition
* If missiles are selected when pausing they temporarily turn white with
    a yellow border
* The pink color for missiles in the HUD is two-tone instead of
    three-tone (not easy to fix)
* Because Botwoon's movement is fixed on the first screen, it does not
    really look like Botwoon is breaking the wall, but rather that the
    wall is crumbling at random.
* Missile icon turns red at the very end of a transition
* Some of the seahorses in writg face the wrong direction initially
* In the room above croc, I was able to get stuck crouching between an
    enemy and a ceiling slope, resulting in samus oscillating
* Cursor has the wrong shape on the last page of the intro
* Warehouse statue is not visible when entering the room; it only
    becomes visible after the room's main routine executes for the first
    time.
* In climb escape, Samus is briefly visible at the bottom of the screen
    after passing through the door
* In climb escape, baby can take Samus through the floor
* In climb escape, baby does not pick Samus up if Samus runs to the
    right-side wall, because baby is too high
* In climb escape, baby can take Samus through the right-side door

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
* There is no statue in caterpillar room (E. did fine without it)
* Put a nova on the floor of business center to help Samus climb (Samus
    can always knock one down with a super)
* Pirate hitbox is noticeably tall (requires changing the spritemaps not
    just the radius)

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
* confusing to see samus statue in red tower before the clue is usable -
    fixed
* ditto warehouse entrance statue - fixed
* which block to bomb in red tower is hard
* there should be a gate in noob bridge otherwise it's a long trip back
    if you return to green hill zone - fixed by making zeelas move
    faster
* frozen creatures were confusing (why were they there? will I get
    frozen?) - I did this before I was comfortable with level editing
* E did not know how to get on rippers in bat room - fixed?
* E thinks he can "push" enemies but it's really just a collision --
    maybe I can make enemies get a little push? - no, but samus can push
    croc
* (related idea - maybe grapple beam can "pull" enemies instead of just
    killing them - but only when samus is walking)
* norfair spiky room is too hard
* hard to get across acid in LN main hall - fixed
* hard to get out of acid in acid statue room
* Please shorten volcano room earthquake - fixed
* Hard to get back up in room next to frog speedway
* It's really hard to get through rooms when the enemies push Samus
    (e.g. business center or green brinstar shaft) - fixed

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
