prophettoggle := 0
^p::
if (prophettoggle == 0)
{
	prophettoggle := 1
	; get current prophecy data from poe.ninja
	UrlDownloadToFile, https://poe.ninja/api/data/ItemOverview?league=Delve&type=Prophecy, prophecies.json
	FileRead, raw, prophecies.json

	; split on { to break apart items
	rawArray := StrSplit(raw, "{")

	; arrays to store names and prices
	names := []
	prices := []

	; loop through raw indexes
	Loop % rawArray.MaxIndex()
	{
		; get current index
		this_item := rawArray[A_Index]
	
		; create search target for name
		subTarget := "name"
		targetSuffix := ":"
		target := """" . subTarget . """" . targetSuffix . """"
		; MsgBox, %target%
		IfInString, this_item, %target%
		{		
			; get name between "name":" and ","icon and push to array
			StringGetPos, pos, this_item, %target%
			pos := pos+8
			StringTrimLeft, trimmed, this_item, %pos%
			targetPrefix :=","
			subTarget := "icon"
			target := """" . targetPrefix . """" . subtarget . """"
			StringGetPos, pos, trimmed, %target%
			pos := pos
			name := SubStr(trimmed, 1, pos)
			names.Push(name)
		}
	
		; reset this_item
		this_item := rawArray[A_Index]
	
		; create search target for price
		subTarget := "chaosValue"
		targetSuffix := ":"
		target := """" . subTarget . """" . targetSuffix
		IfInString, this_item, %target%
		{
			; MsgBox, Index: %A_Index% = %this_item%`n`ntarget: %target%
			; get price between "chaosValue":" and ,"exaltedValue" and push to array
			StringGetPos, pos, this_item, %target%
			pos := pos+13
			StringTrimLeft, trimmed, this_item, %pos%
			targetPrefix :=","
			subTarget := "exaltedValue"
			target := targetPrefix . """" . subtarget . """"
			StringGetPos, pos, trimmed, %target%
			pos := pos
			price := SubStr(trimmed, 1, pos)
			prices.Push(price)
		}	
	}

	; create GUI for displaying data
	Gui, Add, ListView, Grid r20 w225, Name|Price(c)
	Gui +AlwaysOnTop +Resize

	; loop through names and add name and price to the listview
	count := 1
	for index, element in names
	{
		;MsgBox % "Index: " . index . " Value: " . element
		LV_Add("", element, prices[count])
		count := count+1
	}
	LV_ModifyCol()
	LV_ModifyCol(2, "Integer")
	Gui, Show, AutoSize
} else {
	prophettoggle := 0
	Gui, Destroy
}
return
