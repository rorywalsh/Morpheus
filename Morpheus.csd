<Cabbage>
form size(700, 480), caption(""), pluginID("plu1"), colour("white")



;plant to hold listbox for known rows. Easier to mane when it's a plant
image bounds(37, 23, 484, 268), colour(90, 90, 90), plant("listbox"), identchannel("listbox"), visible(0), {
	listbox bounds(2, 2, 478, 262), channel("rowListbox"), file("classicRows.txt"), value(-1), align("left"), highlightcolour(200, 200, 0)
}

;plant to hold array of labels for displaying our matrix.  
image bounds(37, 23, 484, 268), colour(90, 90, 90), plant("matrix"), identchannel("matrix"), visible(1), {
	label bounds(280, 30, 38, 20), widgetarray("note", 144), colour("white"), fontcolour("black"), text(""), corners(0), colour("black")
}

;plant to hold array of widgets used to display search
groupbox bounds(32, 392, 490, 60), colour(160, 160, 160), fontcolour("black"), text("Search pattern"), plant("searchNotes"), visible(0), identchannel("searchNotesPlant"){
	label bounds(5,   30, 38, 20), text(""), fontcolour("black"), colour("white")  widgetarray("searchnote", 12)
}

;plant to hold array of widgets used to display inverse column names. 
image bounds(32, 7, 490, 15), colour("white"), plant("inverseLabelsPlant"), identchannel("inverseLabels_id"){
	label bounds(0, 0, 38, 15), text(""), fontcolour("black"), colour("white") widgetarray("inverseLabels", 12)
}

;plant to hold array of widgets used to display retro inverse column names. 
image bounds(32, 290, 490, 15), colour("white"), plant("retroInverseLabelsPlant"), identchannel("retroInverseLabels_id"){
	label bounds(0, 0, 38, 15), text(""), fontcolour("black"), colour("white") widgetarray("retroInverseLabels", 12)
}

;plant to hold array of widgets used to displayprime row names. 
image bounds(5, 28, 30, 280), colour("white"), plant("primeLabelsPlant"),  identchannel("primeLabels_id"){
	label bounds(0, 0, 30, 15), text(""), fontcolour("black"), colour("white") align("right"), widgetarray("primeLabels", 12)
}
 
;plant to hold array of widgets used to display retrograde row names. 
image bounds(522, 28, 30, 280), colour("white"), plant("retroLabelsPlant"), identchannel("retroLabels_id"){
	label bounds(0, 0, 30, 15), text(""), fontcolour("black"), colour("white") align("left"), widgetarray("retroLabels", 12)
}
 
image bounds(560, 16, 118, 285), colour(200, 200, 200)         
image bounds(32, 304, 647, 95), colour(200, 200, 200)               
                                           
button bounds(576, 24, 95, 20), channel("resetRow"), text("Reset Matrix"), popuptext("Reset matrix back to blank state")
button bounds(576, 72, 95, 20), channel("rand"), text("Randon Row"), popuptext("Fill matrix with random values")
button bounds(576, 48, 95, 20), channel("search"), text("Search Matrix", "Reset Search"), colour:1("green"), popuptext("Enable searching of matrix for a particular pattern")



label bounds(32, -456, 445, 14), colour("black"), visible(0), fontcolour("lime"), text(""), bold(0), identchannel("outputMessage")
;button bounds(632, 320, 60, 25), channel("debug"), text("Debug")


