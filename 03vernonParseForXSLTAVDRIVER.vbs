'------------------------------------------------------
'------------------------------------------------------
'--Merge Vernon Object & AV Files
'------------------------------------------------------
'--Date: 		Nov 2011
'--Author:      Scott Renton
'--Purpose:     Two files are exported from Vernon, one
'--				for objects and one for photo/AV. This instance
'--				is for a database where there are many
'--				images per object, and it is acceptable
'--				to import the same object metadata for
'--				different images.
'--------------------------------------------------------
'--------------------------------------------------------


Option Explicit

'Declare obj variables
Dim objFSO
Dim objInFile1
Dim objInFile2
Dim objInFile3
Dim objInFile4
Dim objLogFile
Dim objOutFile
Dim objCounter

'Declare str variables
Dim strDirectory
Dim strInFile1
Dim strEndNode
Dim strPhoto
Dim strEndNodeInner
Dim strRef
Dim strInFile2
Dim strReadLine1
Dim strReadLine3
Dim strOutFile
Dim strLog
Dim strAccessionNo
Dim strReadLineNext
Dim strLine
Dim strDocPos
Dim strDoc
Dim strSubject
Dim strFirst
Dim strFormat
Dim strObjNo
Dim strDocumentation
Dim strDocumentationVolPage
Dim strDocumentationPerson
Dim strDocumentationNotes
Dim strReproID
Dim strDates
Dim strDatesEnd
Dim strPerson
Dim strPersonName
Dim strPersonNameEnd
Dim strPersonEnd
Dim strNationality
Dim strNationalityEnd
Dim strRole
Dim strRoleEnd
Dim strAvPerson
Dim strAvRole
Dim strSummaryCreator
Dim strSummaryCreatorEnd
Dim strCroppedTiff
Dim strDerivativeTiff
Dim strDerivativeJpeg
Dim strSecondaryCreator
Dim strSecondaryCreatorEnd
Dim strSecondaryDates
Dim strSecondaryDatesEnd
Dim strSecondaryNationality
Dim strSecondaryNationalityEnd
Dim strDocumentationItem
Dim strDocumentationItemEnd
Dim strDocumentationItemVolPage
Dim strDocumentationItemPerson
Dim strDocumentationItemArticle
Dim strDocumentationItemNotes
Dim strDocumentationItemPublishDate
Dim strActiveDates
Dim strActiveDatesEnd
Dim strCTPoint
Dim strDTPoint
Dim strSecondaryRole
Dim strSecondaryRoleEnd
Dim strExternalFile
Dim strFormatItem
Dim strFormatItemEnd

' Declare int variables
Dim intGtPos
Dim intLtPos
Dim intEqualPoint
Dim intRowNo
Dim intPointPoint
Dim intPointPos

Dim a
Dim i

'Initialisation and constant definition
strDirectory = "K:\dld\MIMS Project\Development\MIMSWorkflow\"
strInFile1 = "\ObjectOut.xml"
strInFile2 = "\AVOut.xml"
strOutFile = "\vernonParsed.xml"
strLog = "\Log.txt"
strFormatItem  = "<user_sym_6>"
strFormatItemEnd  = "</user_sym_6>"
strPerson = "prod_pri_person "
strPersonName = "user_sym_16 "
strNationality = "prod_pri_person_nationality "
strDates = "prod_pri_person_lifeyears "
strDatesEnd = "prod_pri_person_lifeyears>"
strRole = "prod_pri_role "
strPersonEnd = "prod_pri_person>"
strPersonNameEnd = "user_sym_16>"
strSummaryCreator = "user_sym_33"
strSummaryCreatorend = "user_sym_33>"
strSecondaryCreator = "user_sym_35"
strSecondaryCreatorEnd = "user_sym_35>"
strSecondaryDates = "prod_det_person_lifeyears"
strSecondaryDatesend = "prod_det_person_lifeyears>"
strSecondaryNationality = "prod_det__person_nationality"
strSecondaryNationalityend = "prod_det__person_nationality>"
strSecondaryRole = "prod_det_role"
strSecondaryRoleEnd = "prod_det_role>"
strNationalityEnd = "prod_pri_person_nationality>"
strRoleEnd = "prod_pri_role>"
strAvPerson = "prod_person"
strAvRole = "prod_role"
strDocumentationItem = "do_sym_document_title"
strDocumentationItemEnd = "do_sym_document_title>"
strActiveDates = "user_sym_24"
strActiveDatesend = "user_sym_24>"
strDocumentationItemVolPage = "documentation_vol_page"
strDocumentationItemPerson ="user_sym_30"
strDocumentationItemArticle ="documentation_article"
strDocumentationItemPublishDate ="do_sym_document_publish_date"
strDocumentationItemNotes ="documentation_notes"
strCroppedTiff = "Cropped Tiff"
strDerivativeJpeg = "Derivative JPEG"
strDerivativeTiff = "Derivative TIFF"
strCTPoint = "c.t"
strDTPoint = "d.t"
strExternalFile = "<user_sym_10"
objCounter = 0
i = 0
a = ""

