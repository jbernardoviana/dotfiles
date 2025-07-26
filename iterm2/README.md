# iTerm2 Profiles

This directory contains iTerm2 profiles exported for easy syncing across devices.

## Current Export

- `iTerm2 State.itermexport` - Complete iTerm2 state export (includes all profiles, settings, etc.)

## How to Import This Export

1. Open iTerm2
2. Go to **File** > **Import Profile...**
3. Select the `iTerm2 State.itermexport` file from this directory
4. Choose whether to replace existing profiles or add new ones

## Alternative: Export as JSON (Recommended)

For better version control and easier management:

1. Open iTerm2 > **Preferences** > **Profiles**
2. Select a profile
3. Click **Other Actions...** (gear icon) > **Export JSON Profile...**
4. Save as `profile-name.json` in this directory

## What Gets Exported/Imported

- Color schemes
- Font settings
- Window and tab preferences
- Keyboard shortcuts
- Triggers and other advanced settings
- Working directory settings
- Command settings

## Tips

- **JSON format is preferred** for version control (human-readable, trackable changes)
- **Export individual profiles** for more granular control
- **Backup before importing** if you have existing profiles you want to keep

## Example Workflow

```bash
# Export your profiles as JSON
# (via iTerm2 UI as described above)

# Add to git
git add iterm2/
git commit -m "Add iTerm2 profiles"

# On another machine
git pull
# Import the profiles via iTerm2 UI
``` 