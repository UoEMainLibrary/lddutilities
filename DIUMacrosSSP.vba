Function specialChars(ByVal textValue As String) As String
    specialChars = Replace(textValue, "&", "&amp;")
    specialChars = Replace(specialChars, "<", "&lt;")
    specialChars = Replace(specialChars, ">", "&gt;")
End Function

Sub CreateXML()
    MsgBox "Howdy DIU! Nice to see ya!"

    'Set worksheet- there is only one.
    Set oWorksheet = ThisWorkbook.Worksheets(1)
    sName = oWorksheet.Name

    'Set no columns and rows for counts
    lCols = oWorksheet.Columns.Count
    lRows = oWorksheet.Rows.Count

    'Header is so long it runs onto many lines- initialise here
    Dim firstheader
    Dim secondheader
    Dim thirdheader
    Dim fourthheader
    Dim Header

    'Initialise data arrays
    Dim ssparray(1000) As String

    'Initialise file objects
    Dim fssp As Object
    Set fssp = CreateObject("ADODB.Stream")

    'Need a second object so we can get rid of the BOM character
    Dim fsspb As Object
    Set fsspb = CreateObject("ADODB.Stream")

    'Set file object properties
    fssp.Type = 2
    fssp.Charset = "utf-8"
    fssp.Open

    'Set binary file object properties and open
    fsspb.Type = 1
    fsspb.Mode = 3
    fsspb.Open

    'Declare final file names
    sspxml = "T:\diu\Worksheets\csv\SSP.xml"

    summfile = "T:\diu\Worksheets\csv\summary.txt"

  'initialise counts
    i = 4
    sspcount = 0

     Close #99
    Open summfile For Output Lock Write As #99

    MsgBox lRows

    'Process all rows
    For i = 4 To lRows
        processed = Cells(i, 22)
        Dim personArray() As String
        Dim categoryArray() As String
        Dim creatorArray() As String
        Dim placeArray() As String
        Dim prodPlaceArray() As String
        Dim creatorNameArray() As String
        Dim creatorNameBits() As String
        shortcoll = ""
        coll = ""
        subjectCatString = ""
        subjectPersonString = ""
        summaryCreator = ""
        subjectPlaceString = ""
        prodPlaceString = ""
        summaryCreatorString = ""
        creatorNameString = ""
        goodrecord = "Y"
        titleString = ""
        badcoll = "N"
        workString = ""
        pageString = ""
        allSubjectCats = ""
        allSubjectPersons = ""
        rightsStatement = ""
        reproRightsStatement = ""
        licenceString = ""
        subsetIndex = ""
        relatedWorkVolPageNo = ""
        reproTitle = ""
        reproRecordId = ""
        reproLinkId = ""
        workRecordId = ""
        reproIdNumber = ""
        Title = ""
        Subset = ""
        relatedWorkTitle = ""
        shelfmark = ""
        sequence = ""
        catalogueNumber = ""
        repository = ""
        reproRepository = ""
        catalogueEntry = ""
        catString = ""
        reproPublicationStatus = ""
        subjectEvent = ""
        reproNotes = ""
        Description = ""
        dateString = ""
        Category = ""
        person = ""
        place = ""
        allSubjectPlaces = ""
        prodPlace = ""
        allProdPlaces = ""
        creatorName = ""
        allCreators = ""
        creatorString = ""
        holding = ""

        'If ready to process act, otherwise bypass
        If processed = "X" Then
            coll = Cells(i, 7)
            If coll <> "" Then
                badcoll = "N"
                'Get collection tla
                Select Case coll

                    Case "Court of Session Papers"
                        sspcoll = coll
                        shortcoll = "ssp"
                   Case Else
                        badcoll = "Y"
                  End Select

                'Constants
                entitys = "<entity name = " & Chr(34)
                entitycfieldst = Chr(34) & ">" & Chr(10) & "<field name=" & Chr(34)
                fieldcvalues = Chr(34) & ">" & Chr(10) & "<value>"
                valueefielde = "</value>" & Chr(10) & "</field>" & Chr(10)
                fields = "<field name=" & Chr(34)
                entitye = "</entity>" & Chr(10)
                valueefieldeentitye = "</value>" & Chr(10) & "</field>" & Chr(10) & "</entity>" & Chr(10)
                ccby = "<![CDATA[<a href = " & Chr(34) & "https://creativecommons.org/licenses/by/3.0/" & Chr(34) & " target=" & Chr(34) & "_blank" & Chr(34) & "><img src = " & Chr(34) & "http://lac-luna-live4.is.ed.ac.uk:8181/graphics/by.jpg" & Chr(34) & "/></a>]]>"
                ccbyncnd = "<![CDATA[<a href = " & Chr(34) & "https://creativecommons.org/licenses/by-nc-nd/3.0/" & Chr(34) & " target=" & Chr(34) & "_blank" & Chr(34) & "><img src = " & Chr(34) & "http://lac-luna-live4.is.ed.ac.uk:8181/graphics/byncnd.jpg" & Chr(34) & "/></a>]]>"
                reproFileType = fields & "repro_file_type" & fieldcvalues & "Cropped TIFF" & valueefielde
                If Cells(i, 5) = "" Then
                   holding = "Unassigned"
                Else
                   holding = Cells(i, 5)
                End If
                holdingInstitution = fields & "holding_institution" & fieldcvalues & holding & valueefielde
                reproCreatorName = entitys & "repro_creator" & entitycfieldst & "repro_creator_name" & fieldcvalues & "Digital Imaging Unit" & valueefielde
                reproCreatorRoleDescription = fields & "repro_creator_role_description" & fieldcvalues & "Creator" & valueefieldeentitye

                'Don't process if no collection
                If badcoll = "Y" Then
                   goodrecord = "N"
                   MsgBox "major problem- mis-spelt or ineligible Collection!" & " " & coll & " " & Cells(i, 8) & Cells(i, 9)
                End If

                'Don't process if no title
                'If Cells(i, 13) = "" Then
                '   goodrecord = "N"
                '  MsgBox "major problem- no Title!" & " " & coll & " " & Cells(i, 8) & Cells(i, 9)
                'Else
                titleString = "Scottish Court of Session Papers"
                'End If

                'If no work record ID (in column 8 OR 9, don't process)
                If Cells(i, 8) = "" Then
                    goodrecord = "N"
                Else
                    workString = Left(Cells(i, 8), 7)
                End If

                If workString = "" Then
                   goodrecord = "N"
                   MsgBox "major problem- no image Id!" & " " & coll & " " & " " & Cells(i, 5) & " " & Cells(i, 9)
                End If

                If goodrecord = "Y" Then
                    'Get copyright & licence text
                    rightsStatement = entitys & "rights" & entitycfieldst & "work_rights_statement" & fieldcvalues & "Out of Copyright." & valueefieldeentitye
                    reproRightsStatement = entitys & "repro_rights" & entitycfieldst & "repro_rights_statement" & fieldcvalues & "Copyright University of Edinburgh Library." & valueefieldeentitye
                    licenceString = entitys & "licence" & entitycfieldst & "licence" & fieldcvalues & ccby & valueefieldeentitye

                    'Process fields by column
                    'If Cells(i, 9) = "" Then
                        subsetIndex = ""
                        relatedWorkVolPageNo = entitye
                        reproTitle = entitys & "repro_title" & entitycfieldst & "repro_title" & fieldcvalues & titleString & valueefieldeentitye
                    'Else
                     '   pageString = specialChars(Cells(i, 9))
                     '   seqString = specialChars(Cells(i, 9))
                     '   subsetIndex = fields & "work_subset_index" & fieldcvalues & pageString & valueefielde
                     '   If shortcoll = "ssp" Then
                     '       relatedWorkVolPageNo = entitye
                     '       reproTitle = entitys & "repro_title" & entitycfieldst & "repro_title" & fieldcvalues & "Case " & pageString & ", " & "Page " & seqString & valueefieldeentitye
                     '   Else
                     '       relatedWorkVolPageNo = fields & "work_source_page_no" & fieldcvalues & pageString & valueefieldeentitye
                     '       reproTitle = entitys & "repro_title" & entitycfieldst & "repro_title" & fieldcvalues & titleString & ", " & pageString & valueefieldeentitye
                     '   End If
                    'End If

                    reproRecordId = entitys & "repro_record" & entitycfieldst & "repro_record_id" & fieldcvalues & workString & "c.tif" & valueefielde
                    reproLinkId = fields & "repro_link_id" & fieldcvalues & workString & "c" & valueefielde
                    workRecordId = fields & "work_record_id" & fieldcvalues & workString & valueefielde
                    reproIdNumber = entitys & "repro_id_number" & entitycfieldst & "repro_id_number" & fieldcvalues & workString & "c" & valueefieldeentitye

                    Title = entitys & "title" & entitycfieldst & "work_title" & fieldcvalues & titleString & valueefieldeentitye
                    Subset = entitys & "subset" & entitycfieldst & "work_subset" & fieldcvalues & titleString & valueefielde
                    relatedWorkTitle = entitys & "related_work" & entitycfieldst & "work_source" & fieldcvalues & titleString & valueefielde

                    If Cells(i, 4) = "" Then
                        MsgBox "major problem- no Shelfmark!" & coll & " " & Cells(i, 8) & Cells(i, 9)
                        shelfmark = ""
                    Else
                        shelfmark = entitys & "id_number" & entitycfieldst & "work_shelfmark" & fieldcvalues & specialChars(Cells(i, 4)) & valueefielde
                    End If

                    If Cells(i, 9) = "" Then
                        sequence = entitye
                    Else
                        sequence = fields & "sequence_no" & fieldcvalues & Cells(i, 9) & valueefieldeentitye
                    End If

                    'If Cells(i, 26) = "" Then
                        catalogueNumber = entitye
                    'Else
                    '    catalogueNumber = fields & "work_catalogue_number" & fieldcvalues & specialChars(Cells(i, 26)) & valueefieldeentitye
                   ' End If

                    repository = entitys & "repository" & entitycfieldst & "work_repository" & fieldcvalues & Cells(i, 7) & valueefieldeentitye
                    reproRepository = entitys & "repro_repository" & entitycfieldst & "repro_repository" & fieldcvalues & Cells(i, 7) & valueefieldeentitye

                    If Cells(i, 21) = "" Then
                        catalogueEntry = ""
                    Else
                        catString = Replace(Cells(i, 21), "&", "%26")
                        catalogueEntry = entitys & "navigation" & entitycfieldst & "catalogue_entry" & fieldcvalues & catString & valueefieldeentitye
                    End If

                   ' If Cells(i, 27) = "N/A" Or Cells(i, 27) = "Unknown" Or Cells(i, 27) = "-" Or Cells(i, 27) = "" Then
                        reproNotes = entitye
                   ' Else
                    '    reproNotes = fields & "repro_notes" & fieldcvalues & specialChars(Cells(i, 27)) & valueefieldeentitye
                   ' End If


                    reproPublicationStatus = entitys & "repro_publication_status" & entitycfieldst & "repro_publication_status" & fieldcvalues & "Full Public Access" & valueefieldeentitye

                    'Build XML file
                    dataLine1 = workRecordId & licenceString & shelfmark & holdingInstitution & catalogueNumber & Title & Subset & subsetIndex & sequence & allCreators & dateString & Description & allProdPlaces & repository & allSubjectPersons & allSubjectPlaces & subjectEvent & allSubjectCats & relatedWorkTitle & relatedWorkVolPageNo & rightsStatement & catalogueEntry
                    dataLine2 = reproRecordId & reproLinkId & reproFileType & reproNotes & reproTitle & reproCreatorName & reproCreatorRoleDescription & reproRepository & reproIdNumber & reproRightsStatement & reproPublicationStatus
                    dataLine = dataLine1 & dataLine2

                    Header = "<?xml version=" & Chr(34) & "1.0" & Chr(34) & " encoding=" & Chr(34) & "UTF-8" & Chr(34) & "?>" & Chr(10) & "<recordList>" & Chr(10)
                    recordLine = "<record>" & Chr(10)
                    recordCloser = "</record>" & Chr(10)

                    'Write to file objects

                    If shortcoll = "ssp" Then
                        If sspcount = 0 Then
                            fssp.WriteText Header & Chr(10)
                        End If
                        fssp.WriteText recordLine
                        fssp.WriteText dataLine & Chr(10)
                        fssp.WriteText recordCloser
                        ssparray(sspcount) = Cells(i, 8) & " ; Public "
                        sspcount = sspcount + 1
                    End If

                    Cells(i, 22) = "V"

                End If
            Else
                MsgBox "major problem- no Collection!" & " " & coll & " " & Cells(i, 8) & Cells(i, 9)
            End If
         End If
    Next
    'Start after the BOM chars, copy to bin and then copy to csv
    If sspcount > 0 Then
        fssp.WriteText "</recordList>"
        fssp.Position = 3
        fssp.CopyTo fsspb
        fssp.Flush
        fssp.Close
        fsspb.SaveToFile sspxml, 2
    Else
        fssp.Close
        fsspb.Close
    End If

        i = 0

        If sspcount > 0 Then
            Print #99, sspcoll
            Print #99, "===================="
            For i = 0 To sspcount
                Print #99, ssparray(i)
            Next
        End If

        Close #99

        MsgBox "Ended!"

