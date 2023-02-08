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
* The game crashes entering GT

Crashes
-------

* E managed to trigger a crash from climb to pit room before getting
    morph, but I don't know how he did it (I cannot reproduce it - E
    came down left side, may have walked over elevator, but that
    shouldn't matter, and I don't think it's there before morph)
* I was able to make spore spawn crash but I am not sure how

Incomplete
----------

* Pirates still explode when shot twice with ice - do any other enemies
    do this?
* Samus loses easy blue suit when taking damage, which can be
    frustrating when trying to shine spark to get through single chamber
* The baby should move more quickly toward Samus if it is very far away
    from Samus
* There are bones left if you revisit Croc
* Acid damage is still reduced in hard mode
* Need to test custom PLMs with xray
* Need to test croc fight in hard mode
* Easy grapple patch should fire grapple the full length without holding
    the fire button

Ideas
-----

* Easier wall jumping? (or just wall-hanging ala spiderman?)
* Change names of items (morph ball -> spider ball, speed booster ->
    blue suit)
* Geemers/zeelas/etc only pick samus up by one pixel, but it is a nice
    effect to pick her up by a few more pixels (three pixels less than
    the top of the enemy works well but needs more testing)

Cosmetic
--------

* Easy blue suit should not produce echoes
* Samus should wiggle during draygon "fight"
* Sometimes when using blue suit (I've seen this in Below Landing Site
    and Acid Snakes Room) Samus turns completely black for a moment like
    you just see her shadow
* Some of the seahorses in writg face the wrong direction initially
* In the room above croc, I was able to get stuck crouching between an
    enemy and a ceiling slope, resulting in samus oscillating
* Cursor has the wrong shape on the last page of the intro
* In escape climb, baby can briefly take Samus through the floor
* In escape climb, shine spark and/or echoes should be stopped when baby
    picks up Samus.
* The bomb blocks in phantoon's room leave behind black background
    instead of background that matches
* "1994" in title sequence is white instead of read
* Copyright notice is blue instead of white
* There are dead people on the title screen

Probably Won't Fix
------------------

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
* hard to get out of acid in acid statue room - I'm not sure why we
    though this was hard
* Please shorten volcano room earthquake - fixed
* Hard to get back up in room next to frog speedway
* It's really hard to get through rooms when the enemies push Samus
    (e.g. business center or green brinstar shaft) - fixed

Tools
-----

* Script to generate room list in asm format
* Write out size as a word instead of as bytes
* Write out warnpc for room headers and enemy population/set
* Room extract writes out incorrect tilemap end for rooms with layer 2
    tilemap (double chamber)
* Extract room PLMs
* add warnpc for all enemy populations and graphics sets
* add doors
