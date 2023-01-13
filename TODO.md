TODO
====

Bugs
----

* Ice beam cannot freeze enemies that take more than one shot
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
* Samus oscillates between riding/falling when atop an enemy going up a
    slope (e.g. in Terminator)
* Enemies that pull Samus offscreen seem to not trigger scrolling (e.g.
    in acid snake room after getting ice) - note this bug no longer gets
    triggered because the novas cannot pull Samus along, but that may
    change in the future

Incomplete
----------

* Kraid fight is still mostly vanilla
* Pit room is empty of enemies
* Ice beam gate room is hard without knowing how to use the run button
* Potential softlock at Kraid (all boss fights should start with the
    door unlocked)
* Potential softlock in speed hallway (though this is less likely)
* Dragons in rising tide should be intangible
* It is not obvious how to get down WS shaft
* Remove spikes from pre-xray room
* WS attic enemies make it challenging after power is on (maybe remove
  kihunters?)
* Eye doors sometimes still close
* Ridley needs to somehow drain Samus's health to 1 to encourage player
    to pick up the e-tank (or maybe just have the door locked)
* doors exiting baby should be left unlocked
* baby should ignore samus's shots otherwise it's too hard to shoot the
    seaweed
* it is no longer as easy to get on top of wavers as I would like
* it used to be that the mochtroids in halfie climb room would "pick up"
    samus as she is standing, but that was changed in order to prevent
    Samus from getting pushed; I would still like them to be able to
    pick her up, because that was fun
* I would like Samus to be able to "stick" herself to enemies while in
    morph ball form so she can ride on ceilings

Cosmetic
--------

* Easy blue suit should not produce echoes
* Blue suit animation is not visible in lava
* Pirate hitbox is noticeably tall
* Can I make the selected item in the HUD be the color of the door it
    opens?
* Lights in the tourian escape rooms blink too fast
* Samus should wiggle during draygon "fight"

Feedback from E
---------------

* business center is hard
* hard to get out of construction zone
* hard to hit chozo orb (can I make power beam hitbox bigger?)
* dead people in ceres (wife noticed)
* hard to get up parlor
* parlor bats are scary
* dachora room bats are scary
* alcatraz is intimidating
* geemers push samus off the ledge in parlor
* green pirates are a challenge
* fun to dance with big pink hoppers but they get in the way
* cacs are scary - remove them (E thinks they are spiders)
* it is hard to get on top of crabs in noob bridge
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
* Please shorten volcano room earthquake
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
