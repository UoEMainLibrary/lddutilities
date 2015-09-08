Sub CreateCSV()
MsgBox "Howdy DIU!"

    'Set worksheet- there is only one.
    Set oWorksheet = ThisWorkbook.Worksheets(1)
    sName = oWorksheet.Name

    'Set no columns and rows for counts
    lCols = oWorksheet.Columns.Count
    MsgBox "Columns:" & lCols
    lRows = oWorksheet.Rows.Count
    MsgBox "Rows:" & lRows

    'Header is so long it runs onto many lines- initialise here
    Dim firstheader
    Dim secondheader
    Dim thirdheader
    Dim fourthheader
    Dim Header

    'Initialise data arrays
    Dim wmmarray(1000) As String
    Dim uoearray(1000) As String
    Dim galarray(1000) As String
    Dim oriarray(1000) As String
    Dim laiarray(1000) As String
    Dim rosarray(1000) As String
    Dim ecrarray(1000) As String
    Dim sssarray(1000) As String
    Dim incarray(1000) As String
    Dim shaarray(1000) As String
    Dim newarray(1000) As String
    Dim thoarray(1000) As String
    Dim salarray(1000) As String
    Dim ardarray(1000) As String
    Dim hilarray(1000) As String
    Dim geoarray(1000) As String

    'Initialise file objects
    Dim fwmm As Object
    Set fwmm = CreateObject("ADODB.Stream")
    Dim fuoe As Object
    Set fuoe = CreateObject("ADODB.Stream")
    Dim fgal As Object
    Set fgal = CreateObject("ADODB.Stream")
    Dim fori As Object
    Set fori = CreateObject("ADODB.Stream")
    Dim flai As Object
    Set flai = CreateObject("ADODB.Stream")
    Dim fros As Object
    Set fros = CreateObject("ADODB.Stream")
    Dim fecr As Object
    Set fecr = CreateObject("ADODB.Stream")
    Dim fsss As Object
    Set fsss = CreateObject("ADODB.Stream")
    Dim finc As Object
    Set finc = CreateObject("ADODB.Stream")
    Dim fsha As Object
    Set fsha = CreateObject("ADODB.Stream")
    Dim fnew As Object
    Set fnew = CreateObject("ADODB.Stream")
    Dim ftho As Object
    Set ftho = CreateObject("ADODB.Stream")
    Dim fsal As Object
    Set fsal = CreateObject("ADODB.Stream")
    Dim fard As Object
    Set fard = CreateObject("ADODB.Stream")
    Dim fhil As Object
    Set fhil = CreateObject("ADODB.Stream")
    Dim fgeo As Object
    Set fgeo = CreateObject("ADODB.Stream")

    'Need a second object so we can get rid of the BOM character
    Dim fwmmb As Object
    Set fwmmb = CreateObject("ADODB.Stream")
    Dim fuoeb As Object
    Set fuoeb = CreateObject("ADODB.Stream")
    Dim fgalb As Object
    Set fgalb = CreateObject("ADODB.Stream")
    Dim forib As Object
    Set forib = CreateObject("ADODB.Stream")
    Dim flaib As Object
    Set flaib = CreateObject("ADODB.Stream")
    Dim frosb As Object
    Set frosb = CreateObject("ADODB.Stream")
    Dim fecrb As Object
    Set fecrb = CreateObject("ADODB.Stream")
    Dim fsssb As Object
    Set fsssb = CreateObject("ADODB.Stream")
    Dim fincb As Object
    Set fincb = CreateObject("ADODB.Stream")
    Dim fshab As Object
    Set fshab = CreateObject("ADODB.Stream")
    Dim fnewb As Object
    Set fnewb = CreateObject("ADODB.Stream")
    Dim fthob As Object
    Set fthob = CreateObject("ADODB.Stream")
    Dim fsalb As Object
    Set fsalb = CreateObject("ADODB.Stream")
    Dim fardb As Object
    Set fardb = CreateObject("ADODB.Stream")
    Dim fhilb As Object
    Set fhilb = CreateObject("ADODB.Stream")
    Dim fgeob As Object
    Set fgeob = CreateObject("ADODB.Stream")

    'Set file object properties
    fwmm.Type = 2
    fwmm.Charset = "utf-8"
    fwmm.Open
    fuoe.Type = 2
    fuoe.Charset = "utf-8"
    fuoe.Open
    fgal.Type = 2
    fgal.Charset = "utf-8"
    fgal.Open
    fori.Type = 2
    fori.Charset = "utf-8"
    fori.Open
    flai.Type = 2
    flai.Charset = "utf-8"
    flai.Open
    fros.Type = 2
    fros.Charset = "utf-8"
    fros.Open
    fecr.Type = 2
    fecr.Charset = "utf-8"
    fecr.Open
    fsss.Type = 2
    fsss.Charset = "utf-8"
    fsss.Open
    finc.Type = 2
    finc.Charset = "utf-8"
    finc.Open
    fsha.Type = 2
    fsha.Charset = "utf-8"
    fsha.Open
    fnew.Type = 2
    fnew.Charset = "utf-8"
    fnew.Open
    ftho.Type = 2
    ftho.Charset = "utf-8"
    ftho.Open
    fsal.Type = 2
    fsal.Charset = "utf-8"
    fsal.Open
    fard.Type = 2
    fard.Charset = "utf-8"
    fard.Open
    fhil.Type = 2
    fhil.Charset = "utf-8"
    fhil.Open
    fgeo.Type = 2
    fgeo.Charset = "utf-8"
    fgeo.Open

    'Set binary file object properties and open
    fwmmb.Type = 1
    fwmmb.Mode = 3
    fwmmb.Open
    fuoeb.Type = 1
    fuoeb.Mode = 3
    fuoeb.Open
    fgalb.Type = 1
    fgalb.Mode = 3
    fgalb.Open
    forib.Type = 1
    forib.Mode = 3
    forib.Open
    flaib.Type = 1
    flaib.Mode = 3
    flaib.Open
    frosb.Type = 1
    frosb.Mode = 3
    frosb.Open
    fecrb.Type = 1
    fecrb.Mode = 3
    fecrb.Open
    fsssb.Type = 1
    fsssb.Mode = 3
    fsssb.Open
    fincb.Type = 1
    fincb.Mode = 3
    fincb.Open
    fshab.Type = 1
    fshab.Mode = 3
    fshab.Open
    fnewb.Type = 1
    fnewb.Mode = 3
    fnewb.Open
    fthob.Type = 1
    fthob.Mode = 3
    fthob.Open
    fsalb.Type = 1
    fsalb.Mode = 3
    fsalb.Open
    fardb.Type = 1
    fardb.Mode = 3
    fardb.Open
    fhilb.Type = 1
    fhilb.Mode = 3
    fhilb.Open
    fgeob.Type = 1
    fgeob.Mode = 3
    fgeob.Open

    'Declare final file names
    wmmcsv = "T:\diu\Worksheets\csv\WMM.csv"
    galcsv = "T:\diu\Worksheets\csv\GAL.csv"
    laicsv = "T:\diu\Worksheets\csv\LAI.csv"
    oricsv = "T:\diu\Worksheets\csv\ORI.csv"
    newcsv = "T:\diu\Worksheets\csv\NEW.csv"
    ardcsv = "T:\diu\Worksheets\csv\ARD.csv"
    hilcsv = "T:\diu\Worksheets\csv\HIL.csv"
    salcsv = "T:\diu\Worksheets\csv\SAL.csv"
    ssscsv = "T:\diu\Worksheets\csv\SSS.csv"
    shacsv = "T:\diu\Worksheets\csv\SHA.csv"
    thocsv = "T:\diu\Worksheets\csv\THO.csv"
    inccsv = "T:\diu\Worksheets\csv\INC.csv"
    uoecsv = "T:\diu\Worksheets\csv\UOE.csv"
    roscsv = "T:\diu\Worksheets\csv\ROS.csv"
    ecrcsv = "T:\diu\Worksheets\csv\ECR.csv"
    geocsv = "T:\diu\Worksheets\csv\GEO.csv"
    summfile = "T:\diu\Worksheets\csv\summary.txt"

    'Set up headers
    firstheader = "Work Record ID,ID Number,ID Date,Cataloguer,Shelfmark,Holding Institution,Old ID,Catalogue Number,Title,Alternate Title,Title Notes,Translated Title,Untranslated Title,Variant Title,Imprint,Subset,Subset Index,Sequence,Creator#1,Creator#2,Creator#3,Creator Name#1,Creator Name#2,Creator Name#3,Creator Dates#1,Creator Dates#2,Creator Dates#3,Creator Nationality#1,Creator Nationality#2,Creator Nationality#3,Creator Role#1,Creator Role#2,Creator Role#3,Creator Active Dates#1,Creator Active Dates#2,Creator Active Dates#3,Summary Creator#1,Summary Creator#2,Summary Creator#3,Production Notes#1,Production Notes#2,Production Notes#3,Associate Creator,Associate Creator Name,Associate Creator Dates,Associate Creator Nationality,Associate Creator Role,Date,Early Date,Late Date,Date Info,Description,Classification,Work Type,Work Type Notes,Measurement,Measurement Type,Measurement Notes,Measurement Unit,Material,Material Notes,Technique,"
    secondheader = "Secondary Technique,Location#1,Location#2,Department,Gallery,Location Info,Production Place#1,Production Place#2,Production Place#3,Production Place#4,Production Place#5,Repository,Source,Repository Notes,Style or Period,Style Secondary Period Term,Culture,Subject#1,Subject#2,Subject#3,Subject Person#1,Subject Person#2,Subject Person#3,Subject Person#4,Subject Person#5,Subject Person#6,Subject Person#7,Subject Person#8,Subject Person#9,Subject Person#10,Subject Person#11,Subject Person#12,Subject Person#13,Subject Person#14,Subject Person#15,Subject Person#16,Subject Person#17,Subject Person#18,Subject Person#19,Subject Person#20,Subject Person#21,Subject Person#22,Subject Person#23,Subject Person#24,Subject Person#25,Subject Person#26,Subject Person#27,Subject Person#28,Subject Person#29,Subject Person#30,Subject Person#31,Subject Person#32,Subject Person#33,Subject Person#34,Subject Person#35,"
    thirdheader = "Subject Role,Subject Place#1,Subject Place#2,Subject Place#3,Subject Place#4,Subject Place#5,Subject Place#6,Subject Event,Subject Object,Subject Category#1,Subject Category#2,Subject Category#3,Subject Category#4,Subject Category#5,Subject Date,Subject Period,Related Object,Relation Type,Reference,Related Work Title,Related Work Page No,Related Work Creator,Related Work Article,Related Work Notes,Related Work Publish Date,Related Work Desc,Rights Statement,Rights Details,Inscription,Inscription Notes,Provenance Notes,Keyword,Catalogue Entry,Media Group,"
    fourthheader = "Repro Record ID,Repro Link ID,Repro File Type,Repro File Size (bytes),Repro Capture Device Type,Repro Resolution (dpi),Repro Notes,Repro Title,Repro Display Measurement (pixels),Repro Measurement Unit,Repro Creator Name#1,Repro Creator Name#2,Repro Creator Role Description#1,Repro Creator Role Description#2,Repro Repository,Repro ID Number,Repro Old ID Number,Repro Related Object,Repro Relation Type,Repro Relation Notes,Repro Description,Repro Rights Statement,Repro Capture Date,Repro Publication Status"

    'And make the header line for csv a concatenation of above
    Header = firstheader & secondheader & thirdheader & fourthheader

    'initialise counts
    i = 5
    wmmcount = 0
    uoecount = 0
    galcount = 0
    oricount = 0
    laicount = 0
    roscount = 0
    ecrcount = 0
    ssscount = 0
    inccount = 0
    shacount = 0
    newcount = 0
    thocount = 0
    salcount = 0
    ardcount = 0
    hilcount = 0
    geocount = 0

    'File objects open- comment out
    'Open wmmcsv For Output Lock Write As #1
    'Open uoecsv For Output Lock Write As #2
    'Open galcsv For Output Lock Write As #3
    'Open laicsv For Output Lock Write As #4
    'Open ecrcsv For Output Lock Write As #5
    'Open inccsv For Output Lock Write As #6
    'Open ssscsv For Output Lock Write As #7
    'Open roscsv For Output Lock Write As #8
    'Open salcsv For Output Lock Write As #9
    'Open hilcsv For Output Lock Write As #10
    'Open ardcsv For Output Lock Write As #11
    'Open shacsv For Output Lock Write As #12
    'Open newcsv For Output Lock Write As #13
    'Open oricsv For Output Lock Write As #14
    'Open thocsv For Output Lock Write As #15
    'Open geocsv For Output Lock Write As #16
     Close #99
    Open summfile For Output Lock Write As #99

    'Process all rows
    For i = 5 To lRows
        processed = Cells(i, 39)
        Dim personArray() As String
        Dim categoryArray() As String
        Dim creatorArray() As String
        Dim placeArray() As String
        Dim prodPlaceArray() As String
        Dim creatorNameArray() As String

        subjectCatString = ""
        subjectPersonString = ""
        summaryCreator = ""
        subjectPlaceString = ""
        prodPlaceString = ""
        summaryCreatorString = ""
        creatorNameString = ""

        'If ready to process act, otherwise bypass
        If processed = "X" Then
            coll = Cells(i, 22)

            'Get collection tla
            Select Case coll
                Case "Western Medieval Manuscripts"
                    wmmcoll = coll
                    shortcoll = "wmm"
                Case "University of Edinburgh"
                    uoecoll = coll
                    shortcoll = "uoe"

                Case "CRC Gallimaufry"
                    galcoll = coll
                    shortcoll = "gal"
                Case "Roslin"
                    shortcoll = "ros"
                    roscoll = coll
                Case "Laing"
                    shortcoll = "lai"
                    laicoll = coll
                Case "Incunabula"
                    inccoll = coll
                    shortcoll = "inc"
                Case "School of Scottish Studies"
                    ssscoll = coll
                    shortcoll = "sss"
                Case "ECA Rare Books"
                    ecrcoll = coll
                    shortcoll = "ecr"
                Case "New College"
                    newcoll = coll
                    shortcoll = "new"
                Case "Shakespeare"
                    shacoll = coll
                    shortcoll = "sha"
                Case "Oriental Manuscripts"
                    oricoll = coll
                    shortcoll = "ori"
                Case "Thomson Walker"
                    thocoll = coll
                    shortcoll = "tho"
                Case "Salvesen"
                    salcoll = coll
                    shortcoll = "sal"
                Case "Architectural Drawings"
                    ardcoll = coll
                    shortcoll = "ard"
                Case "Hill & Adamson"
                    hilcoll = coll
                    shortcoll = "hil"
                Case "Geology and Geologists"
                    geocoll = coll
                    shortcoll = "geo"
            End Select

            'Get copyright text
            Select Case Cells(i, 10)
                Case "UoE-Y"
                    copyrightstring = "Copyright The University of Edinburgh. Free use."
                    reprocopystring = "Copyright The University of Edinburgh."
                Case "UoE-N"
                    copyrightstring = "Copyright The University of Edinburgh. Not for Public Access."
                    reprocopystring = "Copyright The University of Edinburgh."
                Case "Orphan"
                    copyrightstring = "Copyright unknown, orphan work."
                    reprocopystring = "Copyright The University of Edinburgh."
                Case "UoE&A-Y"
                    copyrightstring = "Copyright in the original currently rests with the creator, their estate, heirs or assignees. Permission has been granted for specific use by the University of Edinburgh."
                    reprocopystring = "Copyright The University of Edinburgh."
                Case "UoE&A-N"
                    copyrightstring = "Copyright in the original currently rests with the creator, their estate, heirs or assignees. Permission has not been granted for use by the University of Edinburgh (other than those deemed 'Fair Dealing such as educational, personal and non commercial research - unless otherwise stated)."
                    reprocopystring = "Copyright The University of Edinburgh."
                Case "DataP"
                    copyrightstring = "Copyright in the original may be University of Edinburgh or rest elsewhere. Data Protection restrictions."
                    reprocopystring = "Copyright The University of Edinburgh."
                Case "Loan"
                    copyrightstring = "Copyright in the original currently rests with the creator, their estate, heirs or assignees. Permission has not been granted for  use by the University of Edinburgh (other than those deemed 'Fair Dealing such as educational, personal and non commercial research - unless otherwise stated)."
                    reprocopystring = "Copyright The University of Edinburgh."
                Case "OC"
                    copyrightstring = "Out of Copyright."
                    reprocopystring = "Copyright The University of Edinburgh."
                Case "LHSA"
                    copyrightstring = "Copyright and Data Protection Restrictions. Not for Public Access."
                    reprocopystring = "Copyright and Data Protection Restrictions. Not for Public Access."
                Case Else
                    copyrightstring = "No copyright information available."
                    reprocopystring = "No copyright information available."
            End Select

            'Process repro fields
            reproRecordId = Left(Cells(i, 8), 7) & "c.tif"
            reproTitle = Chr(34) & Cells(i, 13) & ", " & Cells(i, 17) & Chr(34)
            reproLinkId = Left(Cells(i, 8), 7) & "c"

            'Get pub status full text
            If Cells(i, 11) = "Y" Then
                publicStatus = "Full Public Access"
            Else
                publicStatus = "No access"
            End If

            'Process repeating category
            Category = Cells(i, 19)

            If InStr(Category, ";") = 0 Then
                If Category = "N/A" Or Category = "Unknown" Or Category = "-" Then
                    Category = ""
                End If
                subjectCatString = Chr(34) & Category & Chr(34)
                j = 0
            Else
                categoryArray() = Split(Category, ";")
                For j = LBound(categoryArray()) To UBound(categoryArray())
                    If categoryArray(j) = "" Then
                        subjectCatString = subjectCatString & ","
                    Else
                        subjectCatString = subjectCatString & Chr(34) & Trim(categoryArray(j)) & Chr(34) & ","
                    End If
                Next j
            End If

            For o = j To 4
                subjectCatString = subjectCatString & ","
            Next o

            'Process repeating subject persons
            Person = Cells(i, 23)
            If InStr(Person, ";") = 0 Then
                If Person = "N/A" Or Person = "Unknown" Or Person = "-" Then
                    Person = ""
                End If
                subjectPersonString = Chr(34) & Person & Chr(34)
                k = 0
            Else
                personArray() = Split(Person, ";")

                For k = LBound(personArray()) To UBound(personArray())
                    If personArray(k) = "" Then
                        subjectPersonString = subjectPersonString & ","
                    Else
                        subjectPersonString = subjectPersonString & Chr(34) & Trim(personArray(k)) & Chr(34) & ","
                    End If
                Next k
            End If

            For m = k To 34
                subjectPersonString = subjectPersonString & ","
            Next m

            'Process repeating subject places
            Place = Cells(i, 20)
            If InStr(Place, ";") = 0 Then
                If Place = "N/A" Or Place = "Unknown" Or Place = "-" Then
                    Place = ""
                End If
                subjectPlaceString = Chr(34) & Place & Chr(34)
                r = 0
            Else
                placeArray() = Split(Place, ";")
                For r = LBound(placeArray()) To UBound(placeArray())
                    If placeArray(r) = "" Then
                        subjectPlaceString = subjectPlaceString & ","
                    Else
                        subjectPlaceString = subjectPlaceString & Chr(34) & Trim(placeArray(r)) & Chr(34) & ","
                    End If
                Next r
            End If

            For s = r To 5
                subjectPlaceString = subjectPlaceString & ","
            Next s

            'Process repeating prod places
            prodPlace = Cells(i, 15)
            If InStr(prodPlace, ";") = 0 Then
                If prodPlace = "N/A" Or prodPlace = "Unknown" Or prodPlace = "-" Then
                    prodPlace = ""
                End If
                prodPlaceString = Chr(34) & prodPlace & Chr(34)
                v = 0
            Else
                prodPlaceArray() = Split(prodPlace, ";")
                For v = LBound(prodPlaceArray()) To UBound(prodPlaceArray())
                    If prodPlaceArray(v) = "" Then
                        prodPlaceString = prodPlaceString & ","
                    Else
                        prodPlaceString = prodPlaceString & Chr(34) & Trim(prodPlaceArray(v)) & Chr(34) & ","
                    End If
                Next v
            End If

            For w = v To 4
                prodPlaceString = prodPlaceString & ","
            Next w

            'Generate summary creator in correct format
            creatorName = Cells(i, 16)
            If InStr(creatorName, ";") = 0 Then
                'If creatorName = "N/A" Or creatorName = "Unknown" Or creatorName = "-" Then
                '    creatorName = ""
                'End If
                If InStr(creatorName, ",") = 0 Then
                    summaryCreator = creatorName
                Else
                    creatorArray() = Split(creatorName, ",")
                    summaryCreator = Trim(creatorArray(1) & " " & creatorArray(0))
                End If

                creatorNameString = Chr(34) & creatorName & Chr(34)
                summaryCreatorString = Chr(34) & summaryCreator & Chr(34)
                y = 0
            Else
                creatorNameArray() = Split(creatorName, ";")
                For y = LBound(creatorNameArray()) To UBound(creatorNameArray())
                    If creatorNameArray(y) = "" Then
                        creatorNameString = creatorNameString & ","
                    Else
                        creatorNameString = creatorNameString & Chr(34) & Trim(creatorNameArray(y)) & Chr(34) & ","
                    End If

                    If InStr(creatorNameArray(y), ",") = 0 Then
                        summaryCreator = creatorNameArray(y)
                    Else
                        creatorArray() = Split(creatorNameArray(y), ",")
                        summaryCreator = Trim(creatorArray(1) & " " & creatorArray(0))
                        summaryCreatorString = summaryCreatorString & Chr(34) & summaryCreator & Chr(34) & ","
                    End If
                Next y
            End If

            For Z = y To 2
                creatorNameString = creatorNameString & ","
                summaryCreatorString = summaryCreatorString & ","
            Next Z

            'Process out nulls

            If Cells(i, 25) = "N/A" Or Cells(i, 25) = "Unknown" Or Cells(i, 25) = "-" Then
                subjectEventString = ""
            Else
                subjectEventString = Cells(i, 25)
            End If

            If Cells(i, 26) = "N/A" Or Cells(i, 26) = "Unknown" Or Cells(i, 26) = "-" Then
                reproNotes = ""
            Else
                reproNotes = Cells(i, 26)
            End If

            If Cells(i, 21) = "N/A" Or Cells(i, 21) = "Unknown" Or Cells(i, 21) = "-" Then
                descriptionString = ""
            Else
                descriptionString = Cells(i, 21)
            End If

            If Cells(i, 14) = "N/A" Or Cells(i, 14) = "Unknown" Or Cells(i, 14) = "-" Then
                dateString = ""
            Else
                dateString = Cells(i, 14)
            End If

            'Assign data to data lines
