### benbash is a script that helps you find deeply nested files and jump to the select parent directory

##  Notes

1. The filter traverses the full tree of the specified directory and all of its the parent directories. 
2. By default the initial search directory is the current one.
2. An optional third parameter can be set to specify the initial search directory
3. If multiple paths found, only paths with unique directories are returned.

## Install

1. git clone git://github.com/Tertioptus/ben-bash.git
2. cd ben-bash
3. make install

## Shell Commands

	bb <file query> <initial directory>

## Example Usage

	$ bb Makefile
	1: ./Makefile
	~/ben-bash$	
    
