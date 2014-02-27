# Copyright (c) 2008--2011 Andres Loeh, 2010--2014 Mikolaj Konarski
# This file is a part of the computer game Allure of the Stars
# and is released under the terms of the GNU Affero General Public License.
# For license and copyright information, see the file LICENSE.
#

# All xc* tests assume a profiling build (for stack traces).
# See the install-debug target below or .travis.yml.prof.

install-debug:
	cabal install --enable-library-profiling --enable-executable-profiling --ghc-options="-fprof-auto-calls" --disable-optimization

configure-debug:
	cabal configure --enable-library-profiling --enable-executable-profiling --ghc-options="-fprof-auto-calls" --disable-optimization


xcplay:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer

xcpeekCampaign:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --savePrefix peekCampaign --dumpInitRngs --gameMode peekCampaign

xcpeekSkirmish:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --savePrefix peekSkirmish --dumpInitRngs --gameMode peekSkirmish

xcfrontendCampaign:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testCampaign --difficulty 1

xcfrontendSkirmish:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testSkirmish

xcfrontendBattle:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testBattle --difficulty 1

xcfrontendPvP:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testPvP --fovMode Shadow

xcfrontendCoop:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testCoop --difficulty 1 --fovMode Permissive

xcfrontendDefense:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testDefense --difficulty 9

xcbenchCampaign:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendNo --benchmark --stopAfter 60 --gameMode testCampaign --difficulty 1 --setDungeonRng 42 --setMainRng 42

xcbenchBattle:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendNo --benchmark --stopAfter 60 --gameMode testBattle --difficulty 1 --setDungeonRng 42 --setMainRng 42

xcbenchFrontendCampaign:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --maxFps 100000 --savePrefix test --benchmark --stopAfter 60 --gameMode testCampaign --difficulty 1 --setDungeonRng 42 --setMainRng 42

xcbenchFrontendBattle:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --maxFps 100000 --savePrefix test --benchmark --stopAfter 60 --gameMode testBattle --difficulty 1 --setDungeonRng 42 --setMainRng 42

xcbenchNo: xcbenchCampaign xcbenchBattle

xcbench: xcbenchCampaign xcbenchFrontendCampaign xcbenchBattle xcbenchFrontendBattle

xctest-travis: xctest-short xctest-medium xcbenchNo

xctest-travis-long: xctest-short xctest-long xcbenchNo

xctest: xctest-short xctest-medium xctest-long

xctest-short: xctest-short-new xctest-short-load

xctest-medium: xctestCampaign-medium xctestSkirmish-medium xctestBattle-medium xctestPvP-medium xctestCoop-medium xctestDefense-medium

xctest-long: xctestCampaign-long xctestCoop-long xctestDefense-long

xctestCampaign-long:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testCampaign --difficulty 1 > /tmp/stdtest.log

xctestCampaign-medium:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testCampaign --difficulty 1 > /tmp/stdtest.log

xctestSkirmish-long:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testSkirmish > /tmp/stdtest.log

xctestSkirmish-medium:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testSkirmish > /tmp/stdtest.log

xctestBattle-long:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testBattle --difficulty 1 > /tmp/stdtest.log

xctestBattle-medium:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testBattle --difficulty 1 > /tmp/stdtest.log

xctestPvP-long:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testPvP > /tmp/stdtest.log

xctestPvP-medium:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testPvP > /tmp/stdtest.log

xctestCoop-long:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testCoop --difficulty 1 > /tmp/stdtest.log

xctestCoop-medium:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testCoop --difficulty 1 > /tmp/stdtest.log

xctestDefense-long:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testDefense --difficulty 9 > /tmp/stdtest.log

xctestDefense-medium:
	dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testDefense --difficulty 9 > /tmp/stdtest.log

xctest-short-new:
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --savePrefix campaign --dumpInitRngs --gameMode campaign --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --savePrefix skirmish --dumpInitRngs --gameMode skirmish --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --savePrefix battle --dumpInitRngs --gameMode battle --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --savePrefix PvP --dumpInitRngs --gameMode PvP --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --savePrefix Coop --dumpInitRngs --gameMode Coop --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --savePrefix defense --dumpInitRngs --gameMode defense --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --savePrefix peekCampaign --dumpInitRngs --gameMode peekCampaign --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --newGame --savePrefix peekSkirmish --dumpInitRngs --gameMode peekSkirmish --frontendStd --stopAfter 0 > /tmp/stdtest.log

xctest-short-load:
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --savePrefix campaign --dumpInitRngs --gameMode campaign --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --savePrefix skirmish --dumpInitRngs --gameMode skirmish --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --savePrefix battle --dumpInitRngs --gameMode battle --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --savePrefix PvP --dumpInitRngs --gameMode PvP --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --savePrefix Coop --dumpInitRngs --gameMode Coop --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --savePrefix defense --dumpInitRngs --gameMode defense --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --savePrefix peekCampaign --dumpInitRngs --gameMode peekCampaign --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure +RTS -xc -RTS --dbgMsgSer --savePrefix peekSkirmish --dumpInitRngs --gameMode peekSkirmish --frontendStd --stopAfter 0 > /tmp/stdtest.log