dataLine1 = Left(Cells(i, 8), 7) & ",,,," & Chr(34) & Cells(i, 12) & Chr(34) & "," & Chr(34) & "University of Edinburgh" & Chr(34) & ",,," & Chr(34) & Cells(i, 13) & Chr(34) & ",,,,,,," & Chr(34) & Cells(i, 13) & Chr(34) & "," & Chr(34) & Cells(i, 17) & Chr(34) & "," & Cells(i, 18) & "," & creatorNameString & creatorNameString & ",,,,,,,,,,,," & summaryCreatorString & ",,,,,,,," & dateString & ",,,," & Chr(34) & descriptionString & Chr(34) & ",,,,,,,,,,,,,,,,," & prodPlaceString & Chr(34) & Cells(i, 22) & Chr(34) & ",,,,,,,,," & subjectPersonString & "," & subjectPlaceString & Chr(34) & subjectEventString & Chr(34) & ",," & subjectCatString & ",,,,," & Chr(34) & Cells(i, 13) & Chr(34) & "," & Chr(34) & Cells(i, 17) & Chr(34) & ",,,,,," & Chr(34) & copyrightstring & Chr(34) & ",,,,,,,,"
dataLine2 = reproRecordId & "," & reproLinkId & ",Cropped TIFF,,,," & Chr(34) & reproNotes & Chr(34) & "," & reproTitle & ",,,Digital Imaging Unit,,Creator,," & Chr(34) & Cells(i, 22) & Chr(34) & "," & reproLinkId & ",,,,,," & Chr(34) & reprocopystring & Chr(34) & ",," & publicStatus
dataLine = dataLine1 & dataLine2

            'Write to file objects
            If shortcoll = "wmm" Then
                If wmmcount = 0 Then
                    'Print #1, Header
                    fwmm.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fwmm.WriteText dataLine & Chr(10)
                wmmarray(wmmcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                wmmcount = wmmcount + 1
            End If

            If shortcoll = "uoe" Then
                If uoecount = 0 Then
                    'Print #1, Header
                    fuoe.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fuoe.WriteText dataLine & Chr(10)
                uoearray(uoecount) = Cells(i, 8) & " ; " & Cells(i, 11)
                uoecount = uoecount + 1
            End If

            If shortcoll = "gal" Then
                If galcount = 0 Then
                    'Print #1, Header
                    fgal.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fgal.WriteText dataLine & Chr(10)
                galarray(galcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                galcount = galcount + 1
            End If

            If shortcoll = "lai" Then
                If laicount = 0 Then
                    'Print #1, Header
                    flai.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                flai.WriteText dataLine & Chr(10)
                laiarray(laicount) = Cells(i, 8) & " ; " & Cells(i, 11)
                laicount = laicount + 1
            End If

            If shortcoll = "ecr" Then
                If ecrcount = 0 Then
                    'Print #1, Header
                    fecr.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fecr.WriteText dataLine & Chr(10)
                ecrarray(ecrcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                ecrcount = ecrcount + 1

            End If

            If shortcoll = "inc" Then
                If inccount = 0 Then
                    'Print #1, Header
                    finc.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                finc.WriteText dataLine & Chr(10)
                incarray(inccount) = Cells(i, 8) & " ; " & Cells(i, 11)
                inccount = inccount + 1

            End If

            If shortcoll = "sss" Then
                If ssscount = 0 Then
                    'Print #1, Header
                    fsss.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fsss.WriteText dataLine & Chr(10)
                sssarray(ssscount) = Cells(i, 8) & " ; " & Cells(i, 11)
                ssscount = ssscount + 1

            End If

            If shortcoll = "ros" Then
                If roscount = 0 Then
                    'Print #1, Header
                    fros.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fros.WriteText dataLine & Chr(10)
                rosarray(roscount) = Cells(i, 8) & " ; " & Cells(i, 11)
                roscount = roscount + 1

            End If

            If shortcoll = "sal" Then
                If salcount = 0 Then
                    'Print #1, Header
                    fsal.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fsal.WriteText dataLine & Chr(10)
                salarray(salcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                salcount = salcount + 1

            End If

            If shortcoll = "hil" Then
                If hilcount = 0 Then
                    'Print #1, Header
                    fhil.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fhil.WriteText dataLine & Chr(10)
                hilarray(hilcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                hilcount = hilcount + 1

            End If

            If shortcoll = "ard" Then
                If ardcount = 0 Then
                    'Print #1, Header
                    fard.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fard.WriteText dataLine & Chr(10)
                ardarray(ardcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                ardcount = ardcount + 1

            End If

            If shortcoll = "sha" Then
                If shacount = 0 Then
                    'Print #1, Header
                    fsha.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fsha.WriteText dataLine & Chr(10)
                shaarray(shacount) = Cells(i, 8) & " ; " & Cells(i, 11)
                shacount = shacount + 1
            End If

            If shortcoll = "new" Then
                If newcount = 0 Then
                    'Print #1, Header
                    fnew.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fnew.WriteText dataLine & Chr(10)
                newarray(newcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                newcount = newcount + 1
            End If

            If shortcoll = "ori" Then
                If oricount = 0 Then
                    'Print #1, Header
                    fori.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fori.WriteText dataLine & Chr(10)
                oriarray(oricount) = Cells(i, 8) & " ; " & Cells(i, 11)
                oricount = oricount + 1
            End If

            If shortcoll = "tho" Then
                If thocount = 0 Then
                    'Print #1, Header
                    ftho.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                ftho.WriteText dataLine & Chr(10)
                thoarray(thocount) = Cells(i, 8) & " ; " & Cells(i, 11)
                thocount = thocount + 1
            End If

            If shortcoll = "geo" Then
                If geocount = 0 Then
                    'Print #1, Header
                    fgeo.WriteText Header & Chr(10)
                End If
                'Print #1, dataLine
                fgeo.WriteText dataLine & Chr(10)
                geoarray(geocount) = Cells(i, 8) & " ; " & Cells(i, 11)
                geocount = geocount + 1
            End If

             Cells(i, 39) = "V"
           End If


         Next
         'Start after the BOM chars, copy to bin and then copy to csv

         If wmmcount > 0 Then
            fwwm.Position = 3
            fwwm.CopyTo fwmmb
            fwwm.Flush
            fwwm.Close
            fwmmb.SaveToFile wmmcsv, 2
         Else
            fwmm.Close
            fwmmb.Close
         End If

         If uoecount > 0 Then
            fuoe.Position = 3
            fuoe.CopyTo fuoeb
            fuoe.Flush
            fuoe.Close
            fuoeb.SaveToFile uoecsv, 2
         Else
            fuoe.Close
            fuoeb.Close
         End If

         If galcount > 0 Then
            fgal.Position = 3
            fgal.CopyTo fgalb
            fgal.Flush
            fgal.Close
            fgalb.SaveToFile galcsv, 2
         Else
            fgal.Close
            fgalb.Close
         End If

         If ssscount > 0 Then
            fsss.Position = 3
            fsss.CopyTo fsssb
            fsss.Flush
            fsss.Close
            fsssb.SaveToFile ssscsv, 2
         Else
            fsss.Close
            fsssb.Close
         End If

         If inccount > 0 Then
            finc.Position = 3
            finc.CopyTo fincb
            finc.Flush
            finc.Close
            fincb.SaveToFile inccsv, 2
         Else
            finc.Close
            fincb.Close
         End If

         If roscount > 0 Then
            fros.Position = 3
            fros.CopyTo frosb
            fros.Flush
            fros.Close
            frosb.SaveToFile roscsv, 2
         Else
            fros.Close
            frosb.Close
         End If

         If laicount > 0 Then
            flai.Position = 3
            flai.CopyTo flaib
            flai.Flush
            flai.Close
            flaib.SaveToFile laicsv, 2
         Else
            flai.Close
            flaib.Close
         End If

         If ecrcount > 0 Then
            fecr.Position = 3
            fecr.CopyTo fecrb
            fecr.Flush
            fecr.Close
            fecrb.SaveToFile ecrcsv, 2
         Else
            fecr.Close
            fecrb.Close
         End If

         If shacount > 0 Then
            fsha.Position = 3
            fsha.CopyTo fshab
            fsha.Flush
            fsha.Close
            fshab.SaveToFile shacsv, 2
         Else
            fsha.Close
            fshab.Close
         End If

         If thocount > 0 Then
            ftho.Position = 3
            ftho.CopyTo fthob
            ftho.Flush
            ftho.Close
            fthob.SaveToFile thocsv, 2
         Else
            ftho.Close
            fthob.Close
         End If

         If newcount > 0 Then
            fnew.Position = 3
            fnew.CopyTo fnewb
            fnew.Flush
            fnew.Close
            fnewb.SaveToFile newcsv, 2
         Else
            fnew.Close
            fnewb.Close
         End If

         If oricount > 0 Then
            fori.Position = 3
            fori.CopyTo forib
            fori.Flush
            fori.Close
            forib.SaveToFile oricsv, 2
         Else
            fori.Close
            forib.Close
         End If

         If hilcount > 0 Then
            fhil.Position = 3
            fhil.CopyTo fhilb
            fhil.Flush
            fhil.Close
            fhilb.SaveToFile hilcsv, 2
         Else
            fhil.Close
            fhilb.Close
         End If

         If ardcount > 0 Then
            fard.Position = 3
            fard.CopyTo fardb
            fard.Flush
            fard.Close
            fardb.SaveToFile ardcsv, 2
         Else
            fard.Close
            fardb.Close
         End If

         If geocount > 0 Then
            fgeo.Position = 3
            fgeo.CopyTo fgeob
            fgeo.Flush
            fgeo.Close
            fgeob.SaveToFile geocsv, 2
         Else
            fgeo.Close
            fgeob.Close
         End If

         If salcount > 0 Then
            fsal.Position = 3
            fsal.CopyTo fsalb
            fsal.Flush
            fsal.Close
            fsalb.SaveToFile salcsv, 2
         Else
            fsal.Close
            fsalb.Close
         End If

         i = 0

         If wmmcount > 0 Then
            Print #99, wmmcoll
            Print #99, "===================="
            For i = 0 To wmmcount
                Print #99, wmmarray(i)
            Next
        End If

        i = 0

        If uoecount > 0 Then
            Print #99, uoecoll
            Print #99, "===================="
            For i = 0 To uoecount
                Print #99, uoearray(i)
            Next
        End If

        i = 0

        If galcount > 0 Then
            Print #99, galcoll
            Print #99, "===================="
            For i = 0 To galcount
                Print #99, galarray(i)
            Next
        End If


        i = 0

        If laicount > 0 Then
            Print #99, laicoll
            Print #99, "===================="
            For i = 0 To laicount
                Print #99, laiarray(i)
            Next
        End If

        i = 0

        If ecrcount > 0 Then
            Print #99, ecrcoll
            Print #99, "===================="
            For i = 0 To ecrcount
                Print #99, ecrarray(i)
            Next
        End If

        i = 0

        If roscount > 0 Then
            Print #99, roscoll
            Print #99, "===================="
            For i = 0 To roscount
                Print #99, rosarray(i)
            Next
        End If

        i = 0

        If ssscount > 0 Then
            Print #99, ssscoll
            Print #99, "===================="
            For i = 0 To ssscount
                Print #99, sssarray(i)
            Next
        End If

        i = 0

        If inccount > 0 Then
            Print #99, inccoll
            Print #99, "===================="
            For i = 0 To inccount
                Print #99, incarray(i)
            Next
        End If

        i = 0

        If shacount > 0 Then
            Print #99, shacoll
            Print #99, "===================="
            For i = 0 To shacount
                Print #99, shaarray(i)
            Next
        End If

        i = 0

        If oricount > 0 Then
            Print #99, oricoll
            Print #99, "===================="
            For i = 0 To oricount
                Print #99, oriarray(i)
            Next
        End If

        i = 0

        If newcount > 0 Then
            Print #99, newcoll
            Print #99, "===================="
            For i = 0 To newcount
                Print #99, newarray(i)
            Next
        End If

        i = 0

        If thocount > 0 Then
            Print #99, thocoll
            Print #99, "===================="
            For i = 0 To thocount
                Print #99, thoarray(i)
            Next
        End If

        i = 0

        If salcount > 0 Then
            Print #99, salcoll
            Print #99, "===================="
            For i = 0 To salcount
                Print #99, salarray(i)
            Next
        End If

        i = 0

        If hilcount > 0 Then
            Print #99, hilcoll
            Print #99, "===================="
            For i = 0 To hilcount
                Print #99, hilarray(i)
            Next
        End If

        i = 0

        If ardcount > 0 Then
            Print #99, ardcoll
            Print #99, "===================="
            For i = 0 To ardcount
                Print #99, ardarray(i)
            Next
        End If

        i = 0

        If geocount > 0 Then
            Print #99, geocoll
            Print #99, "===================="
            For i = 0 To geocount
                Print #99, geoarray(i)
            Next
        End If
        'Close #1
        'Close #2
        'Close #3
        'Close #4
        'Close #5
        'Close #6
        'Close #7
        'Close #8
        'Close #9
        'Close #10
        'Close #11
        'Close #12
        'Close #13
        'Close #14
        'Close #15
        'Close #16
        Close #99

        MsgBox "Ended!"


End Sub

Sub Button2_Click()
MsgBox "Hello!"

    Set oWorksheet = ThisWorkbook.Worksheets(1)
    sName = oWorksheet.Name
    MsgBox oWorksheet.Name

    lCols = oWorksheet.Columns.Count

    lRows = oWorksheet.Rows.Count

    execdir = "T:\diu\Worksheets\"
    For i = 5 To 9
        If Cells(i, 30) = "R" Then
            folder = Left(Cells(i, 8), 4) & "000-" & Left(Cells(i, 8), 4) & "999"

            copycmd = "T:\diu\Worksheets\copy" & Cells(i, 8) & ".bat"
            Open copycmd For Output Lock Write As #1

            Print #1, "copy T:\diu\Crops\" & folder & "\testing\" & Cells(i, 8) & "m.tif " & Chr(34) & "T:\diu\Crops\TIFFs" & Chr(34) & "> " & Chr(34) & "T:\diu\Crops\error1" & Cells(i, 8) & ".txt" & Chr(34) & " 2>&1"
            Close #1

            retval1 = Shell(Chr(34) & copycmd & Chr(34), vbNormalFocus)

            Cells(i, 30) = "C"

        End If
    Next


End Sub

Sub Embed()
MsgBox "Hello!"

    Set oWorksheet = ThisWorkbook.Worksheets(1)
    sName = oWorksheet.Name
    MsgBox oWorksheet.Name

    lCols = oWorksheet.Columns.Count

    lRows = oWorksheet.Rows.Count

    execdir = "T:\diu\Worksheets\"
    MsgBox execdir
    For i = 5 To 2000
        If Cells(i, 31) = "R" Then
            folder = Left(Cells(i, 8), 4) & "000-" & Left(Cells(i, 8), 4) & "999\"
            imageNo = Left(Cells(i, 8), 7)
            embedcmd = "T:\diu\Worksheets\embed\" & imageNo & ".bat"
            Open embedcmd For Output Lock Write As #1
            Select Case Cells(i, 10)
                Case "UoE-Y"
                    copyrightstring = "Digital Image: Copyright The University of Edinburgh. Original: Copyright The University of Edinburgh. Free use."
                Case "UoE-N"
                    copyrightstring = "Digital Image: Copyright The University of Edinburgh. Original: Copyright The University of Edinburgh. Not for Public Access."
                Case "Orphan"
                    copyrightstring = "Digital Image: Copyright The University of Edinburgh. Original: Copyright unknown, orphan work."
                Case "UoE&A-Y"
                    copyrightstring = "Digital Image: Copyright The University of Edinburgh. Original: Copyright in the original currently rests with the creator, their estate, heirs or assignees. Permission has been granted for specific use by the University of Edinburgh."
                Case "UoE&A-N"
                    copyrightstring = "Digital Image: Copyright The University of Edinburgh. Original: Copyright in the original currently rests with the creator, their estate, heirs or assignees. Permission has not been granted for  use by the University of Edinburgh (other than those deemed 'Fair Dealing such as educational, personal and non commercial research - unless otherwise stated)."
                Case "DataP"
                    copyrightstring = "Digital Image: Copyright The University of Edinburgh. Original: Copyright in the original may be University of Edinburgh or rest elsewhere. Data Protection restrictions."
                Case "Loan"
                    copyrightstring = "Digital Image: Copyright The University of Edinburgh. Original: Copyright in the original currently rests with the creator, their estate, heirs or assignees. Permission has not been granted for  use by the University of Edinburgh (other than those deemed 'Fair Dealing such as educational, personal and non commercial research - unless otherwise stated)."
               Case "OC"
                    copyrightstring = "Digital Image: Copyright The University of Edinburgh. Original: Out of Copyright."
                Case "LHSA"
                    copyrightstring = "Copyright and Data Protection Restrictions. Not for Public Access."
                Case Else
                    copyrightstring = "No copyright information available."
            End Select

            titleString = "Title: " & Cells(i, 13) & "; Author: " & Cells(i, 16) & "; Page No: " & Cells(i, 17) & "; Shelfmark: " & Cells(i, 12) & "; Date: " & Cells(i, 14)
            descString = "Collection: " & Cells(i, 22) & "; Persons: " & Cells(i, 23) & "; Event: " & Cells(i, 25) & "; Place: " & Cells(i, 20) & "; Category: " & Cells(i, 19) & "; Description: " & Cells(i, 21)
            city = "Edinburgh"
            postcode = "EH8 9LJ"
            extrAdr = "Centre for Research Collections, The University of Edinburgh, George Square"
            country = "UK"
            tel = "0131 650 8379"
            Email = "is-crc@ed.ac.uk"
            diu = "Digital Imaging Unit"
            URL = "http://www.lib.ed.ac.uk/resources/collections/crc/index.html"

            Print #1, "cd /D T: > " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>&1"
            Print #1, "cd " & Chr(34) & "T:\diu\Worksheets\exiv2" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "echo " & Chr(34) & "directory is: " & Chr(34) & "%cd% >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Iptc.Application2.Headline String " & imageNo & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Iptc.Application2.Copyright String " & copyrightstring & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Xmp.dc.creator XmpSeq " & diu & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Iptc.Application2.Caption String " & descString & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Iptc.Application2.ObjectName String " & titleString & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrCity XmpText " & city & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrPcode XmpText " & postcode & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrExtadr XmpText  " & extrAdr & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrCtry XmpText " & country & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiTelWork XmpText " & tel & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiEmailWork XmpText " & Email & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M" & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiUrlWork XmpText " & URL & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"

            Close #1

            retval1 = Shell(Chr(34) & embedcmd & Chr(34), vbNormalFocus)

            Cells(i, 31) = "E"

        End If
    Next


End Sub

Sub Rename()
MsgBox "Hello!"

    Set oWorksheet = ThisWorkbook.Worksheets(1)
    sName = oWorksheet.Name
    MsgBox oWorksheet.Name

    lCols = oWorksheet.Columns.Count

    lRows = oWorksheet.Rows.Count

    execdir = "T:\diu\Worksheets\"
    For i = 5 To 2000
        If Cells(i, 31) = "E" Then
            folder = Left(Cells(i, 8), 4) & "000-" & Left(Cells(i, 8), 4) & "999\"
            imageNo = Left(Cells(i, 8), 7)
            copybackcmd = "T:\diu\Worksheets\copyback\" & imageNo & ".bat"
            Open copybackcmd For Output Lock Write As #1

            Print #1, "move T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif*  T:\diu\Crops\" & folder & "Process\" & imageNo & "c.tif"
            'Print #1, "copy T:\diu\Crops\" & folder & "Process\" & imageNo & "c.tif*  T:\diu\Crops\" & folder & imageNo & "c.tif"

            Close #1

            retval1 = Shell(Chr(34) & copybackcmd & Chr(34), vbNormalFocus)

            Cells(i, 31) = "X"

        End If
    Next


End Sub




