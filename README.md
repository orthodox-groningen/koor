# README voor de `koor`-repo.

Deze repo is nog in ontwikkeling. Als hij klaar is bevat hij allerlei zaken ten behoeve van het koor van de orthodoxe parochie in Groningen, zoals koormappen, en audio bestanden om liederen te leren zingen. 

- De [productie website](https://orthodox-groningen.github.io/koor/) wordt automatisch gebouwd wanneer naar de `main` branch wordt gepusht. 
- De [preview website](https://orthodox-groningen.github.io/koor/preview/) wordt automatisch gebouwd wanneer er een PR wordt afgesloten.

## Voor ontwikkelaars

### Opzetten en testen van de site

We gebruiken [HUGO](https://gohugo.io/documentation/) om statische websites te genereren. 

Als je lokaal wilt testen moet je eerst [HUGO downloaden](https://github.com/gohugoio/hugo/releases) en de binary installeren. Zorg dat je daarna de map met de Hugo binary/executable aan je systeem PATH toevoegt. 

De server opstarten doe je met: `hugo server --disableFastRender --cleanDestinationDir`.
Als hij draait geeft hij de URL waar je de site kunt bekijken - doorgaans is dat `http://localhost:1313/koor/`.
Vergeet niet de cache van je browser te disabelen (zit mogelijk bij devtools), zodat je wijzigingen ook daadwerkelijk/meteen terug ziet komen in je browser.

Nu kun je in je editor (ik gebruik VSCode) wijzigingen anbrengen in de content; de server ziet dat en past de site meteen aan zodat je in je browser min of meer direct de wijzigingen te zien krijgt.