groupbox bounds(568, 120, 106, 51) text("Spelling"), fontcolour("black"), colour("White"), 
combobox bounds(576, 144, 92, 24), channel("spellingCombo"), items("Sharps", "Flats", "10", "t"), value(3), popuptext("Change harmonic spelling of notes")
groupbox bounds(568, 168, 106, 55) text("Permutations"), fontcolour("black"), colour("White")
combobox bounds(576, 192, 92, 24), channel("permutationsCombo"), items("Select", "Original", "O x E", "O1 x O2", "Over 5", "Over 7","R[Tri]","R[Tetr]")
groupbox bounds(568, 216, 106, 80) text("Modulation"), fontcolour("black"), colour("White")
combobox bounds(576, 240, 92, 24), channel("modulationsCombo"), items("Select", "Original", "M5", "M7", "M11"), popuptext("Transposes each note by a set interval")
button bounds(576, 96, 95, 20), channel("classicRows"), text("Classic Rows", "Show Matrix"), value(0), popuptext("Shows a list of iconic rows used in various 12-tone compositions")
button bounds(576, 272, 95, 20), channel("norm"), text("Norm"), popuptext("Normalises matrix - sets first note in row to 0 and scales all other notes accordingly")
keyboard bounds(40, 312, 460, 79)

groupbox bounds(504, 312, 170, 51) text("Interval Class"), colour("black"), fontcolour("white"), colour("White")
label bounds(514, 340, 151, 17), text("[0 0 0 0 0 0]"), identchannel("intervalclass")



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

gSCSharp[] init 12
gSCFlat[] init 12
gSCPc[] init 12
gSCPct[] init 12
giProb init 0
giSpelling init 0
giMax init -1
giMatrix[][] init 12,12 

gkLabels[] init 144
gkLabelsTemp[] init 144

