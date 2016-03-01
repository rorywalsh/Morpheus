<Cabbage>
form size(600, 500), caption(""), pluginID("plu1"), colour("white")
label bounds(280, 30, 38, 20), widgetarray("note", 144), text(""), colour("black")
keyboard bounds(40, 336, 479, 79)
button bounds(424, 424, 100, 20), channel("resetRow"), text("Reset")

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

gSCSharp[] init 12
gSCFlat[] init 12
gSCPc[] init 12
gSCPct[] init 12

giSpelling init 0

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
			giICArray[giNoteCount] wrap iIC,0,13
		endif
		giNoteCount = giNoteCount+1
	endif

	;prints "%d %d %d %d\n", giICArray[0], giICArray[1], giICArray[2], giICArray[3]
	;prints "%d %d %d %d\n", giNoteArray[0], giNoteArray[1], giNoteArray[2], giNoteArray[3]
	xout iPresent
endop   
  
;---------------------------------------
; get text from string array
;---------------------------------------     
opcode getTextFromArray, S, ii
	iNote, iSpelling xin
	Soutput init ""
	if iSpelling==0 then
		Soutput = gSCSharp[iNote]
	elseif iSpelling==1 then
		Soutput = gSCFlat[iNote]
	elseif iSpelling==2 then
		Soutput = gSCPc[iNote]
	elseif iSpelling==3 then
		Soutput = gSCPct[iNote]
	endif
	xout Soutput
endop

opcode getSpelling, i, j
iDummyIn xin
		if chnget:i("sharps")==1 then
		iSpelling = 0
		elseif chnget:i("flats")==1 then
		iSpelling = 1
		elseif chnget:i("PCs_te")==1 then
		iSpelling = 2
		elseif chnget:i("PCs")==1 then
		iSpelling = 3
		endif
xout iSpelling		
endop


;================================================
; gets triggered each time a note is pressed
;================================================
instr 1
iRowIsLocked chnget "rowIsLocked"
iGo isAlreadyThere p4
if iGo==0 then
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
		iCurV wrap iCurV,0,13
		
		iCurH -= giICArray[giNoteCount-iCnt]
		iCurH wrap iCurH,0,13
		
		giMatrix[giNoteCount-1][giNoteCount-1-iCnt] = iCurV
		giMatrix[giNoteCount-iCnt-1][giNoteCount-1] = iCurH
		
		SChannel sprintf "note_ident%d", giNoteCount+12*(giNoteCount-1-iCnt)
		;prints SChannel 
		SMessage sprintf "text(\"%s\")", getTextFromArray(iCurV, getSpelling:i())
		chnset SMessage, SChannel
		
		SChannel sprintf "note_ident%d", giNoteCount+12*(giNoteCount-1)-iCnt
		SMessage sprintf "text(\"%s\")", getTextFromArray(iCurH, getSpelling:i())
		chnset SMessage, SChannel
		
		iCnt += 1
	od
endif
endin
;============================================================
; utility instruments for controlling aspects of the GUI
;============================================================
instr 1000	;position all our numberboxes and create global arrays
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
		
	gSCSharp[0] = "C"
	gSCSharp[1] = "C#"
	gSCSharp[2] = "D"
	gSCSharp[3] = "D#"
	gSCSharp[4] = "E"
	gSCSharp[5] = "F"
	gSCSharp[6] = "F#"
	gSCSharp[7] = "G"
	gSCSharp[8] = "G#"
	gSCSharp[9] = "A"
	gSCSharp[10] = "A#"
	gSCSharp[11] = "B"
	
	gSCFlat[0] = "C"
	gSCFlat[1] = "Db"
	gSCFlat[2] = "D"
	gSCFlat[3] = "Eb"
	gSCFlat[4] = "E"
	gSCFlat[5] = "F"
	gSCFlat[6] = "Gb"
	gSCFlat[7] = "G"
	gSCFlat[8] = "Ab"
	gSCFlat[9] = "A"
	gSCFlat[10] = "Bb"
	gSCFlat[11] = "B" 	
	
	gSCPct[0] = "0"
	gSCPct[1] = "1"
	gSCPct[2] = "2"
	gSCPct[3] = "3"
	gSCPct[4] = "4"
	gSCPct[5] = "5"
	gSCPct[6] = "6"
	gSCPct[7] = "7"
	gSCPct[8] = "8"
	gSCPct[9] = "9"
	gSCPct[10] = "e"
	gSCPct[11] = "t"
	
	gSCPc[0] = "0"
	gSCPc[1] = "1"
	gSCPc[2] = "2"
	gSCPc[3] = "3"
	gSCPc[4] = "4"
	gSCPc[5] = "5"
	gSCPc[6] = "6"
	gSCPc[7] = "7"
	gSCPc[8] = "8"
	gSCPc[9] = "9"
	gSCPc[10] = "10"
	gSCPc[11] = "11"				
endin

;-------------------------------------------
;check for changes to GUI
instr 1001	
	if changed:k(chnget:k("resetRow"))==1 then
		event "i", 1002, 0, 1
			giNoteCount=0
			giNoteArray *= 0
			giNoteArray -= 1		
	endif
	
	kReSpellNotes changed chnget:k("sharps"), chnget:k("flats"), \
							chnget:k("PCs_te"), chnget:k("PCs")
	if kReSpellNotes == 1 then
		event "i", 1003, 0, 1, 0
	endif
							
endin

;-------------------------------------------
; empty all labels and reset global arrays
instr 1002
	iCnt init 0
	until iCnt > 144 do
		SChannel sprintf "note_ident%d", iCnt+1
		chnset "text(\"\")", SChannel 
		iCnt=iCnt+1
	od	

	iCnt = 0
	while iCnt < 12 do
		giNoteArray[iCnt]=-1
		giICArray[iCnt]=0
		 
		iCnt=iCnt+1
	od
	giNoteCount=0
	turnoff	
endin

;-------------------------------------------
; change spelling of labels
instr 1003
	;giNoteCount = p4
	iCur init 0
	iCntV init 0
	iCntH init 0
	print giNoteCount		
	until iCntV == giNoteCount do
		until iCntH == giNoteCount do
			SChannel sprintf "note_ident%d", 12*iCntV + iCntH
			iCur = giMatrix[iCntH][iCntV]
			;print iCntH, iCntV
			Sname sprintf "text(\"%s\")", getTextFromArray(iCur, getSpelling:i())
			chnset Sname, SChannel
			;print iCntH, iCntV
			iCntH += 1
		od
		iCntH = 0
		iCntV += 1
	od			

endin
</CsInstruments>  
<CsScore>
i1000 0 1 
i1001 0 10000 
f0 z
</CsScore>
</CsoundSynthesizer> 