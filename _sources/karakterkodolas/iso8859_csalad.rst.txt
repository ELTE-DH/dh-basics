
.. _iso 8859 csalad:

------------------
Az ISO 8859 család
------------------

Az **ISO (International Organization for Standardization)** is az ASCII-t vette alapul egy „univerzális” kódtábla kialakításához, mely a „világ” többi nyelvét is megpróbálta reprezentálni, kevés sikerrel. Egészen az 1980-as évekig komoly problémának minősült Európa országainak, valamint néhány más ország különböző nyelvi karaktereinek a standardizálása is.

Az 1980-as években az **ISO 8859 standard család, más néven Latin kódtáblák** oldották meg ezt a problémát, amelyek több nyelvet tudnak kombinálni. Ezt úgy érték el, hogy az új kódtáblákban a 7-bites ASCII kódtáblát egy bittel kiegészítve 8-bitesre bővítették – hiszen addigra a 8. bit hibajelző szerepe eltűnt –, ezzel megduplázva a rendelkezésre álló karakterek számát (2\ :sup:`8` = 256), hogy reprezentálni tudják a **nyugat-európai ékezetes betűket**, és elnevezték **Latin-1** táblának, majd létrehoztak egy kelet-európait is, melyet **Latin-2-nek** neveztek el, **ebben van a magyar nyelv is**. Több ilyen kódtábla is keletkezett (*Latin-3*, *Latin-4* stb., egészen *Latin-16-ig*), melyek más-más karaktercsoportokra voltak tervezve. Ma ezek a kódtáblák az **ISO/IEC 8859 karakterkódolási rendszerbe** tartoznak.

A különböző nyelvek reprezentációja új problémákat szült: a *lokalizáció* kérdését. Az egyes nyelvek ugyanis más ábécésorrendbe rendezést követeltek meg, valamint ezzel összefüggésben a több karakterből álló betűk egységes kezelése – például a reguláris kifejezéseknél az ``[a-z]`` tartomány definíciója (lásd :ref:`lokalizacio es rendezes` rész) – is problémát jelentett. Sajnos ezek megnyugtató rendezésére a *Unicode* karakterkészlet megjelenéséig várni kellett.

A Latin kódtáblák kódtáblánként két részre oszthatók. Az első 128 karakter minden esetben az ASCII kódtábla maga – kontroll karakterek (például a *TAB*), nagy- és kisbetűk, számok, punktuációk –, és a második 128-ban vannak a táblánként különböző nyugat- és kelet-európai vagy más nyelvi ékezetek és speciális központozási jelek (pl. ``ö``, ``ü``). A Latin kódtáblák rendszere előnyös volt, mert ugyan külön-külön kódtáblákon, de belefért 1 bájtba (8 bit) az összes, a kódtáblában reprezentált nyugati és európai nyelv, az egyes kódtáblákkal pedig még több nyelv is egységesen kezelhetővé vált. A rendszer így nem követelt technikai oldalról nézve inkompatibilis változtatást az domináns ASCII-hoz vagy a használatban lévő (8-bitet egyben kezelni tudó) hardverekhez képest, mely a gyors elterjedéséhez vezetett.

Emiatt a kompromisszum miatt a különböző, eltérő kódtáblához sorolt nyelveket nem lehet egy fájlon belül használni. A különböző nyelvekhez tartozó karakterek beírásához nyelvet és fájlt kell váltani. Az ékezetes karakterek különböző variánsai úgy vannak elhelyezve a kódtáblákon, hogy az egyező és hasonló karakterek ugyanarra a kódpontra essenek, könnyítve rossz kódtábla használata esetén is az olvashatóságot. A megfelelő nyelvű karakterek megjelenítéséhez a fájlt a megfelelő kódtáblában kell megnyitni, különben máshogy jelennek meg ugyanazok a betűk, noha a kódjuk ugyanaz. Például:

.. table::
    :align: center

    +--------------------------+---------------------------------------+
    | .. centered:: Kódtábla   | .. centered:: Ékezetes példaszöveg    |
    +==========================+=======================================+
    | .. centered:: ISO8859-1  | .. centered:: árvíztûrõ tükörfúrógép  |
    +--------------------------+---------------------------------------+
    | .. centered:: ISO8859-2  | .. centered:: árvíztűrő tükörfúrógép  |
    +--------------------------+---------------------------------------+
    | .. centered:: ISO8859-3  | .. centered:: árvíztûrġ tükörfúrógép  |
    +--------------------------+---------------------------------------+
    | .. centered:: ISO8859-4  | .. centered:: árvíztûrõ tükörfúrķgép  |
    +--------------------------+---------------------------------------+
    | .. centered:: ISO8859-5  | .. centered:: сrvэztћrѕ tќkіrfњrѓgщp  |
    +--------------------------+---------------------------------------+
    | .. centered:: ISO8859-7  | .. centered:: αrvνztϋrυ tόkφrfϊrσgιp  |
    +--------------------------+---------------------------------------+
    | .. centered:: ISO8859-9  | .. centered:: árvíztûrõ tükörfúrógép  |
    +--------------------------+---------------------------------------+
    | .. centered:: ISO8859-10 | .. centered:: árvíztûrõ tükörfúrógép  |
    +--------------------------+---------------------------------------+
    | .. centered:: ISO8859-13 | .. centered:: įrvķztūrõ tükörfśrógép  |
    +--------------------------+---------------------------------------+
    | .. centered:: ISO8859-14 | .. centered:: árvíztûrõ tükörfúrógép  |
    +--------------------------+---------------------------------------+

