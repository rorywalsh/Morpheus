<Cabbage>
form size(600, 500), caption(""), pluginID("plu1"), colour("white")
label bounds(280, 30, 38, 20), widgetarray("note", 144), text(""), colour("black")
keyboard bounds(40, 336, 479, 79)
button bounds(424, 424, 100, 20), fontcolour("Black"), channel("resetRow"), text("Reset")

checkbox bounds(40, 424, 80, 20), channel("sharps"), text("Sharps"), radiogroup(99)
checkbox bounds(40, 448, 80, 20), channel("flats"), text("Flats"), radiogroup(99)
checkbox bounds(120, 424, 80, 20), channel("PCs_te"), text("t"), value(1), radiogroup(99),
checkbox bounds(120, 448, 80, 20), channel("PCs"), text("10"), radiogroup(99), 
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

gSC1[] init 12
gSC2[] init 12
gSC3[] init 12
gSC4[] init 12
gSC[] init 12
giMatrix[][] init 12,12

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
;	SChannel sprintf "note%d", giNoteCount+12*(giNoteCount-1);
;	chnset giNoteArray[0], SChannel ; Place diagonal element
	
	iCur = giNoteArray[0]
	iCurV = iCur
	iCurH = iCur
	iCnt = 0
	
	giMatrix[0][0] = iCur
	
	until iCnt == giNoteCount do
		iCurV += giICArray[giNoteCount-iCnt]
		iCurV wrap iCurV,0,12
		
		iCurH -= giICArray[giNoteCount-iCnt]
		iCurH wrap iCurH,0,12
		
		giMatrix[giNoteCount-1][giNoteCount-1-iCnt] = iCurV
		giMatrix[giNoteCount-iCnt-1][giNoteCount-1] = iCurH
		
		SChannel sprintf "note_ident%d", giNoteCount+12*(giNoteCount-1-iCnt)
		prints SChannel 
		SMessage sprintf "text(\"%s\")", chnget:k("sharps")==1 ? gSC1[iCurV] : gSC2[iCurV]
		chnset SMessage, SChannel
		
		SChannel sprintf "note_ident%d", giNoteCount+12*(giNoteCount-1)-iCnt
		SMessage sprintf "text(\"%s\")", chnget:k("sharps")==1 ? gSC1[iCurH] : gSC2[iCurH]
		chnset SMessage, SChannel
		
		iCnt += 1
	od
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

gSC1[0] = "C"
gSC1[1] = "C#"
gSC1[2] = "D"
gSC1[3] = "D#"
gSC1[4] = "E"
gSC1[5] = "F"
gSC1[6] = "F#"
gSC1[7] = "G"
gSC1[8] = "G#"
gSC1[9] = "A"
gSC1[10] = "A#"
gSC1[11] = "B"	

gSC2[0] = "C"
gSC2[1] = "Db"
gSC2[2] = "D"
gSC2[3] = "Eb"
gSC2[4] = "E"
gSC2[5] = "F"
gSC2[6] = "Gb"
gSC2[7] = "G"
gSC2[8] = "Ab"
gSC2[9] = "A"
gSC2[10] = "Bb"
gSC2[11] = "B" 

gSC3[0] = "0"
gSC3[1] = "1"
gSC3[2] = "2"
gSC3[3] = "3"
gSC3[4] = "4"
gSC3[5] = "5"
gSC3[6] = "6"
gSC3[7] = "7"
gSC3[8] = "8"
gSC3[9] = "9"
gSC3[10] = "e"
gSC3[11] = "t"

gSC4[0] = "0"
gSC4[1] = "1"
gSC4[2] = "2"
gSC4[3] = "3"
gSC4[4] = "4"
gSC4[5] = "5"
gSC4[6] = "6"
gSC4[7] = "7"
gSC4[8] = "8"
gSC4[9] = "9"
gSC4[10] = "10"
gSC4[11] = "11"
endin

instr 1001	;check for changes to Row Locked button
	if changed:k(chnget:k("resetRow"))==1 then
		event "i", 1002, 0, 1		
	endif
	
	if changed:k(chnget:k("sharps"))==1 then
		gSC = gSC1
		event "i", 1003, 0, 1
	endif
	
	if changed:k(chnget:k("flats"))==1 then
		gSC = gSC2
		event "i", 1003, 0, 1
	endif
	
	if changed:k(chnget:k("PCs"))==1 then
		gSC = gSC3
		event "i", 1003, 0, 1
	endif
	
	if changed:k(chnget:k("PCs_te"))==1 then
		gSC = gSC4
		event "i", 1003, 0, 1
	endif

endin

instr 1002
	giNoteCount=0
	giNoteArray *= 0
	giNoteArray -= 1

	iCnt init 0
	until iCnt > 144 do
		SChannel sprintf "note_ident%d", iCnt+1
		chnset "text(\"\")", SChannel 
		iCnt=iCnt+1
	od			
	turnoff	
endin

instr 1003
	iCur init 0
	iCntV init 0
	iCntH init 0		
		
	until iCntV == giNoteCount do
		until iCntH == giNoteCount do
			SChannel sprintf "note_ident%d", 12*iCntV + iCntH
			iCur = giMatrix[iCntH][iCntV]
			Sname sprintf "text(%s)", gSC[iCur]
			chnset Sname, SChannel
			iCntH += 1
		od
		iCntV += 1
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