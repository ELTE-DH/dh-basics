.. _nemzetkoziesites hackelessel:

============================
Nemzetköziesítés hackeléssel
============================

Az Internet széles körű elterjedésével a 90-es években szükségessé vált, hogy egy dokumentumon belül különféle nyelvek is meg tudjanak jelenni a maguk speciális karaktereivel, függetlenül attól, hogy egy kódtáblán szerepelnek-e a karakterei. Egyre inkább szükség lett volna egy egységes kódrendszerre, mely egyszerre is képes kezelni *minden nyelv* betűit. A Latin kódolás ebből a szempontból több mint elégtelennek bizonyult, mivel például a mandarin nyelvben több tízezer karakter van, melyek megkülönböztetéséhez több bájtnyi tárhelyre lett volna szükség, akárhogyan is vannak reprezentálva a karakterek. Ekkor az egész világ már tényleg az egész világot jelentette, nem csak a latin betűs írásokat és pár kivételes nyelvet.

Az Internet elődjének (*ARPANET*) publikus megjelenésével (1983) egyértelművé vált, hogy a nyomtatásból ismert formázással kapcsolatos fogalmaink (lásd leíró nyelvek, pl. *(La)TeX* (1978), *SGML* (1988)) és az átvitellel kapcsolatos problémák (lásd az 1983-as *Berkeley Socket*, amely a mai Internet alapja) végleg kikerülnek a karakterkódolás témaköréből. Addigra az ASCII szabvány akkora teret nyert, hogy a fejlődés előfutárából a fejlődés gátja lett, hiszen költséges lett volna olyan rendszereket bevezetni, melyek nem „szabványosak”. Így az új, az elvárásokat teljesítő szabvány megjelenéséig és elterjedéséig különféle kerülőutakra és ügyes szükségmegoldásokra, más néven hekkekre volt szükség.

.. _binaris formatumok:

------------------
Bináris formátumok
------------------

Az elődrendszerek (lásd :ref:`karakterkodolas_tortenete` rész) felépítése miatt kezdetben csak az ASCII kódolású (7 bites), kizárólag nyomtatható karaktereket tartalmazó szöveges formátumok voltak átvihetőek a hálózaton. Ezért maguk a kezdeti protokollok is angol nyelvű szöveges parancsokra alapultak (pl. `a fájlátviteli protokoll (FTP, 1971) <https://en.wikipedia.org/wiki/File_Transfer_Protocol>`_ és az internetes levelezést lehetővé tevő `SMTP (1980) <https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol>`_). Viszont amikor már képeket, nem szöveges jellegű adatokat és a helyspórolás végett tömörített adatokat is továbbítani akartak ezeken a protokollokon „szöveges adattá” kellett kódolni azokat (`binary-to-text encoding <https://en.wikipedia.org/wiki/Binary-to-text_encoding>`_), hogy ne tudjanak zavart okozni az átvitel során. Ennek nyomán megjelent a mind a 8 bitet tetszőlegesen kihasználó, bináris adatok a csak 7 bitet kezelő, szöveges (azaz nyomtatható ASCII karakterekből álló) adatfolyamba való beágyazásának igénye. Ha pedig tetszőleges tartalmú, akár bináris (mind a 8 bitet kihasználó) adat reprezentálható az átvitel során 7-bites nyomtatható karakterekkel a tartalomra vonatkozó további megkötés nélkül, az lehetővé teszi, hogy különféle tisztán bináris (8 bites) formátumok alakuljanak ki kilépve a beágyazottságból. Csak a jól szabályozott részeket kel hozzá lassanként opcionálissá tenni, majd elhagyni.

