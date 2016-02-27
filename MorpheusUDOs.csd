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

	until iCnt == giNoteCount do
		if giNoteArray[iCnt]==iNote then
		 	iPresent = 1
		endif
		iCnt = iCnt+1
	od
	if (iPresent == 0)then
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
		if chnget:i("spellingCombo")==1 then
		iSpelling = 0
		elseif chnget:i("spellingCombo")==2 then
		iSpelling = 1
		elseif chnget:i("spellingCombo")==3 then
		iSpelling = 2
		elseif chnget:i("spellingCombo")==4 then
		iSpelling = 3
		endif
	xout iSpelling		
endop

opcode getMX, i, j
	iDummyIn xin
	;tdo, add reset to original here....
		if chnget:i("modulationsCombo")==3 then
		iMX = 5
		elseif chnget:i("modulationsCombo")==4 then
		iMX = 7
		elseif chnget:i("modulationsCombo")==5 then
		iMX = 11
		endif
	xout iMX		
endop

opcode getPX, i, j
	iDummyIn xin
	;tdo, add reset to original here....
		if chnget:i("permutationsCombo")==3 then
		iPX = 0
		elseif chnget:i("permutationsCombo")==4 then
		iPX = 1
		elseif chnget:i("permutationsCombo")==5 then
		iPX = 2
		elseif chnget:i("permutationsCombo")==6 then
		iPX = 3
		elseif chnget:i("permutationsCombo")==7 then
		iPX = 4
		elseif chnget:i("permutationsCombo")==8 then
		iPX = 5
		endif
	xout iPX		
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

endop

;--------------------------------------------------------------------
; opcode to update visual matrix after some changes have been made
;--------------------------------------------------------------------
opcode updateMatrix, 0, i[]
iArray[] xin
iLocalNoteArray[] = iArray
	giNoteCount = 0
	iCnt init 0
	while iCnt < 12 do
		prints "%d ", iLocalNoteArray[iCnt]
		event_i "i", 100, iCnt*.01, .1, iLocalNoteArray[iCnt]
		iCnt += 1
	od
endop

;---------------------------------------
; opcode to colour a row or column
;------------------------------------
opcode colourRow, 0, iiiiioo
	iType, iIndex, iR, iG, iB, iFade, iDir xin
	iCnt init 0
	iRow init 0


	if iType==0 then ;rows
		until iCnt==12 do
			iFade = iFade==0 ? 0 : (iDir==0 ? 255*((iCnt+1)/12) : 255-(250*((iCnt+1)/12)))
			SChannel sprintf "note_ident%d", iCnt*12+iIndex+1
			SColour sprintf "colour(%d,%d,%d)", iR, iG, iFade
			chnset SColour, SChannel
			iCnt += 1 				
		enduntil 
	else 			;columns
		until iCnt==12 do
			iFade = iFade==0 ? 0 : (iDir==0 ? 255*((iCnt+1)/12) : 255-(250*((iCnt+1)/12)))
			SChannel sprintf "note_ident%d", (iIndex*12)+iCnt+1
			SColour sprintf "colour(%d,%d,%d)", iR, iG, iFade
			chnset SColour, SChannel
			iCnt += 1 				
		enduntil 	
	endif
endop

;---------------------------------------
; reset array
;------------------------------------
opcode resetArray, 0, i[]ii
	iArray[], iSize, iValue xin
	iCnt init 0
	until iCnt==iSize do
		iArray[iCnt] = iValue
		iCnt =+1
	enduntil

endop

;---------------------------------------
; opcode to colour all labels blacks
;------------------------------------
opcode resetLabelColours, 0, i
	iResetText xin
	iCnt init 0
	iCntRows init 0

	until iCnt > 144 do
		if iCntRows%2==1 then
			iGrayScale = 200
		else	
			iGrayScale = (iCnt%2==0 ? 255 : 220)
		endif
		
		if iResetText==1 then
			S1 sprintfk "colour(%d, %d, %d), text(\"\")", iGrayScale, iGrayScale, iGrayScale
		else
			S1 sprintfk "colour(%d, %d, %d)", iGrayScale, iGrayScale, iGrayScale
		endif
		
		S2 sprintfk "note_ident%d", iCnt+1
		chnset S1, S2
		iCnt=iCnt+1
		iCntRows = (iCnt%12==0 ? iCntRows+1 : iCntRows)
	enduntil
endop

;---------------------------------------
; opcode to search through matrix and find matches
; 
; I'd love to see someone try another way of doing this, there 
; has to be an easier way! Rory.
;
opcode searchMatrix, i[], i
iType xin
iFound init 0
iCntRow init 0
iCntCol init 0
iCnt init 0
iSubCnt init 0
iMatches init 0
iMostLikelyRow init -1
iFoundPattern = 0 
iProbTable[] fillarray -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 
iTotalNumberOfSearches init 0
iNumberOfHorizontalSearches init 0
iNumberOfVerticalSearches init 0