giDisplayMatrix[][] init 24, 24
giNoteCount init 0;
giNoteArray[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
giICArray[] init 12
giIC[] init 6
giSearchArray[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
giSearchCount init 0

#include "MorpheusUDOs.csd"
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

		iCurV = giNoteArray[0]
		iCurH = giNoteArray[0]
		iCnt = 1
		iCnt_ = 1
		giMatrix[giNoteCount-1][giNoteCount-1] = giNoteArray[0]
		SChannel sprintf "note_ident%d", giNoteCount+12*(giNoteCount-1)
		SMessage sprintf "text(\"%s\")", getTextFromArray(iCurH, getSpelling:i())
		chnset SMessage, SChannel
		NormalOrder
		; ------- calculating row names for P,I,R and RI--------
		if giNoteCount==1 then
								;p	i	index
			nameRowsAndColumns 	0, 	0, 	1
		else 
			iPx = giNoteArray[0] - giNoteArray[giNoteCount-1]
			iPx wrap iPx,0,12
			iIx = 12 - iPx
			iIx wrap iIx,0,12
								;p		i		index
			nameRowsAndColumns  iPx, 	iIx,	giNoteCount
		endif
		;--------------------------------------------------------		
		until iCnt == giNoteCount do
		
			iCurV += + giICArray[giNoteCount-iCnt]
			iCurV wrap iCurV,0,12
			
			iCurH -=  giICArray[giNoteCount-iCnt]
			iCurH wrap iCurH,0,12
			
			giMatrix[giNoteCount-1][giNoteCount-iCnt-1] = iCurV
			giMatrix[giNoteCount-iCnt-1][giNoteCount-1] = iCurH
			
			SChannel sprintf "note_ident%d", giNoteCount+12*(giNoteCount-1-iCnt)
			SMessage sprintf "text(\"%s\")", getTextFromArray(iCurV, getSpelling:i())
			chnset SMessage, SChannel
			
			SChannel sprintf "note_ident%d", giNoteCount+12*(giNoteCount-1)-iCnt
			SMessage sprintf "text(\"%s\")", getTextFromArray(iCurH, getSpelling:i())
			chnset SMessage, SChannel
			;-----------------------------------
			; Interval Class array 
			if giNoteCount <= 10 then
				until iCnt_ == giNoteCount do
					iIC_cur = giNoteArray[giNoteCount-1] - giNoteArray[giNoteCount-1-iCnt_]		
					iabsIC = abs(iIC_cur)
					if iabsIC <= 6 then
						iIC_cur = iabsIC
					else
						iIC_cur = 12 - iabsIC
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
			elseif giNoteCount == 11 then
				giIC[] fillarray 10,10,10,10,10,5
			elseif giNoteCount == 12 then
				giIC[] fillarray 12,12,12,12,12,6
			endif	
			;-----------------------------------
			iCnt += 1
		od
		
		SIntClass sprintf "text(\"[%d %d %d %d %d %d]\")", giIC[0], giIC[1], giIC[2],giIC[3],giIC[4],giIC[5]
		chnset SIntClass, "intervalclass"
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
		S1 sprintfk "pos(%d, %d) colour(%d, %d, %d)", iCnt%12*40+2, iCntRows*22+2, iGrayScale, iGrayScale, iGrayScale
		S2 sprintfk "note_ident%d", iCnt+1
		chnset S1, S2
		S3 sprintfk "note%d", iCnt+1
		chnset 0, S3
		gkLabels[iCnt]=0
		iCnt=iCnt+1
		iCntRows = (iCnt%12==0 ? iCntRows+1 : iCntRows)
	enduntil

	iCnt = 0
	until iCnt ==12 do
		S1 sprintfk "pos(%d, 25)", iCnt*40+5
		S2 sprintfk "searchnote_ident%d", iCnt+1
		chnset S1, S2
		iCnt=iCnt+1
	enduntil		
	
	iCnt = 0
	until iCnt ==12 do
		S1 sprintfk "pos(%d, 0)", iCnt*40+6
		S2 sprintfk "inverseLabels_ident%d", iCnt+1
		chnset S1, S2
		iCnt=iCnt+1
	enduntil
			
	iCnt = 0
	until iCnt ==12 do
		S1 sprintfk "pos(%d, 0)", iCnt*40+6
		S2 sprintfk "retroInverseLabels_ident%d", iCnt+1		
		chnset S1, S2
		iCnt=iCnt+1
	enduntil
				
	iCnt = 0
	until iCnt ==12 do
		S1 sprintfk "pos(0, %d)", iCnt*22
		S2 sprintfk "primeLabels_ident%d", iCnt+1		
		chnset S1, S2
		iCnt=iCnt+1
	enduntil			
				
	iCnt = 0
	until iCnt ==12 do
		S1 sprintfk "pos(0, %d)", iCnt*22
		S2 sprintfk "retroLabels_ident%d", iCnt+1		
		chnset S1, S2
		iCnt=iCnt+1
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

	kNoteCount = giNoteCount; 	cast to kRate for checking later...

	if metro(5)==1 then
		kIndex = 0
		until kIndex==144 do
		    gkLabels[kIndex] chnget sprintfk("note%d", kIndex+1)
		    if gkLabels[kIndex] != gkLabelsTemp[kIndex] then
		    	printks "%d %d\n", .1, int(kIndex/12), kIndex%12
				event "i", "ColourRowAndColumn", 0, 1, int(kIndex/12), kIndex%12
		    endif
			gkLabelsTemp[kIndex] = gkLabels[kIndex]
		    kIndex = kIndex+1
		enduntil
	endif

	if changed:k(chnget:k("rand"))==1 then
		if kNoteCount == 12 then	
				scoreline {{i"DisplayNotice"  0  100  "The row is completed. Try delete some cells or reset" 5}}, 1
		else
			event "i", "RandRow", 0, 1
		endif
	endif
		
	if changed:k(chnget:k("resetRow"))==1 then
		event "i", "ResetAll", 0, 1 
	endif
	
	if changed:k(chnget:k("norm"))==1 then
		event "i", "DoNorm", 0, 1 	
	endif

	kReSpellNotes changed chnget:k("spellingCombo")
	if kReSpellNotes == 1 then
		event "i", "ChangeSpelling", 0, 1, 0
	endif
				
	kMultiply changed chnget:k("modulationsCombo")
	if kMultiply == 1 then
		event "i", "DoMatrixMultiplication", 0, 1, 0
	endif
	
	kPermute changed chnget:k("permutationsCombo")
	if kPermute == 1 then
		if kNoteCount < 12 then	
				scoreline {{i"DisplayNotice"  0  100  "Please fill a full row before enabling permutation" 5}}, 1
		else
			event "i", "DoRowPermutation", 0, 1, 0
		endif
	endif
	


	if changed:k(chnget:k("search"))==1 then
		if chnget:k("search") == 1 then
			if kNoteCount < 12 then	
				scoreline {{i"DisplayNotice"  0  100  "Please fill a full row before enabling search" 5}}, 1
			else
				chnset "visible(1)", "searchNotesPlant"
				event "i", "ResetSearch", 0, 1
			endif
		else
			chnset "visible(0)", "searchNotesPlant"

		endif
	endif
	
	if changed:k(chnget:k("debug"))==1 then
			;event "i", "SearchMatrixForRow", 0, 1
			;event "i", "PrintMatrix", 0, 1
			printks "Hello\n", 1
			chnset 0, "classicRows"
			chnset 0, "search"
	endif
	
	if changed:k(chnget:k("search"))==1 then
		
	endif

	if changed:k(chnget:k("colourLabel"))==1 then
			SChannel sprintfk "note_ident%d", chnget:k("label")
			chnset "colour(\"yellow\")", SChannel 
	endif
	
	if changed:k(chnget:k("classicRows"))==1 then
		if chnget:k("classicRows") == 1 then
			chnset "visible(1)", "listbox"
			chnset "visible(0)", "matrix"
			chnset "visible(0)", "inverseLabels_id"
			chnset "visible(0)", "retroLabels_id"
			chnset "visible(0)", "retroInverseLabels_id"
			chnset "visible(0)", "primeLabels_id"
		else
			chnset "visible(0)", "listbox"
			chnset "visible(1)", "matrix"
			chnset "visible(1)", "inverseLabels_id"
			chnset "visible(1)", "retroLabels_id"
			chnset "visible(1)", "retroInverseLabels_id"
			chnset "visible(1)", "primeLabels_id"		
		endif
	endif	
	
	if changed:k(chnget:k("rowListbox"))==1 then
		event "i", "RandRow", 0, 1
		event "i", "ShowMatrix", 0, 1
	endif
	
endin

;-------------------------------------------
; shows the main matrix hides the listbox
instr ColourRowAndColumn
	resetLabelColours(0)
	colourRow $ROW, p4, 255, 255, 0
	colourRow $COL, p5, 255, 255, 0
endin
;-------------------------------------------
; shows the main matrix hides the listbox
instr ShowMatrix
giNoteCount=0
resetLabelColours(1)
chnset "visible(1)", "matrix"
chnset "visible(0)", "listbox"
chnset "visible(1)", "inverseLabels_id"
chnset "visible(1)", "retroLabels_id"
chnset "visible(1)", "retroInverseLabels_id"
chnset "visible(1)", "primeLabels_id"
chnset 0, "classicRows"
endin
;-------------------------------------------
; empty all labels and reset global arrays
instr ResetAll
	iCnt init 0
	iCnt_ init 0
	
	resetLabelColours(1)	
	
	iCnt = 0
	while iCnt < 12 do
		giNoteArray[iCnt]=-1
		giICArray[iCnt]=0
		giSearchArray[iCnt]=-1
		giSearchCount=0
		SChannel sprintf "searchnote_ident%d", iCnt+1
		chnset "text(\"\")", SChannel
		SChannel sprintf "primeLabels_ident%d", iCnt+1
		chnset "text(\"\")", SChannel
		SChannel sprintf "inverseLabels_ident%d", iCnt+1
		chnset "text(\"\")", SChannel
		SChannel sprintf "retroLabels_ident%d", iCnt+1
		chnset "text(\"\")", SChannel
		SChannel sprintf "retroInverseLabels_ident%d", iCnt+1
		chnset "text(\"\")", SChannel
		iCnt=iCnt+1
	od
	giNoteCount=0
	; ----- reseting IC matrix	
	giIC fillarray 0,0,0,0,0,0
	SIntClass sprintf "text(\"[%d %d %d %d %d %d]\")", 0,0,0,0,0,0
	chnset SIntClass, "intervalclass"
	chnset 0, "search"
	chnset "visible(0)", "searchNotesPlant"
	turnoff	
endin

;-------------------------------------------
; empty all labels and reset global arrays
instr ResetSearch
	iCnt init 0
	while iCnt < 12 do
		giSearchArray[iCnt]=-1
		giSearchCount=0
		SChannel sprintf "searchnote_ident%d", iCnt+1
		chnset "text(\"\")", SChannel
		iCnt=iCnt+1
	od
	resetLabelColours(0)
endin
;-------------------------------------------
; change spelling of labels
instr ChangeSpelling
	;giNoteCount = p4
	iCur init 0
	iCntV init 0
	iCntH init 0
		
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
;-------------------------------------------
; randomize the rest of the row
instr RandRow
	seed 0
	iCnt init 0
	iCnt_ init 0
	iCnt2 init 0
	iCnt3 init 0
	iRand[] fillarray 0,1,2,3,4,5,6,7,8,9,10,11
	iRand_[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	iRandT[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1	

	until iCnt == giNoteCount do
		iRand[giNoteArray[iCnt]] = -1
		iCnt += 1
	od			
	
	iCnt = 0
	until iCnt == 12 do
		if iRand[iCnt] != -1 then
			iRand_[iCnt_] = iRand[iCnt]
			iCnt_ += 1
		endif
		iCnt += 1
	od
;	prints "%d", iCnt_
	; Fisher and Yeates' Algorithm
	iCnt = iCnt_
	until iCnt == 0 do
		iGen random 0, iCnt
		iGen = int(iGen)
	;	iRandN[iCnt2] = iRand_[iGen] ; be fixed with giNoteArray
		giNoteArray[giNoteCount+iCnt2] = iRand_[iGen]
		iRand_[iGen] = -1
		iCnt2 += 1
		
		iCnt4 = 0
		iCnt3 = 0
		until iCnt3 == iCnt do
			if iRand_[iCnt3] != -1 then
				iRandT[iCnt4] = iRand_[iCnt3]
				iCnt4 += 1	
			endif
			iCnt3 += 1
		od
;		
		iCnt3 = 0		
		until iCnt3 == iCnt do
			iRand_[iCnt3] = iRandT[iCnt3]
			iCnt3 += 1
		od
		
		iCnt -= 1
	od
	;
	iCnt = 0
	iLocalNoteArray[] =  giNoteArray

	while iCnt < 12 do
	;	prints "%d ", iRandN[iCnt]
	 	prints "%d ", iLocalNoteArray[iCnt]
		event_i "i", 1, iCnt*.1, .1, iLocalNoteArray[iCnt]
		iCnt += 1

	od
	prints "\n"
	
	;event_i "i", "CalculateMatrix", 0, .1
endin
;-------------------------------------------
instr DoRowPermutation
	iTemp[] init 12
	iCnt init 0
	
	until iCnt == 12 do
		iTemp[iCnt] = giNoteArray[iCnt]
		iCnt += 1
	od
	
	iP = getPX:i()
	
	if iP == 0 then
	; 0 1 2 3 4 5 6 7 8 9 t e
	; 1 0 3 2 5 4 7 6 9 8 e t
		iCnt = 0
		until iCnt == 6 do
			giNoteArray[2*iCnt+1] = giNoteArray[2*iCnt]
			giNoteArray[2*iCnt] = iTemp[2*iCnt+1]
			iCnt += 1
		od
		
	elseif iP == 1 then
	; 0 1 2 3 4 5 6 7 8 9 t e
	; 2 1 0 5 4 3 8 7 6 e t 9
		iCnt = 0
		until iCnt == 3 do
			giNoteArray[3*iCnt+2] = giNoteArray[3*iCnt]
			giNoteArray[3*iCnt] = iTemp[3*iCnt+2]
			iCnt += 1
		od	
	
	elseif iP == 2 then
	; 0 1 2 3 4 5 6 7 8 9 t e
	; 0 5 t 3 8 1 6 e 4 9 2 7
		iCnt = 0
		until iCnt == 12 do
			giNoteArray[iCnt] = iTemp[(5*iCnt)%12]
			iCnt += 1
		od				
	
	elseif iP == 3 then
	; 0 1 2 3 4 5 6 7 8 9 t e
	; 0 7 2 9 4 e 6 1 8 3 t 5
		iCnt = 0
		until iCnt == 12 do
			giNoteArray[iCnt] = iTemp[(7*iCnt)%12]
			iCnt += 1
		od
	
	elseif iP == 4 then
	; 0 1 2 3 4 5 6 7 8 9 t e
	; 2 0 1 5 3 4 8 6 7 e 9 t
		iCnt = 0
		until iCnt == 4 do
			giNoteArray[iCnt*3] = giNoteArray[iCnt*3+2]
			giNoteArray[iCnt*3+1] = iTemp[iCnt*3]
			giNoteArray[iCnt*3+2] = iTemp[iCnt*3+1]
			iCnt += 1
		od
	
	elseif iP == 5 then
	; 0 1 2 3 4 5 6 7 8 9 t e
	; 4 0 1 2 7 4 5 6 e 8 9 t
		iCnt = 0
		until iCnt == 3 do
			giNoteArray[iCnt*4] = giNoteArray[iCnt*4+3]
			giNoteArray[iCnt*4+1] = iTemp[iCnt*4]
			giNoteArray[iCnt*4+2] = iTemp[iCnt*4+1]
			giNoteArray[iCnt*4+3] = iTemp[iCnt*4+2]
			iCnt += 1
		od
	
	endif
	iLocalNoteArray[] = giNoteArray
	giNoteCount = 0
	iCnt = 0
	while iCnt < 12 do
	 ;	prints "%d ", iLocalNoteArray[iCnt]
		event_i "i", 1, iCnt*.01, .1, iLocalNoteArray[iCnt]
		iCnt += 1
	od
endin
;-------------------------------------------
; reset label colours
instr CallResetLabelColours
	resetLabelColours(0)
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
instr DoNorm	
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
	SMessage sprintf "pos(32, 456), text(\"%s\"), visible(1)", SOutputMessage
	chnset SMessage, "outputMessage"
	if metro(1)==1 then	
		kCount = kCount+1
	endif
	
	if kCount==p5 then;
		chnset "pos(32, -456) visible(0)", "outputMessage"
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
	iColProbs[] init 12
	iRowProbs[] init 12


	resetLabelColours(0); set all labels back to white
			
		
	iColProbs searchMatrix $COL
	iMax maxarray iColProbs
	print iMax
	until iCol==12 do
			if iMax==iColProbs[iCol] && giMax!=iMax then
				until iCnt==giSearchCount do
					until iRow==12 do
						;print iRow
						if giSearchArray[iCnt]==giDisplayMatrix[iRow][iCol] then
							SChannel sprintf "note_ident%d", iRow*12 + iCol + 1
							chnset "colour(255, 255, 0)", SChannel
						endif
						iRow += 1
					enduntil
					iCnt+=1
					iRow=0
				enduntil

			iCnt=0
			endif
	iCol += 1
	enduntil

	iRow init 0 
	iCnt init 0
	iCol init 0
	
	iRowProbs searchMatrix $ROW 
	iMax maxarray iRowProbs

	until iRow==12 do
			if iMax==iRowProbs[iRow] && giMax!=iMax then
				until iCnt==giSearchCount do
					until iCol==12 do
							;print iRow
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
	giMax = iMax		
endin
</CsInstruments>  
<CsScore>
i1000 0 1 
i1001 0 10000 
f0 z
</CsScore>
</CsoundSynthesizer> 