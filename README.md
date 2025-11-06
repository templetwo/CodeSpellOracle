# CodeSpellOracle

A macOS educational game that teaches Python programming through mystical storytelling and interactive coding challenges.

## Overview

CodeSpellOracle is a SwiftUI-based macOS application that gamifies Python learning. Players progress through levels, write Python code to solve challenges, and receive mystical feedback when errors occur.

## Features

- **20+ Levels**: Progressive difficulty from beginner to master
- **Real-time Code Execution**: Python sandbox environment with 5-second timeout
- **Mystical Error Handling**: Educational error messages with hints and fixes
- **Audio Feedback**: Sound effects for typing, success, error, and level completion
- **Achievement System**: Track progress with XP, mana, and unlockable achievements
- **Premium Theme**: Cyberpunk/neon aesthetic with glassmorphic UI
- **Responsive Layout**: Dynamic panel sizing for optimal code editing experience
- **Haptic Feedback**: Tactile responses for game events

## Requirements

- macOS 15.5+
- Xcode 16.4+
- Swift 5.0+
- Python 3 (system `/usr/bin/python3`)

## Project Structure

```
CodeSpellOracle/
├── CodeSpellOracle/
│   ├── Models/
│   │   ├── Level.swift
│   │   ├── LevelDefinitions.swift
│   │   ├── PlayerProfile.swift
│   │   └── Achievement.swift
│   ├── Views/
│   │   ├── MainGameView.swift
│   │   ├── MainGameViewPremium.swift
│   │   ├── LevelSelectionView.swift
│   │   └── Components/
│   ├── Services/
│   │   ├── PythonSandboxService.swift
│   │   ├── MysticalErrorHandler.swift
│   │   ├── GameState.swift
│   │   ├── AudioService.swift
│   │   ├── HapticsService.swift
│   │   └── SaveSystem.swift
│   ├── Utilities/
│   │   ├── Theme.swift
│   │   └── AnimationHelpers.swift
│   └── Resources/
│       └── Sounds/
├── CodeSpellOracleTests/
└── CodeSpellOracleUITests/
```

## Building the Project

### Clean Build

```bash
xcodebuild -project CodeSpellOracle.xcodeproj \\
  -scheme CodeSpellOracle \\
  -configuration Debug \\
  clean build
```

### Release Build

```bash
xcodebuild -project CodeSpellOracle.xcodeproj \\
  -scheme CodeSpellOracle \\
  -configuration Release \\
  build
```

### Running from Xcode

1. Open `CodeSpellOracle.xcodeproj`
2. Select the CodeSpellOracle scheme
3. Press ⌘R to build and run

## Build Troubleshooting

### Common Issues

#### 1. Missing Executable
If the build succeeds but no executable is generated:
- **Cause**: Empty Compile Sources build phase (common in Xcode 16)
- **Solution**: This project uses `PBXFileSystemSynchronizedRootGroup`, which automatically includes all files in the CodeSpellOracle directory
- **Verify**: Check that `CodeSpellOracle.app/Contents/MacOS/CodeSpellOracle` exists after build

#### 2. Type Conflicts
- Ensure `TestCase` in `Level.swift` is distinct from internal service types
- All SwiftUI expressions should be simple enough for type inference

#### 3. Code Signing
- Debug builds use automatic signing with Team ID `P3CR7BQXPU`
- Adjust in Xcode → Project Settings → Signing & Capabilities if needed

## Development Notes

### Xcode 16 Project Format
This project uses the modern `PBXFileSystemSynchronizedRootGroup` feature (objectVersion 77). Files added to the `CodeSpellOracle/` directory are automatically included in the target without manual project file updates.

### Testing
- Unit tests: `CodeSpellOracleTests/`
- UI tests: `CodeSpellOracleUITests/`
- Run tests: ⌘U in Xcode

## Keyboard Shortcuts

- **⌘R**: Run code / Cast spell
- **⌘H**: Request hint / Oracle wisdom
- **⌘⇧L**: Level selection

## Architecture

### Game Flow
1. Player selects a level from `LevelSelectionView`
2. `GameState` loads level data and manages game progression
3. User writes Python code in `MainGameView` or `MainGameViewPremium`
4. Code is executed via `PythonSandboxService` with timeout protection
5. Results are evaluated and displayed with mystical feedback
6. Progress is saved via `SaveSystem`

### Python Execution
- Sandboxed execution using macOS `Process` API
- Temporary files for code execution
- 5-second timeout per execution
- Standard input/output/error capture

### Error Handling
`MysticalErrorHandler` translates Python errors into educational messages:
- SyntaxError → "The Arcane Glyph Falters"
- NameError → "Echo in the Void"
- TypeError → "Rune Mismatch"
- IndentationError → "Scroll Misalignment"

## License

[Add your license here]

## Contributors

[Add contributors here]