if iType==$ROW then
iRIGHT = 0
iLEFT = 1
	until iNumberOfHorizontalSearches==2 do 
			until iCntRow==12 do
				iCnt=0
				iCntCol=0
				iSubCnt=0
				iMatches=0
				until iCnt>=giSearchCount do
					until iCntCol==12 do
					iColCnt2 = iNumberOfHorizontalSearches==iLEFT ? 23-iCntCol : iCntCol
					if giDisplayMatrix[iCntRow][iColCnt2]==giSearchArray[iCnt] then
					;found a match, now check subsequent indices
						until iCnt==giSearchCount do
						iCntCol3 = iNumberOfHorizontalSearches==iLEFT ? 23-(iCntCol+iSubCnt) : iCntCol+iSubCnt
							if giDisplayMatrix[iCntRow][iCntCol3]==giSearchArray[iCnt] then
								SString sprintf "Found on Row %d index %d\n", iCntRow, iCntCol+iSubCnt
								prints SString
								iSubCnt +=1
								if iMatches<iSubCnt then
								 	iMatches = iSubCnt
								 	iMostLikelyRow = iCntRow
									iProbTable[iCntRow] = iProbTable[iCntRow]+1
		;							print iCntRow, iProbTable[iCntRow]
								endif
								iFoundPattern = 1
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
	iNumberOfHorizontalSearches +=1
	iCntRow = 0
	iCnt=0
	iCntCol=0
	iSubCnt=0
	iMatches=0
	enduntil

else

iDOWN = 0 
iUP = 1
	
	until iNumberOfVerticalSearches==2 do
		until iCntCol==12 do
			iCnt=0
			iCntRow=0
			iSubCnt=0
			iMatches=0
			until iCnt>=giSearchCount do
				until iCntRow==12 do
					iCntRow2 = iNumberOfVerticalSearches==iDOWN ? iCntRow : 23-iCntRow
					if giDisplayMatrix[iCntRow2][iCntCol]==giSearchArray[iCnt] then
					;found a match, now check subsequent indices
						until iCnt==giSearchCount do
						iCntRow3 = iNumberOfVerticalSearches==iDOWN ? iCntRow+iSubCnt : 23-(iCntRow+iSubCnt)
							if giDisplayMatrix[iCntRow3][iCntCol]==giSearchArray[iCnt] then
								;SString sprintf "Found on Row %d index %d\n", iCntRow+iSubCnt, iCntCol
								;prints SString
								iSubCnt +=1
								if iMatches<iSubCnt then
								 	iMatches = iSubCnt
								 	iMostLikelyRow = iCntRow
									iProbTable[iCntCol] = iProbTable[iCntCol]+1
		;							print iCntRow, iProbTable[iCntRow]
								endif
								iFoundPattern = 1
								iCnt+=1
							else
							iCnt=giSearchCount
							endif						
						enduntil
					endif
				iCntRow += 1
				enduntil
			iCnt +=1
			enduntil
		iCntCol += 1
		enduntil

	iNumberOfVerticalSearches +=1
	iCntRow = 0
	iCnt=0
	iCntCol=0
	iSubCnt=0
	iMatches=0
	enduntil

endif

xout iProbTable
endop

opcode nameRowsAndColumns, 0, iii
	iP, iI, iIndex xin
	SChannel sprintf "primeLabels_ident%d", iIndex
	SMessage sprintf "text(\"P%d\")", iP
	chnset SMessage, SChannel	
	SChannel sprintf "inverseLabels_ident%d", iIndex
	SMessage sprintf "text(\"I%d\")", iI
	chnset SMessage, SChannel		
	SChannel sprintf "retroInverseLabels_ident%d", iIndex
	SMessage sprintf "text(\"RI%d\")", iI
	chnset SMessage, SChannel			
	SChannel sprintf "retroLabels_ident%d", iIndex
	SMessage sprintf "text(\"R%d\")", iP
	chnset SMessage, SChannel	
endop			

opcode normalOrder,0,0
 	iTemp[] init 12
 	iTemp_Out[] init giNoteCount
 	iCnt init 0
 	iCnt_ init 0
 iRot init 0
 	iNum init 0
 	
 	until iNum == 12 do
 		iCnt = 0
 		until iCnt == giNoteCount do
 			if giNoteArray[iCnt] == iNum then
 				iTemp[iCnt_] = giNoteArray[iCnt]
 				iCnt_ += 1
 			endif
 			iCnt += 1
 		od
 		iNum += 1

 	od
 
 	iDis = iTemp[giNoteCount-1] - iTemp[0]
 
 	
 	iCnt = 1
 	until iCnt == giNoteCount do
 		iDis_t = iTemp[iCnt-1] + 12 - iTemp[iCnt] 
 		if iDis_t < iDis then
 			iDis = iDis_t
 			iRot = iCnt
 	;	print iRot
 		endif
 		iCnt += 1
 	od
 	
 	iCnt = 0
 	until iCnt == giNoteCount do
 		iTemp_Out[iCnt] = iTemp[(iCnt+iRot)%giNoteCount]
  		iCnt += 1
 	od
 
 	iCnt = 0
 	iTemp_ = iTemp_Out[0]
 	until iCnt == giNoteCount do
	 	iTemp_Out[iCnt] = iTemp_Out[iCnt] - iTemp_
  		iCnt += 1
 	od
 
 	iCnt = 0
 	until iCnt == giNoteCount do
 		if iTemp_Out[iCnt] < 0 then
 			iTemp_Out[iCnt] = 12 + iTemp_Out[iCnt] 
 		endif
  		iCnt += 1
 	od
 	 prints "%d %d %d %d %d\n", iTemp_Out[0], iTemp_Out[1], iTemp_Out[2], iTemp_Out[3], iTemp_Out[4]
	 
endop

opcode initialiseStringArrays, 0, 0
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

	gSRowNames[0] = "primeLabels"
	gSRowNames[1] = "inverseLabels"
	gSRowNames[2] = "retroLabels"
	gSRowNames[3] = "retroInverseLabels"
endop