End Sub
Sub Embed()
MsgBox "Hello DIU!"

    Set oWorksheet = ThisWorkbook.Worksheets(1)
    sName = oWorksheet.Name
    MsgBox oWorksheet.Name

    lCols = oWorksheet.Columns.Count

    lRows = oWorksheet.Rows.Count

    execdir = "T:\diu\Worksheets\"

    dt = Format(CStr(Now), "yy_mm_dd_hh_mm")
    embedcmd = "T:\diu\Worksheets\embed\" & dt & ".bat"
    MsgBox embedcmd

    Open embedcmd For Output Lock Write As #1
    Print #1, "cd /D T: > " & Chr(34) & "T:\diu\Worksheets\error\" & imageno & "connection.txt" & Chr(34) & " 2>&1"
    Print #1, "cd " & Chr(34) & "T:\diu\Worksheets\exiv2" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageno & "connection.txt" & Chr(34) & " 2>>&1"
    Print #1, "echo " & Chr(34) & "directory is: " & Chr(34) & "%cd% >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageno & "connection.txt" & Chr(34) & " 2>>&1"

    For i = 4 To lRows
        If Cells(i, 21) = "R" Then
            folder = Left(Cells(i, 8), 4) & "000-" & Left(Cells(i, 8), 4) & "999\"
            imageno = Left(Cells(i, 8), 7)


            copyrightstring = "Holding Institution: " & Cells(i, 5) & ". Digital Image: Copyright University of Edinburgh Library. Original: Out of Copyright."


            titl = "Title: Scottish Court of Session Papers; Sequence No: " & Cells(i, 9) & "; Shelfmark: " & Cells(i, 4)
            'desc = "Collection: " & Cells(i, 22) & "; Persons: " & Cells(i, 23) & "; Event: " & Cells(i, 25) & "; Place: " & Cells(i, 20) & "; Category: " & Cells(i, 19) & "; Description: " & Cells(i, 21)
            city = "Edinburgh"
            pcde = "EH8 9LJ"
            exAd = "Centre for Research Collections, The University of Edinburgh, George Square"
            ctr = "UK"
            tel = "0131 650 8379"
            eml = "is-crc@ed.ac.uk"
            diu = "Digital Imaging Unit"
            URL = "http://www.lib.ed.ac.uk/resources/collections/crc/index.html"

            commands = "T:\diu\Worksheets\commands\" & imageno & ".txt"

            Open commands For Output Lock Write As #2

            Print #2, "set Iptc.Application2.Headline String " & Chr(34) & imageno & Chr(34)
            Print #2, "set Iptc.Application2.Copyright String " & Chr(34) & copyrightstring & Chr(34)
            Print #2, "set Xmp.dc.creator XmpSeq " & Chr(34) & diu & Chr(34)
            'Print #2, "set Iptc.Application2.Caption String " & Chr(34) & desc & Chr(34)
            Print #2, "set Iptc.Application2.ObjectName String " & Chr(34) & titl & Chr(34)
            Print #2, "set Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrCity XmpText " & Chr(34) & city & Chr(34)
            Print #2, "set Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrPcode XmpText " & Chr(34) & pcde & Chr(34)
            Print #2, "set Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrExtadr XmpText " & Chr(34) & exAd & Chr(34)
            Print #2, "set Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrCtry XmpText " & Chr(34) & ctr & Chr(34)
            Print #2, "set Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiTelWork XmpText " & Chr(34) & tel & Chr(34)
            Print #2, "set Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiEmailWork XmpText " & Chr(34) & eml & Chr(34)
            Print #2, "set Iptc.Application2.Headline String " & Chr(34) & imageno & Chr(34)
            Print #2, "set Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiUrlWork XmpText " & Chr(34) & URL & Chr(34)
            Print #2, "del Exif.Image.ImageDescription"
            Close #2
            Print #1, "exiv2 -m" & commands & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageno & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageno & ".txt" & Chr(34) & " 2>>&1"

            Cells(i, 21) = "E"

        End If

    Next
    Close #1
    shellstring = Chr(34) & embedcmd & Chr(34)
    Call Shell("cmd.exe /S /C " & shellstring, vbNormalFocus)
    'retval1 = Shell(Chr(34) & embedcmd & Chr(34), vbNormalFocus)