Ez nehézkes feladat, ezért sokszor a felhasználók a tipográfiailag nem helyes variánsokat használják – vagy egyszerűen ékezet nélkül írnak, ami az ékezetesítés problémáját hozta magával –, annak tudatában, hogy a helyes kódtáblával megnyitva az ékezetek úgyis helyesen fognak megjelenni.
Az ilyen kódolású szövegek manapság szinte egytől egyig konvertálva lettek *UTF-8-ra*. A problémát utólag az okozza, hogy nem megfelelő bemeneti kódtáblát használtak a konverzió során. Például manapság is találkozhatunk hullámos ő-vel (``õ``) és kalapos ű-vel (``û``), mely a **Latin-2** kódtábla helyett helytelenül használt **Latin-1**-re – és ilyen formában Unicode-ra konvertálásra – utal. Szerencsére az ő és ű betűn kívül a magyar ábécé betűi benne vannak a Latin-1 kódtáblában, mivel más lefedett nyelvek betűivel egyeznek:

.. table::
    :align: center

    +-------------------------------+------------------------------------------------------------------------------------------+
    | .. centered:: Latin-1         | .. centered:: Latin-1 kódtábla által lefedett nyelvek,                                   |
    | .. centered:: kódtáblában     | .. centered:: amelyek szintén használják a magánhangzót                                  |
    | .. centered:: szereplő        |                                                                                          |
    | .. centered:: magyar ékezetes |                                                                                          |
    | .. centered:: magánhangzók    |                                                                                          |
    +-------------------------------+------------------------------------------------------------------------------------------+
    | á                             | afrikaans, feröeri, galíciai, izlandi, ír, norvég, okcitán, portugál, skót gael, spanyol |
    +-------------------------------+------------------------------------------------------------------------------------------+
    | é                             | | afrikaans, angol, galíciai, izlandi, ír, olasz, norvég, okcitán, portugál, skót gael,  |
    |                               | | spanyol, svéd                                                                          |
    +-------------------------------+------------------------------------------------------------------------------------------+
    | í                             | afrikaans, feröeri, galíciai, izlandi, okcitán, portugál, spanyol                        |
    +-------------------------------+------------------------------------------------------------------------------------------+
    | ó                             | olasz, norvég, okcitán, portugál, skót gael, spanyol                                     |
    +-------------------------------+------------------------------------------------------------------------------------------+
    | ö                             | luxemburgi, norvég                                                                       |
    +-------------------------------+------------------------------------------------------------------------------------------+
    | ú                             | afrikaans, feröeri, izlandi, ír, okcitán, portugál, spanyol                              |
    +-------------------------------+------------------------------------------------------------------------------------------+
    | ü                             | luxemburgi, norvég, spanyol                                                              |
    +-------------------------------+------------------------------------------------------------------------------------------+

Amennyiben a rossz ékezeteket tartalmazó fájlokban helyre kívánjuk hozni a karaktereket, az UTF-8 formátumú fájlt először nagy valószínűséggel Latin-1-re kell konvertálni, majd Latin-2-ként megnyitva újra UTF-8-ra (lásd :ref:`betuszemet` valamint :ref:`kodolasi hibak, furcsasagok` rész). Mivel az UTF-8 sokkal több karaktert képes kódolni, a konverzió nem mindig fut le hibátlanul. Az adatvesztés elkerülése végett ilyenkor célszerűbb „keresés és csere” módszert alkalmazni.

Több hasonló próbálkozás is volt az ISO szervezetén kívül, például az **Apple Macintosh MacRoman** kódtáblája vagy az **IBM codepage 850-es (CP850)** rendszer (és a **CP852**, amely a magyar ékezeteket tartalmazza hasonlóan a Latin-2 kódtáblához), melyet a **DOS (Disk Operating System)** családba tartozó rendszerek használnak. Ezekben kódolt szövegekkel egyre kisebb eséllyel ugyan, de manapság is találkozhatunk. A Windows sokáig a **windows-1250** (Közép- és Kelet-Európa) és a **windows-1252** (latin ábécé) nevű kódlapot használta, ezekkel mostanság főleg régi honlapokon találkozhatunk. Hiába, a régi mondás még mindig igaz:

.. figure:: ../images/karakterkodolas/iso8859_csalad/xkcd_927_standards.png
   :align: center
