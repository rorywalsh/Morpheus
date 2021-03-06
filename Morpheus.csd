<Cabbage>
form size(780, 525), caption(""), pluginID("plu1"), colour("white")
    
image bounds(580, 16, 190, 445), colour(100, 100, 100)         
;image bounds(24, 528,  647, 95),  co lour(200,  200, 200)                 
;      
button bounds(536, 24, 151,  25), channel("matrixPanel"), text("Matrix"), identchannel("matrixPanel_ident"), colour:1("green"), radiogroup(99), value(1)
button bounds(536, 184, 151, 25), channel("operationsPanel"), text("Operations"), identchannel("operationsPanel_ident"), colour:1("green"), radiogroup(99)
button bounds(536, 208, 151, 25), channel("setTheoryPanel"), text("Set Theory"), identchannel("setTheoryPanel_ident"), colour:1("green"), radiogroup(99)
button bounds(536, 232, 151, 25), channel("midiPanel"), text("Sequencer"), identchannel("midiPanel_ident"), colour:1("green"), radiogroup(99)
button bounds(536, 248, 151, 25), channel("patternsPanel"), text("Patterns"), identchannel("patternsPanel_ident"), colour:1("green"), radiogroup(99) 

image bounds(603, 48, 141, 135), plant("matrixPlant"), identchannel("matrixPlant_ident") {                                          
	button bounds(5, 5, 64, 20), channel("resetRow"), text("Clear"), popuptext("Reset matrix back to blank state")
	button bounds(70, 5, 65, 20), channel("search"), text("Search", "Reset"), colour:1("green"), popuptext("Enable searching of matrix for a particular pattern")
	button bounds(15, 70, 110, 20), channel("rand"), text("Random"), popuptext("Fill matrix with random values")
	label bounds(0, 27, 141, 14), text("Spelling"), fontcolour(40, 40, 40), align("centre"), fontstyle("bold italic")
	image bounds(15, 42, 106, 2), colour(180, 180, 180)
	button bounds(10, 45, 30, 19), channel("sharpSpelling"), text("#"), popuptext("Spell with sharps"), radiogroup(101), value(1), colour:1("green")
	button bounds(40, 45, 30, 19), channel("flatSpelling"), text("b"), popuptext("Spell with flats"), radiogroup(101), colour:1("green")
	button bounds(70, 45, 30, 19), channel("10Spelling"), text("10"), popuptext("Spell with numbers"), radiogroup(101), colour:1("green")
	button bounds(100, 45, 30, 19), channel("tSpelling"), text("t"), popuptext("Spell with numbers, but use t for 10, and e for eleven"), radiogroup(101), colour:1("green")
	;combobox bounds(22, 50, 92, 24), channel("spellingCombo"), items("Sharps", "Flats", "10", "t"), value(3), popuptext("Change harmonic spelling of notes")
	button bounds(15, 91, 110, 19), channel("classicRows"), text("Show Presets", "Show Matrix"), value(0), popuptext("Shows a list of iconic rows used in various 12-tone compositions")
	filebutton bounds(15, 112, 110, 19), channel("saveRow"), text("Save Row"), mode("save"), popuptext("Save current row to presets")
	}