End Sub

Sub Rename()
MsgBox "Hello!"

    Set oWorksheet = ThisWorkbook.Worksheets(1)
    sName = oWorksheet.Name
    MsgBox oWorksheet.Name

    lCols = oWorksheet.Columns.Count

    lRows = oWorksheet.Rows.Count

    execdir = "T:\diu\Worksheets\"
    For i = 4 To lRows
        If Cells(i, 21) = "E" Then
            folder = Left(Cells(i, 8), 4) & "000-" & Left(Cells(i, 8), 4) & "999\"
            imageno = Left(Cells(i, 8), 7)
            copybackcmd = "T:\diu\Worksheets\copyback\" & imageno & ".bat"
            Open copybackcmd For Output Lock Write As #1

            Print #1, "move T:\diu\Crops\" & folder & "Process\" & imageno & "m.tif*  T:\diu\Crops\" & folder & "Process\" & imageno & "c.tif"
            'Print #1, "copy T:\diu\Crops\" & folder & "Process\" & imageNo & "c.tif*  T:\diu\Crops\" & folder & imageNo & "c.tif"

            Close #1

            retval1 = Shell(Chr(34) & copybackcmd & Chr(34), vbNormalFocus)

            Cells(i, 21) = "X"

        End If
    Next


End Sub