Ez a lehetőség vezetett többek között a nemzetközi karakterek és formázások ilyen jellegű tárolásához. Például egy 2003 előtti *MS Word .DOC* (nem docx) formátumú dokumentumot szövegszerkesztővel (pl. *Jegyzettömb*) megnyitva csak értelmezhetetlen adathalmazt látunk (`valójában egy fájlrendszert láthatunk egy fájlban kódolva, csak nem nyilvános/szabványos szabályok szerint <https://en.wikipedia.org/wiki/Microsoft_Word#Binary_formats_(Word_97%E2%80%932007)>`_). Az ilyen, főként bináris formátumok értelmezése, manipulálása csak a felépítésük ismeretében lehetséges. Ez a melegágya a zárt szabványoknak, melyek dekódolása nagyon nehéz, és gátolja az interoperabilitást, alternatív programok fejlesztését. Ezzel szemben a modern formátumok, például a `Office Open XML (docx) <https://en.wikipedia.org/wiki/Office_Open_XML>`_ valójában zip fájlok és szabványosan tömörített formában tartalmazzák a tárolt fájlokat, szabványos felépítésű XML-eket. Ezért kitömörítés után bármilyen szövegszerkesztőben megnyithatóak és szerkeszthetőek, visszatömörítéssel pedig az eredeti formátumba „menthető” a módosítás.

Az (akár bináris, akár szöveges) adatok „szöveges” formátumokba ágyazásának nehézsége abból adódik, hogy a beágyazandó adat tartalma a bitek értékének és sorrendjének tekintetében tetszőleges lehet, viszont a beágyazás után csak közönséges, nyomtatható karakterekkel lehet reprezentálni. Erre a problémára találták ki a **Base64 formátumot**, mely az akár bináris bemeneti adatot 3 darab 8 bites bájtonként (24 bit) veszi, és átalakítja 6 bites egységek négyes csoportjaira úgy, hogy a kimenet minden bájtja egy nyomtatható karakter (nagybetűk, kisbetűk, számok, valamint a ``+`` és ``/`` jelek, összesen 64 darab elem). Abban az esetben, amikor a bemenet hossza nem osztható 3 bájtos egységekre, a kimeneten extra karakterekkel jelzi a rendszer, hogy nincsenek további bitek az utolsó három bájtos kimeneti elemben. Ezek az extra karakterek lehetnek ``A``-betűk, melyek nulla értéket reprezentálnak, vagy szükség esetén egy vagy két ``=`` jel, **melyekről könnyen felismerhető, hogy Base64 kódolással van dolgunk** (lásd :ref:`a base64 kodolas` rész). `A szisztéma ezen az oldalon kipróbálható. <https://www.base64decode.org/>`_

Egy másik hasonló formátum az úgynevezett `Quoted-Printable <https://en.wikipedia.org/wiki/Quoted-printable>`_ kódolás, melynek célja a Base64-el ellentétben, hogy megtartsa az emberi olvashatóságot, amennyire lehet és csak a nem nyomtatható ASCII karaktereket kódolja. Főleg az emailek törzsében a szöveges adatok kódolására használatos. Minden tisztán 8 bites bájt három karakterrel kódolható: az első karakter az egyenlőségjel (``=``) melyet két karakterben a bájt hexadecimális (16-os számrendszer szerinti) értéke követ (bővebben lásd :ref:`karakterhivatkozasok` rész). Ez szükségessé teszi a szövegben amúgy előforduló egyenlőségjelek kódolását minden esetben, hogy ne legyen összetéveszthető a kódolt bájtok első karakterével. A 75 karakternél hosszabb sorokat puha sortörésekkel (egyenlőségjel) el kell törni, hogy a képződő sorok maximum 64 karakter szélesek legyenek a régi szabványnak megfelelően. A sor végi fehér szóközök is kódolandóak, ahogy a szövegbeli valódi sortörések is, melyek kicsi vissza és soremelés párokká alakítandóak az eredeti értéktől függetlenül (lásd :ref:`a quoted-printable kodolas` rész). `A kódolás ezen az oldalon kipróbálható. <https://dencode.com/string/quoted-printable>`_

