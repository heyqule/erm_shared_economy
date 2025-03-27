# ERM Protoss Economy
This mod is an internal library to share protoss economy features between protoss enemy mods. It provides a workflow to get biter egg if the player doesn't play with biter enemy at all.  

This mod does not add prototype or handle game logic by itself.  It's done in the enemy mod that uses this.

# Features:
- Added Larva egg economy.
- Added recipe to create more larva egg (Biochamber).
- Added recipe to convert larva egg to nutrients (Biochamber).
- Added recipe to convert larva egg to biter egg (Biochamber).
- Added recipe to produce uranium-238 with larva egg (New Assembly machine: Plasma Assembling Machine)
- Added technology to unlock playable zerg.
- Added Nexus for player to build nexus units.
- Added zealot, dragoon, darktemplar, scout, corsair, arbiter as playable units.
- Added protoss damage research to upgrade their damage (10 x 20%).

# Implementation Guide
See protoss's prototypes/economy.lua

