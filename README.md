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
    
    	~/Documents$ bb efin
	1: ./eFind
	2: ./eFind/backlog - efind.gsheet
	3: ./eFind/eFind site search memory optimization.gdoc
	2
	1: ./eFind/backlog - efind.gsheet
	~/Documents/eFind$
	
	~/Documents$ bb zooms
	1: ./eFind/stories/User zooms the map to a place, based on place name, using _zoom to_ map tool_
	2: ./eFind/stories/User zooms the map to a Site, based on site name and_or ID, using _zoom to_ map tool_
	3: ./eFind/stories/User zooms the map to an address using the _zoom to_ map tool_
	4: ./eFind/stories/User zooms to ground level
	5: ./eFind/stories/User zooms to ground level/ad User zooms to ground level.gdraw
	6: ./eFind/stories/User zooms to ground level/journal User zooms to ground level.gdoc
	7: ./eFind/stories/User zooms to ground level/sd User zooms to ground level.gdraw
	8: ./eFind/stories/User zooms to ground level/tasks_ User zooms to ground level.gsheet
	ground
	1: ./eFind/stories/User zooms to ground level/ad User zooms to ground level.gdraw
	2: ./eFind/stories/User zooms to ground level/journal User zooms to ground level.gdoc
	3: ./eFind/stories/User zooms to ground level/sd User zooms to ground level.gdraw
	4: ./eFind/stories/User zooms to ground level/tasks_ User zooms to ground level.gsheet
	3
	1: ./eFind/stories/User zooms to ground level/sd User zooms to ground level.gdraw
	~/Documents/eFind/stories/User zooms to ground level$


	


