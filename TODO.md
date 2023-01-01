TODO
====

Bugs
----

* Ice beam cannot freeze enemies that take more than one shot
* Enemies that pull Samus offscreen seem to not trigger scrolling (e.g.
    in acid snake room after getting ice)
* Cannot run through pirates in croc speedway with speed
* Enemies that can move through walls can pull Samus through the floor
    (this is particularly bad with rinkas in MB room)
* Screw attack does not work
* Speed hallway - it is too easy to get stuck under the crumbles
* Blue suit is lost in lava, which can make some rooms difficult
* E managed to trigger a crash from climb to pit room before getting
    morph, but I don't know how he did it (I cannot reproduce it - E
    came down left side, may have walked over elevator, but that
    shouldn't matter, and I don't think it's there before morph)
* Sometimes the top door in Climb is unlocked (it should be locked)
* door at top of climb before getting morph has peculiar scroll
* when clearing the blue suit flag, the flag that causes echoes should
    also be cleared
* easy blue suit is cleared if touching a block horizontally while the
    run button is pressed
* Spore spawn is brown if Samus leaves and comes back
* Caterpillar room statue is missing
* Below Spazer room crashes on bsnes

Incomplete
----------

* Kraid fight is still mostly vanilla
* Phantoon is OHKO but should be a passive fight
* Croc is still vanilla (should "take a bath")
    * plan: croc is vulnerable to uncharged beam and has a larger
        hitbox.  disable flashing when hit and don't require mouth to be
        open.  change acid to water.  fight ends when croc is in the
        water taking a bath.  no spikes on the walls.  croc cannot move
        forward past the door.  give some hint that croc needs a bath,
        otherwise croc just looks scary.
* Pit room is empty of enemies
* The spikes in double chamber are difficult
* Ice beam gate room is hard without knowing how to use the run button
* Stop gadora from shooting
* Keep gadora eyes open?
* Make gadora vulnerable to charge?
* Bat room - remove spikes
* Potential softlock at Kraid (all boss fights should start with the
    door unlocked)
* Potential softlock in speed hallway (though this is less likely)
* Moat room bridge is not aligned on the right side
* Dragons in rising tide should be intangible
* It is not obvious how to get down WS shaft
* Red tower speed blocks should be 4-wide
* It is not possible to go down red tower (need to add a crumble block)
* Decrease spike damage
* Remove spikes from pre-xray room
* Tunnel in phantoon's room should be a bombable block
* Change color of power control (or make it use WS tiles instead of CRE)

Feedback from E
---------------

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
* E did not know how to get on rippers in bat room
* E thinks he can "push" enemies but it's really just a collision --
    maybe I can make enemies get a little push?
* (related idea - maybe grapple beam can "pull" enemies instead of just
    killing them - but only when samus is walking)
* norfair spiky room is too hard

Tools
-----

* Script to generate room list in asm format
* Write out size as a word instead of as bytes
* Extract room data script should not include duplicate FX/graphics
    sets/population (see kraid room as example)
* Write out warnpc for room headers and enemy population/set