image bounds(539, 232, 141, 205) plant("operationsPlant"), identchannel("operationsPlant_ident") {     
	label bounds(0, 5, 141, 14) text("Permutations"), fontstyle("bold italic") fontcolour("black")
	image bounds(15, 20, 106, 2), colour(180, 180, 180)
	combobox bounds(22, 25, 92, 24), channel("permutationsCombo"), items("Select", "Original", "O x E", "O1 x O2", "Over 5", "Over 7","R[Tri]","R[Tetr]","R[Hex]")
	label bounds(0, 53, 141, 14), fontstyle("bold italic"), text("Modulation"), fontcolour("black")
	image bounds(15, 68, 106, 2), colour(180, 180, 180)
	combobox bounds(22, 73, 92, 24), channel("modulationsCombo"), items("Select", "Original", "M5", "M7", "M11"), popuptext("Transposes each note by a set interval")
	label bounds(0, 100, 141, 14), fontstyle("bold italic"), text("Rotation"), fontcolour("black")
	image bounds(15, 117, 106, 2), colour(180, 180, 180)
	button bounds(20, 121, 20, 20), channel("RotDec"), text("L"), popuptext("Rotate a row to the left")
	button bounds(40, 121, 20, 20), channel("RotInc"), text("R"), popuptext("Rotate a row to the right")
	button bounds(75, 121, 20, 20), channel("TransU"), text("+"), popuptext("Transpose Up")
	button bounds(95, 121, 20, 20), channel("TransD"), text("-"), popuptext("Transpose Down")
	checkbox bounds(15, 150, 110, 15), channel("RotMode"), fontcolour("black"), text("Stravinsky Rot."), value(0)
	button bounds(15, 170, 110, 20), channel("norm"), text("Normalise"), popuptext("Normalises matrix - sets first note in row to 0 and scales all other notes accordingly")
	}