' Create the File System Object
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objLogFile = objFSO.CreateTextFile(strDirectory & strLog)
Set objOutFile = objFSO.CreateTextFile(strDirectory & strOutFile)
Set objInFile1 = objFSO.OpenTextFile(strDirectory & strInFile1)
Set objInFile2 = objFSO.OpenTextFile(strDirectory & strInFile2)
Set objInFile3 = objFSO.OpenTextFile(strDirectory & strInFile1)
Set objInFile4 = objFSO.OpenTextFile(strDirectory & strInFile2)

objLogFile.writeLine("Opened XML FIle")


'Loop round AV file
Do While Not objInFile2.AtEndOfStream
	'read each line
	strReadLineNext = objInFile2.ReadLine
	objLogFile.writeLine(strReadLineNext)
	'In order to keep AV Person and Role together (ie so Role describes Person), we assign specific fields for XSLT
	If InStr(strReadLineNext, strAvPerson) Then
		intEqualPoint = InStr(strReadLineNext,"=")
		intRowNo = Mid(strReadLineNext, intEqualPoint + 2, 1)
		strReadLineNext = Replace(strReadLineNext, strAvPerson, "avperson" & intRowNo & " ")
		strReadLineNext = Replace(strReadLineNext, " >", ">")
	End If

	If InStr(strReadLineNext, strAvRole) Then
		intEqualPoint = InStr(strReadLineNext,"=")
		intRowNo = Mid(strReadLineNext, intEqualPoint + 2, 1)
		strReadLineNext = Replace(strReadLineNext, strAvRole, "avrole" & intRowNo & " ")
		strReadLineNext = Replace(strReadLineNext, " >", ">")
	End If

	'ignore spaces
	If strReadLineNext = "" Then
		objLogFile.writeLine("space")
	Else
		'write closing tag
		objOutFile.writeLine(strReadLineNext)

		'Establish ReproID for downstream linking
		If InStr(strReadLineNext,"<im_ref") Then
			intGtPos = InStr(strReadLineNext, ">")
			strReproID = Mid(strReadLineNext, intGtPos +17,20)
			intPointPoint = InStr(strReproID, ".")
			strReproID = Mid(strReproID, 1, intPointPoint -1)
			objOutFile.WriteLine("<reproID>" & strReproID & "</reproID>")
		End If

		'Define the Format of the image
		If InStr(strReadLineNext, strExternalFile) Then
			intPointPos = InStr(strReadLineNext,strCTPoint)
			If intPointPos > 0 Then
				strFormat = strCroppedTiff
			Else
				intPointPos = InStr(strReadLineNext,strDTPoint)
				If intPointPos > 0 Then
					strFormat = strDerivativeTiff
				Else
					strFormat = strDerivativeJpeg
				End If
			End If
			objOutFile.WriteLine(strFormatItem & strFormat & strFormatItemEnd)
		End If

		'look for Accession No- the link to the photo record
		'Change to use established repro ID, not user_sym_3
		'If InStr(strReadLineNext,"<user_sym_3 ") Then
			'intGtPos = InStr(strReadLineNext,">")
		'New line:
		If InStr(strReadLineNext,"<im_ref") Then
		    'Changed line:
			strRef = left(strReproID, 7)
			objLogFile.WriteLine(strRef)
			'when found, open Object file; we have a match
			Set objInFile1 = objFSO.OpenTextFile(strDirectory & strInFile1)
			strPhoto = "Not Found"
			'loop round the Object file, reading each row
			Do While Not objInFile1.AtEndOfStream
				strReadLine1 = objInFile1.ReadLine
				If InStr(strReadLine1, "<object id") Then
					'there are a number of different potential lengths for the id of the object. Capture this.
					'commaString = Mid(strReadLine1,13, 7)
					'commaEndPos = InStr(commaString,Chr(34))
					'strObjNo = Mid(commaString, 1, commaEndPos -1 )
					strObjNo = strReadLine1
				End If

				If InStr(strReadLine1, "<user_sym_37") Then
				'If InStr(strReadLine1, "<accession_no") Then
					intGtPos = InStr(strReadLine1,">")
					strAccessionNo = Mid(strReadLine1,intGtPos + 1,7)
					'if there is no Accession No, then we don't attempt to add any Object info
					If strAccessionNo = "" Then
						MsgBox ("Error 1: No Accession No")
						WScript.Quit
					Else

						'im_ref should match accession_no. When we find that we
						'can start assigning details
						objLogFile.writeLine(strRef &  " & " & strAccessionNo)
						If strRef = strAccessionNo  And Not IsNull(strAccessionNo) Then
							'we do this by opening another instance of the photo file to read through
							objLogFile.writeLine (strAccessionNo & ": " & strRef & " :A Match!")
							Set objInFile3 = objFSO.OpenTextFile(strDirectory & strInFile1)
							strEndNode = "N"

							'loop round, reading each row
							Do Until strEndNode = "Y"
								strReadLine3 = objInFile3.ReadLine

								'if instr(strReadLine3, "<av") then
								If InStr(strReadLine3, "<object id") Then
									'look for the relevant avNo
									If InStr(strReadLine3, strObjNo) Then
										objOutFile.writeLine("<object>")
										strEndNodeInner = "N"

										'and loop until you have found everything for that image
										Do Until strEndNodeInner = "Y"
											strReadLine3 = objInFile3.ReadLine
											'write the av info
											'OBJECT CODE TO GO INTO INNER LOOP
											'Get year from earliest date