Ezekben a formátumokban tetszőleges bemenet kiszámítható formátumúra alakítható az átvitelhez, és az értelmező programra van bízva a tartalom kezelése. Még manapság is használatos, pl. az e-mailbe beágyazott nem ASCII karakterek és a képek így kerülnek továbbításra. Szerencsére manapság elég csak felismerni őket, vannak beépített függvények a kódolásra és dekódolásra (lásd :ref:`karakterkodolas a gyakorlatban` rész). Kezdetben a világhálón található képek ilyen formátumban voltak beágyazva a szöveg közé, hogy a teljes tartalom egy dokumentumon belül maradjon. Manapság már ez egyre ritkább az arculati elemek több helyen történő felhasználása miatt, ezért külön fájlokként hivatkoznak rájuk az internetes dokumentumokban. Habár a Base64 és a Quoted-Printable formátumok megoldották az adattovábbítás kérdését, nem szabványosították az adat értelmezésének módját, így az ASCII karaktertáblában nem szereplő karakterek szabványos jelölésére más megoldás kellett.

.. _karakterhivatkozasok:

--------------------------------
Karakterhivatkozások (entitások)
--------------------------------

Az *SGML* (1988), *HTML* (1993) és *XML* (1998) jelölőnyelvű dokumentumok nyomtatható ASCII karakterek sorozataiból állnak. Mind a szöveges adatokat, mind a formázást, metaadatokat stb. jelölő címkéket, s azok rekurzívan építkező struktúráit ugyanúgy karakterekkel reprezentálják szemben a bináris formátumokkal (pl. doc, xls vö. docx és xlsx, ahol speciális XML fájlok zipbe vannak tömörítve), így lehetővé teszik az automatikus és manuális kezelést is. A tervezésükből fakadóan a címkéken belül találhatóak még attribútum-érték párok is, melyeket szintén számításba kell venni a nyomtatható ASCII karakterekkel való reprezentálhatóságkor.

A jelölőnyelv szempontjából a szintaktikai értelemmel bíró karakterek (pl. a címkéket jelző relációs jelek, idézőjelek stb.) szövegbeli, azaz nem szintaktikai értelemben történő megjelenítése nem egyértelmű külön jelölés nélkül. Szövegbeli reprezentálhatóságukhoz úgynevezett **karakterhivatkozásoknak (character entity reference) nevezett karaktersorozatokat** vezettek be.

Amit beírunk egy XML dokumentumba:

.. code-block:: text

    <címke>Ez a címke tag szöveges tartalma: &lt;p&gt;Ez a &quot;szöveg&quot; így néz ki&lt;/p&gt;</címke>

Ahogy megjelenik a ``<címke>`` címke tartalma (szintaktikai értelemmel nem bíró szöveg):

.. code-block:: text

    Ez a címke tag szöveges tartalma: <p>Ez a "szöveg" így néz ki</p>

Általánosságban a hivatkozások láthatatlan karakterek láthatóvá tételére (szóköz, soremelés, tabulátor stb.) és az adott környezetben a szöveg számítógépes jelölése szempontjából szintaktikai értelemmel bíró karakterek (például a string határoló idézőjel) **literális**, azaz önmagát jelentő változatainak a jelölésére szolgálnak.

Amit beírunk, pl. egy string változóba:

.. code-block:: text

    "Soremelés: \n Egy fordított törtvonal: \\ Tab: \t az idézőjel befejezi a stringet, de \" formában leírható literális alakban is."

Ahogy megjelenik, ha kiíratjuk a változó tartalmát:

.. code-block:: text

    Soremelés:
    Egy fordított törtvonal \ Tab:      az idézőjel befejezi a stringet, de " formában leírható literális alakban is.

A HTML-nyelven belül és az URL-eknél a szintaktikai funkcióval rendelkező karakterek literális alakjának leírásához szükséges karakterhivatkozásokat előállító műveletet **escape-nek**, a karakterhivatkozásokat literális alakká visszaalakító műveletet **unescape-nek** hívjuk, általánosságban ezek a műveletek **qoute-nak** és **unqoute-nak** is hívhatóak (lásd :ref:`kodtablafuggetlen karakterhivatkozasok` rész).

