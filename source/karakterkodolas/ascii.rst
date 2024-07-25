
.. _ascii:

=====
ASCII
=====

Az automatizált kommunikációs berendezések, mint a szikratávíró, ahol a hardver még sokban hasonlított egy írógépre – annyi különbséggel, hogy nem tartozott hozzá személyzet –, hatékonyságuk miatt hamar elterjedtek vezetékes és vezeték nélküli átviteli rendszerek formájában jóval az első „igazi” számítógépek megjelenése előtt. Különféle gépek küldtek és fogadtak szöveges üzeneteket, ezért a távközlési cél széles megvalósításához az általuk használt kódrendszereket szabványosítani kellett. Az első ilyen átfogó és elterjedt szabvány az **ASCII (American Standard Code for Information Interchange)** kódtábla volt, amit 1967-ben vezettek be.

Az ASCII minden karaktert **7-biten** kódol (2\ :sup:`7` = 128 karakter). A nyolcadik bit eleinte az átviteli hibák jelzésére szolgált, később figyelmen kívül hagyták. Az ASCII kódtábla azonban még így is a *Braille-írás* vagy *Morse-kód* által leírható karakterek számánál kétszer többet foglal magában. Az 1967-es változata már tartalmaz kis és nagy angol betűket, számokat és központozási jeleket (összesen 95-öt), valamint úgynevezett vezérlő karaktereket (összesen 33-at) az automatizált írógépek közötti szövegátvitelhez és megjelenítéshez. Ezek a karakterek megtalálhatóak a modern kódtáblákban, mivel kivétel nélkül mindegyik (legalább kifejezőerejében, ha reprezentációban nem is mindig) az ASCII-ra épül.

.. _a szokas hatalma:

----------------
A szokás hatalma
----------------

Az ASCII kódtáblában a számok és nagybetűk elsőbbsége a kezdetleges írógépektől jön (lásd :ref:`bevitel gyorsitasa` rész), melyek eleinte csak számokat, majd számokat és nagybetűket tudtak írni, kisbetűket csak jóval később. A számítógépes megjelenítőkben használt 80-as/120-as sorszélesség az írógépre és annak elődeire vezethető vissza (lásd :ref:`iras kozbeni formazas` rész). A két médium tulajdonságainak összeegyeztetése és egységes kezelése adta az ASCII erősségét a kortársaival szemben.

A kialakításakor – és még napjainkban is – a szövegeknek a papíralapú és a folyamatosan fejlődő digitális kijelzőkön történő kezelése egymás mellett volt jelen. A digitális kijelző viszont nem rendelkezik a távíró szalagjának vagy az írógép papírjának korlátaival, hiszen az „végtelenségig” görgethető vízszintesen és függőlegesen is, mint egy végtelen „festővászon”. Ámde az időben előre haladást valahogy reprezentálni kellett. Az addigi gépesített megoldások (a szalagos távírók és a későbbi fényújság oldalra görgetése) nyomán az ókori tekercsek analógiája, a **függőleges görgetés** honosodott meg a modernebb „könyvek lapozása” analógia helyett, ahol több dolgot is kezelni kellett volna egyszerre. (Illusztráció: `Medieval helpdesk with English subtitles <https://www.youtube.com/watch?v=pQHX-SjgQvQ>`_). A mai napig tart a „függőlegesen folyamatosan görgethető tekercs” elméleti szembenállása a „könyvbe szervezhető” diszkrét lapokkal, amelyekhez tartalomjegyzék készülhet, hogy így oda lehessen lapozni a kívánt oldalhoz. A tekercs és könyv. mint a folytonosság szervezésének formája sokszor visszatérő analógiák az informatikában, az ASCII kódtáblában viszont helytakarékosság miatt csak az első van kezelve.

Az ASCII a szöveg gépi kezelését segítő szabványok láncolatában pont középen helyezkedik el: a benne foglalt elvek, valamint az azokat kivitelező *vezérlőkarakterek* meghatározó része, ahogy a szövegek kezelésének többi fogalma is az írógépektől származik, de a képernyőkön egyaránt jól alkalmazható. Emiatt az ASCII a **szöveges megjelenítőkben (command line terminal)** a mai napig használatban van, miközben napjainkig lehetővé teszi a digitális kijelzők fejlődését a szabványokkal való folyamatos kompatibilitás révén az írógépektől napjainkig (Illusztráció: `Helpdesk version 2.0 with English subtitles <https://www.youtube.com/watch?v=Yq3IkQoX5_I>`_). A következő hasonlóan nagy és előremutató szabványosítási lépés, a hálózati átvitel pedig a **TCP/IP protokoll** megjelenése volt 1975-ben, mely az 1983-as **Berkely sockettel** kiegészülve nyerte el a szabványos, ma is használt formáját, és lett a mai Internet alapja. `Ezzel nagyjából egyidőben, több lépésben alakult ki <https://en.wikipedia.org/wiki/History_of_email>`_ az **email (e-mail) szabvány**, mely eleinte a hálózati átvitel fejlődése nélkül csak szűk kör számára volt elérhető, de végül a két szabvány együtt hozta el a forradalmat. És bár mindkét szabvány sok réteggel bővült az idők során, a kezdeti megfontolások változatlanok bennük.