'											If InStr(strReadLine3, "prod_pri_date_earliest") Then
'												strDate1 =Mid(strReadLine3,49,4)
'												objOutFile.WriteLine(strReadLine3)
'											End If
											'Get year from latest date
'											If InStr(strReadLine3, "prod_pri_date_latest") Then
'												strDate2 =Mid(strReadLine3,47,4)
'												objOutFile.WriteLine(strReadLine3)
'											End If

											'As with AV Person & Role, Group all Person attributes in the same way
											If InStr(strReadLine3, strPerson) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strPerson, "person" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strPersonEnd, "person" & intRowNo & ">")
											End If

											If InStr(strReadLine3, strPersonName) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strPersonName, "personname" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strPersonNameEnd, "personname" & intRowNo & ">")
											End If

											If InStr(strReadLine3, strNationality) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strNationality, "nationality" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strNationalityEnd, "nationality" & intRowNo & ">")
											End If

											If InStr(strReadLine3, strDates) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strDates, "dates" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strDatesEnd, "dates" & intRowNo &">")
											End If

											If InStr(strReadLine3, strRole) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strRole, "role" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strRoleEnd, "role" & intRowNo & ">")
											End If

											If InStr(strReadLine3, strActiveDates) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strActiveDates, "activedates" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strActiveDatesEnd, "activedates" & intRowNo & ">")
											End If

											If InStr(strReadLine3, strSummaryCreator) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strSummaryCreator, "summarycreator" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strSummaryCreatorEnd, "summarycreator" & intRowNo & ">")
											End If

											'Secondary Creator details
											If InStr(strReadLine3, strSecondaryCreator) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strSecondaryCreator, "secondarycreator" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strSecondaryCreatorEnd, "secondarycreator" & intRowNo & ">")
											End If

											If InStr(strReadLine3, strSecondaryDates) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strSecondaryDates, "secondarydates" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strSecondaryDatesEnd, "secondarydates" & intRowNo & ">")
											End If

											If InStr(strReadLine3, strSecondaryNationality) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strSecondaryNationality, "secondarynat" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strSecondaryNationalityEnd, "secondarynat" & intRowNo & ">")
											End If

											If InStr(strReadLine3, strSecondaryRole) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strSecondaryRole, "secondaryrole" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strSecondaryRoleEnd, "secondaryrole" & intRowNo & ">")
											End If

											'Group documentation details
											If InStr(strReadLine3, strDocumentationItem) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strDocumentationItem, "documentation" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, strDocumentationItemend, "documentation" & intRowNo &">")
												If intRowNo = 1 Then
													strDocumentation = strReadLine3
												End If
											End If

											If InStr(strReadLine3, strDocumentationItemVolPage) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strDocumentationItemVolPage, "documentationvolpage" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, " >", ">")
												If intRowNo = 1 Then
													strDocumentationVolPage = strReadLine3
												End If
											End If

											If InStr(strReadLine3, strDocumentationItemPerson) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strDocumentationItemPerson, "documentationperson" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, " >", ">")
												If intRowNo = 1 Then
													strDocumentationPerson = strReadLine3
												End If
											End If

											If InStr(strReadLine3, strDocumentationItemNotes) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strDocumentationItemNotes, "documentationnotes" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, " >", ">")
												If intRowNo = 1 Then
													strDocumentationNotes = strReadLine3
												End If
											End If

											If InStr(strReadLine3, strDocumentationItemArticle) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strDocumentationItemArticle, "documentationarticle" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, " >", ">")
											End If

											If InStr(strReadLine3, strDocumentationItemPublishDate) Then
												intEqualPoint = InStr(strReadLine3,"=")
												intRowNo = Mid(strReadLine3, intEqualPoint + 2, 1)
												strReadLine3 = Replace(strReadLine3, strDocumentationItemPublishDate, "documentationpublishdate" & intRowNo & " ")
												strReadLine3 = Replace(strReadLine3, " >", ">")
											End If

											'Carriage returns
											If InStr(strReadLine3, "||") Then
												strReadLine3 = Replace(strReadLine3, "||", Chr(13))
											End If


											'In order to handle subset, we hold off writing documentation till end
											If strDocumentationVolPage <> "" And (InStr(strReadLine3, "document") And InStr(strReadLine3,"1 >"))  Then
												objLogFile.WriteLine("Should not be writing " & strReadLine3)
											Else
												If InStr(strReadLine3, "/object>" ) = 0 Then
													objOutFile.WriteLine(strReadLine3)
												End If
											End If

											If InStr(strReadLine3, "/object>") Then
												If InStr(strDocumentationNotes, "Subset/Host Work") Then
													strDocumentation = Replace(strDocumentation, "documentation1", "subset")
													objOutFile.WriteLine(strDocumentation)
													strDocumentation = ""
													strDocumentationVolPage = Replace(strDocumentationVolPage, "documentationvolpage1", "subsetpage")
													objOutFile.WriteLine(strDocumentationVolPage)
													strDocumentationVolPage = ""
													strDocumentationNotes = ""
													strDocumentationPerson = ""
													objOutFile.WriteLine(strReadLine3)
												Else
													objOutFile.WriteLine(strDocumentation)
													objOutFile.WriteLine(strDocumentationVolPage)
													objOutFile.WriteLine(strDocumentationPerson)
													objOutFile.WriteLine(strDocumentationNotes)
													strDocumentation = ""
													strDocumentationVolPage = ""
													strDocumentationPerson = ""
													strDocumentationNotes = ""
													objOutFile.WriteLine(strReadLine3)
												End If
												strEndNodeInner = "Y"
												strEndNode = "Y"
											End If
										Loop
									End If
								End If
							Loop
						Else
							strPhoto = "Found"
						End If
					End If
				End If
			Loop
		End If
	End If
Loop


WScript.Quit

