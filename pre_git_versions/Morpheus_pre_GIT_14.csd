<Cabbage>
form size(600, 540), caption(""), pluginID("plu1"), colour("white")

image bounds(37, 27, 484, 268), colour(90, 90, 90)


label bounds(280, 30, 38, 20), widgetarray("note", 144), colour("white"), fontcolour("black"), text(""), corners(0), colour("black")
keyboard bounds(40, 296, 479, 79)

groupbox bounds(40, 392, 150, 71) text("Spelling"), fontcolour("black"), colour(200, 200, 200), plant("spelling"){
	checkbox bounds(15, 25, 80, 20),  fontcolour("black"), channel("sharps"), text("Sharps"), radiogroup(99)
	checkbox bounds(85, 25, 80, 20),  fontcolour("black"), channel("flats"), text("Flats"), radiogroup(99)
	checkbox bounds(15, 45, 40, 20), fontcolour("black"), channel("PCs_te"), text("t"), value(1), radiogroup(99),
	checkbox bounds(85, 45, 40, 20), fontcolour("black"), channel("PCs"), text("10"), radiogroup(99),
	}
;label bounds(72, 421, 80, 12), colour("black") text("Spelling")

button bounds(360, 384, 100, 20), channel("resetRow"), text("Reset")

groupbox bounds(200, 392, 150, 71) text("Modulation"), fontcolour("black"), colour(200, 200, 200), plant("spelling"){
	button bounds(15, 25, 40, 20), channel("M5"), text("M5")
	button bounds(85, 25, 40, 20), channel("M7"), text("M7")
	button bounds(15, 45, 40, 20), channel("M11"), text("M11")
}                             


checkbox bounds(360, 408, 110, 20), channel("search"), fontcolour("black"), text("Enable Search")
label bounds(40, 472, 445, 14), colour("black"), visible(0), fontcolour("lime"), text(""), bold(0), identchannel("outputMessage")
button bounds(360, 432, 60, 25), channel("print"), text("Push", "Push")

image bounds(40, 464, 479, 20), plant("searchNotes"), visible(0), identchannel("searchNotesPlant"){
	label bounds(0, 0, 38, 20), text(""), colour("black")    identChannel("searchnote_ident1")
	label bounds(40, 0, 38, 20), text(""), colour("black")   identChannel("searchnote_ident2")
	label bounds(80, 0, 38, 20), text(""), colour("black")   identChannel("searchnote_ident3")
	label bounds(120, 0, 38, 20), text(""), colour("black")  identChannel("searchnote_ident4")
	label bounds(160, 0, 38, 20), text(""), colour("black")  identChannel("searchnote_ident5")
	label bounds(200, 0, 38, 20), text(""), colour("black")  identChannel("searchnote_ident6")
	label bounds(240, 0, 38, 20), text(""), colour("black")  identChannel("searchnote_ident7")
	label bounds(280, 0, 38, 20), text(""), colour("black")  identChannel("searchnote_ident8")
	label bounds(320, 0, 38, 20), text(""), colour("black")  identChannel("searchnote_ident9")
	label bounds(360, 0, 38, 20), text(""), colour("black")  identChannel("searchnote_ident10")
	label bounds(400, 0, 38, 20), text(""), colour("black")  identChannel("searchnote_ident11")
	label bounds(440, 0, 38, 20), text(""), colour("black")  identChannel("searchnote_ident12")
}
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

#define COL #0#
#define ROW #1#
#define LEFT #2#
#define RIGHT #3#
#define DOWN #4#
#define UP #5#

gSCSharp[] init 12
gSCFlat[] init 12
gSCPc[] init 12
gSCPct[] init 12

giSpelling init 0

giMatrix[][] init 12,12

