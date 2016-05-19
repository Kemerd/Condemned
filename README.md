# Codemned
A nutscript-based roleplay schema based in a zombie-scenario post-apocalyptic world.

[b]My planning list:[/b]
Project Zomboid Like Inventory
Weapons attract zombies
Containers & Items across map - DONEish
Weather makes you sick
Needs/Statuses
All NMRiH Weapons
All NMRiH zombie models
Gore on zombies(?) - DONE
Military hotel/safezone.
Work on Necro Junction More.
Tunnel leading to exterior forest?
Crafting
Airdrops
Make zombies not die in 2 hits.
Fix nutscript death glitch.
Make item spawning categories.
Zombie death t-posing
Zombie ragdolls clipping players
Weapon bobbing
Map item spawning/containers

After hours of work, I finally go the Container system to work 99%!

How it works:
There will be containers around the map.
In a LUA file, there are defined container IDs, each with a list of items that are able to spawn in the container. Each has a rarity for each container-- meaning it's not 100% item based. You're more likely to find ammunition in a gun box than a shelf-- and you won't be finding a pistol in a fridge.
Each container will be a container "type". If the container is empty, it will spawn new items, meaning an occupied container will never "reset". (That means if you want more loot, empty out those containers! We have an anti-lag system for a reason.)

EDIT: Modified the system for ease of creation & use. A storage item that is created initially has no "container" values that marks it for items to spawn in it. An administrator can type /containerset to set the container's ID value to the "default" ID value specified in a .LUA file, or define a custom ID with /containersetid (this also works for props that do not have a specially defined ID). 

Todo:
Support for map keyvalues for containers.