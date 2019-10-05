-- Copyright (c) 2008--2011 Andres Loeh
-- Copyright (c) 2010--2019 Mikolaj Konarski and others (see git history)
-- This file is a part of the computer game Allure of the Stars
-- and is released under the terms of the GNU Affero General Public License.
-- For license and copyright information, see the file LICENSE.
--
-- | Terrain tile definitions.
module Content.TileKind
  ( content
  ) where

import Prelude ()

import Game.LambdaHack.Core.Prelude

import qualified Data.Text as T

import Game.LambdaHack.Content.TileKind
import Game.LambdaHack.Definition.Color
import Game.LambdaHack.Definition.Defs

content :: [TileKind]
content =
  [unknown, unknownOuterFence, basicOuterFence, bedrock, wall, wallSuspect, wallObscured, wallObscuredDefaced, wallObscuredFrescoed, pillar, pillarCache, lampPost, signboardUnread, signboardRead, tree, treeBurnt, treeBurning, rubble, rubbleSpice, doorTrapped, doorClosed, stairsUp, stairsTrappedUp, stairsOutdoorUp, stairsGatedUp, stairsDown, stairsTrappedDown, stairsOutdoorDown, stairsGatedDown, escapeUp, escapeDown, escapeOutdoorDown, wallGlass, wallGlassSpice, pillarIce, pulpit, bush, bushBurnt, bushBurning, fog, fogDark, smoke, smokeDark, doorOpen, floorCorridor, floorArena, floorDamp, floorDirt, floorDirtSpice, floorActor, floorActorItem, floorAshes, shallowWater, shallowWaterSpice, shallowWater2, floorRed, floorBlue, floorBrown, floorArenaShade ]
  ++ map makeDarkColor ldarkColorable
  -- Allure-specific
  ++ [oriel, outerHullWall, rubbleBurning, rubbleBurningSpice, wallOpenable, wallObscuredSafety, wallObscured3dBillboard, wallObscuredPipework, liftShaft, rock, pillarCache2, pillarCache3, stairsDecontaminatingUp, stairsWelded, stairsLiftUp, stairsLiftTrappedUp, stairsLiftGatedUp, stairsLiftDecontaminatingUp, stairsLiftWelded, stairsDecontaminatingDown, stairsLiftDown, stairsLiftTrappedDown, stairsLiftGatedDown, stairsLiftDecontaminatingDown, escapeSpaceshipDown, emptyAirlock, reinforcedWall, reinforcedWallSpice, wallShuttle, wallShuttleSpice, machineWall, machineWallSpice, underbrushBurning, floorOily, oilSpill, oilSpillSpice, floorWindow, underbrush]

unknown,    unknownOuterFence, basicOuterFence, bedrock, wall, wallSuspect, wallObscured, wallObscuredDefaced, wallObscuredFrescoed, pillar, pillarCache, lampPost, signboardUnread, signboardRead, tree, treeBurnt, treeBurning, rubble, rubbleSpice, doorTrapped, doorClosed, stairsUp, stairsTrappedUp, stairsOutdoorUp, stairsGatedUp, stairsDown, stairsTrappedDown, stairsOutdoorDown, stairsGatedDown, escapeUp, escapeDown, escapeOutdoorDown, wallGlass, wallGlassSpice, pillarIce, pulpit, bush, bushBurnt, bushBurning, fog, fogDark, smoke, smokeDark, doorOpen, floorCorridor, floorArena, floorDamp, floorDirt, floorDirtSpice, floorActor, floorActorItem, floorAshes, shallowWater, shallowWaterSpice, shallowWater2, floorRed, floorBlue, floorBrown, floorArenaShade :: TileKind
-- Allure-specific
oriel,       outerHullWall, rubbleBurning, rubbleBurningSpice, wallOpenable, wallObscuredSafety, wallObscured3dBillboard, wallObscuredPipework, liftShaft, rock, pillarCache2, pillarCache3, stairsDecontaminatingUp, stairsWelded, stairsLiftUp, stairsLiftTrappedUp, stairsLiftGatedUp, stairsLiftDecontaminatingUp, stairsLiftWelded, stairsDecontaminatingDown, stairsLiftDown, stairsLiftTrappedDown, stairsLiftGatedDown, stairsLiftDecontaminatingDown, escapeSpaceshipDown, emptyAirlock, reinforcedWall, reinforcedWallSpice, wallShuttle, wallShuttleSpice, machineWall, machineWallSpice, underbrushBurning, floorOily, oilSpill, oilSpillSpice, floorWindow, underbrush :: TileKind

ldarkColorable :: [TileKind]
ldarkColorable = [tree, bush, floorCorridor, floorArena, floorDamp, floorDirt, floorDirtSpice, floorActor, floorActorItem, shallowWater, shallowWaterSpice, shallowWater2, floorOily]