.. _a vezerlokarakterek:

-------------------
A vezérlőkarakterek
-------------------

A vezérlőkarakterek egy része a mai napig használatban van, míg más részük már csak történelmi örökség. A mai napig használt vezérlőkarakterek a következők:

- **Kocsi vissza (Carriage Return, CR)**: térjen vissza a lap bal oldalára.
- **Soremelés (Line Feed, LF)**: lépjen a következő sorba.
- **Tulátor (TAB)**: a behúzást segíti vízszintesen egy változó szélességű szóközzel (a hossza hagyományosan megfelel 4 vagy 8 szóköznek, de a környezet definíciójától függően tetszőlegesen állítható).
- **NULL (NUL)**: eredetileg a lyukkártyákon az üres helyeket jelentette (pl. sor végén), manapság jelzi a memóriában a szöveges tartalom végét az alacsony szintű programozási nyelvekben, bizonyos esetekben határoló karakterként használható.
- **Lapdobás (Form Feed, FF)**: a képernyőt törli (mint a *page down* billentyű). Gyakorlatilag a „következő, üres oldalra lapozással” kiüríti a tartalmát, mintha üres lap jönne, de az előző lap bármikor visszahozható.
- **Szóköz (Space)**: egy üres helyet hagy ki két karakter között – technikailag nem vezérlőkarakter, hanem **nem megjeleníthető (non-printable)** karakter.
- **Visszalépés (Backspace, BS)**: törli a legutolsó karaktert, és visszalép annak helyére (gyakorlatilag balra ír egy szóközt).
- **Fájlvége (End of File, EOF)**: a fájl vagy a bemenet végét jelző speciális „karakter”, mely soha nem tárolódik, mivel csak egy jelzésre szolgáló minden más bemeneti egységtől megkülönböztethető extremális elem. Hasonlóan a *csengő (bell)* karakterhez, amely az írógépeken kívül már nem használatos, de kompatibilitás miatt az ASCII része.
- **Escape karakter (ESC)**: egy olyan karakter, amely azt jelzi, hogy az utána következő vezérlőkarakter sima karakterként értelmezendő, vagy fordítva, a sima karakter vezérlőként. Csak logikailag maradt fenn, nem pedig a konkrét használatban: általában a ``\`` karakterrel lehet „kieszképelni” egy vezérlőkaraktert, a **literális (betű szerinti)** ``\`` karaktert pedig duplázva (``\\``) lehet megjeleníteni (lásd :ref:`ascii kararakterhivatkozasok` rész).

A kocsi vissza és soremelés karakterek az írógépektől származnak, és együttesen végzik el az új sorba lépést. A *Windowsban* az új sorok kocsi vissza, illetve soremelés vezérlőkarakterekkel vannak jelölve (``\r\n``), viszont *Linuxban* csak soremelés van (``\n``), a régi *Macintosh* rendszerekben pedig csak kocsi vissza volt, de már átálltak soremelésre. A nem a vártnak megfelelően jelölt új sorok esetében azt tapasztalhatjuk, hogy a szöveg minden sora egy sorként jelenik meg (Linuxos sorvégek Windowsban, pl. *Jegyzetömbben* megnyitva), vagy minden sor végén egy extra kocsi vissza jel (``\r``) szerepel (Windowsos sorvégek Linuxban megnyitva tetszőleges szövegszerkesztővel, lásd :ref:`kulonfele sorvegek` rész).


.. _a reprezentacio:

---------------
A reprezentáció
---------------

Az ASCII történelmileg 7 bittel dolgozik, így összesen 128 karaktert tud eltárolni. A későbbi számítógépekben megjelenő 8. bit használata opcionális (lásd :ref:`elet egy bajton tul` rész). Mivel minden bit vagy 0 vagy 1 lehet, mindegyik két lehetőséget reprezentálhat, ami a hét helyiérték kombinációját tekintve: 2⋅2⋅2⋅2⋅2⋅2⋅2 = 2\ :sup:`7` = 128. Ebből könnyű megjegyezni, hogy a számítógépek bináris rendszerében a kettőt a rendelkezésre álló bitek számának megfelelően hatványra emelve megtudjuk, hogy a bitsorozatunk hány kombinációt képes reprezentálni. Az alábbi táblázatban a hét bit látható: az alsó sor tartalmazza a bitek értékét, ami lehet 0 vagy 1, a felső sor pedig a helyiértéket, amit képviselnek:

.. table::
    :align: center

    +-------------+------------------+------------------+------------------+-----------------+-----------------+-----------------+-----------------+
    | helyi érték | .. centered:: 64 | .. centered:: 36 | .. centered:: 16 | .. centered:: 8 | .. centered:: 4 | .. centered:: 2 | .. centered:: 1 |
    +-------------+------------------+------------------+------------------+-----------------+-----------------+-----------------+-----------------+
    | bit értéke  | .. centered:: 1  | .. centered:: 0  | .. centered:: 0  | .. centered:: 0 | .. centered:: 0 | .. centered:: 0 | .. centered:: 1 |
    +-------------+------------------+------------------+------------------+-----------------+-----------------+-----------------+-----------------+

