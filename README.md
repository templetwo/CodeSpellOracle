# Code Spell Oracle 🧙‍♂️

A magical journey to learn Python programming through interactive coding challenges.

## Overview

**Code Spell Oracle** is a macOS educational game that teaches Python programming concepts through a fantasy-themed adventure. Players take on the role of an apprentice wizard, solving coding challenges to progress through wizard ranks and unlock achievements.

## Features

- 🎓 **20 Progressive Levels** - From beginner to expert difficulty
- 🧪 **Secure Python Sandbox** - Safe code execution with test validation
- 🏆 **Achievement System** - Unlock achievements as you master concepts
- 📊 **Progress Tracking** - Track XP, Mana, and completion times
- 🎨 **Native macOS UI** - Beautiful SwiftUI interface
- ⚡ **Instant Feedback** - Real-time test results and hints

## Wizard Ranks

Progress through five wizard ranks:
- ✨ **Apprentice** (0-4 levels)
- 📚 **Scholar** (5-9 levels)
- ⚗️ **Enchanter** (10-14 levels)
- 🔮 **Master Sorcerer** (15-19 levels)
- 🧙 **Archmage** (20+ levels)

## Python Concepts Covered

- Functions and parameters
- Conditionals and logic
- Loops and iteration
- Lists and data structures
- Dictionaries
- String manipulation
- Advanced programming patterns

## Requirements

- macOS 14.0 or later
- Python 3.x installed on your system
- Xcode 16.4 or later (for building)

## Installation

1. Clone this repository
2. Open `CodeSpellOracle.xcodeproj` in Xcode
3. Build and run the project

## Keyboard Shortcuts

- `⌘N` - New Game
- `⌘R` - Run Code
- `⌘H` - Show Hint
- `⌘⇧L` - Level Selection
- `⌘⇧A` - Achievements
- `⌘⇧B` - Leaderboard
- `⌘⇧T` - Tutorials

## Architecture

- **Models**: Level definitions, player profiles, achievements
- **Services**: Game state, Python sandbox, save system
- **Views**: SwiftUI-based UI components
- **Utilities**: Themes, animations, design system

## Security

The Python sandbox includes security measures:
- Blocked dangerous imports (os, sys, subprocess, etc.)
- 5-second execution timeout
- Isolated execution environment
- Input validation and sanitization

## License

Copyright © 2025 Spiral. All rights reserved.

## Version

**v1.0.0** - Initial Release
