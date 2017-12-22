Function specialChars(ByVal textValue As String) As String
    specialChars = Replace(textValue, "&", "&amp;")
    specialChars = Replace(specialChars, "<", "&lt;")
    specialChars = Replace(specialChars, ">", "&gt;")
End Function

Sub CreateXML()
    MsgBox "Howdy DIU! I am running CreateXML"

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
    Dim anaarray(1000) As String
    Dim maparray(1000) As String
    Dim walarray(1000) As String

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
    Dim fana As Object
    Set fana = CreateObject("ADODB.Stream")
    Dim fmap As Object
    Set fmap = CreateObject("ADODB.Stream")
    Dim fwal As Object
    Set fwal = CreateObject("ADODB.Stream")

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
    Dim fanab As Object
    Set fanab = CreateObject("ADODB.Stream")
    Dim fmapb As Object
    Set fmapb = CreateObject("ADODB.Stream")
    Dim fwalb As Object
    Set fwalb = CreateObject("ADODB.Stream")

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
    fana.Type = 2
    fana.Charset = "utf-8"
    fana.Open
    fmap.Type = 2
    fmap.Charset = "utf-8"
    fmap.Open
    fwal.Type = 2
    fwal.Charset = "utf-8"
    fwal.Open

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
    fanab.Type = 1
    fanab.Mode = 3
    fanab.Open
    fmapb.Type = 1
    fmapb.Mode = 3
    fmapb.Open
    fwalb.Type = 1
    fwalb.Mode = 3
    fwalb.Open

    'Declare final file names
    wmmxml = "T:\diu\Worksheets\csv\WMM.xml"
    galxml = "T:\diu\Worksheets\csv\GAL.xml"
    laixml = "T:\diu\Worksheets\csv\LAI.xml"
    orixml = "T:\diu\Worksheets\csv\ORI.xml"
    newxml = "T:\diu\Worksheets\csv\NEW.xml"
    ardxml = "T:\diu\Worksheets\csv\ARD.xml"
    hilxml = "T:\diu\Worksheets\csv\HIL.xml"
    salxml = "T:\diu\Worksheets\csv\SAL.xml"
    sssxml = "T:\diu\Worksheets\csv\SSS.xml"
    shaxml = "T:\diu\Worksheets\csv\SHA.xml"
    thoxml = "T:\diu\Worksheets\csv\THO.xml"
    incxml = "T:\diu\Worksheets\csv\INC.xml"
    uoexml = "T:\diu\Worksheets\csv\UOE.xml"
    rosxml = "T:\diu\Worksheets\csv\ROS.xml"
    ecrxml = "T:\diu\Worksheets\csv\ECR.xml"
    geoxml = "T:\diu\Worksheets\csv\GEO.xml"
    anaxml = "T:\diu\Worksheets\csv\ANA.xml"
    mapxml = "T:\diu\Worksheets\csv\MAP.xml"
    walxml = "T:\diu\Worksheets\csv\WAL.xml"

    summfile = "T:\diu\Worksheets\csv\summary.txt"

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
    anacount = 0
    mapcount = 0
    walcount = 0

     Close #99
    Open summfile For Output Lock Write As #99

    'Process all rows
    For i = 5 To lRows


        processed = Cells(i, 40)
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

        'If ready to process act, otherwise bypass
        If processed = "X" Then
            coll = Cells(i, 22)
            If coll <> "" Then
                badcoll = "N"
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
                    Case "Roslin Institute"
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
                    Case "Anatomy"
                        anacoll = coll
                        shortcoll = "ana"
                    Case "Maps"
                        mapcoll = coll
                        shortcoll = "map"
                    Case "Walter Scott Image Collection"
                        walcoll = coll
                        shortcoll = "wal"
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
                holdingInstitution = fields & "holding_institution" & fieldcvalues & "University of Edinburgh" & valueefielde
                reproCreatorName = entitys & "repro_creator" & entitycfieldst & "repro_creator_name" & fieldcvalues & "Digital Imaging Unit" & valueefielde
                reproCreatorRoleDescription = fields & "repro_creator_role_description" & fieldcvalues & "Creator" & valueefieldeentitye

                'Don't process if no collection
                If badcoll = "Y" Then
                   goodrecord = "N"
                   MsgBox "major problem- mis-spelt or ineligible Collection!" & " " & coll & " " & Cells(i, 8) & Cells(i, 9)
                End If

                'Don't process if no title
                If Cells(i, 13) = "" Then
                   goodrecord = "N"
                   MsgBox "major problem- no Title!" & " " & coll & " " & Cells(i, 8) & Cells(i, 9)
                Else
                   titleString = specialChars(Cells(i, 13))
                End If

                'If no work record ID (in column 8 OR 9, don't process)
                If Cells(i, 8) = "" Then
                    workString = Left(Cells(i, 9), 7)
                Else
                    workString = Left(Cells(i, 8), 7)
                End If

                If workString = "" Then
                   goodrecord = "N"
                   MsgBox "major problem- no image Id!" & " " & coll & " " & " " & Cells(i, 13) & " " & Cells(i, 17)
                End If

                If goodrecord = "Y" Then
                    'Get copyright & licence text
                    Select Case Cells(i, 10)
                        Case "UoE-Y"
                            rightsStatement = entitys & "rights" & entitycfieldst & "work_rights_statement" & fieldcvalues & "Copyright The University of Edinburgh. Free use." & valueefieldeentitye
                            reproRightsStatement = entitys & "repro_rights" & entitycfieldst & "repro_rights_statement" & fieldcvalues & "Copyright The University of Edinburgh." & valueefieldeentitye
                            licenceString = entitys & "licence" & entitycfieldst & "licence" & fieldcvalues & ccby & valueefieldeentitye
                        Case "UoE-N"
                            rightsStatement = entitys & "rights" & entitycfieldst & "work_rights_statement" & fieldcvalues & "Copyright The University of Edinburgh. Not for Public Access." & valueefieldeentitye
                            reproRightsStatement = entitys & "repro_rights" & entitycfieldst & "repro_rights_statement" & fieldcvalues & "Copyright The University of Edinburgh." & valueefieldeentitye
                            licenceString = ""
                        Case "Orphan"
                            rightsStatement = entitys & "rights" & entitycfieldst & "work_rights_statement" & fieldcvalues & "Copyright unknown, orphan work." & valueefieldeentitye
                            reproRightsStatement = entitys & "repro_rights" & entitycfieldst & "repro_rights_statement" & fieldcvalues & "Copyright The University of Edinburgh." & valueefieldeentitye
                            licenceString = entitys & "licence" & entitycfieldst & "licence" & fieldcvalues & ccby & valueefieldeentitye
                        Case "UoE&A-Y"
                            rightsStatement = entitys & "rights" & entitycfieldst & "work_rights_statement" & fieldcvalues & "Copyright in the original currently rests with the creator, their estate, heirs or assignees. Permission has been granted for specific use by the University of Edinburgh." & valueefieldeentitye
                            reproRightsStatement = entitys & "repro_rights" & entitycfieldst & "repro_rights_statement" & fieldcvalues & "Copyright The University of Edinburgh." & valueefieldeentitye
                            licenceString = entitys & "licence" & entitycfieldst & "licence" & fieldcvalues & ccbyncnd & valueefieldeentitye
                        Case "UoE&A-N"
                            rightsStatement = entitys & "rights" & entitycfieldst & "work_rights_statement" & fieldcvalues & "Copyright in the original currently rests with the creator, their estate, heirs or assignees. Permission has not been granted for use by the University of Edinburgh (other than those deemed 'Fair Dealing such as educational, personal and non commercial research - unless otherwise stated)." & valueefieldeentitye
                            reproRightsStatement = entitys & "repro_rights" & entitycfieldst & "repro_rights_statement" & fieldcvalues & "Copyright The University of Edinburgh." & valueefieldeentitye
                            licenceString = ""
                        Case "DataP"
                            rightsStatement = entitys & "rights" & entitycfieldst & "work_rights_statement" & fieldcvalues & "Copyright in the original may be University of Edinburgh or rest elsewhere. Data Protection restrictions." & valueefieldeentitye
                            reproRightsStatement = entitys & "repro_rights" & entitycfieldst & "repro_rights_statement" & fieldcvalues & "Copyright The University of Edinburgh." & valueefieldeentitye
                            licenceString = ""
                        Case "Loan"
                            rightsStatement = entitys & "rights" & entitycfieldst & "work_rights_statement" & fieldcvalues & "Copyright in the original currently rests with the creator, their estate, heirs or assignees. Permission has not been granted for  use by the University of Edinburgh (other than those deemed 'Fair Dealing such as educational, personal and non commercial research - unless otherwise stated)." & valueefieldeentitye
                            reproRightsStatement = entitys & "repro_rights" & entitycfieldst & "repro_rights_statement" & fieldcvalues & "Copyright The University of Edinburgh." & valueefieldeentitye
                            licenceString = ""
                        Case "OC"
                            rightsStatement = entitys & "rights" & entitycfieldst & "work_rights_statement" & fieldcvalues & "Out of Copyright." & valueefieldeentitye
                            reproRightsStatement = entitys & "repro_rights" & entitycfieldst & "repro_rights_statement" & fieldcvalues & "Copyright The University of Edinburgh." & valueefieldeentitye
                            licenceString = entitys & "licence" & entitycfieldst & "licence" & fieldcvalues & ccby & valueefieldeentitye
                         Case "LHSA"
                            rightsStatement = entitys & "rights" & entitycfieldst & "work_rights_statement" & fieldcvalues & "Copyright and Data Protection Restrictions. Not for Public Access." & valueefieldeentitye
                            reproRightsStatement = entitys & "repro_rights" & entitycfieldst & "repro_rights_statement" & fieldcvalues & "Copyright and Data Protection Restrictions. Not for Public Access." & valueefieldeentitye
                            licenceString = ""
                        Case Else
                            rightsStatement = entitys & "rights" & entitycfieldst & "work_rights_statement" & fieldcvalues & "No copyright information available." & valueefieldeentitye
                            reproRightsStatement = entitys & "repro_rights" & entitycfieldst & "repro_rights_statement" & fieldcvalues & "No copyright information available." & valueefieldeentitye
                            licenceString = ""
                    End Select

                    'Process fields by column
                    If Cells(i, 17) = "" Then
                        subsetIndex = ""
                        relatedWorkVolPageNo = entitye
                        reproTitle = entitys & "repro_title" & entitycfieldst & "repro_title" & fieldcvalues & titleString & valueefieldeentitye
                    Else
                        pageString = specialChars(Cells(i, 17))
                        subsetIndex = fields & "work_subset_index" & fieldcvalues & pageString & valueefielde
                        relatedWorkVolPageNo = fields & "work_source_page_no" & fieldcvalues & pageString & valueefieldeentitye
                        reproTitle = entitys & "repro_title" & entitycfieldst & "repro_title" & fieldcvalues & titleString & ", " & pageString & valueefieldeentitye
                    End If

                    reproRecordId = entitys & "repro_record" & entitycfieldst & "repro_record_id" & fieldcvalues & workString & "c.tif" & valueefielde
                    reproLinkId = fields & "repro_link_id" & fieldcvalues & workString & "c" & valueefielde
                    workRecordId = fields & "work_record_id" & fieldcvalues & workString & valueefielde
                    reproIdNumber = entitys & "repro_id_number" & entitycfieldst & "repro_id_number" & fieldcvalues & workString & "c" & valueefieldeentitye

                    Title = entitys & "title" & entitycfieldst & "work_title" & fieldcvalues & titleString & valueefieldeentitye
                    Subset = entitys & "subset" & entitycfieldst & "work_subset" & fieldcvalues & titleString & valueefielde
                    relatedWorkTitle = entitys & "related_work" & entitycfieldst & "work_source" & fieldcvalues & titleString & valueefielde

                    If Cells(i, 12) = "" Then
                        MsgBox "major problem- no Shelfmark!" & coll & " " & Cells(i, 8) & Cells(i, 9)
                        shelfmark = ""
                    Else
                        shelfmark = entitys & "id_number" & entitycfieldst & "work_shelfmark" & fieldcvalues & specialChars(Cells(i, 12)) & valueefielde
                    End If

                    If Cells(i, 18) = "" Then
                        sequence = entitye
                    Else
                        sequence = fields & "sequence" & fieldcvalues & Cells(i, 18) & valueefieldeentitye
                    End If

                    If Cells(i, 26) = "" Then
                        catalogueNumber = entitye
                    Else
                        catalogueNumber = fields & "work_catalogue_number" & fieldcvalues & specialChars(Cells(i, 26)) & valueefieldeentitye
                    End If

                    repository = entitys & "repository" & entitycfieldst & "work_repository" & fieldcvalues & Cells(i, 22) & valueefieldeentitye
                    reproRepository = entitys & "repro_repository" & entitycfieldst & "repro_repository" & fieldcvalues & Cells(i, 22) & valueefieldeentitye

                    If Cells(i, 24) = "" Then
                        catalogueEntry = ""
                    Else
                        catString = Replace(Cells(i, 24), "&", "%26")
                        catalogueEntry = entitys & "navigation" & entitycfieldst & "catalogue_entry" & fieldcvalues & catString & valueefieldeentitye
                    End If

                    If Cells(i, 11) = "Y" Then
                        reproPublicationStatus = entitys & "repro_publication_status" & entitycfieldst & "repro_publication_status" & fieldcvalues & "Full Public Access" & valueefieldeentitye
                    Else
                        reproPublicationStatus = entitys & "repro_publication_status" & entitycfieldst & "repro_publication_status" & fieldcvalues & "No Access" & valueefieldeentitye
                    End If

                    If Cells(i, 25) = "N/A" Or Cells(i, 25) = "Unknown" Or Cells(i, 25) = "-" Or Cells(i, 25) = "" Then
                        subjectEvent = ""
                    Else
                        subjectEvent = entitys & "subject" & entitycfieldst & "work_subject_event" & fieldcvalues & specialChars(Cells(i, 25)) & valueefieldeentitye
                    End If

                    If Cells(i, 27) = "N/A" Or Cells(i, 27) = "Unknown" Or Cells(i, 27) = "-" Or Cells(i, 27) = "" Then
                        reproNotes = entitye
                    Else
                        reproNotes = fields & "repro_notes" & fieldcvalues & specialChars(Cells(i, 27)) & valueefieldeentitye
                    End If

                    If Cells(i, 21) = "N/A" Or Cells(i, 21) = "Unknown" Or Cells(i, 21) = "-" Or Cells(i, 21) = "" Then
                        Description = ""
                    Else
                        Description = entitys & "description" & entitycfieldst & "work_description" & fieldcvalues & specialChars(Cells(i, 21)) & valueefieldeentitye
                    End If

                    If Cells(i, 14) = "N/A" Or Cells(i, 14) = "Unknown" Or Cells(i, 14) = "-" Or Cells(i, 14) = "" Then
                        dateString = ""
                    Else
                        dateString = entitys & "dates" & entitycfieldst & "work_display_date" & fieldcvalues & specialChars(Cells(i, 14)) & valueefieldeentitye
                    End If

                    j = 0
                    'Process repeating category
                    Category = Cells(i, 19)
                    If Category = "" Then
                        allSubjectCats = ""
                    Else
                        If InStr(Category, ";") = 0 Then
                            If Category = "N/A" Or Category = "Unknown" Or Category = "-" Then
                                Category = ""
                                allSubjectCats = ""
                            Else
                                allSubjectCats = entitys & "subject" & entitycfieldst & "work_subject_class" & fieldcvalues & specialChars(Category) & valueefieldeentitye
                            End If
                        Else
                            categoryArray() = Split(Category, ";")
                            For j = LBound(categoryArray()) To UBound(categoryArray())
                                If categoryArray(j) = "" Then
                                    allSubjectCats = ""
                                Else
                                    subjectCatString = entitys & "subject" & entitycfieldst & "work_subject_class" & fieldcvalues & Trim(specialChars(categoryArray(j))) & valueefieldeentitye
                                    allSubjectCats = allSubjectCats & subjectCatString
                                End If
                            Next j
                        End If
                    End If

                    'Process repeating subject persons
                    k = 0
                    person = Cells(i, 23)
                    If person = "" Then
                        allSubjectPersons = ""
                    Else
                        If InStr(person, ";") = 0 Then
                            If person = "N/A" Or person = "Unknown" Or person = "-" Then
                                person = ""
                                allSubjectPersons = ""
                            Else
                                allSubjectPersons = entitys & "subject" & entitycfieldst & "work_subject_person" & fieldcvalues & specialChars(person) & valueefieldeentitye
                            End If
                        Else
                            personArray() = Split(person, ";")

                            For k = LBound(personArray()) To UBound(personArray())
                                If personArray(k) = "" Then
                                    allSubjectPersons = ""
                                Else
                                    subjectPersonString = entitys & "subject" & entitycfieldst & "work_subject_person" & fieldcvalues & Trim(specialChars(personArray(k))) & valueefieldeentitye
                                    allSubjectPersons = allSubjectPersons & subjectPersonString
                                End If
                            Next k
                        End If
                    End If

                    'Process repeating subject places

                    r = 0
                    place = Cells(i, 20)
                    If place = "" Then
                        allSubjectPlaces = ""
                    Else
                        If InStr(place, ";") = 0 Then
                            If place = "N/A" Or place = "Unknown" Or place = "-" Then
                                place = ""
                                allSubjectPlaces = ""
                            Else
                                allSubjectPlaces = entitys & "subject" & entitycfieldst & "work_subject_place" & fieldcvalues & specialChars(place) & valueefieldeentitye
                            End If
                        Else
                            placeArray() = Split(place, ";")
                            For r = LBound(placeArray()) To UBound(placeArray())
                                If placeArray(r) = "" Then
                                    allSubjectPlaces = ""
                                Else
                                    subjectPlaceString = entitys & "subject" & entitycfieldst & "work_subject_place" & fieldcvalues & Trim(specialChars(placeArray(r))) & valueefieldeentitye
                                    allSubjectPlaces = allSubjectPlaces & subjectPlaceString
                                End If
                            Next r
                        End If
                    End If

                    v = 0
                    'Process repeating prod places
                    prodPlace = Cells(i, 15)
                    If prodPlace = "" Then
                        allProdPlaces = ""
                    Else
                        If InStr(prodPlace, ";") = 0 Then
                           If prodPlace = "N/A" Or prodPlace = "Unknown" Or prodPlace = "-" Then
                               prodPlace = ""
                               allProdPlaces = ""
                           Else
                               allProdPlaces = entitys & "production_place" & entitycfieldst & "production_place" & fieldcvalues & specialChars(prodPlace) & valueefieldeentitye
                           End If
                        Else
                            prodPlaceArray() = Split(prodPlace, ";")
                            For v = LBound(prodPlaceArray()) To UBound(prodPlaceArray())
                                If prodPlaceArray(v) = "" Then
                                    allProdPlaces = ""
                                Else
                                    prodPlaceString = entitys & "production_place" & entitycfieldst & "production_place" & fieldcvalues & Trim(specialChars(prodPlaceArray(v))) & valueefieldeentitye
                                    allProdPlaces = allProdPlaces & prodPlaceString
                                End If
                            Next v
                        End If
                    End If

                    'Generate summary creator in correct format
                    y = 0
                    creatorName = Cells(i, 16)
                    If creatorName = "" Then
                        allCreators = ""
                    Else
                        If InStr(creatorName, ";") = 0 Then
                            If InStr(creatorName, ",") = 0 Then
                                summaryCreator = creatorName
                            Else
                                creatorNameBits() = Split(creatorName, ",")
                                summaryCreator = Trim(Trim(creatorNameBits(1)) & " " & Trim(creatorNameBits(0)))
                            End If
                            creatorString = entitys & "creator" & entitycfieldst & "work_creator_details" & fieldcvalues & specialChars(creatorName) & valueefielde
                            creatorNameString = fields & "work_creator_name" & fieldcvalues & specialChars(creatorName) & valueefielde
                            summaryCreatorString = fields & "summary_creator" & fieldcvalues & specialChars(summaryCreator) & valueefieldeentitye
                            allCreators = creatorString & creatorNameString & summaryCreatorString
                        Else
                            creatorNameArray() = Split(creatorName, ";")

                            For y = LBound(creatorNameArray()) To UBound(creatorNameArray())
                                If creatorNameArray(y) = "" Then
                                    allCreators = ""
                                Else
                                    creatorString = entitys & "creator" & entitycfieldst & "work_creator_details" & fieldcvalues & Trim(specialChars(creatorNameArray(y))) & valueefielde
                                    creatorNameString = fields & "work_creator_name" & fieldcvalues & Trim(specialChars(creatorNameArray(y))) & valueefielde
                                End If

                                If InStr(creatorNameArray(y), ",") = 0 Then
                                    summaryCreatorString = fields & "summary_creator" & fieldcvalues & Trim(specialChars(creatorNameArray(y))) & valueefieldeentitye
                                Else

                                    creatorNameBits() = Split(creatorNameArray(y), ",")
                                    summaryCreator = Trim(Trim(creatorNameBits(1)) & " " & Trim(creatorNameBits(0)))
                                    summaryCreatorString = fields & "summary_creator" & fieldcvalues & specialChars(summaryCreator) & valueefieldeentitye
                                End If
                                creatorBlock = creatorString & creatorNameString & summaryCreatorString
                                allCreators = allCreators & creatorBlock
                            Next y
                        End If
                    End If

                    'Build XML file
                    dataLine1 = workRecordId & licenceString & shelfmark & holdingInstitution & catalogueNumber & Title & Subset & subsetIndex & sequence & allCreators & dateString & Description & allProdPlaces & repository & allSubjectPersons & allSubjectPlaces & subjectEvent & allSubjectCats & relatedWorkTitle & relatedWorkVolPageNo & rightsStatement & catalogueEntry
                    dataLine2 = reproRecordId & reproLinkId & reproFileType & reproNotes & reproTitle & reproCreatorName & reproCreatorRoleDescription & reproRepository & reproIdNumber & reproRightsStatement & reproPublicationStatus
                    dataLine = dataLine1 & dataLine2

                    Header = "<?xml version=" & Chr(34) & "1.0" & Chr(34) & " encoding=" & Chr(34) & "UTF-8" & Chr(34) & "?>" & Chr(10) & "<recordList>" & Chr(10)
                    recordLine = "<record>" & Chr(10)
                    recordCloser = "</record>" & Chr(10)

                    'Write to file objects
                    If shortcoll = "wmm" Then
                        If wmmcount = 0 Then
                            fwmm.WriteText Header & Chr(10)
                        End If
                        fwmm.WriteText recordLine
                        fwmm.WriteText dataLine & Chr(10)
                        fwmm.WriteText recordCloser
                        wmmarray(wmmcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        wmmcount = wmmcount + 1
                    End If

                    If shortcoll = "geo" Then
                        If geocount = 0 Then
                            fgeo.WriteText Header & Chr(10)
                        End If
                        fgeo.WriteText recordLine
                        fgeo.WriteText dataLine & Chr(10)
                        fgeo.WriteText recordCloser
                        geoarray(geocount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        geocount = geocount + 1
                    End If

                    If shortcoll = "ori" Then
                        If oricount = 0 Then
                            fori.WriteText Header & Chr(10)
                        End If
                        fori.WriteText recordLine
                        fori.WriteText dataLine & Chr(10)
                        fori.WriteText recordCloser
                        oriarray(oricount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        oricount = oricount + 1
                    End If

                    If shortcoll = "tho" Then
                        If thocount = 0 Then
                            ftho.WriteText Header & Chr(10)
                        End If
                        ftho.WriteText recordLine
                        ftho.WriteText dataLine & Chr(10)
                        ftho.WriteText recordCloser
                        thoarray(thocount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        thocount = thocount + 1
                    End If

                    If shortcoll = "new" Then
                        If newcount = 0 Then
                            fnew.WriteText Header & Chr(10)
                        End If
                        fnew.WriteText recordLine
                        fnew.WriteText dataLine & Chr(10)
                        fnew.WriteText recordCloser
                        newarray(newcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        newcount = newcount + 1
                    End If

                    If shortcoll = "sha" Then
                        If shacount = 0 Then
                            fsha.WriteText Header & Chr(10)
                        End If
                        fsha.WriteText recordLine
                        fsha.WriteText dataLine & Chr(10)
                        fsha.WriteText recordCloser
                        shaarray(shacount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        shacount = shacount + 1
                    End If

                    If shortcoll = "ard" Then
                        If ardcount = 0 Then
                            fard.WriteText Header & Chr(10)
                        End If
                        fard.WriteText recordLine
                        fard.WriteText dataLine & Chr(10)
                        fard.WriteText recordCloser
                        ardarray(ardcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        ardcount = ardcount + 1
                    End If

                    If shortcoll = "hil" Then
                        If hilcount = 0 Then
                            fhil.WriteText Header & Chr(10)
                        End If
                        fhil.WriteText recordLine
                        fhil.WriteText dataLine & Chr(10)
                        fhil.WriteText recordCloser
                        hilarray(hilcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        hilcount = hilcount + 1
                    End If

                    If shortcoll = "sal" Then
                        If salcount = 0 Then
                            fsal.WriteText Header & Chr(10)
                        End If
                        fsal.WriteText recordLine
                        fsal.WriteText dataLine & Chr(10)
                        fsal.WriteText recordCloser
                        salarray(salcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        salcount = salcount + 1
                    End If

                    If shortcoll = "ros" Then
                        If roscount = 0 Then
                            fros.WriteText Header & Chr(10)
                        End If
                        fros.WriteText recordLine
                        fros.WriteText dataLine & Chr(10)
                        fros.WriteText recordCloser
                        rosarray(roscount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        roscount = roscount + 1
                    End If

                    If shortcoll = "sss" Then
                        If ssscount = 0 Then
                            fsss.WriteText Header & Chr(10)
                        End If
                        fsss.WriteText recordLine
                        fsss.WriteText dataLine & Chr(10)
                        fsss.WriteText recordCloser
                        sssarray(ssscount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        ssscount = ssscount + 1
                    End If

                    If shortcoll = "inc" Then
                        If inccount = 0 Then
                            finc.WriteText Header & Chr(10)
                        End If
                        finc.WriteText recordLine
                        finc.WriteText dataLine & Chr(10)
                        finc.WriteText recordCloser
                        incarray(inccount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        inccount = inccount + 1
                    End If

                    If shortcoll = "ecr" Then
                        If ecrcount = 0 Then
                            fecr.WriteText Header & Chr(10)
                        End If
                        fecr.WriteText recordLine
                        fecr.WriteText dataLine & Chr(10)
                        fecr.WriteText recordCloser
                        ecrarray(ecrcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        ecrcount = ecrcount + 1
                    End If

                    If shortcoll = "lai" Then
                        If laicount = 0 Then
                            flai.WriteText Header & Chr(10)
                        End If
                        flai.WriteText recordLine
                        flai.WriteText dataLine & Chr(10)
                        flai.WriteText recordCloser
                        laiarray(laicount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        laicount = laicount + 1
                    End If

                    If shortcoll = "gal" Then
                        If galcount = 0 Then
                            fgal.WriteText Header & Chr(10)
                        End If
                        fgal.WriteText recordLine
                        fgal.WriteText dataLine & Chr(10)
                        fgal.WriteText recordCloser
                        galarray(galcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        galcount = galcount + 1
                    End If

                    If shortcoll = "uoe" Then
                        If uoecount = 0 Then
                            fuoe.WriteText Header & Chr(10)
                        End If
                        fuoe.WriteText recordLine
                        fuoe.WriteText dataLine & Chr(10)
                        fuoe.WriteText recordCloser
                        uoearray(uoecount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        uoecount = uoecount + 1
                    End If

                    If shortcoll = "ana" Then
                        If anacount = 0 Then
                            fana.WriteText Header & Chr(10)
                        End If
                        fana.WriteText recordLine
                        fana.WriteText dataLine & Chr(10)
                        fana.WriteText recordCloser
                        anaarray(anacount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        anacount = anacount + 1
                    End If

                    If shortcoll = "map" Then
                        If mapcount = 0 Then
                            fmap.WriteText Header & Chr(10)
                        End If
                        fmap.WriteText recordLine
                        fmap.WriteText dataLine & Chr(10)
                        fmap.WriteText recordCloser
                        maparray(mapcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        mapcount = mapcount + 1
                    End If

                    If shortcoll = "wal" Then
                        If walcount = 0 Then
                            fwal.WriteText Header & Chr(10)
                        End If
                        fwal.WriteText recordLine
                        fwal.WriteText dataLine & Chr(10)
                        fwal.WriteText recordCloser
                        walarray(walcount) = Cells(i, 8) & " ; " & Cells(i, 11)
                        walcount = walcount + 1
                    End If

                     Cells(i, 40) = "V"


                End If
            Else
                MsgBox "major problem- no Collection!" & " " & coll & " " & Cells(i, 8) & Cells(i, 9)
            End If
         End If


         Next
         'Start after the BOM chars, copy to bin and then copy to csv

         If wmmcount > 0 Then
            fwmm.WriteText "</recordList>"
            fwmm.Position = 3
            fwmm.CopyTo fwmmb
            fwmm.Flush
            fwmm.Close
            fwmmb.SaveToFile wmmxml, 2
         Else
            fwmm.Close
            fwmmb.Close
         End If

         If uoecount > 0 Then
            fuoe.WriteText "</recordList>"
            fuoe.Position = 3
            fuoe.CopyTo fuoeb
            fuoe.Flush
            fuoe.Close
            fuoeb.SaveToFile uoexml, 2
         Else
            fuoe.Close
            fuoeb.Close
         End If

         If galcount > 0 Then
            fgal.WriteText "</recordList>"
            fgal.Position = 3
            fgal.CopyTo fgalb
            fgal.Flush
            fgal.Close
            fgalb.SaveToFile galxml, 2
         Else
            fgal.Close
            fgalb.Close
         End If

         If ssscount > 0 Then
            fsss.WriteText "</recordList>"
            fsss.Position = 3
            fsss.CopyTo fsssb
            fsss.Flush
            fsss.Close
            fsssb.SaveToFile sssxml, 2
         Else
            fsss.Close
            fsssb.Close
         End If

         If inccount > 0 Then
            finc.WriteText "</recordList>"
            finc.Position = 3
            finc.CopyTo fincb
            finc.Flush
            finc.Close
            fincb.SaveToFile incxml, 2
         Else
            finc.Close
            fincb.Close
         End If

         If roscount > 0 Then
            fros.WriteText "</recordList>"
            fros.Position = 3
            fros.CopyTo frosb
            fros.Flush
            fros.Close
            frosb.SaveToFile rosxml, 2
         Else
            fros.Close
            frosb.Close
         End If

         If laicount > 0 Then
            flai.WriteText "</recordList>"
            flai.Position = 3
            flai.CopyTo flaib
            flai.Flush
            flai.Close
            flaib.SaveToFile laixml, 2
         Else
            flai.Close
            flaib.Close
         End If

         If ecrcount > 0 Then
            fecr.WriteText "</recordList>"
            fecr.Position = 3
            fecr.CopyTo fecrb
            fecr.Flush
            fecr.Close
            fecrb.SaveToFile ecrxml, 2
         Else
            fecr.Close
            fecrb.Close
         End If

         If shacount > 0 Then
            fsha.WriteText "</recordList>"
            fsha.Position = 3
            fsha.CopyTo fshab
            fsha.Flush
            fsha.Close
            fshab.SaveToFile shaxml, 2
         Else
            fsha.Close
            fshab.Close
         End If

         If thocount > 0 Then
            ftho.WriteText "</recordList>"
            ftho.Position = 3
            ftho.CopyTo fthob
            ftho.Flush
            ftho.Close
            fthob.SaveToFile thoxml, 2
         Else
            ftho.Close
            fthob.Close
         End If

         If newcount > 0 Then
            fnew.WriteText "</recordList>"
            fnew.Position = 3
            fnew.CopyTo fnewb
            fnew.Flush
            fnew.Close
            fnewb.SaveToFile newxml, 2
         Else
            fnew.Close
            fnewb.Close
         End If

         If oricount > 0 Then
            fori.WriteText "</recordList>"
            fori.Position = 3
            fori.CopyTo forib
            fori.Flush
            fori.Close
            forib.SaveToFile orixml, 2
         Else
            fori.Close
            forib.Close
         End If

         If hilcount > 0 Then
            fhil.WriteText "</recordList>"
            fhil.Position = 3
            fhil.CopyTo fhilb
            fhil.Flush
            fhil.Close
            fhilb.SaveToFile hilxml, 2
         Else
            fhil.Close
            fhilb.Close
         End If

         If ardcount > 0 Then
            fard.WriteText "</recordList>"
            fard.Position = 3
            fard.CopyTo fardb
            fard.Flush
            fard.Close
            fardb.SaveToFile ardxml, 2
         Else
            fard.Close
            fardb.Close
         End If

         If geocount > 0 Then
            fgeo.WriteText "</recordList>"
            fgeo.Position = 3
            fgeo.CopyTo fgeob
            fgeo.Flush
            fgeo.Close
            fgeob.SaveToFile geoxml, 2
         Else
            fgeo.Close
            fgeob.Close
         End If

         If salcount > 0 Then
            fsal.WriteText "</recordList>"
            fsal.Position = 3
            fsal.CopyTo fsalb
            fsal.Flush
            fsal.Close
            fsalb.SaveToFile salxml, 2
         Else
            fsal.Close
            fsalb.Close
         End If

         If anacount > 0 Then
            fana.WriteText "</recordList>"
            fana.Position = 3
            fana.CopyTo fanab
            fana.Flush
            fana.Close
            fanab.SaveToFile anaxml, 2
         Else
            fana.Close
            fanab.Close
         End If

         If mapcount > 0 Then
            fmap.WriteText "</recordList>"
            fmap.Position = 3
            fmap.CopyTo fmapb
            fmap.Flush
            fmap.Close
            fmapb.SaveToFile mapxml, 2
         Else
            fmap.Close
            fmapb.Close
         End If

         If walcount > 0 Then
            fwal.WriteText "</recordList>"
            fwal.Position = 3
            fwal.CopyTo fwalb
            fwal.Flush
            fwal.Close
            fwalb.SaveToFile walxml, 2
         Else
            fwal.Close
            fwalb.Close
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

        i = 0

        If anacount > 0 Then
            Print #99, anacoll
            Print #99, "===================="
            For i = 0 To anacount
                Print #99, anaarray(i)
            Next
        End If

        i = 0

        If mapcount > 0 Then
            Print #99, mapcoll
            Print #99, "===================="
            For i = 0 To mapcount
                Print #99, maparray(i)
            Next
        End If

        If walcount > 0 Then
            Print #99, walcoll
            Print #99, "===================="
            For i = 0 To walcount
                Print #99, walarray(i)
            Next
        End If

        Close #99

        MsgBox "Ended!"

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

    dt = Format(CStr(Now), "yyy_mm_dd_hh_mm")
    embedcmd = "T:\diu\Worksheets\embed\" & dt & ".bat"
    MsgBox embedcmd

    Open embedcmd For Output Lock Write As #1
    Print #1, "cd /D T: > " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & "connection.txt" & Chr(34) & " 2>&1"
    Print #1, "cd " & Chr(34) & "T:\diu\Worksheets\exiv2" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & "connection.txt" & Chr(34) & " 2>>&1"
    Print #1, "echo " & Chr(34) & "directory is: " & Chr(34) & "%cd% >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & "connection.txt" & Chr(34) & " 2>>&1"

    For i = 5 To lRows
        If Cells(i, 32) = "R" Then
            folder = Left(Cells(i, 8), 4) & "000-" & Left(Cells(i, 8), 4) & "999\"
            imageNo = Left(Cells(i, 8), 7)

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

            Print #1, "exiv2 -M " & Chr(34) & "set  Iptc.Application2.Headline String " & imageNo & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " > " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M " & Chr(34) & "set  Iptc.Application2.Copyright String " & copyrightstring & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M " & Chr(34) & "set  Xmp.dc.creator XmpSeq " & diu & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M " & Chr(34) & "set  Iptc.Application2.Caption String " & descString & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M " & Chr(34) & "set  Iptc.Application2.ObjectName String " & titleString & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M " & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrCity XmpText " & city & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M " & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrPcode XmpText " & postcode & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M " & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrExtadr XmpText  " & extrAdr & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M " & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiAdrCtry XmpText " & country & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M " & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiTelWork XmpText " & tel & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M " & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiEmailWork XmpText " & Email & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"
            Print #1, "exiv2 -M " & Chr(34) & "set  Xmp.iptc.CreatorContactInfo/Iptc4xmpCore:CiUrlWork XmpText " & URL & Chr(34) & " " & Chr(34) & "T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif" & Chr(34) & " >> " & Chr(34) & "T:\diu\Worksheets\error\" & imageNo & ".txt" & Chr(34) & " 2>>&1"

            Cells(i, 32) = "E"

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
    dt = Format(CStr(Now), "yyy_mm_dd_hh_mm")
    copybackcmd = "T:\diu\Worksheets\copyback\" & dt & ".bat"
    Open copybackcmd For Output Lock Write As #1
    For i = 5 To lRows
        If Cells(i, 32) = "E" Then
            folder = Left(Cells(i, 8), 4) & "000-" & Left(Cells(i, 8), 4) & "999\"
            imageNo = Left(Cells(i, 8), 7)


            Print #1, "move T:\diu\Crops\" & folder & "Process\" & imageNo & "m.tif*  T:\diu\Crops\" & folder & "Process\" & imageNo & "c.tif"
            'Print #1, "copy T:\diu\Crops\" & folder & "Process\" & imageNo & "c.tif*  T:\diu\Crops\" & folder & imageNo & "c.tif"

            Cells(i, 32) = "X"

        End If
    Next

    Close #1

    shellstring = Chr(34) & copybackcmd & Chr(34)
    Call Shell("cmd.exe /S /C " & shellstring, vbNormalFocus)
    'retval1 = Shell(Chr(34) & copybackcmd & Chr(34), vbNormalFocus)

End Sub