giDisplayMatrix[][] init 24, 24
giProbTable[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
giNoteCount init 0;
giNoteArray[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
giICArray[] init 12
giIC[] init 6
giSearchArray[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
giSearchCount init 0

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
	;while iCnt < iSize do
	
	until iCnt == giNoteCount do
		if giNoteArray[iCnt]==iNote then
		;	printf "%d %d \n",1,giNoteArray[iCnt], iNote
		 	iPresent = 1
		endif
		iCnt = iCnt+1
	od
;	prints "%d %d %d \n",iCnt, giNoteCount, iPresent
	if (iPresent == 0)then
;	prints "%d %d \n", giNoteCount, iPresent
		giNoteArray[giNoteCount] = iNote
		
		if giNoteCount >= 1 then
			iIC = giNoteArray[giNoteCount] - giNoteArray[giNoteCount-1]
			giICArray[giNoteCount] wrap iIC,0,12
		endif
		giNoteCount = giNoteCount+1
	endif
	xout iPresent
endop   

;---------------------------------------
; generic version of isAlreadyThere UDO
;---------------------------------------  
opcode isAlreadyThereSimple, i, ii[]
	iNote, iArray[] xin
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

opcode getMX, i, j
	iDummyIn xin
		if chnget:i("M3")==1 then
		iMX = 3
		elseif chnget:i("M5")==1 then
		iMX = 5
		elseif chnget:i("M7")==1 then
		iMX = 7
		elseif chnget:i("M11")==1 then
		iMX = 11
		endif
	xout iMX		
endop

;--------------------------------------
;utility UDOs to print arrays...
opcode printArrayContents, 0, i[]i
	iArray[], iNoElements xin
	iIndex init 0
	until iIndex==iNoElements do
		prints "%d\t", iArray[iIndex]
	iIndex = iIndex+1
	od
	prints "\n"
endop
;--------------------------------------
opcode print2DArrayContents, 0, i[][]ii
	iArray[][], iNoRows, iNoCols xin
	iCntR init 0
	iCntC init 0
	until iCntR==iNoRows do
		until iCntC==iNoCols do
			prints "%d ", iArray[iCntR][iCntC]
			iCntC = iCntC+1
		od
		iCntR = iCntR+1
		iCntC = 0
		prints "\n"
	od
endop
;---------------------------------------
; opcode to rearrange matrix into usable form
;------------------------------------
opcode fillDisplayMatrix, 0, i[][]
	iArray[][] xin
	iCnt init 0
	iRow init 0
	until iRow==24 do
		;	prints "%d %d %d %d %d %d %d %d %d %d %d %d\n", iArray[iRow][0], iArray[iRow][1], iArray[iRow][2], iArray[iRow][3], iArray[iRow][4], iArray[iRow][5], iArray[iRow][6], iArray[iRow][7], iArray[iRow][8], iArray[iRow][9], iArray[iRow][10], iArray[iRow][11]
			until iCnt==24 do
				giDisplayMatrix[iRow][iCnt] =  iArray[iCnt%12][iRow%12];
				iCnt = iCnt+1 
			enduntil
		iCnt = 0
		iRow = iRow+1
	enduntil
;	
;	iCnt = 0
;	iRow = 0	
;	until iRow==12 do
;		;	prints "%d %d %d %d %d %d %d %d %d %d %d %d\n", iArray[iRow][0], iArray[iRow][1], iArray[iRow][2], iArray[iRow][3], iArray[iRow][4], iArray[iRow][5], iArray[iRow][6], iArray[iRow][7], iArray[iRow][8], iArray[iRow][9], iArray[iRow][10], iArray[iRow][11]
;			until iCnt==12 do
;				giDisplayMatrix[12+iRow][12+iCnt] =  giDisplayMatrix[iRow][iCnt]
;				iCnt = iCnt+1 
;			enduntil
;		iCnt = 0
;		iRow = iRow+1
;	enduntil	
endop

;---------------------------------------
; opcode to colour a rown or colums
;------------------------------------
opcode colourRow, 0, iiiii
	iType, iIndex, iR, iG, iB xin
	iCnt init 0
	iRow init 0

	if iType==0 then
		until iCnt==12 do
			SChannel sprintf "note_ident%d", iCnt*12+iIndex+1
			SColour sprintf "colour(%d,%d,%d)", iR, iG, iB
			chnset SColour, SChannel
			iCnt += 1 				
		enduntil 
	else
		until iCnt==12 do
			SChannel sprintf "note_ident%d", (iIndex*12)+iCnt+1
			SColour sprintf "colour(%d,%d,%d)", iR, iG, iB
			chnset SColour, SChannel
			iCnt += 1 				
		enduntil 	
	endif
endop

;---------------------------------------
; opcode to colour all labels blacks
;------------------------------------
opcode resetLabelColours, 0, i
	iNumLabels xin
	iCnt init 0
	iCntRows init 0

	until iCnt > 144 do
		if iCntRows%2==1 then
			iGrayScale = 200
		else	
			iGrayScale = (iCnt%2==0 ? 255 : 220)
		endif
		S1 sprintfk "colour(%d, %d, %d)", iGrayScale, iGrayScale, iGrayScale
		S2 sprintfk "note_ident%d", iCnt+1
		chnset S1, S2
		iCnt=iCnt+1
		iCntRows = (iCnt%12==0 ? iCntRows+1 : iCntRows)
	enduntil
endop

;-----------------------------------------------
; search matrix for pattern
; search matrix for pattern
opcode searchMatrix, i[], ii
iType, iDir xin
iFound init 0
iCntRow init 0
iCntCol init 0
iCnt init 0
iSubCnt init 0
iMatches init 0
iMostLikelyRow init -1
iFoundPattern = 0 
iProbTable[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 

if iType==$ROW && iDir==$RIGHT then
	until iCntRow==12 do
		iCnt=0
		iCntCol=0
		iSubCnt=0
		iMatches=0
		until iCnt>=giSearchCount do
			until iCntCol==12 do
			if giDisplayMatrix[iCntRow][iCntCol]==giSearchArray[iCnt] then
			;found a match, now check subsequent indices
				until iCnt==giSearchCount do
					if giDisplayMatrix[iCntRow][iCntCol+iSubCnt]==giSearchArray[iCnt] then
						;SString sprintf "Found on Row %d index %d\n", iCntRow, iCntCol+iSubCnt
						;prints SString
						iSubCnt +=1
						if iMatches<iSubCnt then
						 	iMatches = iSubCnt
						 	iMostLikelyRow = iCntRow
							iProbTable[iCntRow] = iProbTable[iCntRow]+1
;							print iCntRow, iProbTable[iCntRow]
						endif
						iCnt+=1
					else
					iCnt=giSearchCount
					endif			
					
				enduntil
			endif
			iCntCol += 1
			enduntil
		iCnt +=1
		enduntil
	iCntRow += 1
	enduntil

endif

xout iProbTable
endop






;================================================
; gets triggered each time a note is pressed
;================================================
instr 1

if chnget:i("search")==1 then
	iGoSearch isAlreadyThereSimple p4%12, giSearchArray
	if iGoSearch==0 then
		giSearchArray[giSearchCount] = p4%12
		SChannel sprintf "searchnote_ident%d", giSearchCount+1
		SMessage sprintf "text(\"%d\")", giSearchArray[giSearchCount]
		chnset SMessage, SChannel 
		
		giSearchCount = giSearchCount+1

		event_i "i", "SearchMatrixForRow", 0, 1
	endif
else
	iGo isAlreadyThere p4
	if iGo==0 then
		
	;	giIC = giIC*0
		iCurV = giNoteArray[0]
		iCurH = giNoteArray[0]
		iCnt = 1
		iCnt_ = 1
		giMatrix[giNoteCount-1][giNoteCount-1] = giNoteArray[0]
		SChannel sprintf "note_ident%d", giNoteCount+12*(giNoteCount-1)
		SMessage sprintf "text(\"%s\")", getTextFromArray(iCurH, getSpelling:i())
		chnset SMessage, SChannel
		
		until iCnt == giNoteCount do

			iCurV += + giICArray[giNoteCount-iCnt]
			iCurV wrap iCurV,0,12
			
			iCurH -=  giICArray[giNoteCount-iCnt]
			iCurH wrap iCurH,0,12
			
			giMatrix[giNoteCount-1][giNoteCount-iCnt-1] = iCurV
			giMatrix[giNoteCount-iCnt-1][giNoteCount-1] = iCurH
			
			SChannel sprintf "note_ident%d", giNoteCount+12*(giNoteCount-1-iCnt)
			;prints SChannel 
			SMessage sprintf "text(\"%s\")", getTextFromArray(iCurV, getSpelling:i())
			chnset SMessage, SChannel
			
			SChannel sprintf "note_ident%d", giNoteCount+12*(giNoteCount-1)-iCnt
			SMessage sprintf "text(\"%s\")", getTextFromArray(iCurH, getSpelling:i())
			chnset SMessage, SChannel
			;-----------------------------------
			; Interval Class array 
			until iCnt_ == giNoteCount do
				iIC_cur = giNoteArray[giNoteCount-1] - giNoteArray[giNoteCount-1-iCnt_]
			;	iIC_cur wrap iIC_cur, 0, 7			
				
				if iIC_cur <= 6 then
					iIC_cur = abs(iIC_cur)
				else
					iIC_cur = 12 - abs(iIC_cur)
				endif
				
				iCnt_ += 1
				
				if iIC_cur = 1 then
					giIC[0] = giIC[0]+1
				elseif iIC_cur = 2 then
					giIC[1] = giIC[1]+1
				elseif iIC_cur = 3 then
					giIC[2] = giIC[2]+1
				elseif iIC_cur = 4 then
					giIC[3] = giIC[3]+1
				elseif iIC_cur = 5 then
					giIC[4] = giIC[4]+1
				elseif iIC_cur = 6 then
					giIC[5] = giIC[5]+1
				endif
				
			
			od	
			prints "%d %d %d %d %d %d\n", giIC[0], giIC[1], giIC[2],giIC[3],giIC[4],giIC[5]
			;-----------------------------------
			
			iCnt += 1
		od
	;	prints "%d\n", giMatrix[giNoteCount-1][giNoteCount-1]
	endif
	
		fillDisplayMatrix(giMatrix)
	
endif	
endin
;============================================================
; utility instruments for controlling aspects of the GUI
;============================================================
instr 1000	;position all our numberboxes and create global arrays
	iCnt init 0
	iCntRows init 0

	until iCnt > 144 do
		if iCntRows%2==1 then
			iGrayScale = 200
		else	
			iGrayScale = (iCnt%2==0 ? 255 : 220)
		endif
		S1 sprintfk "pos(%d, %d) colour(%d, %d, %d)", iCnt%12*40+40, iCntRows*22+30, iGrayScale, iGrayScale, iGrayScale
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
		event "i", "ResetAll", 0, 1 
			giNoteCount=0
			giNoteArray *= 0
			giNoteArray -= 1	
	endif
	
	kNoteCount = giNoteCount; 	cast to kRate for checking later...

	kReSpellNotes changed chnget:k("sharps"), chnget:k("flats"), \
							chnget:k("PCs_te"), chnget:k("PCs")
	if kReSpellNotes == 1 then
		event "i", "ChangeSpelling", 0, 1, 0
	endif
				
	kMultiply changed chnget:k("M3"), chnget:k("M5"), \
							chnget:k("M7"), chnget:k("M11")
	if kMultiply == 1 then
		event "i", "DoMatrixMultiplication", 0, 1, 0
	endif
	
	if changed(chnget:k("print"))==1 then
		event "i", "printMatrix", 0, 1
	endif	

	if changed:k(chnget:k("search"))==1 then
		if chnget:k("search") == 1 then
			if kNoteCount < 12 then	
				scoreline {{i"DisplayNotice"  0  100  "Please fill a full row before enabling search" 5}}, 1
			else
				chnset "visible(1)", "searchNotesPlant"
			endif
		else
			chnset "visible(0)", "searchNotesPlant"
		endif
	endif
	
	if changed:k(chnget:k("print"))==1 then
			;event "i", "SearchMatrixForRow", 0, 1
			event "i", "PrintMatrix", 0, 1
	endif

	if changed:k(chnget:k("colourLabel"))==1 then
			SChannel sprintfk "note_ident%d", chnget:k("label")
			chnset "colour(\"yellow\")", SChannel 
	endif
endin

;-------------------------------------------
; empty all labels and reset global arrays
instr ResetAll
	iCnt init 0
	iCnt_ init 0
	until iCnt > 144 do
		SChannel sprintf "note_ident%d", iCnt+1
		chnset "text(\"\"), colour(\"black\")", SChannel 
		iCnt=iCnt+1
	od	

	iCnt = 0
	while iCnt < 12 do
		giNoteArray[iCnt]=-1
		giICArray[iCnt]=0
		giSearchArray[iCnt]=-1
		 
		iCnt=iCnt+1
	od
	giNoteCount=0
	; ----- reseting IC matrix	
	giIC fillarray 0,0,0,0,0,0
	
	chnset 0, "search"
	chnset "visible(0)", "searchNotesPlant"
	turnoff	
endin

;-------------------------------------------
; change spelling of labels
instr ChangeSpelling
	;giNoteCount = p4
	iCur init 0
	iCntV init 0
	iCntH init 0
	print giNoteCount		
	until iCntV == giNoteCount do
		until iCntH == giNoteCount do
			SChannel sprintf "note_ident%d", 12*iCntV + iCntH + 1
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

;-------------------------------------------
; reset label colours
instr CallResetLabelColours
	resetLabelColours(144)
endin

;-------------------------------------------
; Multiplication
instr DoMatrixMultiplication	
	iCur init 0
	iCntV init 0
	iCntH init 0
	iM = getMX:i()
	
	until iCntV == giNoteCount do
		until iCntH == giNoteCount do
			iCur = giMatrix[iCntH][iCntV]*iM
			iCur wrap iCur,0,12
			giMatrix[iCntH][iCntV] = iCur
			iCntH += 1
		od
		iCntH = 0
		iCntV += 1
	od			
	event "i", "ChangeSpelling", 0, 1, 0
endin

;-------------------------------------------
; Normalization 16.02.16
instr DoMatrixNorm	
	iCur init 0
	iCntV init 0
	iCntH init 0
	
	until iCntV == giNoteCount do
		until iCntH == giNoteCount do
			iCur = giMatrix[iCntH][iCntV] - giNoteArray[0]
			iCur wrap iCur,0,12
			giMatrix[iCntH][iCntV] = iCur
			iCntH += 1
		od
		iCntH = 0
		iCntV += 1
	od			
	event "i", "ChangeSpelling", 0, 1, 0
endin
;-------------------------------------------
; Display notification ..called whenever we need to give
; a message to the end user...
instr DisplayNotice
	SOutputMessage = p4
	kCount init 0
	SMessage sprintf "text(\"%s\"), visible(1)", SOutputMessage
	chnset SMessage, "outputMessage"
	if metro(1)==1 then	
		kCount = kCount+1
	endif
	
	if kCount==p5 then;
		chnset "visible(0)", "outputMessage"
		chnset 0, "search"
		turnoff
	endif
endin

instr PrintMatrix
;print matrix
	prints "\n"
	print2DArrayContents(giDisplayMatrix, 24, 24)
	;colourRow($COL, 4, 255, 255, 0)
	;colourRow($ROW, 4, 255, 255, 0)
endin 


;-------------------------------------------
; search matrix for row
instr SearchMatrixForRow
	iRow init 0 
	iCnt init 0
	iCol init 0
	iRowProbs[] init 12
	iLabelCnt init 0

	resetLabelColours(144); set all labels back to white
		
	iRowProbs searchMatrix $ROW, $RIGHT		 
	iMax maxarray iRowProbs
	
	until iRow==12 do
			if iMax==iRowProbs[iRow] then
				until iCnt==giSearchCount do
					until iCol==12 do
							print iRow
							if giSearchArray[iCnt]==giDisplayMatrix[iRow][iCol] then
							SChannel sprintf "note_ident%d", iRow*12 + iCol + 1
							chnset "colour(255, 255, 0)", SChannel
							endif
					iCol += 1
					enduntil
					iCnt+=1
					iCol=0
				enduntil

			iCnt=0
			endif
	iRow += 1
	enduntil

endin

</CsInstruments>  
<CsScore>
i1000 0 1 
i1001 0 10000 
f0 z
</CsScore>
</CsoundSynthesizer> 