-- Symbols to be used:
--         LOS    noLOS
-- Walk    .'~    :;
-- noWalk  %^     #O&<>+
--
-- can be opened ^&+
-- can be closed '
-- some noWalk can be changed without opening, regardless of symbol
-- not used yet:
-- : (curtain, etc., not flowing, but solid and static)
-- ` (not distinct enough from ' and already used for some blasts)

-- Note that for AI hints and UI comfort, most multiple-use @Embed@ tiles
-- should have a variant, which after first use transforms into a different
-- colour tile without @ChangeTo@ and similar (which then AI no longer touches).
-- If a tile is supposed to be repeatedly activated by AI (e.g., cache),
-- it should keep @ChangeTo@ for the whole time.

-- * Main tiles, modified for Allure; some removed

-- ** Not walkable

-- *** Not clear

unknown = TileKind  -- needs to have index 0 and alter 1; no other with 1
  { tsymbol  = ' '
  , tname    = "unknown space"
  , tfreq    = [("unknown space", 1)]
  , tcolor   = defFG
  , tcolor2  = defFG
  , talter   = 1
  , tfeature = [Dark]
  }
unknownOuterFence = TileKind
  { tsymbol  = ' '
  , tname    = "unknown space"
  , tfreq    = [("unknown outer fence", 1)]
  , tcolor   = defFG
  , tcolor2  = defFG
  , talter   = maxBound  -- impenetrable
  , tfeature = [Dark]
  }
basicOuterFence = TileKind
  { tsymbol  = '#'
  , tname    = "habitat containment wall"
  , tfreq    = [("habitat containment wall", 1)]
  , tcolor   = BrBlack
  , tcolor2  = BrBlack
  , talter   = maxBound  -- impenetrable
  , tfeature = []
  }
bedrock = TileKind
  { tsymbol  = '#'
  , tname    = "wall"
  , tfreq    = [ ("fillerWall", 1), ("legendLit", 100), ("legendDark", 100)
               , ("rogueSet", 60), ("museumSetDark", 4), ("noiseSetLit", 450)
               , ("powerSetDark", 450), ("battleSetDark", 250)
               , ("escapeSetDark", 4)
               , ("stair terminal Lit", 100), ("stair terminal Dark", 100)
               , ("doorlessWallOver_#", 80), ("doorlessMachineryOver_#", 1) ]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 100
  , tfeature = []
  }
wall = bedrock
  { tfreq    = [("trappableWall", 1), ("rectWindowsOver_%", 80)]
  , tfeature = [BuildAs "suspect wall"]
  }
wallSuspect = TileKind  -- only on client
  { tsymbol  = '#'
  , tname    = "suspect wall"
  , tfreq    = [("suspect wall", 1)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 2
  , tfeature = [ RevealAs "trapped door"
               , ObscureAs "obscured wall"
               ]
  }
wallObscured = TileKind
  { tsymbol  = '#'
  , tname    = "scratched wall"
  , tfreq    = [("obscured wall", 50)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 5
  , tfeature = [ Embed "scratch on wall"
               , HideAs "suspect wall"
               ]
  }
wallObscuredDefaced = TileKind
  { tsymbol  = '#'
  , tname    = "defaced wall"
  , tfreq    = [ ("obscured wall", 25), ("escapeSetDark", 2)
               , ("museumSetDark", 2) ]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 5
  , tfeature = [ Embed "obscene pictogram"
               , HideAs "suspect wall"
               ]
  }
wallObscuredFrescoed = TileKind
  { tsymbol  = '#'
  , tname    = "subtle mural"
  , tfreq    = [("obscured wall", 5), ("museumSetDark", 2)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 5
  , tfeature = [ Embed "subtle fresco"
               , HideAs "suspect wall"
               ]  -- a bit beneficial, but AI would loop if allowed to trigger
                  -- so no @ConsideredByAI@
  }
pillar = TileKind
  { tsymbol  = '0'
  , tname    = "construction beam"
  , tfreq    = [ ("legendLit", 100), ("legendDark", 100)
               , ("museumSetDark", 20), ("emptySetLit", 20) ]
  , tcolor   = BrCyan  -- not BrWhite, to tell from heroes
  , tcolor2  = Cyan
  , talter   = 100
  , tfeature = []
  }
pillarCache = TileKind
  { tsymbol  = '#'
  , tname    = "abandoned stash"
  , tfreq    = [ ("cachable abandoned", 20)
               , ("cache maze", 33), ("cache shuttle", 25) ]
  , tcolor   = BrBlue
  , tcolor2  = Blue
  , talter   = 5
  , tfeature = [ Embed "abandoned cache"
               , ChangeTo "cachable abandoned", ConsideredByAI ]
      -- Not explorable, but prominently placed, so hard to miss.
      -- Very beneficial, so AI eager to trigger, unless wary of traps.
  }
lampPost = TileKind
  { tsymbol  = '0'
  , tname    = "lamp post"
  , tfreq    = [("lampPostOver_0", 1)]
  , tcolor   = BrYellow
  , tcolor2  = Brown
  , talter   = 100
  , tfeature = []  -- embed something and explain how there's often
                   -- artificial ambient light in the habitats, but not in all
                   -- of them and in both cases lamps are used to provide fancy
                   -- (extra) lighting; say how low energy drain, such as
                   -- permanent ambient light, is not a problem due to tech
                   -- and also because it's a tiny fraction of what is needed
                   -- for the ecosystem/life support
  }
signboardUnread = TileKind  -- client only, indicates never used by this faction
  { tsymbol  = '0'
  , tname    = "signboard"
  , tfreq    = [("signboard unread", 1)]
  , tcolor   = BrCyan
  , tcolor2  = Cyan
  , talter   = 5
  , tfeature = [ ConsideredByAI  -- changes after use, so safe for AI
               , RevealAs "signboard"  -- to display as hidden
               ]
  }
signboardRead = TileKind
  { tsymbol  = '0'
  , tname    = "signboard"
  , tfreq    = [ ("signboard", 1), ("emptySetLit", 1)
               , ("arenaSetLit", 1), ("arenaSetDark", 1), ("museumSetDark", 1)
               , ("escapeSetDark", 1) ]
  , tcolor   = BrCyan
  , tcolor2  = Cyan
  , talter   = 5
  , tfeature = [Embed "signboard", HideAs "signboard unread"]
  }
tree = TileKind
  { tsymbol  = '0'
  , tname    = "tree"
  , tfreq    = [ ("emptySetLit", 1), ("brawlSetLit", 140)
               , ("shootoutSetLit", 10), ("huntSetLit", 10)
               , ("escapeSetLit", 35), ("zooSetDark", 20)
               , ("treeShadeOver_0_Lit", 1) ]
  , tcolor   = BrGreen
  , tcolor2  = Green
  , talter   = 4
  , tfeature = [ChangeWith ["fire source"] "burning tree"]
  }
treeBurnt = tree
  { tname    = "burnt tree"
  , tfreq    = [("zooSetDark", 10), ("tree with fire", 30)]
  , tcolor   = BrBlack
  , tcolor2  = BrBlack
  , tfeature = [Dark]
  }
treeBurning = tree  -- present in "emptySetLit" as early light/fire source
  { tname    = "burning tree"
  , tfreq    = [ ("emptySetLit", 1), ("zooSetDark", 60)
               , ("tree with fire", 70), ("burning tree", 1) ]
  , tcolor   = BrRed
  , tcolor2  = Red
  , talter   = 5
  , tfeature = [Embed "big fire", ChangeTo "tree with fire"]
      -- TODO: dousing off the tree will have more sense when it periodically
      -- explodes, hitting and lighting up the team and so betraying it
  }
rubble = TileKind
  { tsymbol  = '&'
  , tname    = "rubble pile"
  , tfreq    = [ ("rubble", 1), ("legendLit", 1), ("legendDark", 1)
               , ("stair terminal Lit", 6), ("stair terminal Dark", 6)
               , ("lift terminal Lit", 6), ("lift terminal Dark", 6)
               , ("emptySetLit", 3), ("exitSetLit", 8)
               , ("noiseSetLit", 50), ("powerSetDark", 150)
               , ("zooSetDark", 100), ("ambushSetDark", 3) ]
  , tcolor   = BrYellow
  , tcolor2  = Brown
  , talter   = 4  -- boss can dig through
  , tfeature = [OpenTo "floorAshesLit", Embed "rubble"]
      -- It's not explorable, due to not being walkable nor clear and due
      -- to being a door (@OpenTo@), which is kind of OK, because getting
      -- the item is risky and, e.g., AI doesn't attempt it.
      -- Also, AI doesn't go out of its way to clear the way for heroes.
      -- RUbble can't be ignited, but burning installation, when doused,
      -- becomes rubble. That's different than with trees and bushes.
  }
rubbleSpice = rubble
  { tfreq    = [ ("smokeClumpOver_f_Lit", 1), ("smokeClumpOver_f_Dark", 1)
               , ("rubbleOrWaste_Lit", 1), ("rubbleOrWaste_Dark", 1)
               , ("cache deposit", 33), ("cachable deposit", 80) ]
  , tfeature = Spice : tfeature rubble
  }
doorTrapped = TileKind
  { tsymbol  = '+'
  , tname    = "trapped door"
  , tfreq    = [("trapped door", 1)]
  , tcolor   = BrRed
  , tcolor2  = Red
  , talter   = 2
  , tfeature = [ Embed "doorway trap"
               , OpenTo "open door"
               , HideAs "suspect wall"
               ]
  }
doorClosed = TileKind
  { tsymbol  = '+'
  , tname    = "closed door"
  , tfreq    = [("legendLit", 100), ("legendDark", 100), ("closed door", 1)]
  , tcolor   = Brown
  , tcolor2  = BrBlack
  , talter   = 2
  , tfeature = [OpenTo "open door"]  -- never hidden
  }
stairsUp = TileKind
  { tsymbol  = '<'
  , tname    = "staircase up"
  , tfreq    = [("staircase up", 9), ("ordinary staircase up", 1)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 0  -- very easy stairs, unlike all others
  , tfeature = [Embed "staircase up", ConsideredByAI]
  }
stairsTrappedUp = TileKind
  { tsymbol  = '<'
  , tname    = "windy staircase up"
  , tfreq    = [("staircase up", 1)]
  , tcolor   = BrRed
  , tcolor2  = Red
  , talter   = talterForStairs
  , tfeature = [ Embed "staircase up", Embed "staircase trap up"
               , ConsideredByAI, ChangeTo "ordinary staircase up" ]
                 -- AI uses despite the trap; exploration more important
  }
stairsOutdoorUp = stairsUp
  { tname    = "signpost pointing backward"
  , tfreq    = [("staircase outdoor up", 1)]
  , talter   = talterForStairs
  }
stairsGatedUp = stairsUp
  { tname    = "gated staircase up"
  , tfreq    = [("gated staircase up", 1)]
  , talter   = talterForStairs + 2  -- animals and bosses can't use
  }
stairsDown = TileKind
  { tsymbol  = '>'
  , tname    = "staircase down"
  , tfreq    = [("staircase down", 9), ("ordinary staircase down", 1)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 0  -- very easy stairs, unlike all others
  , tfeature = [Embed "staircase down", ConsideredByAI]
  }
stairsTrappedDown = TileKind
  { tsymbol  = '>'
  , tname    = "crooked staircase down"
  , tfreq    = [("staircase down", 1)]
  , tcolor   = BrRed
  , tcolor2  = Red
  , talter   = talterForStairs
  , tfeature = [ Embed "staircase down", Embed "staircase trap down"
               , ConsideredByAI, ChangeTo "ordinary staircase down" ]
  }
stairsOutdoorDown = stairsDown
  { tname    = "signpost pointing forward"
  , tfreq    = [("staircase outdoor down", 1)]
  , talter   = talterForStairs
  }
stairsGatedDown = stairsDown
  { tname    = "gated staircase down"
  , tfreq    = [("gated staircase down", 1)]
  , talter   = talterForStairs + 2  -- animals and bosses can't use
  }
escapeUp = TileKind
  { tsymbol  = '<'
  , tname    = "exit hatch up"
  , tfreq    = [("legendLit", 1), ("legendDark", 1), ("escape up", 1)]
  , tcolor   = BrYellow
  , tcolor2  = BrYellow
  , talter   = 0  -- anybody can escape (or guard escape)
  , tfeature = [Embed "escape", ConsideredByAI]
  }
escapeDown = TileKind
  { tsymbol  = '>'
  , tname    = "exit trapdoor down"
  , tfreq    = [("legendLit", 1), ("legendDark", 1), ("escape down", 1)]
  , tcolor   = BrYellow
  , tcolor2  = BrYellow
  , talter   = 0  -- anybody can escape (or guard escape)
  , tfeature = [Embed "escape", ConsideredByAI]
  }
escapeOutdoorDown = escapeDown
  { tname    = "exit back to town"
  , tfreq    = [("escape outdoor down", 1)]
  }

-- *** Clear

wallGlass = TileKind
  { tsymbol  = '%'
  , tname    = "transparent polymer wall"
  , tfreq    = [("legendLit", 1), ("legendDark", 1), ("museumSetDark", 8)]
  , tcolor   = BrBlue
  , tcolor2  = Blue
  , talter   = 10
  , tfeature = [BuildAs "closed door", Clear]
  }
wallGlassSpice = wallGlass
  { tfreq    = [ ("rectWindowsOver_%", 20)
               , ("cache jewelry", 66), ("cachable jewelry", 80) ]
  , tfeature = Spice : tfeature wallGlass
  }
pillarIce = TileKind
  { tsymbol  = '^'
  , tname    = "ice buildup"
  , tfreq    = [ ("legendLit", 1), ("legendDark", 1), ("noiseSetLit", 300)
               , ("brawlSetLit", 20), ("lift terminal Dark", 4) ]
                 -- ice only in dark staircases
  , tcolor   = BrBlue
  , tcolor2  = Blue
  , talter   = 4  -- boss can dig through
  , tfeature = [Clear, Embed "frozen mass", OpenTo "shallow water Lit"]
      -- Is door, due to @OpenTo@, so is not explorable, but it's OK, because
      -- it doesn't generate items nor clues. This saves on the need to
      -- get each ice pillar into sight range when exploring level.
  }
pulpit = TileKind
  { tsymbol  = '%'
  , tname    = "VR booth"
  , tfreq    = [("pulpit", 1)]
  , tcolor   = BrYellow
  , tcolor2  = Brown
  , talter   = 5
  , tfeature = [Clear, Embed "pulpit"]
                 -- mixed blessing, so AI ignores, saved for player fun
  }
bush = TileKind
  { tsymbol  = '%'
  , tname    = "bush"
  , tfreq    = [ ("bush Lit", 1), ("emptySetLit", 1), ("arenaSetLit", 10)
               , ("shootoutSetLit", 30), ("huntSetLit", 30)
               , ("escapeSetLit", 40), ("zooSetDark", 100)
               , ("bushClumpOver_f_Lit", 1), ("pumpsOver_f_Lit", 1)
               , ("lift terminal Lit", 4) ]
  , tcolor   = BrGreen
  , tcolor2  = Green
  , talter   = 4
  , tfeature = [ChangeWith ["fire source"] "burning bush", Clear]
  }
bushBurnt = bush
  { tname    = "burnt bush"
  , tfreq    = [ ("battleSetDark", 30), ("ambushSetDark", 3), ("zooSetDark", 50)
               , ("bush with fire", 70) ]
  , tcolor   = BrBlack
  , tcolor2  = BrBlack
  , tfeature = [Dark, Clear]
  }
bushBurning = bush
  { tname    = "burning bush"
  , tfreq    = [ ("emptySetLit", 1), ("ambushSetDark", 10), ("zooSetDark", 300)
               , ("bush with fire", 30), ("burning bush", 1) ]
  , tcolor   = BrRed
  , tcolor2  = Red
  , talter   = 5
  , tfeature = [Embed "small fire", ChangeTo "bush with fire", Clear]
  }

-- ** Walkable

-- *** Not clear

fog = TileKind
  { tsymbol  = ';'
  , tname    = "faint fog"
  , tfreq    = [ ("fog Lit", 1), ("emptySetLit", 50), ("noiseSetLit", 120)
               , ("shootoutSetLit", 30), ("huntSetLit", 30)
               , ("fogClumpOver_f_Lit", 60), ("fogClumpOver_f_Dark", 60)
               , ("lift terminal Lit", 40) ]
      -- lit fog is OK for shootout, because LOS is mutual, as opposed
      -- to dark fog, and so camper has little advantage, especially
      -- on big maps, where he doesn't know on which side of fog patch to hide
  , tcolor   = BrCyan
  , tcolor2  = Cyan
  , talter   = 0
  , tfeature = [Walkable, NoItem, OftenActor]
  }
fogDark = fog
  { tname    = "thick fog"
  , tfreq    = [("escapeSetDark", 50), ("lift terminal Dark", 40)]
  , tfeature = Dark : tfeature fog
  }
smoke = TileKind
  { tsymbol  = ';'
  , tname    = "billowing smoke"
  , tfreq    = [ ("smoke Lit", 1), ("labTrailLit", 1)
               , ("stair terminal Lit", 2), ("lift terminal Lit", 6)
               , ("smokeClumpOver_f_Lit", 3), ("smokeClumpOver_f_Dark", 3)
               , ("exitSetLit", 20), ("ambushSetDark", 20) ]
  , tcolor   = Brown
  , tcolor2  = BrBlack
  , talter   = 0
  , tfeature = [Walkable, NoItem]  -- not dark, embers
  }
smokeDark = smoke
  { tname    = "lingering smoke"
  , tfreq    = [ ("powerSetDark", 100)
               , ("zooSetDark", 20), ("ambushSetDark", 40), ("battleSetDark", 5)
               , ("stair terminal Dark", 2), ("lift terminal Dark", 6) ]
  , tfeature = Dark : tfeature smoke
  }

-- *** Clear

doorOpen = TileKind
  { tsymbol  = '\''
  , tname    = "open door"
  , tfreq    = [("legendLit", 100), ("legendDark", 100), ("open door", 1)]
  , tcolor   = Brown
  , tcolor2  = BrBlack
  , talter   = 4
  , tfeature = [ Walkable, Clear, NoItem, NoActor
               , CloseTo "closed door"
               ]
  }
floorCorridor = TileKind
  { tsymbol  = floorSymbol
  , tname    = "floor"
  , tfreq    = [("floorCorridorLit", 1)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 0
  , tfeature = [Walkable, Clear]
  }
floorArena = floorCorridor
  { tfreq    = [ ("floorArenaLit", 1), ("arenaSetLit", 200)
               , ("museumSetLit", 400), ("zooSetLit", 600) ]
  }
floorDamp = floorArena
  { tname    = "damp floor"
  , tfreq    = [ ("noiseSetLit", 600), ("emptySetLit", 900)
               , ("damp floor Lit", 1)
               , ("stair terminal Lit", 20), ("lift terminal Lit", 6) ]
  }
floorDirt = floorArena
  { tname    = "dirt"
  , tfreq    = [ ("brawlSetLit", 1000), ("shootoutSetLit", 1000)
               , ("huntSetLit", 1000), ("escapeSetLit", 1000)
               , ("ambushSetLit", 1000), ("battleSetLit", 1000)
               , ("dirt Lit", 1) ]
  }
floorDirtSpice = floorDirt
  { tfreq    = [ ("treeShadeOver_s_Lit", 1), ("bushClumpOver_f_Lit", 1)
               , ("pumpsOver_f_Lit", 3) ]
  , tfeature = Spice : tfeature floorDirt
  }
floorActor = floorArena
  { tfreq    = [("floorActorLit", 1)]
  , tfeature = OftenActor : tfeature floorArena
  }
floorActorItem = floorActor
  { tfreq    = [("floorActorItem", 1), ("legendLit", 100)]
  , tfeature = VeryOftenItem : tfeature floorActor
  }
floorAshes = floorActor
  { tfreq    = [ ("smokeClumpOver_f_Lit", 1), ("smokeClumpOver_f_Dark", 1)
               , ("floorAshesLit", 1), ("floorAshesDark", 1) ]
  , tname    = "dirt and ash pile"
  , tcolor   = Brown
  , tcolor2  = Brown
  }
shallowWater = TileKind
  { tsymbol  = '~'
  , tname    = "water puddle"
  , tfreq    = [ ("aquatic", 1), ("shallow water Lit", 1), ("legendLit", 100)
               , ("emptySetLit", 5), ("noiseSetLit", 30), ("shootoutSetLit", 5)
               , ("huntSetLit", 250), ("lift terminal Lit", 4) ]
  , tcolor   = BrCyan
  , tcolor2  = Cyan
  , talter   = 2
  , tfeature = ChangeWith ["cold source"] "frozen path" : Embed "shallow water"
               : tfeature floorActor
  }
shallowWaterSpice = shallowWater
  { tfreq    = [ ("fogClumpOver_f_Lit", 40), ("pumpsOver_f_Lit", 3)
               , ("rubbleOrWaste_Lit", 1) ]
  , tfeature = Spice : tfeature shallowWater
  }
shallowWater2 = shallowWater
  { tname    = "water pool"
  , tfreq    = [("poolOver_~_Lit", 1)]
  }
floorRed = floorCorridor
  { tname    = "emergency walkway"
  , tfreq    = [ ("trailLit", 70), ("safeTrailLit", 70)
               , ("lift terminal Lit", 6), ("lift terminal Dark", 6) ]
  , tcolor   = BrRed
  , tcolor2  = Red
  , tfeature = [Embed "straight path", Trail, Walkable, Clear]
  }
floorBlue = floorRed
  { tname    = "frozen path"
  , tfreq    = [("trailLit", 100), ("frozen path", 1)]
  , tcolor   = BrBlue
  , tcolor2  = Blue
  , talter   = 2
  , tfeature = [ ChangeWith ["fire source"] "shallow water Lit"
               , Embed "frozen ground", Trail, Walkable, Clear ]
  }
floorBrown = floorRed
  { tname    = "transport route"
  , tfreq    = [ ("trailLit", 50), ("safeTrailLit", 50)
               , ("transport route", 1) ]
  , tcolor   = BrMagenta
  , tcolor2  = Magenta
  }
floorArenaShade = floorActor
  { tname    = "shaded ground"
  , tfreq    = [("shaded ground", 1), ("treeShadeOver_s_Lit", 2)]
  , tcolor   = BrYellow  -- match others, even though no lit counterpart
  , tcolor2  = BrBlack
  , tfeature = Dark : NoItem : tfeature floorActor
  }

-- * Allure-specific

-- ** Not walkable

-- *** Not clear

oriel = TileKind
  { tsymbol  = '%'  -- story-wise it's transparent, hence the symbol
  , tname    = "oriel"
  , tfreq    = [ ("oriels fence", 15)
               , ("airlock fence", 5), ("empty airlock fence", 5) ]
  , tcolor   = White
  , tcolor2  = Black
  , talter   = 5
  , tfeature = [Embed "black starry sky", Dark]
  }
outerHullWall = basicOuterFence
  { tname    = "outer hull wall"
  , tfreq    = [ ("basic outer fence", 1), ("oriels fence", 85)
               , ("airlock fence", 40), ("empty airlock fence", 40) ]
  }
rubbleBurning = TileKind  -- present in "emptySetLit" as early light/fire source
  { tsymbol  = '&'
  , tname    = "burning installation"
  , tfreq    = [ ("emptySetLit", 1), ("powerSetDark", 20)
               , ("ambushSetDark", 15), ("zooSetDark", 30)
               , ("stair terminal Lit", 4), ("stair terminal Dark", 4)
               , ("lift terminal Lit", 4), ("lift terminal Dark", 4)
               , ("burning installation", 1) ]
  , tcolor   = BrRed
  , tcolor2  = Red
  , talter   = 4  -- boss can dig through
  , tfeature = [ChangeTo "rubble", Embed "big fire"]
  }
rubbleBurningSpice = rubbleBurning
  { tfreq    = [ ("smokeClumpOver_f_Lit", 1), ("smokeClumpOver_f_Dark", 1)
               , ("cache deposit", 33) ]
  , tfeature = Spice : tfeature rubbleBurning
  }
wallOpenable = bedrock
  { tfreq    = [("openableWall", 1)]
  , tfeature = [BuildAs "closed door"]
  }
wallObscuredSafety = TileKind
  { tsymbol  = '#'
  , tname    = "safety procedures board"
  , tfreq    = [("obscured wall", 5), ("exitSetLit", 1)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 5
  , tfeature = [ Embed "ruined first aid kit"
               , HideAs "suspect wall"
               ]
  }
wallObscured3dBillboard = TileKind
  { tsymbol  = '#'
  , tname    = "3D billboard"
  , tfreq    = [("obscured wall", 25)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 5
  , tfeature = [ Embed "3D display"
               , HideAs "suspect wall"
               ]
  }
wallObscuredPipework = TileKind
  { tsymbol  = '#'
  , tname    = "exposed pipework"
  , tfreq    = [("obscured wall", 25)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 5
  , tfeature = [ Embed "cracked flue"
               , HideAs "suspect wall"
               ]
  }
liftShaft = pillar
  { tname    = "lift shaft"
  , tfreq    = [("lift shaft", 1)]
  }
rock = pillar
  { tname    = "rock"
  , tfreq    = [("arenaSetLit", 4), ("arenaSetDark", 4), ("brawlSetLit", 30)]
  }
pillarCache2 = pillarCache
  { tname    = "rack of deposit boxes"
  , tfreq    = [ ("cachable deposit", 20), ("cache deposit", 33)
               , ("stair terminal Lit", 1), ("stair terminal Dark", 1) ]
  , tfeature = [ Embed "deposit box"
               , ChangeTo "cachable deposit", ConsideredByAI ]
  }
pillarCache3 = pillarCache
  { tname    = "jewelry display"
  , tfreq    = [ ("cachable jewelry", 20), ("cache jewelry", 33)
               , ("museumSetDark", 2) ]
  , tfeature = [ Embed "jewelry case", Embed "jewelry display trap"
               , ChangeTo "cachable jewelry", ConsideredByAI ]
  }
stairsDecontaminatingUp = stairsUp
  { tname    = "decontaminating staircase up"
  , tfreq    = [("decontaminating staircase up", 1)]
  , tcolor   = BrBlue
  , tcolor2  = Blue
  , talter   = talterForStairs
  , tfeature = Embed "decontamination chamber" : tfeature stairsUp
  }
stairsWelded = stairsUp
  { tname    = "staircase up welded shut"
  , tfreq    = [("welded staircase up", 1)]
  , tcolor   = BrMagenta
  , tcolor2  = Magenta
  , talter   = talterForStairs  -- TODO: after character progression?
                                -- + 3  -- gear or level up needed
  , tfeature = [ ChangeWith ["blowtorch"] "ordinary staircase up"
               , ChangeWith ["cold source"] "ordinary staircase up"
               , Embed "crude weld", ConsideredByAI ]
  }
stairsLiftUp = stairsUp
  { tname    = "lift up"
  , tfreq    = [("staircase lift up", 9), ("ordinary lift up", 1)]
  , talter   = talterForStairs
  , tcolor   = BrCyan
  , tcolor2  = Cyan
  , tfeature = [Embed "lift up", ConsideredByAI]
  }
stairsLiftTrappedUp = stairsTrappedUp
  { tname    = "corroded lift up"
  , tfreq    = [("staircase lift up", 1)]
  , tcolor   = BrBlue
  , tcolor2  = Blue
  , tfeature = [ Embed "lift up", Embed "lift trap"
               , ConsideredByAI, ChangeTo "ordinary lift up" ]
                 -- AI uses despite the trap; exploration more important
  }
stairsLiftGatedUp = stairsLiftUp
  { tname    = "manually opened lift up"
  , tfreq    = [("gated lift up", 1)]
  , talter   = talterForStairs + 2  -- animals and bosses can't use
  }
stairsLiftDecontaminatingUp = stairsLiftUp
  { tname    = "decontaminating lift up"
  , tfreq    = [("decontaminating lift up", 1)]
  , tcolor   = BrBlue
  , tcolor2  = Blue
  , tfeature = Embed "decontamination chamber" : tfeature stairsLiftUp
  }
stairsLiftWelded = stairsLiftUp
  { tname    = "lift up welded shut"
  , tfreq    = [("welded lift up", 1)]
  , tcolor   = BrMagenta
  , tcolor2  = Magenta
  , talter   = talterForStairs
  , tfeature = [ ChangeWith ["blowtorch"] "ordinary lift up"
               , ChangeWith ["cold source"] "ordinary lift up"
               , Embed "crude weld", ConsideredByAI ]
  }
stairsDecontaminatingDown = stairsDown
  { tname    = "decontaminating staircase down"
  , tfreq    = [("decontaminating staircase down", 1)]
  , tcolor   = BrBlue
  , tcolor2  = Blue
  , talter   = talterForStairs
  , tfeature = Embed "decontamination chamber" : tfeature stairsDown
  }
stairsLiftDown = stairsDown
  { tname    = "lift down"
  , tfreq    = [("staircase lift down", 9), ("ordinary lift down", 1)]
  , tcolor   = BrCyan
  , tcolor2  = Cyan
  , talter   = talterForStairs
  , tfeature = [Embed "lift down", ConsideredByAI]
  }
stairsLiftTrappedDown = stairsTrappedDown
  { tname    = "corroded lift down"
  , tfreq    = [("staircase lift down", 1)]
  , tcolor   = BrBlue
  , tcolor2  = Blue
  , tfeature = [ Embed "lift down", Embed "lift trap"
               , ConsideredByAI, ChangeTo "ordinary lift down" ]
  }
stairsLiftGatedDown = stairsLiftDown
  { tname    = "manually opened lift down"
  , tfreq    = [("gated lift down", 1)]
  , talter   = talterForStairs + 2  -- animals and bosses can't use
  }
stairsLiftDecontaminatingDown = stairsLiftDown
  { tname    = "decontaminating lift down"
  , tfreq    = [("decontaminating lift down", 1)]
  , tcolor   = BrBlue
  , tcolor2  = Blue
  , tfeature = Embed "decontamination chamber" : tfeature stairsLiftDown
  }
escapeSpaceshipDown = escapeDown
  { tname    = "airlock to a shuttle"
  , tfreq    = [("escape spaceship down", 1), ("airlock fence", 3)]
  }
emptyAirlock = escapeDown
  { tname    = "empty airlock"
  , tfreq    = [ ("airlock fence", 2), ("empty airlock fence", 7)
               , ("emptySetLit", 2), ("ambushSetDark", 7) ]
                   -- not in exitSetLit; space can't be seen
  , tcolor   = BrBlack
  , tcolor2  = BrBlack
  , tfeature = [Embed "disengaged docking"]
  }
reinforcedWall = TileKind
  { tsymbol  = '#'
  , tname    = "reinforced wall"
  , tfreq    = [("reinforced wall", 1), ("rogueSet", 15), ("exitSetLit", 20)]
  , tcolor   = White
  , tcolor2  = BrBlack
  , talter   = 100
  , tfeature = []
  }
reinforcedWallSpice = reinforcedWall
  { tfreq    = [ ("doorlessWallOver_#", 20)
               , ("cache maze", 66), ("cachable abandoned", 80) ]
  , tfeature = Spice : tfeature reinforcedWall
  }
wallShuttle = bedrock
  { tname    = "shuttle hull"
  , tfreq    = [("shuttle hull", 1)]
  , tfeature = [Embed "shuttle hardware"]
  }
wallShuttleSpice = wallShuttle
  { tfreq    = [("cache shuttle", 75)]
  , tfeature = Spice : tfeature wallShuttle
  }

-- *** Clear

machineWall = TileKind
  { tsymbol  = '%'
  , tname    = "hardware rack"
  , tfreq    = [ ("hardware rack", 1)
               , ("rogueSet", 25), ("noiseSetLit", 250), ("powerSetDark", 250)
               , ("exitSetLit", 30)
               , ("lift terminal Lit", 40), ("lift terminal Dark", 40) ]
  , tcolor   = White
  , tcolor2  = BrBlack
  , talter   = 100
  , tfeature = [Clear]
  }
machineWallSpice = machineWall
  { tfreq    = [("doorlessMachineryOver_#", 1)]
  , tfeature = Spice : tfeature machineWall
  }

-- ** Walkable

-- *** Not clear

underbrushBurning = underbrush
  { tsymbol  = ';'
  , tname    = "burning underbrush"
  , tfreq    = [ ("ambushSetDark", 1), ("zooSetDark", 5)
               , ("bush with fire", 30), ("burning underbrush", 1) ]
  , tcolor   = BrRed
  , tcolor2  = Red
  , talter   = 0  -- just walk into it; even animals can
  , tfeature = [ Embed "small fire", ChangeTo "floorAshesLit"
               , Walkable, NoItem, NoActor ]  -- not clear, due to smoke
  }

-- *** Clear

floorOily = floorArena
  { tname    = "oily floor"
  , tfreq    = [ ("powerSetLit", 600), ("exitSetLit", 900)
               , ("oily floor Lit", 1), ("rubbleOrWaste_Lit", 1)
               , ("oilOver_o_Lit", 4) ]
  }
oilSpill = TileKind
  { tsymbol  = '~'
  , tname    = "oil spill"
  , tfreq    = [ ("powerSetDark", 35), ("exitSetLit", 1)
               , ("ambushSetDark", 20), ("oil spill", 1) ]
  , tcolor   = BrYellow
  , tcolor2  = BrGreen
  , talter   = 0
  , tfeature = Embed "machine oil" : tfeature floorActor
  }
oilSpillSpice = oilSpill
  { tfreq    = [ ("rubbleOrWaste_Lit", 1), ("rubbleOrWaste_Dark", 1)
               , ("oilOver_o_Lit", 1), ("oilOver_o_Dark", 1) ]
  , tfeature = Spice : tfeature oilSpill
  }
floorWindow = floorArena
  { tsymbol  = ' '  -- story-wise it's transparent, hence the symbol
  , tname    = "floor window"
  , tfreq    = [("emptySetLit", 6)]
  , tcolor   = defFG
  , tcolor2  = defFG
  , tfeature = Embed "black starry sky" : tfeature floorCorridor
  }
underbrush = TileKind
  { tsymbol  = floorSymbol
  , tname    = "underbrush"
  , tfreq    = [ ("underbrush Lit", 1), ("underbrush Dark", 1)
               , ("emptySetLit", 3), ("arenaSetLit", 3), ("shootoutSetLit", 3)
               , ("huntSetLit", 3), ("escapeSetLit", 4), ("zooSetDark", 5)
               , ("smokeClumpOver_f_Lit", 1), ("smokeClumpOver_f_Dark", 1)
               , ("trailLit", 50), ("safeTrailLit", 50)
               ]
  , tcolor   = BrGreen
  , tcolor2  = Green
  , talter   = 2
  , tfeature = [ ChangeWith ["fire source"] "burning underbrush"
               , Trail, Walkable, Clear, NoItem ]
  }

-- * Helper functions

makeDark :: TileKind -> TileKind
makeDark k = let darkText :: GroupName TileKind -> GroupName TileKind
                 darkText t = maybe t (toGroupName . (<> "Dark"))
                              $ T.stripSuffix "Lit" $ fromGroupName t
                 darkFrequency = map (first darkText) $ tfreq k
                 darkFeat (OpenTo t) = Just $ OpenTo $ darkText t
                 darkFeat (CloseTo t) = Just $ CloseTo $ darkText t
                 darkFeat (ChangeTo t) = Just $ ChangeTo $ darkText t
                 darkFeat (OpenWith grps t) =
                   Just $ OpenWith grps $ darkText t
                 darkFeat (CloseWith grps t) =
                   Just $ CloseWith grps $ darkText t
                 darkFeat (ChangeWith grps t) =
                   Just $ ChangeWith grps $ darkText t
                 darkFeat (HideAs t) = Just $ HideAs $ darkText t
                 darkFeat (BuildAs t) = Just $ BuildAs $ darkText t
                 darkFeat (RevealAs t) = Just $ RevealAs $ darkText t
                 darkFeat (ObscureAs t) = Just $ ObscureAs $ darkText t
                 darkFeat VeryOftenItem = Just OftenItem
                 darkFeat OftenItem = Nothing  -- items not common in the dark
                 darkFeat feat = Just feat
             in k { tfreq    = darkFrequency
                  , tfeature = Dark : mapMaybe darkFeat (tfeature k)
                  }

-- The yellow colour represents a dark tile lit by artificial light source,
-- or seen (felt, if very close) via noctovision. It is used to distinguish
-- ambiently lit tiles and dark tiles lit by dynamic light.
makeDarkColor :: TileKind -> TileKind
makeDarkColor k = (makeDark k) { tcolor  = if tsymbol k == floorSymbol
                                              && tcolor k == BrWhite
                                           then BrYellow
                                           else tcolor k
                               , tcolor2 = BrBlack
                               }
