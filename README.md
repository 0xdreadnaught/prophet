# prophet
Prophecy price chart for PoE

# Info
Prophet uses autohotkey and the poe.ninja API to create a table of all prophecies and their current price.
Prophet pulls new price data every time you toggle on.
The raw JSON response is stored in ./prophecies.json.
The default window size can be adjusted by editing `Gui, Add, ListView, Grid r20 w225, Name|Price(c)` on line 68
`r20` is the number of rows, and `w255` is the width of the window.

# Hotkeys
* CTRL-P toggles the chart
