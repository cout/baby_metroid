TODO
====

Bugs
----

* Enemies that pull Samus offscreen might do not trigger scrolling.  To
    reproduce: allow all three novas to go ahead of Samus leaving ice,
    then get pulled along (not pushed) by the 3rd nova.
* Contact damage index is ignored for blue suit if easy blue suit is
     canceled when entering the room
* Big Baby in MB room should not attach to Samus
* When Joonie fought Botwoon, Botwoon came out of the hole but never
    re-entered the hole AND did not break the wall.  I think Joonie
    came out of the hole at the right time to trigger a race condition.
    The fix was for Samus to "hide" again.

Crashes/Softlocks
-----------------

* E managed to trigger a crash from climb to pit room before getting
    morph, but I don't know how he did it (I cannot reproduce it - E
    came down left side, may have walked over elevator, but that
    shouldn't matter, and I don't think it's there before morph)
* Joonie managed to softlock in old mother brain room by getting pinned
    between an etecoon and the ceiling.

Incomplete
----------

* Green pirates are OHKO (or two shots with ice); other enemies do not
    behave this way
* The baby should move more quickly toward Samus if it is very far away
    from Samus
* Acid damage is still reduced in hard mode
* Need to test custom PLMs with xray
* Golden torizo fight is a vanilla one-shot fight, which is probably too
    scary
* Baby in various forms should not damage Samus in hard mode
* Hatchling does not interact with Samus beam
* Add credits for jooniejoone and somerando (caauyjip) and everyone who
    posted to the metroidconstruction forum
* It is possible to kill Draygon

Cosmetic
--------

* Easy blue suit should not produce echoes
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
* Terminator is very laggy
* Samus's ship shows up incorrectly in the cutscene before zebes on
    Mesen-S
* There is a graphical glitch with the HUD just after a PB goes off in
    GT room when jumping up to get the super

Probably Won't Fix
------------------

* Geemers (and possibly other enemies) can pull Samus partially up into
    a block when she is morphed (though it is possible this can be
    triggered when she is not morphed)
* When riding a geemer up a slope, Samus loses just a little bit of X
    position relative to the geemer every now and then; this effect is
    amplified if Samus is morphed inside the geemer rather than riding
    on top.
* Terminator has an intense amount of lag in hard mode (and maybe in
    easy mode) with my usual strat.  Not sure if it has to do with Samus
    firing or just collision detection.
* It is possible to clip past Crocomire.  This looks a little glitchy,
    but everything works correctly.
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
* Samus can jump over the green pirates' feet, but Samus can only walk
    or roll through the pirates if they are walking toward her.

Feedback from E
---------------

* business center is hard
* hard to get out of construction zone
* hard to hit chozo orb (can I make power beam hitbox bigger?)
* dead people in ceres (wife noticed) - fixed
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

Future Ideas
------------

* Easier wall jumping? (or just wall-hanging ala spiderman?)
* Change names of items (morph ball -> spider ball, speed booster ->
    blue suit)
* Geemers/zeelas/etc only pick samus up by one pixel, but it is a nice
    effect to pick her up by a few more pixels (three pixels less than
    the top of the enemy works well but needs more testing)
* Samus should take damage when grappling enemies in hard mode
* Small baby could have a shot reaction that is more than just a cry
* Add a hatchling to the room before spore spawn
* Make Samus wiggle during draygon "fight"

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
