#CONFIG FOR INTRO TEXT
#Think we can chuck the white style: <style>a:link{color:white}a:visited{color:white}a:hover{color:#fab207}#inner{margin-left:10px;}</style>

#######################################
#    ALL COLLECTIONS
#######################################

update EXTENDEDCOLLECTIONPROPERTIES

set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
        <div id="inner"><p>These collections display highlights of the resources of the University of Edinburgh Library, principally from within Special Collections. At present we have almost 12,000 images in the system with more being added on a regular basis.</p>

        <p>Among the types of material included are examples of:</p>

         <p>- Architectural Drawings, including William Playfair&#39;s original drawings for Old College</p>
         <p>- The calotype photographs of Hill and Adamson, two of the early pioneers of photography.</p>
         <p>- Oriental manuscripts including the World history of Rashid Al-Din, and the Chronology of ancient nations of Al-Biruni, from the 14th century A.D.</p>
         <p>- The Walter Scott Image Collection, based primarily on the visual materials and realia contained in Edinburgh University Library&#39;s Corson Collection</p>
         <p>- The University of Edinburgh - people, places and events</p>

    <p align=left>Direct link to media group: <a href = "http://images.is.ed.ac.uk/luna/servlet/view/group/35">Religion In Medieval Scotland (no longer a discrete collection)</a>.</p>
     <p>Where possible, the images are publicly available under a Creative Commons CC-BY licence. This is clearly marked on the front pages of the relevant collections, and on the requisite images.</p>
<p align=left>If you would like to re-use any non-CC-BY images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p><p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'All Collections';
    
#######################################
#    ALL COLLECTIONS- TEACHING
#######################################

update EXTENDEDCOLLECTIONPROPERTIES

set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style> <div id="inner"><p>These image collections are either teaching collections, with a wealth of useful Art and Architecture material, or collaborative project collections, where multiple institutions have brought their material together around a shared theme.</p><p>We have also included collections from LUNA Commons on this site- sets from other LUNA-using institutions which have been made publicly available to any LUNA application.</p><p>Please note, due to copyright, the teaching collections are only visible on-campus, or through the ECA or University&#39;s VPN. If you have a fair reason to gain access to these collections, please email lddt@mlist.is.ed.ac.uk</p></div></font>'
    where
    COLLECTIONID = 'All Collections';

#######################################
#    AMICA
#######################################

update luna.EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner"><p><a href="http://www.davidrumsey.com/amica/" target="_blank"><b>The AMICA Library</b></a> contains over 108,000 works of art from the collections of contributing museums worldwide. Cultures and time periods range from contemporary art, Native American and Inuit art, to ancient Greek, Roman, and Egyptian works, along with Japanese and Chinese works.
        Types of works include paintings, sculptures, drawings, prints, and photographs, as well as textiles, costumes, jewelry, decorative art, and books and manuscripts. </p>
        <p>A paid subscription is required to access the high resolution version of the AMICA Library. For information on subscribing visit <a style="color:white;" href="http://www.davidrumsey.com/amica">The AMICA Library</a>.
         You will view the images at a lower resolution from the free Preview version.</p>
        <p>If you are already an individual subscriber <a style="color:white;" href=http://amica.davidrumsey.com/luna/servlet/login>login</a>
        above for high resolution access. <a style="color:white;" href="http://www.davidrumsey.com/amica/institution_subscribe.html "> Learn more</a> about institutional subscriptions. </p></div>
        '
where
    COLLECTIONID = 'AMICO~1~1';

#######################################
#    ANATOMY
#######################################