image bounds(539, 268, 141, 160), plant("setTheoryPlant"), identchannel("setTheoryPlant_ident"){
	label bounds(0, 5, 141, 14), text("Interval Class"),  fontstyle("bold italic") fontcolour("black")
	image bounds(15, 19, 106, 2), colour(180, 180, 180)
	label bounds(5, 20, 130, 16), text("[0 0 0 0 0 0]"), fontcolour("black"), fontstyle("plain"), identchannel("intervalclass")
	label bounds(0, 40, 141, 14), text("Prime Form"),  fontstyle("bold italic") fontcolour("black")
	image bounds(15, 54, 106, 2), colour(180, 180, 180)
	label bounds(5, 60, 130, 12), text(" 1 2 3 4 5 6 7 8 9 10 11"), fontcolour("black"), fontstyle("plain"), identchannel("intervalclass")
	label bounds(0, 76, 141, 14), text("Normal Order"),  fontstyle("bold italic") fontcolour("black")
	image bounds(15, 91, 106, 2), colour(180, 180, 180)
	label bounds(5, 96, 130, 12), text(" 1 2 3 4 5 6 7 8 9 10 11"), fontcolour("black"), fontstyle("plain"), identchannel("intervalclass"
	label bounds(15, 115, 100, 14), align("left"), text("Forte Num."),  fontstyle("bold italic") fontcolour("black")	
	label bounds(90, 115, 20, 14), align("centre"), text("1"),  fontstyle("bold italic") fontcolour("white"), colour("black")	
	label bounds(15, 135, 110, 14), align("centre"), text("Description..."),    fontstyle("italic") fontcolour("black")	
}


image bounds(539, 435, 141, 30), plant("midiPlant"), identchannel("midiPlant_ident"){
	checkbox bounds(12, 5, 80, 20), channel("sequencerMode"), fontcolour("black"), text("Enable"), value(0)
	combobox bounds(80, 5, 50, 22), channel("octaveRange"), items("C1", "C2", "C3", "C4", "C5", "C6"), value(3)
}

image bounds(539, 435, 141, 30), plant("patternsPlant"), identchannel("patternsPlant_ident"){
	combobox bounds(28, 5, 100, 22), channel("patterns"), align("left"), items("Chessboard", "Lattice", "Dyads", "Thrichords", "Tetrachords", "Hexachords"), value(2)
}

;csoundoutput bounds(0, 500, 700, 200)
;plant to hold listbox for known rows. Easier to mane when it's a plant
image bounds(37, 23, 436, 316), colour(90, 90, 90), plant("listbox"), identchannel("listbox"), visible(0), {
	image bounds(0, 0, 436, 316), colour("black")
	listbox bounds(2, 2, 478, 262), channel("rowListbox"), populate("*.row"), value(-1), align("left"), highlightcolour(200, 200, 0), identchannel("listbox_ident")
}

;plant to hold array of labels for displaying our matrix.  
image bounds(37, 23, 508, 364), colour(90, 90, 90), plant("matrix"), identchannel("matrix"), visible(1), {
	label bounds(280, 30, 40, 28), widgetarray("note", 144), colour("white"), fontcolour("black"), text(""), corners(0), colour("black")
}  

;plant to hold array of widgets used to display search
groupbox bounds(40, 416, 504, 49), colour(160, 160, 160), fontcolour("black"), text("Search pattern"), plant("searchNotes"), visible(0), identchannel("searchNotesPlant"){
	label bounds(5,   45, 32, 20), text(""), fontcolour("black"), colour("white")  widgetarray("searchnote", 12)
}

;plant to hold array of widgets used to display inverse column names. 
image bounds(32, 7, 500, 15), colour("white"), plant("inverseLabelsPlant"), identchannel("inverseLabels_id"){
	label bounds(0, 0, 38, 15), text(""), fontstyle(0), fontcolour("black"), colour("white") widgetarray("inverseLabels", 12)
}

;plant to hold array of widgets used to display retro inverse column names. 
image bounds(32, 392, 500, 15), colour("white"), plant("retroInverseLabelsPlant"), identchannel("retroInverseLabels_id"){
	label bounds(0, 0, 38, 15), text(""), fontstyle(0), fontcolour("black"), colour("white") widgetarray("retroInverseLabels", 12)
}

;plant to hold array of widgets used to displayprime row names. 
image bounds(5, 28, 30, 400), colour("white"), plant("primeLabelsPlant"),  identchannel("primeLabels_id"){
	label bounds(0, 0, 30, 15), text(""), fontstyle(0), fontcolour("black"), colour("white") align("right"), widgetarray("primeLabels", 12)
}
 
;plant to hold array of widgets used to display retrograde row names. 
image bounds(546, 28, 24, 400), colour("white"), plant("retroLabelsPlant"), identchannel("retroLabels_id"){
	label bounds(0, 0, 30, 15), text(""), fontstyle(0),  fontcolour("black"), colour("white") align("left"), widgetarray("retroLabels", 12)
}
 

keyboard bounds(591, 370, 164, 69), scrollbars(0), keywidth(23.8)

;button bounds(27, 511, 60, 25), channel("but1"), text("Push", "Push")
</Cabbage> 
<CsoundSynthesizer>
<CsOptions>
-dm0 -n -+rtmidi=null -M0 -Q0 --midi-key=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 64
nchnls = 2
0dbfs=1
  
;Rory Walsh & Gleb Rogozinsky 2016  

#define COL #0#
#define ROW #1#

#define Prime #1#
#define Retrograde #2#
#define Inverse #3#
#define RetrogradeInverse #4#

giGEN02RowTable init 99
giGEN02SavedRowTable init 100

gkSequencerRow init -1
gSCSharp[] init 12
gSCFlat[] init 12
gSCPc[] init 12
gSCPct[] init 12
gSRowNames[] init 4
giProb init 0
giSpelling init 0
giSequencerCount init 0
giMax init -1
giMatrix[][] init 12,12 

gkLabels[] init 144
gkLabelsTemp[] init 144

gkSequencerRowColIndex init 0

gkPLabelsTemp[] init 12
gkPLabels[] init 12
gkRLabelsTemp[] init 12
gkRLabels[] init 12
gkRILabelsTemp[] init 12
gkRILabels[] init 12
gkILabelsTemp[] init 12
gkILabels[] init 12
gSFilename init ""
giDisplayMatrix[][] init 24, 24
giNoteCount init 0;
giNoteArray[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
giICArray[] init 12
giIC[] init 6
giSearchArray[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
giSearchCount init 0

;includes various utility UDOS
#include "MorpheusUDOs.csd"

massign 0, 100
;================================================
; gets triggered each time a note is pressed
;================================================
instr 100

if chnget:i("search")==1 then				;if instrument is in search mode

	iGoSearch isAlreadyThereSimple p4%12, giSearchArray
	if iGoSearch==0 then
		giSearchArray[giSearchCount] = p4%12
		SChannel sprintf "searchnote_ident%d", giSearchCount+1
		SMessage sprintf "text(\"%d\")", giSearchArray[giSearchCount]
		chnset SMessage, SChannel 
		
		giSearchCount = giSearchCount+1
 
		event_i "i", "SearchMatrixForRow", 0, 1
	endif
	
elseif chnget:i("sequencerMode")==1	then	;if instrument is in sequencer mode
		;proof of concept more than anything else...
		iOctave = chnget:i("octaveRange");
		
		;if a row has not been selected set it to the default row
		gkSequencerRow = gkSequencerRow==-1 ? 1 : gkSequencerRow
		
		if i(gkSequencerRow)==$Prime  then
			iNote = giDisplayMatrix[i(gkSequencerRowColIndex)][giSequencerCount%12]+((iOctave+3)*12)
			noteondur 1, iNote, 100, 1000
		 	giSequencerCount+=1
		elseif i(gkSequencerRow)==$Retrograde  then
			iNote = giDisplayMatrix[i(gkSequencerRowColIndex)][giSequencerCount%12]+((iOctave+3)*12)
			noteondur 1, iNote, 100, 1000
			giSequencerCount-=1
		elseif i(gkSequencerRow)==$Inverse  then
			iNote = giDisplayMatrix[giSequencerCount%12][i(gkSequencerRowColIndex)]+((iOctave+3)*12)
			noteondur 1, iNote, 100, 1000
		 	giSequencerCount+=1
		elseif i(gkSequencerRow)==$RetrogradeInverse  then
			iNote = giDisplayMatrix[giSequencerCount%12][i(gkSequencerRowColIndex)]+((iOctave+3)*12)
			noteondur 1, iNote, 100, 1000
			giSequencerCount-=1
		endif
else										;if instrument is in normal mode

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
		normalOrder()
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
		S1 sprintfk "pos(%d, %d) colour(%d, %d, %d)", iCnt%12*42+2, iCntRows*30+2, iGrayScale, iGrayScale, iGrayScale
		S2 sprintfk "note_ident%d", iCnt+1 
		chnset S1, S2
		S3 sprintfk "note%d", iCnt+1
		chnset 0, S3
		gkLabels[iCnt]=0
		iCnt=iCnt+1
		iCntRows = (iCnt%12==0 ? iCntRows+1 : iCntRows)
	enduntil

	iCnt = 0
	until iCnt == 12 do
		gkPLabelsTemp[iCnt] = 0
		gkPLabels[iCnt] = 0
		gkRLabelsTemp[iCnt] = 0
		gkRLabels[iCnt] = 0
		gkRILabelsTemp[iCnt] = 0
		gkRILabels[iCnt] = 0
		gkILabelsTemp[iCnt] = 0
		gkILabels[iCnt] = 0
	iCnt+=1
	enduntil
		
	iCnt = 0
	until iCnt ==12 do
		S1 sprintfk "pos(%d, 25)", iCnt*41+10
		S2 sprintfk "searchnote_ident%d", iCnt+1
		chnset S1, S2
		iCnt=iCnt+1
	enduntil		
	
	iCnt = 0
	until iCnt ==12 do
		S1 sprintfk "pos(%d, 0)", iCnt*42+6
		S2 sprintfk "inverseLabels_ident%d", iCnt+1
		chnset S1, S2
		iCnt=iCnt+1
	enduntil
			
	iCnt = 0
	until iCnt ==12 do
		S1 sprintfk "pos(%d, 0)", iCnt*42+6
		S2 sprintfk "retroInverseLabels_ident%d", iCnt+1		
		chnset S1, S2
		iCnt=iCnt+1
	enduntil
				
	iCnt = 0
	until iCnt ==12 do
		S1 sprintfk "pos(0, %d)", iCnt*30+2
		S2 sprintfk "primeLabels_ident%d", iCnt+1		
		chnset S1, S2
		iCnt=iCnt+1
	enduntil			
				 
	iCnt = 0
	until iCnt ==12 do
		S1 sprintfk "pos(1, %d)", iCnt*30+2
		S2 sprintfk "retroLabels_ident%d", iCnt+1		
		chnset S1, S2
		iCnt=iCnt+1
	enduntil				
	
	initialiseStringArrays()			
endin

;-------------------------------------------
;check for changes to GUI
instr 1001

	kNoteCount = giNoteCount; 	cast to kRate for checking later...

	kTrig changed chnget:k("matrixPanel"), chnget:k("setTheoryPanel"), chnget:k("operationsPanel"), chnget:k("midiPanel")
	if kTrig==1 then
		if chnget:k("operationsPanel")==1 then				;when panel 2 is enabled
			chnset "visible(0)", "matrixPlant_ident"
			chnset "pos(603, 75), visible(1)", "operationsPlant_ident"
			chnset "visible(0)", "setTheoryPlant_ident"
			chnset "pos(600, 50)", "operationsPanel_ident"
			chnset "pos(600, 281)", "setTheoryPanel_ident"
			chnset "pos(600, 306)", "midiPanel_ident"
			chnset "pos(600, 331)", "patternsPanel_ident"
			chnset "visible(0)", "midiPlant_ident"
			chnset "visible(0)", "patternsPlant_ident"
			
			
		elseif chnget:k("setTheoryPanel")==1 then				;when panel 3 is enabled
			
			chnset "pos(600, 50)", "operationsPanel_ident"
			chnset "pos(600, 24)", "MatrixPanel_ident"
			chnset "pos(600, 76)", "setTheoryPanel_ident"
			chnset "pos(600, 262)", "midiPanel_ident"
			chnset "pos(600, 288)", "patternsPanel_ident"
			chnset "visible(0)", "operationsPlant_ident"
			chnset "visible(0)", "operationsPlant_ident"
			chnset "visible(0)", "matrixPlant_ident"
			chnset "pos(603, 101), visible(1)", "setTheoryPlant_ident"
			chnset "visible(0)", "midiPlant_ident"
			chnset "visible(0)", "patternsPlant_ident"

		elseif chnget:k("midiPanel")==1 then				;when panel 3 is enabled
			
			chnset "pos(600, 50)", "operationsPanel_ident"
			chnset "pos(600, 24)", "MatrixPanel_ident"
			chnset "pos(600, 76)", "setTheoryPanel_ident"
			chnset "pos(600, 102)", "midiPanel_ident"
			chnset "pos(600, 160)", "patternsPanel_ident"
			
			chnset "visible(0)", "operationsPlant_ident"
			chnset "visible(0)", "setTheoryPlant_ident"
			chnset "visible(0)", "matrixPlant_ident"
			chnset "visible(0)", "setTheoryPlant_ident"
			chnset "pos(603, 128), visible(1)", "midiPlant_ident"
			chnset "visible(0)", "patternsPlant_ident"

		elseif chnget:k("patternsPanel")==1 then				;when panel 3 is enabled
			
			chnset "pos(600, 50)", "operationsPanel_ident"
			chnset "pos(600, 24)", "MatrixPanel_ident"
			chnset "pos(600, 76)", "setTheoryPanel_ident"
			chnset "pos(600, 102)", "midiPanel_ident"
			chnset "pos(600, 128)", "patternsPanel_ident"
			
			chnset "visible(0)", "operationsPlant_ident"
			chnset "visible(0)", "setTheoryPlant_ident"
			chnset "visible(0)", "matrixPlant_ident"
			chnset "visible(0)", "setTheoryPlant_ident"
			chnset "visible(0)", "midiPlant_ident"
			chnset "pos(603, 154), visible(1)", "patternsPlant_ident"
						
		elseif chnget:k("matrixPanel")==1 then					;when panel 1 is enabled
			chnset "pos(600, 24), visible(1)", "matrixPanel_ident"
			chnset "pos(600, 184)", "operationsPanel_ident"
			chnset "pos(600, 208)", "setTheoryPanel_ident"
			chnset "pos(600, 232)", "midiPanel_ident"
			chnset "pos(600, 254)", "patternsPanel_ident"
			chnset "visible(0)", "setTheoryPlant_ident"
			chnset "visible(0)", "operationsPlant_ident"
			chnset "visible(1)", "matrixPlant_ident"
			chnset "visible(0)", "midiPlant_ident"	
			chnset "visible(0)", "patternsPlant_ident"
		endif

;button bounds(536, 24, 151, 25), channel("matrixPanel"), text("Matrix"), identchannel("matrixPanel_ident"), colour:1(70, 70, 70), radiogroup(99), value(1)
;button bounds(536, 184, 151, 25), channel("operationsPanel"), text("Operations"), identchannel("operationsPanel_ident"), colour:1(70, 70, 70), radiogroup(99)
;button bounds(536, 208, 151, 25), channel("setTheoryPanel"), text("Set Theory"), identchannel("setTheoryPanel_ident"), colour:1(70, 70, 70), radiogroup(99)
;button bounds(536, 232, 151, 25), channel("midiPanel"), text("Sequencer"), identchannel("sequencerPanel_ident"), colour:1(70, 70, 70), radiogroup(99)
						
	endif	
		
			
	if changed:k(chnget:k("rand"))==1 then
		if kNoteCount == 12 then	
			;	scoreline {{i"DisplayNotice"  0  100  "The row is completed. Try delete some cells or reset" 5}}, 1
			event "i", "ResetAll", 0, 1, 0
			event "i", "RandRow", 0, 1
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

	;kReSpellNotes changed chnget:k("spellingCombo")
	kReSpellNotes changed chnget:k("sharpSpelling"), chnget:k("10Spelling"), chnget:k("flatSpelling"), chnget:k("tSpelling")
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
		event "i", "LoadPresetFile", 0, 1
		event "i", "ShowMatrix", 0, 1
	endif
	
	if changed:k(chnget:k("RotInc"))==1 then
		event "i", "RotationRight", 0, 1, chnget:k("RotMode") 
	endif
	
	if changed:k(chnget:k("RotDec"))==1 then
		event "i", "RotationLeft", 0, 1, chnget:k("RotMode") 
	endif
	
	if changed:k(chnget:k("TransU"))==1 then
		event "i", "Transposition", 0, 1, 1 
	endif
	
	if changed:k(chnget:k("TransD"))==1 then
		event "i", "Transposition", 0, 1, -1 
	endif

	if changed:k(chnget:k("patterns"))==1 then
		;event "i", "ChangePattern", 0, 1, -1 
	endif

	gSFilename chnget "saveRow"
	kTrig changed gSFilename
	if kTrig==1 then
		event "i", "SavePresetFile", 0, 1
	endif	
endin

;-----------------------------------------
; change pattern
instr ChangePattern
resetLabelColours(0)
endin
;----------------------------------------
;save and load presets...
instr SavePresetFile
SFullFileName sprintf "%s", gSFilename

copya2ftab giNoteArray, giGEN02SavedRowTable
ftsave SFullFileName, 1, giGEN02SavedRowTable
chnset "refresfiles()", "listbox_ident"
endin

instr LoadPresetFile
	a1 init 1
	iCnt init 0
	SFilenames[] directory ".", ".row"
	iNumberOfFiles lenarray SFilenames
	printf_i "Filename = %s \n", 1, SFilenames[chnget:i("rowListbox")-1]
	ftload SFilenames[chnget:i("rowListbox")-1], 1, giGEN02RowTable
	
	
	until iCnt==12 do
		giNoteArray[iCnt] tab_i iCnt, giGEN02RowTable
	;rint giNoteArray[iCnt]
		iCnt = iCnt+1
	od
	
	giNoteCount = 12
	updateMatrix(giNoteArray)
endin
;----------------------------------------
;rotation instruments...
instr RotationRight
	iCnt init giNoteCount-1
	iCntV init 0
	iCntH init 0
	iTemp = giNoteArray[iCnt]
	iSt init 0
	
	if p4 == 1 then
		iSt = giNoteArray[0]
	endif
	
	until iCnt == 0 do
		giNoteArray[iCnt] = giNoteArray[iCnt-1]
		iCnt -= 1
	od
	giNoteArray[0] = iTemp
	
	if p4 == 1 then
		iDif = iTemp - iSt
		iCnt = 0
		until iCnt == giNoteCount do
			iTemp = giNoteArray[iCnt] - iDif
			iTemp wrap iTemp,0,12
			giNoteArray[iCnt] = iTemp
			iCnt += 1
		od	
	endif	
	
	updateMatrix(giNoteArray)

endin

instr RotationLeft
	iCnt init 0
	iTemp = giNoteArray[0]
	
	until iCnt == giNoteCount-1 do
		giNoteArray[iCnt] = giNoteArray[iCnt+1]
		iCnt += 1
	od
	giNoteArray[iCnt] = iTemp
	
	if p4 == 1 then
		iDif = giNoteArray[0] - iTemp
		iCnt = 0
		until iCnt == giNoteCount do
			iTemp = giNoteArray[iCnt] - iDif
			iTemp wrap iTemp,0,12
			giNoteArray[iCnt] = iTemp
			iCnt += 1
		od	
	endif
	
	updateMatrix(giNoteArray)
endin

instr Transposition
	iCnt init 0
	iTemp init 0
	
	until iCnt == giNoteCount do
		iTemp = giNoteArray[iCnt]+p4
		iTemp wrap iTemp,0,12
		giNoteArray[iCnt] = iTemp
		iCnt += 1
	od

	updateMatrix(giNoteArray)
endin
;----------------------------------------
;check for clicks on labels...
instr 1002 
	if metro(2)==1 then
		kIndex = 0
		until kIndex==144 do
		    gkLabels[kIndex] chnget sprintfk("note%d", kIndex+1)
		    if gkLabels[kIndex] != gkLabelsTemp[kIndex] then
		    	printks "%d %d\n", .1, int(kIndex/12), kIndex%12
				event "i", "ColourRowAndColumn", 0, .1, int(kIndex/12), kIndex%12
		    endif
			gkLabelsTemp[kIndex] = gkLabels[kIndex]
		    kIndex = kIndex+1
		enduntil  
		
		kIndex = 0 	
		until kIndex==12 do
			gkPLabels[kIndex] chnget sprintfk("primeLabels%d", kIndex+1)
			if gkPLabels[kIndex] != gkPLabelsTemp[kIndex] then
				printks sprintfk("primeLabels%d", kIndex+1), 0
				event "i", "ColourRow", 0, .1, kIndex, 0
				giSequencerCount = 0
				gkSequencerRow = $Prime
				gkSequencerRowColIndex = kIndex
			endif
			gkPLabelsTemp[kIndex] = gkPLabels[kIndex]
			kIndex+=1
		enduntil

		kIndex = 0 	
		until kIndex==12 do
			gkRLabels[kIndex] chnget sprintfk("retroLabels%d", kIndex+1)
			if gkRLabels[kIndex] != gkRLabelsTemp[kIndex] then
				printks sprintfk("retroLabels%d", kIndex+1), 0
				event "i", "ColourRow", 0, .1, kIndex, 1
				giSequencerCount = 11
				gkSequencerRow = $Retrograde
				gkSequencerRowColIndex = kIndex
			endif
			gkRLabelsTemp[kIndex] = gkRLabels[kIndex]
			kIndex+=1
		enduntil
		
		kIndex = 0 	
		until kIndex==12 do
			gkILabels[kIndex] chnget sprintfk("inverseLabels%d", kIndex+1)
			if gkILabels[kIndex] != gkILabelsTemp[kIndex] then
				printks sprintfk("inverseLabels%d", kIndex+1), 0
				event "i", "ColourColumn", 0, .1, kIndex, 0
				giSequencerCount = 0
				gkSequencerRow = $Inverse
				gkSequencerRowColIndex = kIndex
			endif
			gkILabelsTemp[kIndex] = gkILabels[kIndex]
			kIndex+=1
		enduntil 
 
		kIndex = 0 	
		until kIndex==12 do
			gkRILabels[kIndex] chnget sprintfk("retroInverseLabels%d", kIndex+1)
			if gkRILabels[kIndex] != gkRILabelsTemp[kIndex] then
				printks sprintfk("retroInverseLabels%d", kIndex+1), 0
				event "i", "ColourColumn", 0, .1, kIndex, 1
				giSequencerCount = 11
				gkSequencerRow = $RetrogradeInverse
				gkSequencerRowColIndex = kIndex
			endif
			gkRILabelsTemp[kIndex] = gkRILabels[kIndex]
			kIndex+=1
		enduntil			 
	endif
endin
;-------------------------------------------
; Colour rows and columns in one go
instr ColourRowAndColumn
	resetLabelColours(0)
	colourRow $ROW, p4, 255, 255, 0
	colourRow $COL, p5, 255, 255, 0
endin
;-------------------------------------------
; colour a row
instr ColourRow
	resetLabelColours(0)
	colourRow $ROW, p4, 255, 255, 0, 1, p5
endin
;-------------------------------------------
; colour a column
instr ColourColumn 
	resetLabelColours(0) 
	colourRow $COL, p4, 255, 255, 0, 1, p5
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
	giNoteCountOld=0
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

	; Fisher and Yeates' Algorithm
	iCnt = iCnt_
	until iCnt == 0 do
		iGen random 0, iCnt
		iGen = int(iGen)
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
	giNoteCount = 12
	updateMatrix(giNoteArray)
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
	
	elseif iP == 6 then
	; 0 1 2 3 4 5 6 7 8 9 t e
	; 5 0 1 2 3 4 e 6 7 8 9 t
		iCnt = 0
		until iCnt == 2 do
			giNoteArray[iCnt*6] = giNoteArray[iCnt*6+5]
			giNoteArray[iCnt*6+1] = iTemp[iCnt*6]
			giNoteArray[iCnt*6+2] = iTemp[iCnt*6+1]
			giNoteArray[iCnt*6+3] = iTemp[iCnt*6+2]
			giNoteArray[iCnt*6+2] = iTemp[iCnt*6+1]
			giNoteArray[iCnt*6+3] = iTemp[iCnt*6+2]
			iCnt += 1
		od
	
	
	endif
	updateMatrix(giNoteArray)
endin
;-------------------------------------------
; reset label colours
instr CallResetLabelColours
	resetLabelColours(0)
endin

;-------------------------------------------
; Multiplication 27.02.16
instr DoMatrixMultiplication	
	iCnt init 0
	iM = getMX:i()
	
	until iCnt == giNoteCount do
		iTemp = giNoteArray[iCnt] * iM
		iTemp wrap iTemp,0,12
		giNoteArray[iCnt] = iTemp
		iCnt += 1
	od			
	updateMatrix(giNoteArray)
endin

;-------------------------------------------
; Normalization 27.02.16
instr DoNorm	
	iCnt init 0
	iZero = giNoteArray[0]
	until iCnt == giNoteCount do
		iTemp = giNoteArray[iCnt] - iZero
		iTemp wrap iTemp,0,12
		giNoteArray[iCnt] = iTemp
		iCnt += 1
	od			
	updateMatrix(giNoteArray)
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

f99 0 12 -2 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
f100 0 12 -2 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1

i1000 0 1 
i1001 0 10000   
i1002 0 10000
f0 z
</CsScore>
</CsoundSynthesizer> 