A karakterhivatkozásokkal történő leírás lehetővé teszi, hogy a különböző Latin kódtáblák karakterei (pl. a hullámos ő ``õ`` a Latin-1-ből és a magyar hosszú ő ``ő`` a Latin-2-ből) egy dokumentumon belül is szerepelhetnek – az ilyen hivatkozások felépítésükben a kombinálódó (pl. repülő) ékezetekre (lásd :ref:`repulo ekezetek es proszeky-kod` rész) hasonlítanak. A hivatkozott karakterek értelmezése a megjelenítő programokra (többnyire a böngészőre) van hagyva. A programok többségében a hivatkozások megjelenésekor már un. **8-bit tiszta** (8 bites egységekben történő) feldolgozás történik, amiben egy karakter egy bájtnak van tekintve a bitek értékétől függetlenül. Ilyenkor a karakterek például csak másolva vagy generálva vannak nagyobb csoportokban és nem külön-külön értelmezve, ezért ez az eljárás nem okoz hibát. Ez az elv jelenik meg az UTF-8 tervezésekor is. Lásd :ref:`utf8` rész.

Amit beírunk egy XML dokumentumba:

.. code-block:: text

    <címke>literális és / ampersand jel: &amp; egy Latin-1-es hullámos o betű &otilde; és egy Latin-2-es magyar két vesszős o &odblac; egy fájlban leírva.</címke>

Ahogy megjelenik a ``<címke>`` címke tartalma (szintaktikai értelemmel nem bíró szöveg):

.. code-block:: text

    literális és / ampersand jel: & egy Latin-1-es hullámos o betű õ és egy Latin-2-es magyar két vesszős o ő egy fájlban leírva.

A karakterhivatkozások kitalálása után sokáig megszokott volt a régi programokkal való kompatibilitás: a különféle számítógépes architektúrák, mint a **big endian** és a **little endian** közötti átvihetőség (lásd :ref:`bitek sorrendje a szeles karakterben` rész) jegyében a speciális karaktereknek (a Latin kódtáblák, UTF-8 stb. elemei) az ASCII által kínált készlettel kompatibilis módon való, hivatkozással történő leírása. Hátrányként említhető, hogy így az absztrakciós szintek összekeverednek, mivel egy karakter valójában több karakterrel íródik le, ami megnehezíti például a reguláris kifejezések írását (pl. negáció), és biztonsági hibákat is eredményezhet (pl. `„double encoding” támadások <https://en.wikipedia.org/wiki/Double_encoding>`_) a korlátos karakterkészlet adta hamis biztonságérzet miatt.