update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
        <style>a:link{color:white}a:visited{color:white}a:hover{color:#fab207}#inner{margin-left:10px;}</style>
        <div id="inner"><p>Welcome to the Anatomy image collection. Initially, this repository holds Edinburgh-owned images from the <a href = "http://www.arsanatomica.lib.ed.ac.uk" target="_blank">Ars Anatomica</a> project, but in due course we will add high-resolution images digitised from our Anatomy collection.</p>
        <p>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p>
        <p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEcha~4~4';

#######################################
#    ARCHITECTURAL DRAWINGS
#######################################

update EXTENDEDCOLLECTIONPROPERTIES set INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style><p>This collection is based around the architectural drawings of William Henry Playfair (1789-1857) and Robert Rowand Anderson (1834-1921).</p><p>While Playfair&#39;s most important works in Edinburgh have been executed in the Greek revivalist or classical style - earning for Edinburgh the title of &#39;Athens of the North&#39; - he was competent in other styles too. New College, housing the University&#39;s Faculty of Divinity and the Church of Scotland&#39;s General Assembly Hall (the latter being the temporary home of the Scottish Parliament from 1999) is a jagged-lined rendering of the Gothic style. He also built country houses and mansions in the Italianate and Tudor styles.</p><p>Anderson had four years of legal training, and then while serving with the Royal Engineers he studied construction and design. He then entered the Architectural Section of the School of the Board of Manufactures, and before setting up in practice in Edinburgh, in around 1875, he spent a year in continental travel. His practice was very successful and his output was large. His work included the University of Edinburgh Medical School, the Scottish National Portrait Gallery (and Museum of Antiquities), Edinburgh, the Montrose Memorial within the High Kirk of St. Giles, Edinburgh, Mount Stuart on the Isle of Bute and Central Station Hotel, Glasgow. Anderson was knighted in 1902 and he was the first President of the Scottish Institute of Architects.</p><p>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p><p><a href ="http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>' where COLLECTIONID = 'UoEcar~3~3';

#######################################
#    ARCHIVISION
#######################################
update EXTENDEDCOLLECTIONPROPERTIES
set INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style> <div id="inner"><p>The <b>Archivision Digital Research Library</b> is a collection of high quality images- photographed by a professional photographer, trained as an architect, and past Visual Resource curator.</p><p>Each site&#39;s documentation is extensive- intending to provide for in-depth visual research and analysis by students of architecture, landscape architecture, urban planning, archaeology, art and art history. </p><p>A core architecture collection covering important Egyptian, Greek, Roman, Medieval, Renaissance, Baroque, 18th and 19th Century, Islamic and Modern sites, gardens, parks and works of public art selected from our growing archive of more than 120,000 images. Each Module contains a mix of material spanning multiple countries and time periods to enhance its use in all curricula. No images are repeated. </p></div></font>'
where
    COLLECTIONID = 'UoEarc~1~1';

#######################################
#    ARS ANATOMICA
#######################################

update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style><div id="inner"><p>The purpose of <a href="http://www.arsanatomica.lib.ed.ac.uk/" target = "_blank">Ars Anatomica</a> is to signal the existence of, and to encourage research on, some of the most important books on human anatomy in the collections of Edinburgh University Library (EUL) and the library of the Royal College of Physicians of Edinburgh (RCPE). These books, as well as often being in themselves beautiful objects, were fundamental instruments for the international communication of knowledge about anatomy.</p><p>This web site concentrates on the visual aspects of this process of information transfer, which has allowed us to make maximum use of the impressive capabilities of high resolution digital imaging.</p>
<p>Vesalius&#39;s <i>De humani corporis fabrica libri septem</i>, printed in 1543, in Basel, by Johannes Oporinus was chosen as the central work. The diffusion of its illustrations in sixteenth-century Europe, both directly and indirectly, is the subject of this online presentation.</p><p align=left><a href="http://creativecommons.org/licenses/by-nc-nd/3.0/">Creative Commons Info</a><p align=left></font><img src="https://images.is.ed.ac.uk/graphics/CClicence.png"/></div>'
where
    COLLECTIONID = 'UoEcha~4~4';

#######################################r
#    ART
#######################################

update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

 <div id="inner"><p>The University holds around 2,500 works of art. The Art Collection is now an amalgamation of the University of Edinburgh&#39;s original art collection, which spans some 400 years of collecting, and the Edinburgh College of Art collection of prints, drawings, paintings and sculpture. The ECA collection tells a unique story of the artistic output of the College, particularly in the early to mid-20th century. Some of the most respected names in Scottish art appear, such as S.J. Peploe, John Bellany, Anne Redpath and Elizabeth Blackadder.<p>

<p>The Art Collection has as its centrepiece the Torrie Collection of 17th century Dutch and Italian Masters with works by Ruisdael, ten Oever, Van der Meulen, Pynacker, Rosa and van de Velde. The University also holds the second largest collection of portraits in Scotland ranging from 17th century portraits of John Napier and John Knox to the recent dynamic painting of Peter Higgs by Ken Currie. Other portrait artists represented are Sir Henry Raeburn, Stanley Cursiter, Sir George Reid, James Cowie and Victoria Crowe.</p>

<p>A large percentage of the Art Collection is on display enhancing the public, staff and student spaces of the University. A number of works from the Torrie Collection are on long-term loan to the National Galleries of Scotland. The principal areas of display include Edinburgh College of Art, Old College, Playfair Library, Raeburn Room, the University of Edinburgh Library, New College, McEwan Hall and the Royal (Dick) School of Veterinary Studies.</p>

<p>As well as supporting research at all levels of the University, the uniqueness of the Art Collection lies in its innovative use. The collection is interpreted and displayed in new and exciting ways, introducing contemporary insights and conversations to constantly reinvigorate debate. This involves working closely with Edinburgh College of Art and The Talbot Rice Gallery to ensure that collections are developed through contemporary collecting and also utilised by some of the world&#39;s leading contemporary artists, academics and curators and presented to as wide an audience as possible.</p>
<p>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p>
        <p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEart~1~1';

#######################################
#    CARMICHAEL WATSON
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner"><p>The Carmichael Watson collection in Edinburgh University Library, centred on the papers of the pioneering folklorist Alexander Carmichael (1832-1912), is the foremost collection of its kind in the country, a treasure-chest of stories, songs, customs, and beliefs from the Gaelic-speaking areas of Scotland. It offers us fundamental insights into the creation of Carmichael&#39;s greatest work Carmina Gadelica, an anthology of Hebridean charms, hymns, and songs, and a key text in the &#39;Celtic Twilight&#39; movement. </p>
        <p>The value of the collection goes far beyond literary studies. It offers exciting potential for interdisciplinary cooperation between local and scholarly communities, for collaborative research in history, theology, literary criticism, philology, place-names, archaeology, botany and environmental studies. </p>
        <p>Through cataloguing, indexing, transcribing, translating, digitisation, and conservation, this project aims to open up and make accessible this important collection to the academic and broader community. </p>
        <p align=left>Explore the full <a href = "http://www.carmichaelwatson.lib.ed.ac.uk/cwatson/" target = "_blank">Carmichael Watson Project website here</a>.</p>
        <p>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p>
        <p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEcar~1~1';

#######################################
#    CHARTING THE NATION
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
        <div id="inner"><p>The <a href="http://www.chartingthenation.lib.ed.ac.uk/index.html" target="_blank"><b>Charting the Nation</b></a> image collection includes a wide variety of single maps and maps in atlases and other bound books, together with important manuscript and printed texts relating to the geography and mapping of Scotland from 1550 to 1740 and beyond.</p>
        <p>The site contains invaluable source materials for the study of the history of cartography, architectural history, genealogy, military history, environmental history and archaeology, amongst many other disciplines. Over 3,500 high resolution images are currently available. </p>
        <p align=left><a href="http://creativecommons.org/licenses/by-nc-nd/3.0/">Creative Commons Info
        </a><p align=left></font>
        <img src="https://images.is.ed.ac.uk/graphics/CClicence.png"/></div>'
where
    COLLECTIONID = 'UoEcha~1~1';

#######################################
#    CRC GALLIMAUFRY
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style><p>gal&#8226;li&#8226;mau&#8226;fry/,gal&#601;&#180;m&#244;fr&#275;/</p><p>Noun:</p><p>A confused jumble or medley of things.</p><p>A hash made from diced or minced meat.</p><p>A high proportion of the work of the Library&#39;s Digital Imaging Unit is the completion of reader&#39;s orders for digital images. In most cases these orders might be for one-off photographs of a particular item or perhaps a few pages from a book.  These photographs are retained for potential future orders but unless the entire original item has been digitised, the images are stored in a miscellaneous grouping entitled "Gallimaufry."  The sheer variety of the images held in this group give a fantastic overview of the breadth of material held within the University Library.</p><p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/><b> Digital Book: </b><a href = "http://images.is.ed.ac.uk/luna/servlet/s/458wk0">Wode&#39;s Partbooks Bassus (Set 2)</a></p><p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/><b> Digital Book: </b><a href = "http://images.is.ed.ac.uk/luna/servlet/s/jedr3j">George Focus&#39; Recueil de Desseins Ridicules</a></p><p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/><b> Digital Book: </b><a href = "http://images.is.ed.ac.uk/luna/servlet/s/ei4y5e">Thistlewaite Manuscript</a></p><p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/><b> Digital Book: </b><a href = "http://images.is.ed.ac.uk/luna/servlet/s/ytvdf9">Instrumentalischer Bettlermantl</a></p><p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/><b> Digital Book: </b><a href = "http://images.is.ed.ac.uk/luna/servlet/s/8g04l1">James Wilson&#39;s Illustrations of Zoology</a></p> <p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/><b> Digital Book: </b><a href = "http://images.is.ed.ac.uk/luna/servlet/s/109unz">Phoebe Anna Traquair&#39;s Song School St Mary (1897)</a></p><p align=left>Direct link to media group: <a href = "http://images.is.ed.ac.uk/luna/servlet/view/group/35">Religion In Medieval Scotland (no longer a discrete collection)</a>.</p><p align=left>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p><p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEgal~5~5';


#######################################
#    ECA LIBRARY IMAGES
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner"><p><b>Using the Collections</b></p>
        <li> Access to the ECA Library Image Collection and the ECA Photography Collection is restricted to the staff and students of the University of Edinburgh.
        <li> Images from these databases may be used in lectures, seminars and presentations, and purely for the purpose of non-commercial research, private study, criticism or review.
        <li> Any presentation slides with these images should not be placed on a virtual learning environment (e.g. WebCT) or on webpages as this is considered to be dissemination and would infringe copyright. The images should be redacted before the presentation is shared.
        <li> Acknowledgement of the source of the image is good practice and this can be placed adjacent to the image or towards the end of the research, study, critical or review piece.
        <br>
        <p><b>Copyright information</b></p>
        <li>  The images in the ECA Library Image Collection and the ECA Photography Collection are in copyright under the laws of the United Kingdom, and through international treaties, other countries.
        <li>  They may not be republished or reproduced in print, electronic form, or by any other means, (except in the case of screen prints for the purpose of strictly non-commercial private study and academic research) without the specific permission, in advance, of the copyright holder and the holding institution.
        <li>  The copyright and intellectual property rights in some images are owned by third parties. The responsibility for identifying copyright holders and securing any necessary permission to use an item rests ultimately with the person or persons desiring to do so.
        </p></div></font>'
where
    COLLECTIONID = 'UoEecl~1~1';


#######################################
#    ECA PHOTOGRAPHY
#######################################

update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
        <div id="inner"><p><b>Using the Collections</b></p>
        <li> Access to the ECA Photography Collection is restricted to the staff and students of the University of Edinburgh.
        <li> Images from these databases may be used in lectures, seminars and presentations, and purely for the purpose of non-commercial research, private study, criticism or review.
        <li> Any presentation slides with these images should not be placed on a virtual learning environment (e.g. WebCT) or on webpages as this is considered to be dissemination and would infringe copyright. The images should be redacted before the presentation is shared.
        <li> Acknowledgement of the source of the image is good practice and this can be placed adjacent to the image or towards the end of the research, study, critical or review piece.
        <br>
        <p><b>Copyright information</b></p>
        <li>  The images in the ECA Photography Collection are in copyright under the laws of the United Kingdom, and through international treaties, other countries.
        <li>  They may not be republished or reproduced in print, electronic form, or by any other means, (except in the case of screen prints for the purpose of strictly non-commercial private study and academic research) without the specific permission, in advance, of the copyright holder and the holding institution.
        <li>  The copyright and intellectual property rights in some images are owned by third parties. The responsibility for identifying copyright holders and securing any necessary permission to use an item rests ultimately with the person or persons desiring to do so.
        </p></div></font>
        '
where
    COLLECTIONID = 'UoEecp~1~1';

#######################################
#    ECA RARE BOOKS
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set INTRODUCTIONTEXT =
'<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
<div id="inner"><p>The Rare Books Collection of Edinburgh College of Art, includes about 1,500 items, which date from before 1489 to the twentieth century.  Most of them are printed books; many of them are illustrated.  It is particularly strong in books of the eighteenth and nineteenth centuries on architecture, design and ornament.  There are also nineteenth-century photographs, examples of textile design, and early nineteenth-century hand-painted designs for Edinburgh Shawls.   Many of the books originated in the collections of the institutions which preceded ECA: the drawing academy of the Board of Trustees for Manufactures in Scotland, and the School of Applied Art.</p>
<p>The collection is now housed in the Centre for Research Collections in the Main Library.</p>
<p align=left><a href="http://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons Info
<p align=left>
<img src="https://images.is.ed.ac.uk/graphics/by-front.jpg"/></a>
<p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where COLLECTIONID = 'UoEwmm~3~3';

#######################################
#    GEOLOGY AND GEOLOGISTS
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set INTRODUCTIONTEXT =
'<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
<div id="inner"><p>Geo science was first taught in Edinburgh under the title of Natural History. Professors included Robert Ramsay, John Walker (1731-1803) and Robert Jameson (1774-1854), who held the Chair for fifty years. When George Allman (1812-1898) was about to retire, the University received a letter from Sir Roderick Impey Murchison (1792-1871), Director of the Geological Survey of the United Kingdom, proposing that the Chair of Natural History to be divided, in order to create a separate Chair of Geology. To this end he offered to provide an endowment of &#163;6,000.</p>
<p>The University received a further letter from Murchison, in which he added that the endowment was conditional on him being the person to nominate the new Chair of Geology. The University then wrote to the Treasury asking for a grant of &#163;200 per annum to make the Chair viable. The Treasury replied that they were prepared to provide this sum on condition that Murchison&#39;s clause regarding nomination be deleted.</p>
<p>In March 1871, Archibald Geikie presented his commission to the Senatus Academicus, as the holder of the first Regius Chair of Geology. At that time Archibald Geikie was the President of the Edinburgh Geological Society and, coincidentally, Sir Roderick Murchison was its patron. One way or another, Murchison got his own way. Geikie was succeeded by his younger brother James Geikie (1839-1915) in 1882.</p>
<p>The Geology Department was located in Old College until 1932, when it moved to King&#39;s Buildings. Its new home was named The Grant Institute, in recognition of an endowment from Sir Alexander Grant and was opened by Prime Minister James Ramsay Macdonald on 28 January, 1932.</p>
<p>Inter-related collections held in the department and in Special Collections, include papers and objects relating not only to University of Edinburgh geologists but also the wider community, including both Murchison and Sir Charles Lyell (1797-1975).</p>
<br>
<p align=left>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p><p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where COLLECTIONID = 'UoEsha~5~5';

#######################################
#    HAIL
#######################################

update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner"><p>
        <a href="http://www.hail.lib.ed.ac.uk/index.html" target="_blank"><b>The History of Art Image Library</b></a> is a collaboration between Edinburgh University Library and the History of Art unit of the School of Arts, Culture and Environment, University of Edinburgh.</p>
        <p>At its core are images created from the collection of 35mm transparencies that constitute the first and second year undergraduate teaching sets of the History of Art programme. These have been scanned digitally and catalogued to the Visual Resources Association (VRA) core metadata standard, version 3. </p>
        </font></div>'
where
    COLLECTIONID = 'UoEhal~1~1';

#######################################
#    HILL AND ADAMSON
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set INTRODUCTIONTEXT =
'<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
<div id="inner"><p>In the mid-1840s, the Scottish painter-photographer team of Hill and Adamson produced the first substantial body of self-consciously artistic work using the newly invented medium of photography, one which ranks among the highest achievements of photographic portraiture. A substantial quantity of their work is held by the University Library.  During their four year collaboration, which only ended with the death of Adamson, they produced around 3,000 images, around 700 of which are available in this collection. It includes photographs of local characters and famous figures of the era, as well as landscape and urban scenes.</p>
<p align=left><a href="http://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons Info
<p align=left>
<img src="https://images.is.ed.ac.uk/graphics/by-front.jpg"/></a>
<p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where COLLECTIONID = 'UoEcar~4~4';

#######################################
#    INCUNABULA
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner"><p>Incunabula, from the Latin for &#34;swaddling clothes&#34;, are books from the infancy of printing &#45; anything printed using moveable type before 1501.  These books are among the most precious items in any library and Edinburgh University is privileged to have a significant collection of nearly 300 such books.</p>

        <p>These early books have been extracted from other sequences and other collections, including the libraries of Dugald Stewart and Clement Litill.  Many have numerous provenances.  There are some particularly beautiful books with hand-colouring and early bindings.  A copy of the Decretals of Gratian, printed in 1472, was reputedly the favourite printed book of its owner, William Morris (Inc.4.4).  Most of the books are continental imprints, including a copy of the first book printed at Venice in 1469.  There are, however, two papal indulgences printed by Wynkyn de Worde in 1497 and 1498, and an imperfect copy of Caxton&#39;s Polychronicon.</p>

        <p>The oldest printed book in the Library is in fact a Chinese book printed in woodblock in 1440 &#45; Zhou yi zhuan yi da quan [Complete commentaries on the Yi Jing], Df.7.106.</p>
<p align=left><a href="http://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons Info
<p align=left>
<img src="https://images.is.ed.ac.uk/graphics/by-front.jpg"/></a>
<p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEgal~2~2';


#######################################
#    LAING
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
        <div id="inner"><p>David Laing bequeathed his collection of rare books and manuscripts to the University of Edinburgh in 1878. It resides as a unique asset in the University&#39;s Special Collections &#45; an archive of rare historical importance containing many of the most exceptional, beautiful and important manuscripts and books in Scotland. As a result of its sheer size &#45; some 500,000 items &#45; and its complexity, it has yet to be properly conserved, catalogued or studied. A selection of images from this collection are available online.</p>
<p align=left><a href="http://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons Info
<p align=left>
<img src="https://images.is.ed.ac.uk/graphics/by-front.jpg"/></a>
<p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEwmm~2~2';

#######################################
#    LHSA IMAGES
#######################################
update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner"><p>Lothian Health Services Archive (LHSA) holds the historically important local records of NHS hospitals and other health-related material. These images represent items in our collections, and are provided for private study or non-commercial research.  <br><br>
<B>Copyright information</B>
<br><br>
The images in this collection are in copyright under the laws of the United Kingdom, and through international treaties, other countries.
<p>
They may not be republished or reproduced in print, electronic form, or by any other means, (except in the case of screen prints for the purpose of strictly non-commercial private study and academic research) without the specific permission, in advance, of the copyright holder and the holding institution.</p>
<br><br>
<p>If you wish to use any of these images, or for more information on LHSA collections, please <a href="http://www.lhsa.lib.ed.ac.uk/contact/index.html" target="_blank">contact us</a>. </p>'
where
    COLLECTIONID = 'UoE~2~2';

#######################################
#    MAPS
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner"><p>Welcome to the maps image collection. This repository holds Edinburgh-owned items digitised for the <a href="http://www.chartingthenation.lib.ed.ac.uk/index.html" target="_blank"><b>Charting the Nation</b></a> project. More maps will be added to this collection in due course. </p>
        <p align=left>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p><p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEcha~1~1';

#######################################
#    MIMED
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
        <div id="inner"><p>St Cecilia&#39;s Hall is home to the University of Edinburgh&#39;s musical instrument collection, which ranks among the world&#39;s most important collections of musical heritage. St Cecilia&#39;s Hall has been granted official Recognised Collection of National Significance to Scotland status.</p>
<p>The emphasis of the Collection is on instruments that are no longer in regular current use and the collecting policy is to acquire instruments when they fall out of use rather than to collect instruments by contemporary makers. The Collection thus covers the period from the 16th century (the earliest from which examples are available for acquisition) to the 20th century (the most recent from which instruments can be regarded as historic).</p>

<p>Many of the instruments are still playable and through an established concert programme and as a regular venue during the Edinburgh International Festival, the Concert Room provides a contemporaneous setting for performances, within which the audience can be seen as the interface between the University and the public. For instance, St Cecilia&#39;s Hall is the only place in the world where it is possible to hear 18th century music in an 18th century concert hall played on 18th century instruments.</p>

<p>The instruments are supplemented by an archive of original materials, working papers and a sound archive. The Collection as a whole attracts researchers from far and wide and is an extensively cited resource in international scholarship. Instruments are lent to prestigious exhibitions at home and internationally.</p>
<p align=left><a href="http://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons Info
<p align=left>
<img src="https://images.is.ed.ac.uk/graphics/by-front.jpg"/></a>
<p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEart~2~2';


#######################################
#     MUSEUMS
#######################################
    update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner"><p>

This is a collection of images commissioned by the Museums department. These are images which do not fall into the existing Art, MIMEd or Geology LUNA collections, and often serve as part of Exhibitions.</p>

        <p align=left>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p><p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>' where
    COLLECTIONID = 'UoEhal~2~2';

#######################################
#    NEW COLLEGE
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
    <div id="inner"><p>New College Library began in 1843, with the formation of the Free Church of Scotland&#39;s New College. The original Library was founded upon donations, including many rare books from libraries, churches and individuals across Europe. The Library also grew by amalgamation, incorporating, for example, the Library of the United Presbyterian Church in 1900 and the Library of the Church of Scotland&#39;s General Assembly in 1958.</p>

<p>New College Library&#39;s  substantial rare book collections reflect its heritage as a centre of learning for Presbyterian ministry. Early Bibles in Latin, Greek and Hebrew as well as English form a rich seam throughout the collections, which also includes more modern Bibles in languages from throughout the globe. Pamphlets are a particular strength of the collection, including many unique early Scottish imprints. Publications from the eighteenth and nineteenth centuries bear witness to the development of religious life and culture in Scotland and the Scottish diaspora, and to the impact of missionary work worldwide. For more information about New College Library&#39;s Special Collections, see <a href="http://www.ed.ac.uk/is/new-college-special-collections">http://www.ed.ac.uk/is/new-college-special-collections</a>.</p>
    <p align=left>Media group: <a href = "http://images.is.ed.ac.uk/luna/servlet/view/group/35" target ="_blank">Religion In Late Medieval Scotland</a>.</p>
<p align=left >Media group: <a href = "http://images.is.ed.ac.uk/luna/servlet/view/group/36"  target ="_blank">complete digitised version of MS 42 (Book of Hours)</a>.</p>
<p align=left><a href="http://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons Info
<p align=left>
<img src="https://images.is.ed.ac.uk/graphics/by-front.jpg"/></a>
<p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEsha~3~3';

#######################################
#    OBJECT LESSONS
#######################################

update luna.EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
        <style>a:link{color:white}a:visited{color:white}a:hover{color:#fab207}#inner{margin-left:10px;}</style>
        <div id="inner"><p>
        <a href="http://www.objectlessons.lib.ed.ac.uk/index.htm" target="_blank">
        <b>Object Lessons</b></a> was an exhibition that ran in the summer of 2003 and which displayed a selection from the University&#39;s large collections. The theme of Object Lessons was not just the history of collecting but also the way in which the whole approach to learning in many key areas in the history of Western thought has been shaped by the same processes of visual analysis and enquiry that have produced these collections. The exhibition also told part of the story of the University itself, for it is especially in these areas of thought that it has played, and continues to play, a distinguished part. Visual skills have been central to this story, where art and science have often worked much more closely together than we might imagine. The themes into which the exhibition was divided have been chosen to illustrate how these continuities of thought link the past with the present and future.</p>

        <p align=left><a href="http://creativecommons.org/licenses/by-nc-nd/3.0/">Creative Commons Info
        </a><p align=left></font>
        <img src="https://images.is.ed.ac.uk/graphics/CClicence.png"/></div>'
where
    COLLECTIONID = 'UoEhal~2~2';

#######################################
#    ORIENTAL MANUSCRIPTS
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner"><p>A large part of the Oriental Manuscript Collection consists of Arabic and Persian manuscripts. Arabic manuscripts include commentaries on the Koran; traditions of the Prophet and Imam; prayers;
         law, general history and biography; medicine, mathematics, philosophy and ethics; and,
        grammar, rhetoric, poetry, prose, tales, dictionary, and controversy. Persian manuscripts
        include theology, history, biography, and travel; mathematics and astronomy; ethics, poetry,
        music, composition and proverbs, tales and romances; grammar and dictionary; and, agriculture and war. The Arabic and Persian manuscripts include the World history of Rashid Al-Din,
    and the Chronology of ancient nations of Al-Biruni, from the 14th century A.D. Hindustani manuscripts include history; poetry and tales; and, astrology. Turkish manuscripts consist of material
    acquired in Astrakhan and includes several early Ottoman texts, divans of Neva&#39;i and items of dialectical interest. Included in the Oriental Collection are around 100 bundles or parcels of Buddhist works on palm leaves
    in Burmese, Pali, Sanskrit, Siamese, Tamil, and Tibetan. There are also Sanskrit charters on copper plates, and Oxyrynchus Papyri. </p>
<p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/>
<b> Digital Book: </b><a href = "http://images.is.ed.ac.uk/luna/servlet/s/kwl89a">Rashid Al-Din&#39;s World History<a></p>
<p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/>
<b> Digital Book: </b><a href = "http://images.is.ed.ac.uk/luna/servlet/s/ob683d">Al-Biruni&#39;s Chronology of Ancient Nations<a></p>
<p align=left>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p><p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEsha~4~4';

#######################################
#    ROSLIN INSTITUTE
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style><div id="inner"><p>The archives and printed collections of the Roslin Institute were acquired by Edinburgh University Library Special Collections in 2009, following the Institute&#39;s merge with the University&#39;s College of Medicine and Veterinary Medicine. The collections comprise: the archival records of the Institute and predecessor bodies (including the Animal Breeding Research Organisation); a large collection of bound offprints from the Institute and predecessor bodies, as well as from F.A.E. Crew; rare books from the Institute&#39;s library, and a collection of nearly 3,500 late 19th/early 20th century glass plate slides. These collections are currently being catalogued with funding from the Wellcome Trust, who have also funded the digitisation of the glass slide collection. Catalogues are searchable online on the CRC&#39;s Archives and Manuscripts pages.</p><p align=left>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p><p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEgal~6~6';

#######################################
#    SALVESEN
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
        <div id="inner"><p>The history of the firm of Christian Salvesen goes back to 1851 when Christian Salvesen arrived in Leith and set up in business as a shipowner and broker. Two years later he joined the Edinburgh merchant George Vair Turnbull, continuing in partnership with him until he went solo in 1872.
        Three of his sons, Thomas, Frederick and Theodor joined him in the business; the fourth, Edward, preferred a legal career which began with a law degree from the University of Edinburgh, and which culminated in his elevation to the College of Justice and the Bench as The Hon. Lord Salvesen (1857-1942). </p>
        <p>The archives of Christian Salvesen Ltd were surveyed by the National Register of Archives (Scotland) 1968 and deposited with the University Library in 1969, with several tranches of additional material coming in later years. "A List of the Archives of Messrs Christian Salvesen Limited deposited in Edinburgh University Library" was compiled by Tom Hubbard on a grant from the firm, and was published by the Library in 1981; copies are available for consultation in the Special Collections Department. Histories of the firm held in the Library include "Salvesen of Leith", by Wray Vamplew (Edinburgh & London: Scottish Academic Press, 1975) and "A whaling enterprise: Salvesen in the Antarctic", by Sir Gerald Elliot (Wilby, Norwich [U.K.]: Michael Russell, 1998), both of which have been presented to the Library. Sir Gerald Elliot, Chairman of Christian Salvesen plc from 1981 to 1988, has also presented to the Library a collection of historic books on whaling in the South Atlantic and the Antarctic. </p>
<p align=left>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p><p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEcar~2~2';

#######################################
#    SCHOOL OF SCOTTISH STUDIES
#######################################


update luna.EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>
        <style>a:link{color:white}a:visited{color:white}a:hover{color:#fab207}#inner{margin-left:10px;}</style>
        <div id="inner"><p>The School of Scottish Studies Photographic Archive, housed in the basement of 27 George Square, contains over 40,000 images - mainly black and white prints along with a substantial collection of colour slides.</p>
        <p>The Archive is particularly rich in rurally based material, and the majority of the images date from the 1930s to the present day. Subject matter includes domestic buildings, household economy, agriculture, fishing, transport and communications, crafts, seasonal customs, music and dance, and portraits of tradition bearers.</p>
        <h3 align=left>Sources</h3>
        <p>Pictures come from a variety of sources including staff and student fieldwork and donated collections, for example:</p>
        <li>	Robert Atkinson Collection
        <li>	Werner Kissling Collection
        <li>	John Levy Collection
        <li>	Marinell Ash Slide Collection
        </p>

        <p align=left><a href="http://creativecommons.org/licenses/by-nc-nd/3.0/">Creative Commons Info
        </a><p align=left></font>
        <img src="https://images.is.ed.ac.uk/graphics/CClicence.png"/></div>'
where
    COLLECTIONID = 'UoEgal~3~3';

SESSIOn

The case papers of the Scottish Court of Session, Scotland’s supreme civil court, are the most significant, yet still unstudied, printed source for the history, society and literature of Scotland from 1710-1850. During this period, every paper which came before the Court was required to be printed for the lawyers, in a small number of copies.  There are three surviving collections of the Session Papers, held by Edinburgh University Library, the Faculty of Advocates, and the Signet Library, all in the city of Edinburgh and containing approximately 250,000 items.
From October 2016 to April 2017 – and in partnership with the Faculty of Advocates and the Signet Library – the University led a pilot project which captured 13,500 images from the three collections, tackling examples of volumes from different series, dates and physical states, and surveyed the overall conservation and preservation needs.
Further digitisation will be carried out later in 2018 and more images will then be made available.

#######################################
#    SHAKESPEARE
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner"><p>The library&#39;s rich holdings of early English drama include the majority of editions of William Shakespeare published before 1660, mainly through the Halliwell-Phillipps Collection.  Halliwell-Phillipps (1820-1899) was a prolific and controversial literary scholar, who built up vast collections on Shakespeare and English literature.</p>
<p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/>
<b> Digital Book: </b><a href = "http://images.is.ed.ac.uk/luna/servlet/s/65ti5h"  target="_blank">Shakespeare- Romeo and Juliet, 1599<a></p>
<p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/>
<b> Digital Book: </b><a href = "http://images.is.ed.ac.uk/luna/servlet/s/9h4fn7" target="_blank">Shakespeare- Love&#39;s Labours Lost, 1598<a></p>
<b> IIIF View: </b><a href ="https://librarylabs.ed.ac.uk/iiif/uv/?manifest=https://librarylabs.ed.ac.uk/iiif/speccollprototype/manifests/user/ad8adc832592099889ee4307.json" target="_blank">Works of Ben Jonson</a>
<p align=left><a href="http://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons Info
<p align=left>
<img src="https://images.is.ed.ac.uk/graphics/by-front.jpg"/></a>
<p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEsha~1~1';

#######################################
#    THOMSON WALKER
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner">
        <p>Sir John William Thomson-Walker (1871-1937), surgeon and print-collector, formed an outstanding collection of engraved portraits of European medical men dating from the 16th to the 20th centuries.</p>
        <p>Born in Newport, Fife, Thomson-Walker was educated at the Edinburgh Institution and the University of Edinburgh, graduating in 1894, before undertaking postgraduate study in Vienna. He set up in Harley Street, London, as a consultant at King&#39;s College and St Peter&#39;s Hospitals, becoming one of the leading urologists of his day. In 1907 he was appointed a Hunterian Professor of the Royal College of Surgeons of England, and was knighted in 1922. He held a number of visiting lectureships, and was elected President of the Medical Society of London in 1933. </p>
        <p>Print collecting was his lifelong passion. In his will, Thomson-Walker bequeathed his collection to the University of Edinburgh, "in the hope of encouraging the study of the history of medicine on which this great medical school has had such a profound and lasting influence". The collection came to the University in 1939. Including subsequent accessions funded by his endowment, it now totals nearly 3,000 prints and a number of books on the art and technique of engraving. Digitisation of the prints is ongoing. </p>
<p align=left><a href="http://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons Info
<p align=left>
<img src="https://images.is.ed.ac.uk/graphics/by-front.jpg"/></a>
<p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEsha~2~2';

#######################################
#    UNIVERSITY OF EDINBURGH
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>

        <div id="inner">
        <p>The University of Edinburgh - People, Places, Events collection is exactly as described: a mixed group of images showing people, buildings and activities from the past and present of University life.</p>

        <p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/><b> Digital Book: </b> <a href = "https://images.is.ed.ac.uk/luna/servlet/s/og0148" target ="_blank">Institute of Animal Genetics photograph album (1955)</a></p>


<p align=left>If you would like to re-use any of these images, please contact the Centre for Research Collections (is-crc@ed.ac.uk) where staff can advise you of the copyright status. Further information can be found on our <a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/image-licensing"  target="_blank">Image Licensing webpages</a>.</p><p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEgal~4~4';

#######################################
#    WALTER SCOTT
#######################################


update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style><div id="inner"><p>The Walter Scott Image Collection is based primarily on the visual materials and realia contained in Edinburgh University Library&#39;s <a href = "http://www.walterscott.lib.ed.ac.uk/corson.html">Corson Collection</a>. The former include portraits of Scott and of people associated with Scott, art inspired by his novels and poems, illustrations to editions of his works, and pictures of places associated with Scott. They cover a variety of formats: oil and watercolour paintings, drawings, engravings, etchings, lithographs, and photographs. The realia consist of memorabilia and other examples of material culture associated with Scott and his homes and haunts (especially Abbotsford). In addition, there are playbills, title pages, and illustrative material relating to theatrical and musical adaptations of Scott and to translations of his work. The Image Collection also contains manuscripts of Scott&#39;s works and correspondence drawn from the Corson Collection and the Library&#39;s Laing Collection. </p><p>Like the Corson Collection itself, the Image Database is wide-ranging and eclectic. It is a valuable resource for anyone interested in the diffusion of Scott&#39;s work in Scotland, Great Britain, and abroad, in Scott&#39;s role in the creation of Scottish national identity, and in his influence on British and foreign depictions of Scotland.</p><p>For more information on Scott&#39;s life and work, visit Edinburgh University Library&#39;s <a href = "http://www.walterscott.lib.ed.ac.uk">Walter Scott Digital Archive</a>.</p><p>Have a look at our <a href = "https://www.flickr.com/photos/crcedinburgh/sets/72157645197625560/map/">Flickr map</a>, which shows the locations of some of the engravings in modern-day Edinburgh!</p><p align=left><a href="http://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons Info<p align=left><img src="https://images.is.ed.ac.uk/graphics/by-front.jpg"/></a><p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEwal~1~1';

#######################################
#    WESTERN MEDIEVAL MANUSCRIPTS
#######################################

update EXTENDEDCOLLECTIONPROPERTIES
set
    INTRODUCTIONTEXT = '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style><div id="inner"><p>There are about 330 medieval manuscripts held in Special Collections, about half of them drawn from the Laing Collection. They are of diverse origin and subject matter, with some manuscripts representing the Benedictine and Carthusian monasteries at Erfurt, some material from Bury St. Edmunds, Reading and Syon and other British locations, and also from Aberdeen, Dunkeld, Elgin, Sciennes, and Inchcolm, in Scotland. Well represented are biblical, liturgical and theological texts, especially a good collection of late medieval illuminated books of hours. Within the Biblical manuscripts there are Bibles, parts of the Bible, Bible histories, Lives of our Lord and the Blessed Virgin Mary, and other saints. The Liturgical manuscripts include Antiphoner, Breviaries, Directories, Grails, Horae, Martyrology, Missals, Pontificals, Psalters etc. Theological texts include Apocryphal material, Commentaries, General, Moral, Mystical, Sermons, and Patristic material. There are Philosophy texts, Law, material on Medicine and History. The manuscripts include Classical and Medieval Literature. </p><p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/><b> Digital Book: </b> <a href = "http://images.is.ed.ac.uk/luna/servlet/s/9vd52y">Four Gospels, Germany (Ms 12)</a></p>  <p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/><b> Digital Book: </b> <a href = "http://images.is.ed.ac.uk/luna/servlet/s/523yw6">Bible Historial, France (Ms 19)</a></p>  <p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/><b> Digital Book: </b> <a href = "http://images.is.ed.ac.uk/luna/servlet/s/5df6n0">Celtic Psalter (Ms 56)</a></p>  <p><img src="https://images.is.ed.ac.uk/graphics/closed-book.jpg" alt="Book Reader Icon" name="Book reader" width="21" height="21" border="0" id="Book reader"/><b> Digital Book: </b> <a href = "http://images.is.ed.ac.uk/luna/servlet/s/d4wx22">Book of Hours, 1430 (Ms 39)</a></p><p align=left>Media group: <a href = "http://images.is.ed.ac.uk/luna/servlet/view/group/35" target ="_blank">Religion In Late Medieval Scotland</a>.</p><p align=left >Media group: <a href = "http://images.is.ed.ac.uk/luna/servlet/view/group/36"  target ="_blank">complete digitised version of MS 42 Book of Hours</a>.</p><p align=left><a href="http://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons Info<p align=left><img src="https://images.is.ed.ac.uk/graphics/by-front.jpg"/></a><p><a href = "http://www.ed.ac.uk/information-services/library-museum-gallery/crc/services/copying-and-digitisation/permission-to-reproduce-images/takedown-policy" target="_blank">Our Takedown Policy</a></p></div></font>'
where
    COLLECTIONID = 'UoEwmm~1~1';


select
    *
from
    luna.EXTENDEDCOLLECTIONPROPERTIES;

update luna.EXTENDEDCOLLECTIONPROPERTIES
set
    HEADERGRAPHICURL = 'https://images.is.ed.ac.uk/graphics/luna-UoEwmm-1-NA.jpg', THEME = 'blue'
where
    collectionid = 'UoEwmm~1~1';

update luna.EXTENDEDCOLLECTIONPROPERTIES
set
    HEADERGRAPHICURL = 'https://images.is.ed.ac.uk/graphics/luna-UoEart-1-NA.jpg', THEME = 'blue'
where
    collectionid = 'UoEart~1~1';

update luna.EXTENDEDCOLLECTIONPROPERTIES
set
    HEADERGRAPHICURL = 'https://images.is.ed.ac.uk/graphics/luna-header.jpg'
where
    collectionid = 'All Collections';

update
	luna.MEDIAFIELDS
set
;
select * from lac_galli.ISENTITYTYPES;

show processlist;

alter table luna.EXTENDEDCOLLECTIONPROPERTIES change column INTRODUCTIONTEXT INTRODUCTIONTEXT varchar(5000);

select * from luna.MEDIAFIELDS where W4TYPE IS NOT NULL AND UNIQUECOLLECTIONID = 3 AND INSTITUTIONID = 'UoEcar';

select
    *
from
    `luna`.`EXTENDEDCOLLECTIONPROPERTIES`;

select
    *
from
    luna.MEDIACOLLECTIONS;

update luna.MEDIAFIELDS
set
    W4TYPE = 'WHERE'
where
    institutionid = 'UoEwmm'
        and collectionid = 1
        and displayname = 'Production Place';

select
    *
from
    `luna`.`MEDIAFIELDS`
where
    `institutionid` in ('UoEsha' , 'UoEwmm', 'UoEcar', 'UoEgal')
        and `PREVIEWFIELD` = 1;

select * from luna.MEDIAFIELDS where fieldname like'%PAGE%';

select
    *
from
    `luna`.`MEDIAFIELDS`
where
    `institutionid` in ('UoEwal')
and `PREVIEWFIELD` = 1;


update EXTENDEDCOLLECTIONPROPERTIES set INTRODUCTIONTEXT = replace(INTRODUCTIONTEXT, '<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>','<font size =2 ><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style><style>#inner{margin-left:10px; max-width:750px;text-align: justify;text-justify: inter-word;}</style>');

update luna.MEDIAFIELDS set PREVIEWFIELDSORT = 4, PREVIEWFIELD = 1 where institutionid = 'UoEwal' and uniquecollectionid = 1 and  displayname = 'Date';
update luna.MEDIAFIELDS set PREVIEWFIELDSORT = 0, PREVIEWFIELD = 0 where institutionid = 'UoEwal' and uniquecollectionid = 1 and  displayname = 'Related Work Page No';

update luna.MEDIAFIELDS
set
    PREVIEWFIELDSORT = '1',
    PREVIEWFIELD = '1'
where
    institutionid in ('UoEsha' , 'UoEwmm', 'UoEcar', 'UoEgal')
        and DISPLAYNAME = 'Creator';
update luna.MEDIAFIELDS
set
    PREVIEWFIELDSORT = '2',
    PREVIEWFIELD = '1'
where
    institutionid in ('UoEsha' , 'UoEwmm', 'UoEcar', 'UoEgal')
        and DISPLAYNAME = 'Title';
update luna.MEDIAFIELDS
set
    PREVIEWFIELDSORT = '3',
    PREVIEWFIELD = '1'
where
    institutionid in ('UoEsha' , 'UoEwmm', 'UoEcar', 'UoEgal')
        and DISPLAYNAME = 'Shelfmark';
update luna.MEDIAFIELDS
set
    PREVIEWFIELDSORT = '4',
    PREVIEWFIELD = '1'
where
    institutionid in ('UoEsha' , 'UoEwmm', 'UoEcar', 'UoEgal')
        and DISPLAYNAME = 'Related Work Page No';
update luna.MEDIAFIELDS
set
    DEFAULTCOLLECTIONSORT = '1'
where
    institutionid in ('UoEsha' , 'UoEwmm', 'UoEcar', 'UoEgal')
        and DISPLAYNAME = 'Creator';
update luna.MEDIAFIELDS
set
    DEFAULTCOLLECTIONSORT = '2'
where
    institutionid in ('UoEsha' , 'UoEwmm', 'UoEcar', 'UoEgal')
        and DISPLAYNAME = 'Shelfmark';
update luna.MEDIAFIELDS
set
    DEFAULTCOLLECTIONSORT = '3'
where
    institutionid in ('UoEsha' , 'UoEwmm', 'UoEcar', 'UoEgal')
        and DISPLAYNAME = 'Related Work Page No';
update luna.MEDIAFIELDS
set
    DEFAULTCOLLECTIONSORT = '4'
where
    institutionid in ('UoEsha' , 'UoEwmm', 'UoEcar', 'UoEgal')
        and DISPLAYNAME = 'Title';

update luna.MEDIAFIELDS
set
    PREVIEWFIELDSORT = '0',
    PREVIEWFIELD = '0'
where
    institutionid in ('UoEsha' , 'UoEwmm', 'UoEcar', 'UoEgal')
        and DISPLAYNAME in ('Repro Record ID' , 'Repro Title',
        'Creator Name',
        'ID Number');

update luna.MEDIAFIELDS
set
    PREVIEWFIELDSORT = '2',
    PREVIEWFIELD = '1'
where
    institutionid = 'UoEgal'
        and COLLECTIONID = 4
        and DISPLAYNAME = 'Repro Title';

select
    institutionid,
    uniquecollectionid,
    displayname,
    w4type,
    previewfieldsort,
    defaultcollectionsort,
    summarydescriptionfieldsort
from
    `luna`.`MEDIAFIELDS`
where
    `institutionid` in ('UoEart')
        and COLLECTIONID = 2
        and (`DEFAULTCOLLECTIONSORT` > 0
        or W4TYPE IS NOT NULL
        or PREVIEWFIELD = 1
        or SUMMARYDESCRIPTIONFIELD > 0);

update luna.MEDIAFIELDS
set
    DEFAULTCOLLECTIONSORT = '0'
where
    institutionid in ('UoEsha' , 'UoEwmm', 'UoEcar', 'UoEgal')
        and DISPLAYNAME in ('Repro Record ID' , 'Repro Title',
        'Creator Name',
        'ID Number');

insert into IROBJECTIMAGEMAP (IMAGEID, OBJECTID) values (104053, 77068);

select * from luna.EXTENDEDCOLLECTIONPROPERTIES ;

update luna.EXTENDEDCOLLECTIONPROPERTIES
set theme = 'blue';

update luna.MEDIAFIELDS
set
    DEFAULTCOLLECTIONSORT = 4
where
    institutionid = 'UoEgal'
        and COLLECTIONID = 4
        and DISPLAYNAME = 'Repro Title';

select DESTMEDIAID, OBJECTKEY from CCMEDIABATCHELEMENTS where BATCHID = 1025;

delete from IROBJECTIMAGEMAP where IMAGEID = 104053;

select  v.valuetext, o.objectid, v.fieldid from DTVALUES v, DTVALUETOOBJECT o where o.valueid = v.valueid and fieldid = 276 and valuetext like '0056%';



