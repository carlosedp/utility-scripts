# Utility Scripts

## backup.sh

Script to perform backups based on rsync using a mechanism similar to Apple´s Time Machine.
Each run creates a new backup set with incremental changes and hard-links to unchanged files.

## sync_files.sh

Sync files between two dirs. An abstration to ease rsync.

## highlight.sh

Highlights output based on regex and color id.
Usage: cat log.txt | highlight.sh pattern1 31 pattern2 34 pattern 3 32"
