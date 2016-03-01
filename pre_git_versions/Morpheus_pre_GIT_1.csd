<Cabbage>
form size(600, 500), caption(""), pluginID("plu1"), colour("white")
numberbox bounds(280, 30, 40, 25), widgetarray("note", 144), range(-1, 11, -1, 1, 1), active(0), value(0)
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
  
;RoryWalsh & GlebRogozinsky 2016  

giNoteCount init 0;
giNoteArray[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
giICArray[] fillarray 0,0,0,0,0,0,0,0,0,0,0,0
 
;---------------------------------------
; check if a value is already part of an array
;---------------------------------------   
opcode isAlreadyThere, i, i
iNote xin
iCnt init 0
iPresent init 0
iIC init 0
iSize init 12
iNote = iNote%12 ; PC
while iCnt < iSize do
	if giNoteArray[iCnt]==iNote then
	;	prints "%d %d \n", iArray[iCnt], iNote
	 	iPresent = 1
	endif
	iCnt = iCnt+1
od

if iPresent == 0 then
	giNoteArray[giNoteCount] = iNote
	
	if giNoteCount >= 1 then
		iIC = giNoteArray[giNoteCount] - giNoteArray[giNoteCount-1]
		giICArray[giNoteCount] wrap iIC,0,12
	endif
	giNoteCount += 1
endif

;prints "%d %d %d %d\n", giICArray[0], giICArray[1], giICArray[2], giICArray[3]
;prints "%d %d %d %d\n", giNoteArray[0], giNoteArray[1], giNoteArray[2], giNoteArray[3]
xout iPresent
endop   
  
;================================================
; gets triggered each time a note is pressed
;================================================
instr 1
iRowIsLocked chnget "rowIsLocked"
iGo isAlreadyThere p4
if iGo==0 && chnget:i("rowIsLocked")==0 then
;	prints "%d %d %d %d\n", giICArray[0], giICArray[1], giICArray[2], giICArray[3]
;	prints "%d %d %d %d\n\n", giNoteArray[0], giNoteArray[1], giNoteArray[2], giNoteArray[3]
	SChannel sprintf "note%d", giNoteCount+12*(giNoteCount-1)
	chnset giNoteArray[0], SChannel ; Place diagonal element
	
	iCur = giNoteArray[0]
	iCurV = iCur
	iCurH = iCur
	iCnt = 1
	until iCnt == giNoteCount do
		iCurV += giICArray[giNoteCount-iCnt]
		iCurV wrap iCurV,0,12
		
		iCurH -= giICArray[giNoteCount-iCnt]
		iCurH wrap iCurH,0,12
		
		SChannel sprintf "note%d", giNoteCount+12*(giNoteCount-1-iCnt)
		chnset iCurV, SChannel
		
		SChannel sprintf "note%d", giNoteCount+12*(giNoteCount-1)-iCnt
		chnset iCurH, SChannel
		
		iCnt += 1
	od

;	SChannel sprintf "note%d", i(giNoteCount)+1
;	chnset p4%12, SChannel
	;giNoteArray[giNoteCount] = p4
	;giNoteCount = giNoteCount+1
	if giNoteCount==12 then
		chnset 1, "rowIsLocked"
		chnset "active(1)", "rowLock_id"
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
if changed:k(chnget:k("rowIsLocked"))==1 && chnget:k("rowIsLocked")==1 then
	event "i", 1002, 0, 1
		giNoteCount=0
		giNoteArray *= 0
		giNoteArray -= 1		
endif

;	while kCnt < 12 do
;		giNoteArray[kCnt]=0
;	until iCnt > 144 do
;		SChannel sprintf "note%d", iCnt+1
;		chnset -1, SChannel ; Place diagonal element
;	enduntil	
;	kCnt = kCnt+1
;	od
endin

instr 1002
iCnt init 0
	until iCnt > 144 do
		SChannel sprintf "note%d", iCnt+1
		chnset -1, SChannel 
		iCnt=iCnt+1
	od	
	turnoff	
endin
</CsInstruments>  
<CsScore>
i1000 0 1 
i1001 0 10000 
f0 z
</CsScore>
</CsoundSynthesizer> 