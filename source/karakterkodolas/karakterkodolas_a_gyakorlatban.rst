.. _karakterkodolas a gyakorlatban:

==============================
Karakterkódolás a gyakorlatban
==============================

Az alábbiakban példákon keresztül Python és Linux környezetben mutatjuk be a karakterkódolást.

.. _ascii kararakterhivatkozasok:

------------------------------------------
ASCII karakterhivatkozások (fehérszóközök)
------------------------------------------

Pythonban a láthatatlan ASCII karakterek a szokványos hivatkozásokkal írhatóak le:

.. code-block:: python

    >>> print("Soremelés: -->\n<-- Egy fordított törtvonal: \\ Tab: -->\t<-- az idézőjel befejezi a stringet, de \" formában leírható literális alakban is.")
    Soremelés: -->
    <-- Egy fordított törtvonal: \ Tab: --> <-- az idézőjel befejezi a stringet, de " formában leírható literális alakban is.

Az amúgy szintaktikai jelentéssel bíró karakterek, mint az idézőjel (``"`` és ``'`` használattól függően) és a fordított törtvonal (``\``) literális formában fordított törtvonallal prefixálva (``\"``, ``\'`` és ``\\``) írhatóak le, ahogy a példa is mutatja.


.. _unicode karakterhivatkozasok:

----------------------------
Unicode karakterhivatkozások
----------------------------

A Unicode karakterhivatkozásoknak sok fajtája van. Érdemes kipróbálni `az alábbi oldalon <https://onlineunicodetools.com/escape-unicode>`_ található opciókat, melyek különböző programozási nyelvek által használt jelöléseket alakítanak át. Pythonban a következő hivatkozás alakban leírt Unicode karakterek automatikusan a literális alakjukká konvertálódnak:

.. code-block:: python

    >>> print("Unicode escape (kódpont, 4 számjegyű): \u00e1\u0072\u0076\u00ed\u007a\u0074\u0171\u0072\u0151\u0074\u00fc\u006b\u00f6\u0072\u0066\u00fa\u0072\u00f3\u0067\u00e9\u0070")
    Unicode escape (kódpont, 4 számjegyű): árvíztűrőtükörfúrógép
    >>> print("Unicode escape (kódpont, 8 számjegyű): \U000000e1\U00000072\U00000076\U000000ed\U0000007a\U00000074\U00000171\U00000072\U00000151\U00000074\U000000fc\U0000006b\U000000f6\U00000072\U00000066\U000000fa\U00000072\U000000f3\U00000067\U000000e9\U00000070")
    Unicode escape (kódpont, 8 számjegyű): árvíztűrőtükörfúrógép
    >>> print("Kis ő betű név szerint hivatkozva: \N{Latin Small Letter O with Double Acute}")
    Kis ő betű név szerint hivatkozva: ő
    >>> print(b"UTF-8 escape (csak ASCII!): \xc3\xa1\x72\x76\xc3\xad\x7a\x74\xc5\xb1\x72\xc5\x91\x74\xc3\xbc\x6b\xc3\xb6\x72\x66\xc3\xba\x72\xc3\xb3\x67\xc3\xa9\x70".decode("UTF-8"))
    UTF-8 escape (csak ASCII!): árvíztűrőtükörfúrógép
    >>> print(b"UTF-8 escape (csak ASCII!): \xc3\xa1\x72\x76\xc3\xad\x7a\x74\xc5\xb1\x72\xc5\x91\x74\xc3\xbc\x6b\xc3\xb6\x72\x66\xc3\xba\x72\xc3\xb3\x67\xc3\xa9\x70")
    b'UTF-8 escape (csak ASCII!): \xc3\xa1rv\xc3\xadzt\xc5\xb1r\xc5\x91t\xc3\xbck\xc3\xb6rf\xc3\xbar\xc3\xb3g\xc3\xa9p

Az utolsó két példában a string UTF-8 kódolású alakjának bájtjai szerepelnek, ezért szükséges a Pythonban a literálist kezdő idézőjel előtt ``b`` prefixummal jelezni, hogy bájt és nem string literálisról van szó. A bájtszekvenciák a literális stringekkel ellentétben csak ASCII karaktereket és azokkal leírható hivatkozásokat tartalmazhatnak. Az ilyen formában írt hivatkozásokban a bájtok egymás utáni sorozatai összeadják az UTF-8 karaktereket azok láncolatát alkotva. Ezt a bájtsorozatot a ``decode()`` függvénnyel Unicode stringgé szükséges alakítani kiírás előtt, amennyiben szöveges kiírást szeretnénk. Az utolsó példában a ``print()`` függvény automatikusan felismeri, ha string helyett bájt szekvenciát kap, és a ``b`` prefixummal ellátott formában írja ki a bemenetet, nem úgy ahogy várnánk (lásd :ref:`python bajtok es karakterek` rész).

A Unicode karakterek nevei és `kategóriái <https://www.unicode.org/reports/tr44/#General_Category_Values>`_ az alábbi módon határozhatóak meg:

.. code-block:: python

    >>> import unicodedata
    >>> print(unicodedata.name("ő"))
    LATIN SMALL LETTER O WITH DOUBLE ACUTE
    >>> print("\N{LATIN SMALL LETTER O WITH DOUBLE ACUTE}")
    ő
    >>> print(unicodedata.category("ő"))
    Ll
    >>> print(unicodedata.category("Ő"))
    Lu
    >>> print(unicodedata.category("."))
    Po

A Python beépített reguláris kifejezés motorja nem támogatja a Unicode tulajdonságokat, ugyanakkor ezekre a gyakorlatban csak igen ritkán van szükség. Viszont arra vigyázni kell, hogy a karakterosztályokra illeszkedő reguláris kifejezések, például a számjegyekre illeszkedő ``\b`` nem csak a latin nyelvekben megszokott `nyugati arab számokra <https://hu.wikipedia.org/wiki/Hindu%E2%80%93arab_sz%C3%A1m%C3%ADr%C3%A1s>`_ fog illeszkedni:

.. code-block:: python

    >>> import re
    >>> s = "Thai számok: \u0e55\u0e57 , nyugati arab számok: 57"
    >>> print(s)
    Thai számok: ๕๗ , nyugati arab számok: 57
    >>> m = re.search("\d+", s)
    >>> print(m.group())
    ๕๗

Ha mégis Unicode tulajdonságok alapján szeretnénk Pythonban reguláris kifejezéseket illeszteni, akkor a `regex modul <https://github.com/mrabarnett/mrab-regex#unicode-codepoint-properties-including-scripts-and-blocks>`_ telepítésével megtehetjük.


.. _kodtablafuggetlen karakterhivatkozasok:

----------------------------------------------------------------
Kódtáblafüggetlen karakterhivatkozások előállítása és feloldása
----------------------------------------------------------------

A HTML és az XML numerikus hivatkozásainak kezelése rendre decimális és hexadecimális formában, a nem numerikus entitásokhoz hasonlóan működik. Az ``encode()`` és az ``escape()`` metódusok csak a nem reprezentálható karaktereket kódolják hivatkozással:

.. code-block:: python

    >>> import html
    >>> print(html.unescape("&#225;&#114;&#118;&#237;&#122;&#116;&#369;&#114;&#337;&#116;&#252;&#107;&#246;&#114;&#102;&#250;&#114;&#243;&#103;&#233;&#112;"))
    árvíztűrőtükörfúrógép
    >>> print("árvíztűrőtükörfúrógép".encode("ASCII", "xmlcharrefreplace")
    b'&#225;rv&#237;zt&#369;r&#337;t&#252;k&#246;rf&#250;r&#243;g&#233;p'
    >>> print(html.unescape("&#xe1;&#x72;&#x76;&#xed;&#x7a;&#x74;&#x171;&#x72;&#x151;&#x74;&#xfc;&#x6b;&#xf6;&#x72;&#x66;&#xfa;&#x72;&#xf3;&#x67;&#xe9;&#x70;"))
    árvíztűrőtükörfúrógép
    >>> print(html.escape("árvíztűrőtükörfúrógép & < > ' \" \\"))
    árvíztűrőtükörfúrógép &amp; &lt; &gt; &#x27; &quot; \
    >>> print("árvíztűrőtükörfúrógép".encode("latin1", "xmlcharrefreplace"))
    b'\xe1rv\xedzt&#369;r&#337;t\xfck\xf6rf\xfar\xf3g\xe9p'


Az URL-ekben található százalékjeles jelölés kezelése során a ``quote()`` metódus csak a nem ASCII és nem reprezentálható karaktereket kódolja hivatkozással:

.. code-block:: python

    >>> import urllib.parse
    >>> print(urllib.parse.unquote("%C3%A1rv%C3%ADzt%C5%B1r%C5%91t%C3%BCk%C3%B6rf%C3%BAr%C3%B3g%C3%A9p"))
    árvíztűrőtükörfúrógép
    >>> print(urllib.parse.quote("árvíztűrőtükörfúrógép & < > ' \" \\"))
    '%C3%A1rv%C3%ADzt%C5%B1r%C5%91t%C3%BCk%C3%B6rf%C3%BAr%C3%B3g%C3%A9p%20%26%20%3C%20%3E%20%27%20%22%20%5C'

A **JSON formátum** akkor használatos, ha rekurzív adatstruktúrákat akarunk átvinni ember által is olvasható, szöveges formában akár különféle programozási nyelvek között. Pythonban az alapbeállítás az, hogy ASCII kompatibilis formában adja meg a karaktereket, de ez felülbírálható:

.. code-block:: python

    >>> import json
    >>> print(json.dumps(["Ez egy stringekből álló lista.", "árvíztűrőtükörfúrógép"]))
    ["Ez egy stringekb\u0151l \u00e1ll\u00f3 lista.", "\u00e1rv\u00edzt\u0171r\u0151t\u00fck\u00f6rf\u00far\u00f3g\u00e9p"]
    >>> print(json.dumps(["Ez egy stringekből álló lista.", "árvíztűrőtükörfúrógép"], ensure_ascii=False))
    ["Ez egy stringekből álló lista.", "árvíztűrőtükörfúrógép"]


.. _a base64 kodolas:

----------------
A Base64 kódolás
----------------

Pythonban a base64 modul bájtokat vár, így magunknak kell kódolnunk a stringjeinket. A szabványos kódolási módszeren túl lehetőség van a ``+`` és ``/`` jelek helyett definiálni karaktereket. Például az URL-ekben ezeknek a karaktereknek szintaktikai jelentése van, így helyettük rendre ``-`` és ``_`` jeleket használnak szabványos helyettesítőként. Az `OpenPGP <https://hu.wikipedia.org/wiki/PGP>`_ szabványban a Base64 kódoláshoz hasonló, Radix64 módszert alkalmazzák az aláírókulcs reprezentációjára, ami tartalmaz még egy hibajavító kódot, a kimenet végéhez kötelezően hozzáfűzi a bemenet hibajavító, ellenőrző kódját, valamint kötelezően sortörést alkalmaz minden 76. karakter után. Publikus kulcsoknál találkozhatunk vele. A Radix64 kódolás nem a Python sztenderd könyvtár része.

.. code-block:: python

    >>> import base64
    >>> print(base64.b64encode("árvíztűrőtükörfúrógép???< >".encode("UTF-8")))
    b'w6FydsOtenTFsXLFkXTDvGvDtnJmw7pyw7Nnw6lwPz8/PCA+'
    >>> print(base64.b64decode(b"w6FydsOtenTFsXLFkXTDvGvDtnJmw7pyw7Nnw6lwPz8/PCA+").decode("UTF-8"))
    árvíztűrőtükörfúrógép???< >
    >>> print(base64.b64encode("árvíztűrőtükörfúrógép???< >".encode("UTF-8"), altchars=b"*,"))  # + és / helyett * és ,
    b'w6FydsOtenTFsXLFkXTDvGvDtnJmw7pyw7Nnw6lwPz8,PCA*'
    >>> print(base64.b64decode(b"w6FydsOtenTFsXLFkXTDvGvDtnJmw7pyw7Nnw6lwPz8,PCA*", altchars=b"*,").decode("UTF-8"))  # + és / helyett * és ,
    árvíztűrőtükörfúrógép???< >
    >>> print(base64.b64encode("arvizturot".encode("UTF-8")))
    b'YXJ2aXp0dXJvdA=='
    >>> print(base64.b64decode(b"aXp0dXJvdA==").decode("UTF-8"))  # Lecsípjük a kód első 4 karakterét és a kimenet első 3 karaktere hiányozni fog
    izturot


.. _a quoted-printable kodolas:

--------------------------
A Quoted-Printable kódolás
--------------------------

Az emailek szövegeiben található nem nyomtatható ASCII karakterek kódolására szolgáló Quoted-Printable kódolás előállítása és dekódolása a Python sztenderd könyvtár része. A quopri modul a base64 modulhoz hasonlóan bájtokat vár és ad vissza, így magunknak kell kódolnunk a stringjeinket.

.. code-block:: python

    >>> import quopri
    >>> s = "Ez egy hosszú szöveg ékezetekkel. Árvíztűrőtükörfúrógép. De csak a nem ASCII karaktereket változtatja meg."
    >>> e = quopri.encodestring(s.encode("UTF-8"))
    >>> e
    b'Ez egy hossz=C3=BA sz=C3=B6veg =C3=A9kezetekkel. =C3=81rv=C3=ADzt=C5=B1r=C5=\n=91t=C3=BCk=C3=B6rf=C3=BAr=C3=B3g=C3=A9p. De csak a nem ASCII karaktereket =\nv=C3=A1ltoztatja meg.'
    >>> print(e.decode("UTF-8"))  # Lehetne ASCII is. Ilyenkor láthatóvá válnak a sortörések, amiket a kódolás csinált.
    Ez egy hossz=C3=BA sz=C3=B6veg =C3=A9kezetekkel. =C3=81rv=C3=ADzt=C5=B1r=C5=
    =91t=C3=BCk=C3=B6rf=C3=BAr=C3=B3g=C3=A9p. De csak a nem ASCII karaktereket =
    v=C3=A1ltoztatja meg.
    >>> s2 = """Ez egy hossz=C3=BA sz=C3=B6veg =C3=A9kezetekkel. =C3=81rv=C3=ADzt=C5=B1r=C5=
    =91t=C3=BCk=C3=B6rf=C3=BAr=C3=B3g=C3=A9p. De csak a nem ASCII karaktereket =
    m=C3=B3dos=C3=ADtja."""
    >>> d = quopri.decodestring(s2.encode("UTF-8"))
    >>> print(d.decode("UTF-8"))
    Ez egy hosszú szöveg ékezetekkel. Árvíztűrőtükörfúrógép. De csak a nem ASCII karaktereket változtatja meg.

Ha a kódolás segítségével előálló bájtsorozatot újra karakterlánccá alakítjuk (akár ASCII akár a vele kompatibilis tetszőleges kódtábla pl. UTF-8 segítségével) és kiírjuk, akkor láthatjuk, hogy a hosszú sorok maximum 76 hosszúakra lettek tördelve. Az s2 változóba visszaírjuk a kapott stringet ``"""`` segítségével, hogy több soros literálist írhassunk be. Majd bájtokká konvertáljuk a dekódoláshoz, dekódoljuk a ``decodestring()`` függvénnyel és újfent karakterlánccá alakítjuk a kiíráshoz. Ekkor visszakapjuk az eredeti értéket.


.. _ekezetes zip kitomorites:

---------------------------------------------------------
Ékezetes fájlneveket tartalmazó ZIP archívum kitömörítése
---------------------------------------------------------

Ha olyan zip fájlt kapunk, amiben az ékezetek kitömörítéskor rossz kódolásban vannak, akkor a következő parancs egyikével helyes fájlnevekkel kitömöríthető az archívum:


.. code-block:: shell

    $ unzip -I1250 archivum.zip
    $ unzip -O852 archivum.zip

`A Windows 10 tömörített mappa funkciója az OEM charset értéket állítja 852-es karaktertáblával <https://hup.hu/comment/2904162#comment-2904162>`_ (lásd :ref:`iso 8859 csalad` rész).


.. _kulonfele sorvegek:

------------------
Különféle sorvégek
------------------

A Unix-alapú rendszerek – így a modern *macOS* verziók – csak a ``\n``-t használják a sorvégek jelzésére, míg a Windows ``\r\n``-t.
Régi macOS rendszereken csak a ``\r`` volt használatos. Ezekkel ritkán még találkozhatunk. A ``cat -v`` paranccsal ellenőrizhető a jelenlétük és a ``sed`` paranccsal helyes paraméterezésével alakíthatók át.

.. code-block:: shell

    # Linuxban megnyitva egy Windows-os stílusú szövegfájlt első látásra nem tapasztalunk semmit, hiszen mindkét karakter láthatatlan:
    $ echo -e "Ez egy pelda szoveg.\r\nMasodik sora.\r\n"
    Ez egy pelda szoveg.
    Masodik sora.

    $ echo -e "Ez egy pelda szoveg.\r\nMasodik sora.\r\n" | cat -v
    Ez egy pelda szoveg.^M
    Masodik sora.^M

    # A ^M-el jelölt karakterek a láthatóvá tett extra sorvégek.
    # Konvertálásuk parancssorban legegyszerűbben a sed paranccsal (üres karakterre való cseréléssel) történhet:
    $ echo -e "Ez egy pelda szoveg.\r\nMasodik sora.\r\n" | sed 's/\r$//' | cat -v
    Ez egy pelda szoveg.
    Masodik sora.

    # Ekkor csak a képernyőre kiírt szövegben tűnnek el az extra karakterek, a fájl tényleges átírásához a következő parancsra van szükség:
    $ sed -i 's/\r$//' fájl.txt
    # Vagy egy másik fájl létrehozásához:
    $ sed 's/\r$//' fájl.txt > fájl_unix.txt
    # A csak \r karakter tartalmazó fájlok átalakítása:
    $ sed -i 's/\r/\n/' fájl.txt
    # Vagy egy másik fájl létrehozásához:
    $ sed 's/\r/\n/' fájl.txt > fájl_unix.txt

A Python az úgynevezett **univerzális sorvégek (universal newlines)** funkciója segítségével minden szabványos újsorformátumot egységesen kezel, beolvasáskor, és kiíráskor Unix típusú sorvégeket használ, amennyiben nem írjuk fölül ezeket az alapértelmezéseket. Viszont figyelnünk kell arra, hogy ha nem adunk meg karakterkódolást, alapértelmezésben a rendszer beállításának megfelelőt használja, így előállhat Windowson Unix sorvégű fájl, Windows rendszernek megfelelő karakterkódolással (lásd :ref:`python bajtok es karakterek` rész).
Fontos megjegyezni továbbá, hogy minden szöveges fájl újsorral kell, hogy végződjön, mert különben ha hozzá akarunk illeszteni valamit a fájl végéhez akkor az az utolsó sorban folytatólagosan kerül kiírásra (pl. a prompt a fájl kiíratásánál). 


.. _lokalizacio es rendezes:

-----------------------
Lokalizáció és rendezés
-----------------------

Akkor tudunk váltani a lokalizációk között, ha az adott nyelv telepítve van. A ``locale -a`` paranccsal nézhetjük meg, hogy milyen lokalizációk vannak telepítve, illetve a ``locale`` paranccsal pedig megnézhetjük a különböző lokalizációs rétegek beállítását (felület nyelve, dátum, pénzformátum, ábécébe rendezés stb.):

.. code-block:: shell

    $ locale -a
    C
    C.utf8
    en_US.utf8
    hu_HU.utf8
    POSIX
    $ locale
    LANG=hu_HU.UTF-8
    LANGUAGE=
    LC_CTYPE=hu_HU.UTF-8
    LC_NUMERIC=hu_HU.UTF-8
    LC_TIME=hu_HU.UTF-8
    LC_COLLATE=hu_HU.UTF-8
    LC_MONETARY=hu_HU.UTF-8
    LC_MESSAGES=hu_HU.UTF-8
    LC_PAPER=hu_HU.UTF-8
    LC_NAME=hu_HU.UTF-8
    LC_ADDRESS=hu_HU.UTF-8
    LC_TELEPHONE=hu_HU.UTF-8
    LC_MEASUREMENT=hu_HU.UTF-8
    LC_IDENTIFICATION=hu_HU.UTF-8
    LC_ALL=

A lokalizációk tekintetében a legszembetűnőbb probléma a rendezés. Az alábbi parancs alapesetben az ASCII sorrendű rendezést fogja mutatni (karakterlánc típussal megadott számok és nagybetűk elől, ékezetes betűk leghátul):

.. code-block:: python

    >>> sorted(["A", "Á", "ő", "Ű", "B", "e", "a", "ny","gy", "z", "k", "4", "13"])
    ['13', '4', 'A', 'B', 'a', 'e', 'gy', 'k', 'ny', 'z', 'Á', 'ő', 'Ű']

De ha beállítjuk a magyar lokalizációt:

.. code-block:: python

    >>> import locale
    >>> locale.setlocale(locale.LC_ALL, "hu_HU.UTF-8")
    >>> sorted(["A", "Á", "ő", "Ű", "B", "e", "a", "ny","gy", "z", "k", "4", "13"], key=locale.strxfrm)
    ['13', '4', 'a', 'A', 'Á', 'B', 'e', 'gy', 'k', 'ny', 'ő', 'Ű', 'z']

A betűk a „helyükre” kerülnek, a (karakterlánc típussal megadott) számok viszont még mindig nem. Pythonban alapesetben a ``C.UTF-8/POSIX`` lokalizációt használja a rendszer, mivel ez a leggyorsabb, míg a Linux parancssorban, ha magyar nyelven szól hozzánk a rendszer, valószínűleg a magyar lokalizáció van beállítva. Azért csak valószínűleg, mert a kettő egymástól függetlenül tetszőlegesen állítható.

A Linux parancssor lokalizációinak további gyakorlati különbségeit az alábbi példán lehet látni (csillagokkal határolva jelöltük az illeszkedő részt):

.. code-block:: shell

    $ export LC_ALL=C.UTF-8; echo "egészen" | grep "[p-t]"
    egé*s*zen
    $ export LC_ALL=hu_HU.UTF-8; echo "egészen" | grep "[p-t]"
    egé*sz*en

A magyar lokalizáció esetén a ``p`` és ``t`` betűk között az ``sz`` betű is szerepel, így nem csak az ``s`` betűre illeszkedik a keresés, hanem az ``sz`` betű mindkét karaktere, szemben a ``C`` lokalizációval, amely esetében a keresés csak az ``s`` betűre illeszkedik. Hasonló meglepetések érhetik a felhasználót az ékezetes betűkkel kapcsolatban, valamint kis- és nagybetű érzéketlen módban.


.. _python kis es nagybetusites:

---------------------
Kis- és nagybetűsítés
---------------------

A `Python 3.12 dokumentációja a következőt írja <https://docs.python.org/3.12/library/locale.html>`_:

    There is no way to perform case conversions and character classifications according to the locale.

    [Nincs mód a nagy- és kisbetűk átalakítására és a karakterek osztályozására a nyelvterületnek megfelelően.]

Így `a török i-betűk helyes kis- és nagybetűsítésének eléréséhez külső könyvtárat kell használni <https://stackoverflow.com/questions/19703106/python-and-turkish-capitalization/72393581#72393581>`_:

.. code-block:: python

    >>> from icu import UnicodeString, Locale  # sudo apt install libicu-dev és pip install pyicu
    >>> lowercase_i_w_dot = "i"
    >>> uppercase_i_wo_dot = "I"
    # A locale beállítása az ICU-ban
    >>> tr = Locale("TR")
    # ICU uppercase:
    # 1. Az ICU féle UnicodeString típussá alakítjuk a Python str típusú stringet
    # 2. Meghívjuk a toUpper() metódust a nagybetűsítéshez
    # 3. Az eredményt visszaalakítjuk Python str típussá a további használathoz
    >>> uppercase_i_w_dot = str(UnicodeString(lowercase_i_w_dot).toUpper(tr))
    >>> print(uppercase_i_w_dot)  # LATIN CAPITAL LETTER I WITH DOT ABOVE
    İ
    # ICU lowercase
    # 1. Az ICU féle UnicodeString típussá alakítjuk a Python str típusú stringet
    # 2. Meghívjuk a toLower() metódust a kisbetűsítéshez
    # 3. Az eredményt visszaalakítjuk Python str típussá a további használathoz
    >>> lowercase_i_wo_dot = str(UnicodeString(uppercase_i_wo_dot).toLower(tr))
    >>> print(lowercase_i_wo_dot)  # LATIN SMALL LETTER DOTLESS I
    ı
    # A sima locale állítással nem megy
    >>> import locale
    >>> locale.setlocale(locale.LC_ALL, "tr_TR.UTF-8")  # Ha rendszerszinten telepítve van ez a locale
    # Beépített uppercase
    >>> print(lowercase_i_w_dot.upper())  # 'LATIN CAPITAL LETTER I'
    I
    >>> print(lowercase_i_w_dot.upper() == uppercase_i_w_dot)  # False
    False
    # Beépített lowercase
    >>> print(uppercase_i_wo_dot.lower())  # 'LATIN SMALL LETTER I'
    i
    >>> print(uppercase_i_wo_dot.lower() == lowercase_i_wo_dot)  # False
    False


Nem várható el minden esetben, hogy a kis- vagy nagybetűsített string hossza meg fog egyezni a bemenetével, vagy hogy a kis- és nagybetűsítés pontosan egymás ellentétét fogja jelenteni, ha sorban egymás után végezzük el ezeket a műveleteket. A kis- és nagybetű érzéketlen összehasonlításra a ``casefold()`` metódus ad helyes megoldást, mely agresszíven kisbetűsít és transzliterál a nagyobb egyezés eléréséhez:

.. code-block:: python

    >>> s = "ß"
    >>> print(len(s))
    1
    >>> su = s.upper()
    >>> print(su)
    SS
    >>> print(len(su))
    2
    >>> print(s.upper().lower() == s)
    False
    >>> print(s.casefold() == su.casefold())
    True


Ahogy az sem várható el, hogy minden karakter vagy kis- vagy nagybetűs, ebből következően pedig, hogy minden karakter átalakítható legyen kisbetűsből naggyá vagy fordítva:

.. code-block:: python

    >>> print(".".upper() == ".".lower())
    True
    >>> print(".".isupper())
    False
    >>> print(".".islower())
    False

.. _a bom:

-----------------------
A BOM (byte order mark)
-----------------------

Bár ritkán lehet manapság találkozni vele, de ha egy extra karaktert látunk a fájl elején, akkor valószínűleg BOM-mal van dolgunk. Ilyenkor a következő gyakorlati tudnivalókra érdemes odafigyelni:

- Pythonban a BOM-os UTF-8 kódolású fájlokat a ``utf_8_sig`` kódolásban megnyitva kiszedi a rendszer a BOM karaktert a fájl elejéről, egyéb esetben (pl. ``UTF-8``-cal megnyitva) otthagyja.
- Linuxban a ``cat`` parancs (egy vagy több fájl paraméter esetén) nem távolítja el a BOM karaktert.
- A ``sed`` paranccsal `le lehet vágni a BOM karakter a fájl elejéről <https://unix.stackexchange.com/questions/381230/how-can-i-remove-the-bom-from-a-utf-8-file/381263#381263>`_: ``sed -i '1s/^\xEF\xBB\xBF//' orig.txt``
- UTF-16 és UTF-32 kódolás esetén Pythonban lehetőségünk van automatikusan a BOM-ból meghatározni a bájtsorrendet (``UTF-16`` és ``UTF-32``), vagy manuálisan megadni (``UTF-16BE``, ``UTF-32BE``, valamint ``UTF-16LE``, ``UTF-32LE``), ez utóbbi esetben nem számít a rendszer BOM karakterre.


.. _python bajtok es karakterek:

-------------------------------------------------
A Python hozzáállása a bájtokhoz és karakterekhez
-------------------------------------------------

Míg a Linux parancssorában egy-két archaikus kivételtől eltekintve (pl. ``tr`` és ``wc -c`` parancsok) Unicode karakterekkel dolgozhatunk.
Létezik az `uutils <https://uutils.github.io/>`_ csomag, mely a parancssori eszközök gyűjteményének Rust nyelvű implementációja, mely teljes mértékben Unicode kompatibilis és csereszabatos az eredeti parancsokkal, de jelenleg még nem alapértelmezett a Linux disztribúciókban. Számos `weboldal <https://dencode.com/en/>`_ is elérhető, ahol a különféle kódolások kipróbálhatóak szükség esetén.

Pythonban lehetőség van bájtokkal és karakterekkel is dolgozni hasonló interfészeken. A fő szabály ilyenkor az, hogy követni kell a használt típust, vagy pedig explicit módon konvertálni (pl. ``encode()`` és ``decode()``). Érdekesség, hogy `lehet saját dekódoló szabályokat definiálni <https://hup.hu/node/182170>`_, de erre igen ritkán van szükség.

.. code-block:: python

    # Fájl megnyitása olvasásra szöveges módban
    >>> fh = open("input.txt", encoding="UTF-8")
    # Fájl megnyitása olvasásra bináris módban
    >>> fh = open("input.txt", "rb")
    # String literális megadása
    >>> s = "Ez egy string"
    # Bájtstring literális megadása (csak ASCII karaktereket tartalmazhat)
    >>> b = b"Ez egy string"
    # Stringből bájtstring és fordítva (meg kell adni a kódolást explicit módon!)
    >>> b2 = s.encode("UTF-8")
    >>> s2 = b.decode("UTF-8")
    # A kódolásnak és dekódolásnak a már ismertetett beállítási lehetőségei vannak
    >>> b2 = s.encode("UTF-8", "replace")
    >>> s2 = b.decode("UTF-8", "ignore")
    # Ha egy függvény mindkét formát elfogadja, akkor arra kell számítani, hogy a bemeneti formátumban kapjuk a kimenetet is:
    >>> import os
    >>> os.listdir(".")
    ['fájl.txt', 'mappa', ...]
    # Míg bájtként adva a paramétert
    >>> os.listdir(b".")
    [b'fájl.txt', b'mappa', ...]

A Python a fájl megnyitása után csak a megfelelő típusú változókat engedi beleírni a fájlba, egyéb esetben hibát ad. Ha a megnyitott fájlt átadjuk egy külső könyvtárnak (pl. ``pickle``, ``json``, ``beautifulsoup4``), érdemes binárisan megnyitni a fájlt, mert ekkor a könyvtárakra bízunk minden hibakezelést. Ha rossz kódolásban nyitjuk meg a fájlt szövegfájlként, akkor nekünk kell a hibákat kezelni, emellett a dekódolás szükségtelenül lassíthat a feldolgozáson.

A Python ``open()`` függvénye alapesetben szöveges fájlként olvasásra fogja megnyitni a fájlt (ezért az ``"r"`` opció elhagyható), de a kódolását alapesetben a rendszer kódolása alapján (a ``locale.getpreferredencoding()`` függvény értéke) határozza meg. Így az a kód, amely Linuxon működik implicit UTF-8-at használva, Windows esetén hibát adhat, illetve írásnál meglepő eredményekre vezethet, mivel a rendszer alapbeállítása nem UTF-8. Ezért érdemes mindig expliciten megadni a várt kódolást.


.. _a fajlok kodolasanak explicit megadasa:

--------------------------------------
A fájlok kódolásának explicit megadása
--------------------------------------

Nem mindig lehet 100%-os pontossággal automatikusan meghatározni egy fájl kódolását (pl. a Latin kódtáblák közötti különbségtétel). A fájlok típusáról, illetve a kódolásukról a ``file`` parancs tud bővebb információt nyújtani:

.. code-block:: shell

    $ file /etc/passwd
    /etc/passwd: ASCII text

Egy másik lehetőség a `chardet <https://github.com/chardet/chardet>`_ Python könyvtár parancssori eszköze:

.. code-block:: shell

    $ chardetect /etc/passwd
    /etc/passwd: MacRoman with confidence 0.7192171344165436

Amint látjuk, ez a megoldás nem tévedhetetlen. `Továbbá magyar szövegek kódolásának meghatározására jó ideje nem alkalmas. <https://github.com/chardet/chardet/commit/da6c0a079c41683ca475e28364fcf9c4d34f4359>`_


Ha meghatároztuk a kódolást, az ``iconv`` paranccsal lehet egész fájlok kódolását megváltoztatni:

.. code-block:: shell

    $ iconv -f latin2 -t UTF-8  /etc/passwd > output.txt


Pythonban a forrásfájlok kódolása alapértelmezésben UTF-8, ha ettől eltérünk, azt a fájl elején a `kódolás nevének <https://docs.python.org/3.12/library/codecs.html#standard-encodings>`_ megadásával kell jelezni (a példában latin2 kódolás szerepel). Forrásfájlok és szöveges fájlok esetén a szerkesztőprogramok ilyenkor képesek értelmezni az explicit jelölést, és ehhez igazítani megnyitáskor a kódolást:

.. code-block:: python

    **# -*- coding: latin2 -*-**

XML fájlokban manapság UTF-8 kódolást várnak el, de ezt is expliciten jelölni kell az XML deklarációjánál a fájl elején:

.. code-block:: XML

    <?xml version="1.0" encoding="UTF-8"?>

HTML esetén a ``head`` címke alatt kell jelölni egy ``meta`` címkében a kódolást:

.. code-block:: XML

    <html>
    <head>
    <meta charset="UTF-8">
    ...
    </head>
    ...
    </html>

Abban az esetben, ha egy HTML vagy XML fájl valódi kódolása eltér a definíciójában szereplő kódolástól (pl. a valódi kódolás UTF-8, de az XML definíciója szerint latin2), akkor a fájl feldolgozása betűszeméthez vezethet, mely nem ad explicit hibaüzenetet, csak rossz adatot. A következőképpen javítható ilyenkor a fájl (az egész fájl memóriába olvasása nélkül):

.. code-block:: python

    >>> import codecs
    # 1. A fájl bináris módban történő megnyitása
    >>> fh = open("fájl.xml", "rb")
    # 2. A fájl valódi kódolásának megfelelő kódolásban történő dekódolását végző iterátor definiálása
    >>> str_it = codecs.iterdecode(fh, "UTF-8")
    # 3. A dekódolt fájl újrakódolása a deklarált kódolás szerint (a kimenet egy bájtokat adó generátor lesz, ami soronként megy végig a fájlon)
    >>> byte_it = codecs.iterencode(str_it, "latin2")
    # 4a. A bájtok fájlba írása
    >>> open("fájl_fixed.xml", "wb").writelines(byte_it)
    # 4b. VAGY a bájtok összeállítása egy bytestring típussá (ami már hiba nélkül beadható pl. a BeautifulSoup-nak)
    >>> fixed_bytestring = b"".join(byte_it)


.. _kodolasi hibak, furcsasagok:

---------------------------
Kódolási hibák, furcsaságok
---------------------------

Az „árvíztűrőtükörfúrógép” természetesen nem kódolható ASCII formátumban az ékezetek miatt, de karakterhivatkozásokkal vagy a nem kódolható karakterek kihagyásával, illetve ``\N{REPLACEMENT CHARACTER}``-re történő kicserélésével igen:

.. code-block:: python

    >>> s = "árvíztűrőtükörfúrógép"
    >>> print(s.encode("ascii", "namereplace"))
    b'\\N{LATIN SMALL LETTER A WITH ACUTE}rv\\N{LATIN SMALL LETTER I WITH ACUTE}zt\\N{LATIN SMALL LETTER U WITH DOUBLE ACUTE}r\\N{LATIN SMALL LETTER O WITH DOUBLE ACUTE}t\\N{LATIN SMALL LETTER U WITH DIAERESIS}k\\N{LATIN SMALL LETTER O WITH DIAERESIS}rf\\N{LATIN SMALL LETTER U WITH ACUTE}r\\N{LATIN SMALL LETTER O WITH ACUTE}g\\N{LATIN SMALL LETTER E WITH ACUTE}p'
    >>> print(s.encode("ascii", "xmlcharrefreplace"))
    b'&#225;rv&#237;zt&#369;r&#337;t&#252;k&#246;rf&#250;r&#243;g&#233;p'
    >>> s.encode("ascii", "ignore")
    b'rvztrtkrfrgp'
    >>> s.encode("ascii", "replace")
    b'?rv?zt?r?t?k?rf?r?g?p'
    >>> print(s.encode("latin2").decode("latin1"))  # Hibásan dekódolt latin2 kódolás
    árvíztûrõtükörfúrógép
    >>> print(s.encode("UTF-8").decode("latin1"))  # Hibásan dekódolt UTF-8 kódolás, betűszemét
    Ã¡rvÃ­ztÅ±rÅtÃ¼kÃ¶rfÃºrÃ³gÃ©p

Hasonlóan kényszeríthetők ki más kódolások is. Mivel a Unicode minden kódolást magában foglal, nem minden karakter kódolható például latin1-ben, de minden latin1 kódolású szöveg dekódolható például latin2-ben, ami bizonyos esetekben más karaktereket eredményez (lásd :ref:`betuszemet` rész). A problémák akkor kezdődnek, amikor egy karakterhivatkozásokkal tarkított ASCII karakterekre egyszerűsített stringet az entitások feloldása nélkül valódi ASCII kódolásban dekódolunk:

.. code-block:: python

    >>> b = "ő".encode("UTF-8").decode("ASCII", "backslashreplace")  # Nem feloldott entitások megmaradnak a string formában. Hiba!
    >>> print(b)
    \xc5\x91
    >>> print(b.encode('ASCII').decode('unicode-escape').encode('latin1').decode("UTF-8"))  # Az előző hiba helyrehozása
    ő
    >>> b = "ő".encode("ASCII", "backslashreplace")  # ASCII kompatibilis Unicode escape szekvencia
    >>> print(b)
    b'\\u0151'
    >>> bs = b.decode("ASCII")
    >>> print(bs)  # Itt konkrétan egy stringről van szó, ami "véletlenül" egybeesik az ő betű hivatkozásával
    \u0151
    >>> print(json.dumps([bs]))  # JSON formátumban kiírva a hibás string
    ["\\u0151"]
    >>> print(bs.encode("ASCII").decode("unicode-escape"))
    ő

A negyedik sor mutatja, hogy az UTF-8 bájtszekvenciák ``str`` típusból hogyan alakíthatóak vissza Unicode karakterekké: mivel a hibás string csak ASCII karaktereket tartalmaz, először ``bytes`` típussá lehet alakítani a tartalom változtatása nélkül. Viszont ekkor még minden escape szekvencia több karakterként (összesen 8 darab) értelmeződik, amit az ``unicode-escape`` kódolás átalakít két karakterré, de rosszul. A latin1 kódolás azért szükséges, hogy a tartalom változtatása nélkül ``bytes`` típussá tudjuk alakítani a stringünket, ami így már két karakter hosszú lesz, és dekódolható a normális UTF-8 kódolással. Az utolsó előtti sorban az elrontott string tartalma explicit módon visszaalakításra kerül ``bytes`` típusra a tartalom változtatása nélkül, amelyből feloldhatóak a tartalmazott Unicode escape szekvenciák. Az ilyen hibák elkerülésének legjobb módja az, ha csak minimális eszképelést használunk a kódolások során.

Az alábbi gyakorlati példa mutatja, hogy hányféle eszképelés keveredhet, ha ASCII kompatibilis JSON-ba rakunk HTML kód fragmentumokat, ami manapság igen gyakori:

.. code-block:: python

    >>> import json
    >>> import html
    >>> j = '{"description": "&lt;p&gt;&lt;strong&gt;&lt;span style=&quot;text-decoration: underline;&quot;&gt;V\\u00edzilabda, n\\u0151k, bronzm\\u00e9rk\\u0151z\\u00e9s, 16.20&lt;\\/span&gt;&lt;\\/strong&gt;&lt;br&gt; &lt;em&gt;Eddigi csoportm\\u00e9rk\\u0151z\\u00e9seink&lt;\\/em&gt;: &lt;br&gt; \\u2013 K\\u00edna \\u2013 Magyarorsz\\u00e1g 11\\u201313&lt;br&gt; \\u2013 Spanyolorsz\\u00e1g \\u2013 Magyarorsz\\u00e1g 11\\u201310&lt;br&gt; \\u2013 Magyarorsz\\u00e1g \\u2013 Egyes\\u00fclt \\u00c1llamok 6\\u201311&lt;br&gt;&lt;em&gt;Negyedd\\u00f6nt\\u0151&lt;\\/em&gt;&lt;br&gt;\\u2013 Ausztr\\u00e1lia \\u2013 Magyarorsz\\u00e1g 8\\u20138 \\u2013 \\u00f6tm\\u00e9teresekkel 3\\u20135&lt;em&gt;&lt;br&gt;El\\u0151d\\u00f6nt\\u0151&lt;\\/em&gt;&lt;br&gt; \\u2013 Magyarorsz\\u00e1g \\u2013 Egyes\\u00fclt \\u00c1llamok 10\\u201314&lt;br&gt; &lt;em&gt;Bronzm\\u00e9rk\\u0151z\\u00e9s&lt;\\/em&gt;&lt;br&gt; \\u2013 Magyarorsz\\u00e1g \\u2013 Oroszorsz\\u00e1g&lt;\\/p&gt;"}'
    >>> d = json.loads(j)  # A JSON gondoskodik a Unicode eszképelés visszaállításáról és a védett per- és fordított perjelekről
    >>> html_code = html.unescape(d['description'])
    >>> print(html_code)
    <p><strong><span style="text-decoration: underline;">Vízilabda, nők, bronzmérkőzés, 16.20</span></strong><br> <em>Eddigi csoportmérkőzéseink</em>: <br> – Kína – Magyarország 11–13<br> – Spanyolország – Magyarország 11–10<br> – Magyarország – Egyesült Államok 6–11<br><em>Negyeddöntő</em><br>– Ausztrália – Magyarország 8–8 – ötméteresekkel 3–5<em><br>Elődöntő</em><br> – Magyarország – Egyesült Államok 10–14<br> <em>Bronzmérkőzés</em><br> – Magyarország – Oroszország</p>

Előfordulhat, hogy a HTML kód fragmentumok nem jólformált HTML-t adnak, de ilyenkor a BeautifulSoup4 legjobb tudása szerint próbálja értelmezni a bemenetet. Általánosságban ezért érdemes ilyen esetekben a kód fragmentumokat jólformált egységekben tárolni, ahol minden címkének, idézőjelnek és zárójelnek megvan a párja, hogy a fragmentum kód szinten is értelmezhető és módosítható legyen. Máskülönben az idővel elkerülhetetlen módosítások során – amelyek várhatóan „keresés és csere” módszerrel fognak történni, nem értelmezve egyben a teljes kódot – további hiba csúszhat az adatba, amely a böngészők és a BeautifulSoup4 hibatűrése miatt csak későn kerül napvilágra.


.. _karakterek nyomtatasbeli szelessegenek meghatarozasa:

----------------------------------------------------
Karakterek nyomtatásbeli szélességének meghatározása
----------------------------------------------------

A `wcwidth <https://github.com/jquast/wcwidth>`_ Python könyvtár ki tudja számolni, hogy a beírt karakter vagy string hány ASCII karakternyi helyet fog foglalni nyomtatásban. Ez elsődlegesen az ázsiai nyelvek esetén érdekes:

.. code-block:: python

    >>> import wcwidth
    >>> text = "コンニチハ"
    >>> print(len(text))
    5
    >>> wcwidth.wcswidth(text)
    10


.. _lagykotojel kiszedese:

------------------------------------------
A feltételes kötőjel kiszedése a szövegből
------------------------------------------

A feltételes kötőjel (soft hyphen) és társai olyan nem látható karakterek, amelyek előfordulhatnak a szövegekben, amennyiben nyomdai célokkal készítették őket (pl. a webről letöltött szövegek, melyek tipográfiailag helyesen meg lettek jelenítve). Éppen ezért kell kiszedni őket az olyan szövegekből, amikre adatként kívánunk tekinteni. Az alábbi parancsok segítségével a feltételes kötőjel az karakterhivatkozásának segítségével kerül definiálásra, mielőtt eltávolítjuk az összes példányát a fájlból.

.. code-block:: shell

    # A fájl megváltoztatásával:
    $ sed -i $'s/\u00AD//g' fájl.txt
    # Vagy egy másik fájl létrehozásával:
    $ sed $'s/\u00AD//g' fájl.txt > fájl_unix.txt

A dollárjel (``$``) azért szükséges az string előtt, hogy a shell értelmezze a karakterhivatkozásokat a stringben. Idézőjellel (``"``) nem működik, csak aposztróffal (``'``).

Pythonban a feltételes kötőjel a következőképpen szedhető ki egy stringből a karakterhivatkozásának segítségével:

.. code-block:: python

    >>> s = "al\u00ADma"
    >>> s
    'al\xadma'
    >>> print(s)  # Nyomtatott formában nem látható, de az előző parancs kimenetén látszik, hogy ott van
    al­ma
    >>> s.replace("\u00AD", "")  # A csere után már nem szerepel
    'alma'
 

.. _nem unicode kompatibilis parancsok futtatasa:

--------------------------------------------
Nem Unicode kompatibilis parancsok futtatása
--------------------------------------------

A ``luit`` parancs segítségével szükség esetén egy Unicode kompatibilis terminálban futtathatunk olyan régi parancsokat, amik nem kompatibilisek az Unicode-dal, akár interaktív módon is. Így a régi parancsok modern környezetben is használhatóvá válnak.

.. code-block:: shell

    $ echo "árvíztűrőtükörfúrógép" > fájl.txt  # Az Unicode terminál eredeti beállításaival
    $ file fájl.txt
    fájl.txt: Unicode text, UTF-8 text
    $ luit -encoding ISO8859-2  # (A luit parancs telepítése után) új shellt hoz létre a megfelelő kódolással
    $ echo "árvíztűrőtükörfúrógép" > fájl.txt  # Ez már az új shellben történik
    $ file fájl.txt
    fájl.txt: ISO-8859 text
    $ LC_ALL=hu_HU luit [parancs]  # Az első megoldás alternatívája, a lokalizációt is beállítja
    $ [parancs] | luit -c -encoding ISO8859-2  # A régi program kimenetét alakítja Unicode formára
    $ luit -encoding ISO8859-2 [parancs]  # A parancs közvetlen futtatása a kívánt kódolással. Ilyenkor a kimenet átirányítása már Unicode formájú lesz


.. _ascii rajzok es videok:

----------------------
ASCII rajzok és videók
----------------------

Egy távoli szerverre bejelentkezve terminálon keresztül nem tudjuk megjeleníteni a különböző kép és videófájlokat. Ahhoz, hogy kapjunk egy „képet” arról, hogy hogyan néznek ki, mielőtt letöltenénk őket át kell őket konvertálni ASCII rajzzá vagy videóvá. Ehhez például a `jp2a <https://github.com/cslarsen/jp2a>`_ a `ascii-image-converter <https://github.com/TheZoraiz/ascii-image-converter>`_ programok használhatóak. Az újabb megoldások már képesek színeket és nem csak ASCII karaktereket alkalmazni a valódihoz közelebb álló rajzok előállításához.

.. code-block:: shell

    $ jp2a kép.jpg  # JPEG képeket lehet megjeleníteni ASCII formában
    ...
    $ ascii-image-converter kép.jpg  # A főbb képformátumokat támogatja
    ...
    $ mpv -vo=caca --quiet video.mp4 # A legtöbb videó formátumot le tudja játszani a terminálban ASCII art formában
    $ DISPLAY="" mpv -vo=caca --quiet video.mp4  # Az előző parancs kiegészítve, hogy grafikus felülettel rendelkező gépen ne nyisson új ablakot 

Léteznek olyan böngészők, amelyek terminálban is használhatóak, bár a képességeik igen alapvetőek. A `browsh <https://www.brow.sh/>`_ a weblapokon található képeket át tudja alakítani ASCII rajzzá a jobb felhasználói élmény érdekében.

Érdekesség, hogy vannak olyan művészeti projektek, ahol karakterkódolási és egyéb trükkök segítségével `az interneten keresztül lehet nézni ASCII arttal készült animációkat <http://mewbies.com/acute_terminal_fun_telnet_public_servers_watch_star_wars_play_games_etc.htm>`_ `vagy játszani játékokat <https://thenewstack.io/the-lost-worlds-of-telnet/>`_. Például a Star Wars VI. epizódját ASCII animációs változatban:

.. code-block:: shell

    $ telnet towel.blinkenlights.nl  
    ...

A fenti animáció `megnézhető böngészőből is <https://www.asciimation.co.nz/>`_.
