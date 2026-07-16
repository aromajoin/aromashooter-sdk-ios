# Change log
Version 2.0.0 (2026-07-11)
---
- BREAKING: renamed `diffuse*` APIs to `shoot*` — `shootSimple` / `shootAllSimple` / `shootWithIntensity` / `shootAllWithIntensity` / `shootAromaFlower` / `shootAromaFlowerAll`, and `stop`/`stopAll` → `stopSimple`/`stopAllSimple`
- BREAKING: model `CartridgePort` → `AromaChamber`; property/param `intensityPercent` → `concentration`
- BREAKING: params `booster` → `internalBooster`, `boosterIntensity` → `internalBoosterIntensity`, `fanIntensity` → `externalBoosterIntensity`, `port`/`ports` → `chamber`/`chambers`
- No wire-protocol or behavioral change — identifiers only. Clean break, no deprecated aliases.

Version 1.3.1 (2020-07-07)
---
- Compile SDK in XCode 12 beta (Swift 5.3)

Version 1.3.0 (2019-10-09)
---
- Work with AS2 AromaShooter Device
- Add new diffuse method for AS2 AromaShooter Device

Version 1.2.1 (2018-08-26)
---
- Update to Swift 5

Version 1.2.0 (2018-11-16)
---
- Add 'stop-diffusing' features
- Add 'connection-screen' ui part

