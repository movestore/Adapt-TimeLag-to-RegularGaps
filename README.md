# Adapt Time Lag for Regular Gaps

MoveApps

Github repository: *github.com/movestore/Adapt-TimeLag-to-RegularGaps*

## Description
Use this App if you want to calculate average duration properties of your data and the data were collected with regular daily gaps (e.g. no locations at night), which might lead to unrealistic weighting of locations just before the gap. This App will generate an adapted timelag2 attribute that is used in Apps like "Add Elevation", "Daily Proportions" or "Nest User Radius".

## Documentation
This App requires the App 'Time Lag Between Locations' be run before it in the workflow. 

This App was created to account for unrealistic weighting of locations in data that were collected with regular daily gaps (e.g. no locations at night). In Apps like "Add Elevation", "Daily Proportions" or "Nest User Radius", average durations are calculated and will be distorted by artificially long durations of the last daily location (before the gap). Therefore, this App should be included in a workflow before the aforementioned Apps, because it calculates the attribute `timelag2` which accounts for this problem. Namely, for each location before such regular gap, `timelag2` is not the true timelag towards the next location but simply the median data resolution, thus giving the location a realistic duration for calculations like 'proportional flight duration per day'.

Please take care in further Apps/calculations what is known of the animals' behaviour during the data gap. If it is for sure not on the nest then `timelag2` should be used, if it is likely on the nest `timelag` should be used. 


### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
none.

### Settings 
**Daily time of last location (`last_loctime`):** Last possible time of day that a location could be collected (before the gap). This parameter is provided as timestamp, but note that the year, month and day will be ignored. Defaults to NULL.

### Null or error handling:
**Daily time of last location (`last_loctime`):** NULL (default) will lead to the input data set being returned, i.e. `timelag2` will not be calculated.

**Data:** The full data set (possibly with additional attribues) is returned.














