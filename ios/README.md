# PokeWalk iOS MVP

This folder contains a native SwiftUI walking-companion app that uses Apple's Core Motion `CMPedometer` API.

## What it does

- Counts today's steps
- Shows estimated walking distance
- Tracks progress toward a daily route
- Works without HealthKit or a server
- Keeps the legacy reverse-engineering code separate

## Generate the Xcode project

Install XcodeGen, then from this folder run:

```bash
xcodegen generate
open PokeWalk.xcodeproj
```

In Xcode:

1. Select the PokeWalk target.
2. Choose your Apple Developer team under Signing & Capabilities.
3. Change the bundle identifier if `com.realmcera.pokewalk` is unavailable.
4. Run on a physical iPhone to test real step data.

## App Store work still required

- Final app name and branding
- Original app icon and screenshots
- Privacy policy/support URL
- App Store Connect record
- Privacy nutrition-label answers for motion/fitness data
- Archive and TestFlight testing
- App Review submission

### Intellectual-property note

The original repository documents Nintendo's Pokéwalker hardware. Do not ship Nintendo/Pokémon logos, characters, sprites, ROM data, sounds, or other protected assets unless you have permission to distribute them. For a public App Store release, use original branding and original visual assets.
