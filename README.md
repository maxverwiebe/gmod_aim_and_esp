# AimAssist and ESP Plugin for Autorun-rs

This Lua script is a plugin for the Autorun-rs system, designed for educational and demonstration purposes in Garry's Mod environments. It features an aim assistance system and enhanced visual player indicators (ESP) to study the impact and potential of runtime modifications in a controlled testing environment.

## Features

- **Aim Assistance**: Automatically assists in aiming at the nearest player when the left ALT key is pressed.
- **Enhanced Visual Indicators (ESP)**: Displays additional information about the targeted player, such as health and nickname.
- **Toggle ESP**: Ability to toggle ESP features on and off dynamically through console commands.

## Prerequisites

Before using this plugin, ensure you have Autorun-rs installed. You can find the installation instructions and more details about Autorun-rs [here](https://github.com/Vurv78/Autorun-rs).

## Installation

1. Clone the repository.
2. Navigate to `C:\Users\<User>\autorun\plugins` directory.
3. Insert the content of this repo there so the structure looks like this `autorun/plugins/simple_aim_and_esp`.

## Usage

Once the script is placed in the appropriate directory, it will be automatically loaded by Autorun-rs when Garry's Mod starts. Here’s how to control the features:

- **Activate Aim Assist**: Hold the left ALT key during gameplay. The script will find the closest player and assist your aim towards that player.
- **Toggle ESP**: Open the console (`~` key) and type `toggle_esp`. This will enable or disable the ESP functionality.

## Console Commands

- `toggle_esp`: Enables or disables the ESP features. When enabled, ESP will display health and names of players around you.

## Safety and Compliance

This script is intended for educational use only to demonstrate the capabilities of the Autorun-rs plugin system and Lua scripting within a controlled environment. Please use responsibly and within the bounds of the Garry's Mod community guidelines and server rules.

## Support

For issues, questions, or contributions, please refer to the main Autorun-rs GitHub repository or join the [Discord server](https://discord.gg/yXKMt2XUXm) linked in the main Autorun-rs page.
