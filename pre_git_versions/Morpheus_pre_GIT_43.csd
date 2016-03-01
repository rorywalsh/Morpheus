<Cabbage>
form size(600, 500), caption(""), pluginID("plu1"), colour("white")
numberbox bounds(-100, -100, 40, 25), widgetarray("note", 144), range(0, 128, 0, 1, 1), active(0), value(0)
keyboard bounds(40, 336, 479, 79)
checkbox bounds(424, 424, 120, 20), fontcolour("Black"), channel("rowIsLocked"), text("Row Locked"), active(0), identchannel("rowLock_id")

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key=4
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 64
nchnls = 2
0dbfs=1
  
;RoryWalsh 2016  
  
giNoteCount init 0;
giNoteArray[] fillarray 0,0,0,0,0,0,0,0,0,0
 
;---------------------------------------
; check if a value is already part of an array
;---------------------------------------   
opcode isAlreadyThere, i, iii[]
iNote, iIndex, iArray[] xin
iCnt init 0
iPresent init 0
iSize init 12
while iCnt < iSize do
	if iArray[iCnt]==iNote then
		;prints "%d %d \n", iArray[iCnt], iNote
	 	iPresent = 1
	endif
	iCnt = iCnt+1
od

xout iPresent
endop   
  
;================================================
; gets triggered each time a note is pressed
;================================================
instr 1
iRowIsLocked chnget "rowIsLocked"
iGo isAlreadyThere p4, giNoteCount, giNoteArray
if iGo==0 && chnget:i("rowIsLocked")==0 then
	SChannel sprintf "note%d", i(giNoteCount)+1
	chnset p4, SChannel
	giNoteArray[giNoteCount] = p4
	giNoteCount = giNoteCount+1
	if giNoteCount==12 then
		chnset 1, "rowIsLocked"
		chnset "active(1)", "rowLock_id"
		giNoteCount=0
	endif
endif
endin

;================================================
; these instrument update and maintain the GUI widgets
;================================================
instr 1000	;position all our numberboxes....
iCnt init 0
iCntRows init 0
kMetro metro kr
	until iCnt > 144 do
		S1 sprintfk "pos(%d, %d)", iCnt%12*40+40, iCntRows*25+30
		S2 sprintfk "note_ident%d", iCnt+1
		chnset S1, S2
		iCnt=iCnt+1
		iCntRows = (iCnt%12==0 ? iCntRows+1 : iCntRows)
	enduntil		
endin

instr 1001	;check for changes to Row Locked button
kCnt = 0
if changed:k(chnget:k("rowIsLocked"))==1 && chnget:k("rowIsLocked")==1 then
	while kCnt < 12 do
		giNoteArray[kCnt]=0
	kCnt = kCnt+1
	od
endif
endin
</CsInstruments>  
<CsScore>
i1000 0 1 
i1001 0 10000 
f0 z
</CsScore>
</CsoundSynthesizer> 