play:
	dist/build/Allure/Allure --dbgMsgSer

peekCampaign:
	dist/build/Allure/Allure --dbgMsgSer --savePrefix peekCampaign --dumpInitRngs --gameMode peekCampaign

peekSkirmish:
	dist/build/Allure/Allure --dbgMsgSer --savePrefix peekSkirmish --dumpInitRngs --gameMode peekSkirmish

frontendCampaign:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testCampaign --difficulty 1

frontendSkirmish:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testSkirmish

frontendBattle:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testBattle --difficulty 1

frontendPvP:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testPvP --fovMode Shadow

frontendCoop:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testCoop --difficulty 1 --fovMode Permissive

frontendDefense:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --maxFps 180 --savePrefix test --dumpInitRngs --gameMode testDefense --difficulty 9

benchCampaign:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendNo --benchmark --stopAfter 60 --gameMode testCampaign --difficulty 1 --setDungeonRng 42 --setMainRng 42

benchBattle:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendNo --benchmark --stopAfter 60 --gameMode testBattle --difficulty 1 --setDungeonRng 42 --setMainRng 42

benchFrontendCampaign:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --maxFps 100000 --savePrefix test --benchmark --stopAfter 60 --gameMode testCampaign --difficulty 1 --setDungeonRng 42 --setMainRng 42

benchFrontendBattle:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --maxFps 100000 --savePrefix test --benchmark --stopAfter 60 --gameMode testBattle --difficulty 1 --setDungeonRng 42 --setMainRng 42

benchNo: benchCampaign benchBattle

bench: benchCampaign benchFrontendCampaign benchBattle benchFrontendBattle


test-travis: test-short test-medium benchNo

test-travis-long: test-short test-long benchNo

test: test-short test-medium test-long

test-short: test-short-new test-short-load

test-medium: testCampaign-medium testSkirmish-medium testBattle-medium testPvP-medium testCoop-medium testDefense-medium

test-long: testCampaign-long testCoop-long testDefense-long

testCampaign-long:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testCampaign --difficulty 1 > /tmp/stdtest.log

testCampaign-medium:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testCampaign --difficulty 1 > /tmp/stdtest.log

testSkirmish-long:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testSkirmish > /tmp/stdtest.log

testSkirmish-medium:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testSkirmish > /tmp/stdtest.log

testBattle-long:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testBattle --difficulty 1 > /tmp/stdtest.log

testBattle-medium:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testBattle --difficulty 1 > /tmp/stdtest.log

testPvP-long:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testPvP > /tmp/stdtest.log

testPvP-medium:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testPvP > /tmp/stdtest.log

testCoop-long:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testCoop --difficulty 1 > /tmp/stdtest.log

testCoop-medium:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testCoop --difficulty 1 > /tmp/stdtest.log

testDefense-long:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 580 --dumpInitRngs --gameMode testDefense --difficulty 9 > /tmp/stdtest.log

testDefense-medium:
	dist/build/Allure/Allure --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --frontendStd --benchmark --stopAfter 280 --dumpInitRngs --gameMode testDefense --difficulty 9 > /tmp/stdtest.log

test-short-new:
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --newGame --savePrefix campaign --dumpInitRngs --gameMode campaign --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --newGame --savePrefix skirmish --dumpInitRngs --gameMode skirmish --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --newGame --savePrefix battle --dumpInitRngs --gameMode battle --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --newGame --savePrefix PvP --dumpInitRngs --gameMode PvP --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --newGame --savePrefix Coop --dumpInitRngs --gameMode Coop --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --newGame --savePrefix defense --dumpInitRngs --gameMode defense --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --newGame --savePrefix peekCampaign --dumpInitRngs --gameMode peekCampaign --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --newGame --savePrefix peekSkirmish --dumpInitRngs --gameMode peekSkirmish --frontendStd --stopAfter 0 > /tmp/stdtest.log

test-short-load:
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --savePrefix campaign --dumpInitRngs --gameMode campaign --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --savePrefix skirmish --dumpInitRngs --gameMode skirmish --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --savePrefix battle --dumpInitRngs --gameMode battle --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --savePrefix PvP --dumpInitRngs --gameMode PvP --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --savePrefix Coop --dumpInitRngs --gameMode Coop --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --savePrefix defense --dumpInitRngs --gameMode defense --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --savePrefix peekCampaign --dumpInitRngs --gameMode peekCampaign --frontendStd --stopAfter 0 > /tmp/stdtest.log
	while true; do echo ' '; echo '.'; sleep 1; done | dist/build/Allure/Allure --dbgMsgSer --savePrefix peekSkirmish --dumpInitRngs --gameMode peekSkirmish --frontendStd --stopAfter 0 > /tmp/stdtest.log



# The rest of the makefile is unmaintained at the moment.

default : dist/setup-config
	runghc Setup build

dist/setup-config : Allure.cabal
	runghc Setup configure --user

clean :
	runghc Setup clean

ghci :
	ghci -XCPP -idist/build/autogen:GameDefinition