Manapság minden program kompatibilis az UTF-8 szabvánnyal, és a fenti leíró nyelvekben kódolt szövegekben majdnem minden literális alakban szerepel, és csak minimális számú hivatkozás van használatban – ezek a „kisebb” (``<``), „nagyobb” (``>``), az „és” (``&``) és az „idézőjel” (``"``) karakterek. Ezeknek a hivatkozásoknak két típusa van: a **numerikus karakterhivatkozás (numeric character reference)** és a **karakteregység hivatkozás (character entity reference)**, melyekre elég úgy utalnunk, hogy **HTML-entitás**. Ez egy olyan karakterlánc, amely egy „és” jellel / „ampersanddal” (``&``) kezdődik és egy pontosvesszővel (``;``) végződik.

Például:

.. table::
    :align: center

    +----------------------+----------------------------+----------+
    | Numerikus hivatkozás | Karakteregység hivatkozás  | Karakter |
    +======================+============================+==========+
    | &#60;                | &gt;                       | <        |
    +----------------------+----------------------------+----------+
    | &#62;                | &lt;                       | >        |
    +----------------------+----------------------------+----------+
    | &#38;                | &amp;                      | &        |
    +----------------------+----------------------------+----------+
    | \&\#34;              | &quot;                     | "        |
    +----------------------+----------------------------+----------+


A később létrejött Unicode kódtábla karaktereinek hivatkozásaiban – a karakterek számának drasztikus növekedésére reagálva – a numerikus hivatkozások váltak elterjedtebbé. A numerikus karakterhivatkozásokban a számok a kódpontokra utalnak. Például a ``&#123`` és ``&#x7B`` karakterhivatkozások esetében az első a **decimális** (10-es számrendszer szerinti), a második a **hexadecimális** (16-os számrendszer szerinti) forma. A 16-os számrendszerben a 0-9 számok mellett az A, B, C, D, E és F betűk is használatosak a 10-15-ös érték egy helyiértéken történő jelöléséhez. A hexadecimális formát az x-szel való prefixálás jelzi. A karakterkészletek közötti konverzió nem változtat ezeken a hivatkozásokon, de ezeket is el lehet rontani karakterkonverzió során (lásd :ref:`kodolasi hibak, furcsasagok` rész).

Bár a böngészők igyekeznek a felhasználó elől jótékonyan elrejteni, kétféle karakterhivatkozást is alkalmaznak az URL-eken belül: (a) az elérési útban található ékezetes betűk jelölésére használatos, százalék jelekkel prefixált hexadecimális számokkal való kódolás (**URL encode** és **URL decode**) és (b) az ékezetes doménnevek kódolásakor az úgynevezett `„Punycode” <https://en.wikipedia.org/wiki/Punycode>`_, mely az ``„xn--”`` előtagról ismerhető fel (**Punycode encode** és **Punycode decode**). Valamint az Unicode karaktereknek vannak további hivatkozásai is, melyek szintén az ASCII kompatibilitást szolgálják (lásd :ref:`ascii kararakterhivatkozasok` rész). Az alábbi táblázat példákon keresztül mutatja be a böngészőben használható karakterhivatkozásokat (a böngésző címsorába illesztve tesztelhető a visszaalakításuk):

.. table::
    :align: center

    +-------------------------------------------------------------------------------------------------------+
    | .. centered:: A Wikipedia Árvíztűrőtükörfúrógép cikke, UTF-8 kódolásban *URL encode-olva*             |
    +=======================================================================================================+
    | ``https://hu.wikipedia.org/wiki/%C3%81rv%C3%ADzt%C5%B1r%C5%91_t%C3%BCk%C3%B6rf%C3%BAr%C3%B3g%C3%A9p`` |
    +-------------------------------------------------------------------------------------------------------+
    | .. centered:: A ``https://www.árvíztűrőtükörfúrógép.hu`` domén *Punycodeban*                          |
    +-------------------------------------------------------------------------------------------------------+
    | .. centered:: ``https://www.xn--rvztrtkrfrgp-bbb7j2b8f0b9d7a21oft.hu``                                |
    +-------------------------------------------------------------------------------------------------------+

Ahogy a bináris formátumoknál (lásd :ref:`binaris formatumok` rész), itt is az a fontos, hogy felismerjük a kódolást, mivel a beépített kódoló és dekódoló függvények segítségével könnyen kezelhetőek. Amennyiben hiba van, az valószínűleg a függvények egymás utáni helytelen sorrendben való alkalmazásából adódik, általában hasonló módon visszaalakítható az eredeti állapot (lásd :ref:`karakterkodolas a gyakorlatban` rész). 

.. _repulo ekezetek es proszeky-kod:

-------------------------------
Repülő ékezetek és Prószéky-kód
-------------------------------

Egy másik (az írógépektől átvett) megközelítés a különféle ékezetes karakterek előállítására más nyelvű vagy korlátozott billentyűzeten, hogy külön visszük be az ékezetet az alapbetűtől. Az úgynevezett **halott billentyű (dead key)** egy olyan mechanizmus, melyet a **compose key** lenyomásával hívunk elő, s melynek használatával létre tudjuk hozni azokat az ékezetes betűket, amelyek egyébként nem találhatóak meg a billentyűzeten külön billentyűn. Eredetileg az írógép a halott billentyű lenyomásakor a kocsi előremozdítása nélkül ugyanarra a karakterhelyre üti az ékezetet az újabb billentyű lenyomásával, és csak ezután mozdítja előre a kocsit.

A számítógépen az **AltGr** (compose key) lenyomásával együtt azt a billentyűt kell lenyomni a betűk feletti számbillentyűk sorából, amely a jobb alsó sarkában tartalmazza azt az ékezetet, melyet kombinálni akarunk az alapkarakterrel. A compose key lenyomásának következtében nem jelenik meg a beírt karakter, hanem az ezzel egyidőben, valamint ezután lenyomott karakterek kombinálódnak. Amennyiben például az ``ă`` betűt akarjuk leírni (magyar billentyűzetkiosztásban), azt a halott billentyű mechanizmus segítségével a következőképpen tehetjük meg:

1. Lenyomjuk az AltGr billentyűt (compose key).
2. Ezzel egyidőben pedig a 4-es billentyűt a betűk feletti számbillentyűk sorából, mivel a 4-es billentyű jobb alsó sarkában található a ``˘``, azaz a **căciulă** nevű ékezet.
3. Fölengedjük ezeket.
4. Végül pedig megnyomjuk az ``a`` billentyűt.

Így a két karakter egy karakter helyén jelenik meg, ugyanakkor az így létrehozott karakterek nem kompatibilisak az ASCII-val (lásd :ref:`normalizacio es spam szures` rész). Az ilyen karakterek ASCII-val kompatibilis jelölésére – azzal a megszorítással, hogy elég az ember számára érthetőnek maradni, hiszen nem mindig definiált *escape mechanizmus* (pl. a távirati stílusban a „kiissza” szó mechanikusan dekódolva helytelenül „kíssza” lesz) – az a megoldás, hogy külön jelöljük az ékezeteket a hozzájuk tartozó alapbetűtől, melyre az alábbi formák adottak (csak a kisbetűs formákat soroljuk fel, nagybetűk esetén csak az alapbetű cserélendő):

.. table::
    :align: center

    +---+----------+---------+-----------+----------+-----------------+--------------+
    |   | .. centered:: Repülő ékezetek  | (La)TeX  | Távirati stílus | Prószéky-kód |
    +===+==========+=========+===========+==========+=================+==============+
    | á | a'       |      'a |      \\'a | \\'{a}   | aa              | a1           |
    +---+----------+---------+-----------+----------+-----------------+--------------+
    | é | e'       |      'e |      \\'e | \\'{e}   | ee              | e1           |
    +---+----------+---------+-----------+----------+-----------------+--------------+
    | í | i'       |      'i |      \\'i | \\'{\i}  | ii              | i1           |
    +---+----------+---------+-----------+----------+-----------------+--------------+
    | ó | o'       |      'o |      \\'o | \\'{o}   | oo              | o1           |
    +---+----------+---------+-----------+----------+-----------------+--------------+
    | ö | o:       |      :o |      \\:o | \\"{o}   | oe              | o2           |
    +---+----------+---------+-----------+----------+-----------------+--------------+
    | ő | o"       |      "o |      \\"o | \\H{o}   | ooe             | o3           |
    +---+----------+---------+-----------+----------+-----------------+--------------+
    | ü | u:       |      :u |      \\:u | \\"{u}   | ue              | u2           |
    +---+----------+---------+-----------+----------+-----------------+--------------+
    | ű | u"       |      "u |      \\"u | \\H{u}   | uue             | u3           |
    +---+----------+---------+-----------+----------+-----------------+--------------+


A **repülő ékezeteknél** az alapbetű előtt vagy után jelenik meg az ékezet, és a konvenciótól függően kell az ilyen ékezeteket ``\`` karakterrel kieszképelni. A **(La)TeX formalizmusban** kicsit eltérő a formátum, például a hosszú ``ő`` karakternél a ``H`` a *Hungarian-re* utal. A **távirati stílusban** a hosszú magánhangzók dupla rövid magánhangzókkal helyettesítendők, illetve az ``ő`` és ``ű`` esetén egy extra ``e`` betűt kapnak, hogy megkülönböztethetőek legyenek az ``ó`` és ``ú`` betűktől. Létezik továbbá a **Prószéky-kód**, ahol `az egyes ékezettípusok meg vannak számozva, és az alapbetű után kerülnek <http://nyelvor.c3.hu/special/prokod.pdf>`_. Ezek a megoldások manapság igen ritkán használatosak, többnyire korlátozott környezetben (Morse-kód, rádiózás), de a régi szövegek tartalmazhatnak hasonló megoldásokat.