A kódtáblában először a vezérlőkarakterek jönnek, majd matematikai jelek, számok, a nagybetűk és pár központozási jel, végül a kisbetűk. Például a nagy a betű (``A``) esetében – ami a ``1000001``-es bináris reprezentációt kapta, vagyis a 64-es és az 1-es helyiértékeken lévő bitek értéke 1, a többi pedig 0 tehát – 64 + 1, a bitek összértéke, ami a decimális számrendszerben jelölve 65.


.. _kis- es nagybetusites:

-----------------------
A kis- és nagybetűsítés
-----------------------

A karakterek elhelyezése nagyon tudatos volt, hogy elősegítse a gyakori műveletek, pl. a kis- és nagybetűsítés gyors elvégzését. Az ASCII-ban a betűk rendre a következőképpen vannak kódolva:

.. table::
    :align: center

    +----------------------+-----------------------------+-----------------------------+
    | .. centered:: Betű   | .. centered:: Reprezentáció | .. centered:: Reprezentáció |
    |                      | .. centered:: nagy változat | .. centered:: kis változat  |
    |                      | .. centered:: (A-Z)         | .. centered:: (a-z)         |
    +----------------------+-----------------------------+-----------------------------+
    | .. centered:: a      | .. centered:: ``1000001``   | .. centered:: ``1100001``   |
    +----------------------+-----------------------------+-----------------------------+
    | .. centered:: b      | .. centered:: ``1000010``   | .. centered:: ``1100010``   |
    +----------------------+-----------------------------+-----------------------------+
    | .. centered:: c      | .. centered:: ``1000011``   | .. centered:: ``1100011``   |
    +----------------------+-----------------------------+-----------------------------+
    | .. centered:: ...    | .. centered:: ...           | .. centered:: ...           |
    +----------------------+-----------------------------+-----------------------------+
    | .. centered:: z      | .. centered:: ``1011010``   | .. centered:: ``1111010``   |
    +----------------------+-----------------------------+-----------------------------+

Így a 7-bites kódolás miatt a 8-bites egységek első bináris számjegyét nem tekintve (a példákban 1-el jelöljük mindenhol), elég volt csak a második bináris számjegyből megállapítani, hogy kis- vagy nagybetűről van-e szó (1 vagy 0 az érték), és aztán az utolsó ötből megállapítani a betűt. Tehát a kis/nagybetűk konverziójához elég volt a második bitet átállítani. Például a nagy z (``Z``) karakter reprezentációjában, ami ``1X11011``, az X-et nulláról egyre állítva kisbetűsíthető a karakter.

A kis a-tól (``a``, ``1100000``) a nagy z-ig (``Z``, ``1011011``) az angol ábécé karakterei a rendelkezésre álló 5 bitből (2\ :sup:`5` = 32) csupán 26 kombinációt foglaltak le, ezért a fennmaradó 6 lehetőséget felhasználták olyan speciális karakterek kódolására, mint pl. a zárójelek.  Igyekeztek ezeket is úgy választani, hogy az eltolásuk („shiftelésük”) logikus legyen. Így lettek egymás „nagy és kisbetűs” párjai a nyitó és záró zárójelek szögletes (``[`` és ``]``) és kapcsos (``{`` és ``}``) formái: az egyik fajta nyitó vagy záró jelről a másik fajta, de azonosan nyitó vagy záróra változtatható egy bit módosításával.

Az ASCII tökéletesen megfelel az angol nyelv számára, és a korai elterjedése miatt a legtöbb karakterkódolási rendszernek az ASCII az alapja a mai napig. Viszont elég csak Európára gondolnunk, hogy lássuk a számtalan nyelv sajátosságaiból fakadó problémákat, melyeket az ASCII kialakításakor nem kezeltek.


.. _ascii rajzok:

------------------------
ASCII rajzok (ASCII art)
------------------------

Az ASCII 128 karakteréből 95 nyomtatható. A kódtáblával egyidőben elindult egy művészeti ág, mely a nyomtatható karakterek segítségével készített számítógépes rajzokat foglalta magába. Ez az ASCII és más későbbi kódtáblák változatos médiumokon (pl. írógép, terminál) való használatának köszönhetően `számos formát öltött <https://en.wikipedia.org/wiki/ASCII_art>`_ (pl. statikus, animált). Ennek a művészei formának a mai napig nagy kultusza van. Vannak programok, melyek képesek képeket illetve videókat akár animált **ASCII art** formába alakítani (lásd :ref:`ascii rajzok es videok` rész), valamint az így készült rajzoknak `külön archívuma <https://www.asciiart.eu/>`_ is van. Érdemes összevetni az emojikkal, melyek később jelentek meg (lásd :ref:`megjelenites es komb`).
