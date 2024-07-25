# Digitális bölcsészet alapok

Az alábbiakban összegyűjtött tudásanyag az [ELTE Digitális Bölcsészet Tanszék (ELTE-DH)](https://elte-dh.hu/) és [Digitális Örökség Nemzeti Laboratórium (DH-LAB)](https://dh-lab.hu/) által a digitáls bölcsészet műveléséhez elengedhetetlen szakmai kompetenciák elsajátításához és elmélyítéséhez kíván hozzájárulni. Fontosnak tartjuk, hogy ezen szakmai tudásbázis kúrált formában, egy helyen, szabadon elérhető legyen mindenki számára.

A közzétett anyag folyamatosan bővül és frissül új témákkal a mindennapi gyakorlatnak megfelelően. Szívesen vesszük a hozzászólásokat, hibajavításokat, kiegészítéseket.

## A közzétett anyag az alábbi címeken elérhető

- https://dh-basics.readthedocs.io/hu/latest/
- https://elte-dh.github.io/dh-basics/

## Fejlesztés

1. `git checkout main`: a main branchből kell indulni
2. `git pull`: frissíteni a repót
3. `git checkout -b [új_branch_neve]`
4. MÓDOSÍTANI valamit
5. Saját gépen tesztelni: `BUILDDIR='build' make html` (az eredmény a `build/html/index.html` megnyitásával látható)
6. `git commit -m 'üzenet'`: kommitolni beszédes kommit üzenettel
7. `git push --set-upstream origin [új_branch_neve]`: pusholni
8. `https://github.com/ELTE-DH/dh-basics/pull/new/[új_branch_neve]`: pull requestet csinálni
9. Megnézni, hogy builelődik-e, ha igen, akkor ok, ha nem javítani
   - All checks have passed?
   - Ha nem, akkor a `build-sphinx-to-gh-pages / build (pull_request)` sornál a `details`-re kell kattintani
   - A piros x-et kibontani és megnézni, hogy mi a baja
10. Ha minden jó, akkor `squash and merge` (ne feledjük szerkeszteni a kommit címét és szövegét) és automatikusan megjelenik az új anyag a gh-pagesban fél perccel később.

## Licenc

Az anyag a [Creative Commons, Nevezd meg! - Így add tovább! CC-BY-SA 4.0 Nemzetközi Licenc](https://creativecommons.org/licenses/by-sa/4.0/deed.hu) feltételeinek megfelelően, permalinkes (kattintható és az adott cikkre mutató) forrásmegjelöléssel szabadon felhasználható.
