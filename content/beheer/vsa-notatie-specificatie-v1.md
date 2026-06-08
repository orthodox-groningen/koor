---
title: "Vereenvoudigde Slavische Accentnotatie (VSA) - Specificatie (eerste concept)"
---

## Inleiding

<!-- http://www.ivanmoody.co.uk/orthodoxliturgylinks.htm  -->

De Slavisch‑orthodoxe zangtraditie kent een lange geschiedenis van **staffloze neumen­notatie**, waarvan de bekendste vorm de klassieke **Znamenny‑notatie** is. Deze notatie, ontwikkeld binnen de Oost‑Slavische kerkmuziek, gebruikt ideografische tekens (*kriuki* of *znamëna*) om melodische beweging, formules en expressie vast te leggen zonder exacte toonhoogtes. Een toegankelijke introductie is te vinden op de pagina over [Znamenny chant](https://en.wikipedia.org/wiki/Znamenny_chant), en een overzicht van de historische notatievormen staat beschreven onder [Znamenny musical notation](https://en.wikipedia.org/wiki/Znamenny_notation).

Hoewel deze officiële systemen rijk en complex zijn, ontstonden er in parochies door de eeuwen heen ook **vereenvoudigde, mondeling overgeleverde markeersystemen**. Deze systemen — vaak bestaande uit gestapelde streepjes boven de tekst en horizontale lijnen onder syllaben — dienden als praktische hulpmiddelen om **accent**, **richting** en **duur** van de zang aan te geven. Ze werden gebruikt door dirigenten en zangers zonder formele opleiding in de volledige kriuki‑traditie. Deze notaties zijn echter **nooit gestandaardiseerd**, **niet officieel gedocumenteerd**, en verschillen per regio, koorleider of lokale traditie.

Dit document introduceert een formele, systematische codificatie van deze praktijkgerichte notatie, en noemen die de **Vereenvoudigde Slavische Accentnotatie (VSA‑notatie)**. De VSA‑notatie is geen vervanging van de historische kriuki‑ of znamenny‑notatie, maar een **geformaliseerde synthese** van de best werkende elementen uit de lokaal gegroeide, mondeling overgeleverde werkwijzen. Het doel is om een notatie te bieden die:

- eenvoudig te leren is voor zangers zonder gespecialiseerde opleiding,
- nauw aansluit bij bestaande parochiële praktijk,
- formeel definieerbaar is in een grammatica,
- betrouwbaar te parseren en te renderen is in digitale omgevingen,
- en geschikt is voor gebruik in moderne workflows zoals statische websites, tekst‑gebaseerde editors en automatische renderers.

De VSA‑notatie legt dus niet de volledige rijkdom van de traditionele kriuki vast, maar biedt een **lichte, consistente en reproduceerbare** manier om Slavisch‑orthodoxe congregatiezang te noteren. De VSA-notatie beschrijft melodische beweging binnen een modaal toonstelsel waarin stapgrootten niet uniform zijn en afhankelijk zijn van de context van de gekozen grondtoon (de `do` van een toonladder).

Hoewel VSA primair een visuele zangnotatie is, bevat het voldoende semantische informatie om geautomatiseerde conversie naar symbolische muziekformaten zoals MusicXML mogelijk te maken.

In de rest van dit document wordt deze notatie volledig gespecificeerd, inclusief syntaxis, semantiek, voorbeelden en richtlijnen voor implementatie.

---

## Glossary

| Term | Betekenis |
|-------|-----------|
| Zangstuk | Een tekst die gezongen kan worden, zoals een tropaar of een kondak, en in de VSA-muzieknotatie is opgeschreven. |
| Toonhoogte-markering | Een speciale constructie aan het begin of einde van een zangstuk waarmee een absolute toonhoogte (de 'do') en optioneel een relatieve toonhoogtewijziging worden vastgelegd. Een toonhoogte-markering heeft de vorm [<absolute-toonhoogte><hoogte-modifier>:]. |
| Absolute toonhoogte | Een expliciete toonhoogteaanduiding, bijvoorbeeld C4, die dient als referentiepunt voor de interpretatie van de relatieve toonhoogtewijzigingen in een zangstuk |
| Zangelement-scope | Alle tekst (karakters) tussen `{` en `}`. Deze zijn verdeeld in (a) een optionele hoogte-modifier, (b) exact één zangelement en (c) een optionele lengte-modifier. |
| Zangelement | Een (doorgaans kleine rij) karakters waaraan muzikale informatie wordt gekoppeld. Een zangelement is vaak geen woord of lettergreep. |
| Renderen | Het omzetten van vsa-notatie naar een visuele weergave, bijvoorbeeld HTML, SVG of PDF. |
| Hoogte-modifier | Een rij karakters die melodische informatie specificeert (bijvoorbeeld of het zangelement hoger of lager gezongen moet worden, en hoeveel), en kan zijn samengesteld uit meerdere EHMs. |
| EHM (Enkelvoudige hoogte-modifier) | Een elementaire hoogte-modifier, zoals `/`, `\\` of `+/`. Deze zijn gespecificeerd in de tabel in hoofdstuk 2. |
| Lengte-modifier | Een rij karakters die ritmische informatie specificeert (bijvoorbeeld of het zangelement langer of korter duurt dan daarvoor, en hoeveel), en kan zijn samengesteld uit meerdere ELMs. |
| ELM (Enkelvoudige Lengte-Modifier) | Een elementaire lengte-modifier, zoals `_`, `__` of `.`. Deze zijn gespecificeerd in de tabel in hoofdstuk 3. |
| Samengestelde modifier | Een rij EHMs of ELMs gescheiden door `&`. |
| Muzikale positie | De kleinste muzikale eenheid binnen een zangstuk. Een muzikale positie representeert precies één gezongen toon met een bepaalde relatieve toonhoogte (vastgelegd door een EHM) en een bepaalde duur (vastgelegd door een ELM). Tijdens het renderen wordt een muzikale positie weergegeven als één kolom van het grid. Muzikale posities vormen samen de muzikale tijdlijn van het zangstuk. |
| Kolom | De grafische representatie van één muzikale positie tijdens het renderen. |
| Grid | Het renderobject waarop een zangelement-scope wordt weergegeven. Bestaat uit drie rijen: EHMs, zangelement en ELMs. |
| Glyph | De grafische representatie van een EHM of ELM. |

---

## 1. Regels

- De VSA notatie specificeert of en zo ja welke grafische elementen (glyphs) onder c.q. boven geselecteerde stukken tekst (zg. 'zangelementen') moeten worden geplaatst.
- Glyphs die onder c.q. boven een 'zangelement' worden gerenderd, moeten gecentreerd worden uitgelijnd met het zangelement.
- een **zangelement-scope** is al hetgeen tussen `{` en `}` staat.
- binnen een zangelement-scope mag geen whitespace (spaties, tabs, new lines e.d.) voorkomen.
- de inhoud van het zangelement-scope bestaat uit achtereenvolgens:
  - een (optionele) **hoogte-modifier**, die bestaat uit 1 of meer **EHMs (enkelvoudige hoogte-modifiers)**. Een EHM  is één van de in hoofdstuk 2 gedefineerde patronen die onderling zijn gescheiden/gekoppeld door het teken `&`. De hoogte modifier specificeert wat er boven het zangelement moet worden gerenderd. Zij laten zangers zien hoeveel er hoger of lager gezongen moet worden. Een niet bestaande/lege hoogte-modifier geeft aan dat het zangelement op dezelfde toonhoogte moet worden gezongen als diens voorganger.
  - een (verplicht) tekstelement (dat is dus het **zangelement**), die bestaat uit een niet-lege rij van tekens die gemakkelijk met een toetsenbord te maken zijn, behalve tekens die voor modifiers gebruikt kunnen worden. Als die nodig zijn kunnen ze buiten zangelement-scopes worden geplaatst (en dat is ook de bedoeling).
  - een (optionele) **lengte-modifier**, die bestaat uit 1 of meer **ELMs (enkelvoudige lengte-modifiers)**. Een ELM   is één van de in hoofdstuk 3 gedefineerde patronen die onderling zijn gescheiden/gekoppeld door het teken `&`. De lengte modifier specificeert wat er onder het zangelement moet worden gerenderd. Zij laten zangers zien hoeveel langer of korter (een deel van) een zangelement gezongen moet worden dan de standaard lengte. Een niet bestaande/lege lengte-modifier geeft aan dat het zangelement de standaard (basis) lengte heeft.
- de renderingen onder en/of boven het zangelement zijn onderling gecentreerd.
- de renderingen onder en/of boven het zangelement zijn goed leesbaar, ook op een afstandje.
- een **toonhoogte-modifier** is een EHM zonder de notatie die "handhaaf dezelfde toon" betekent.
- een **toonhoogte-markering** bestaat uit een (optionele) toonhoogte-modifier die wordt voorafgegaan door `[` en wordt gevolgd door `:]`. Het zijn optionele elementen, die alleen mogen voorkomen aan het begin en het eind van een zangstuk. Ze worden gerenderd als een horizontale streep op de baseline van de tekst met de rendering van de EHM daarboven.

---

## 2. Enkelvoudige Modifiers

Om veranderingen in hoogte en duur aan te geven tebruiken we twee basisconcepten:
- De **Enkelvoudige Hoogte Modifier (EHM)** beschrijft een beweging over de toonladder van de huidige grondtoon context.
- De **Enkelvoudige Lengte Modifier (ELM)** beschrijft hoe lang een noot duurt ten opzichte van de standaard-lengte (i.e. de duur van de meeste noten in een zangstuk)

### 2.1 EHMs 

De toonladder bestaat uit opeenvolgende graden (stappen) met variabele afstand. In de toonladder waar `C` de `do` (grondtoon) is, is de toonladder `C, D, E, F, A, B, C`. De afstand `D-E` en `B-C` zijn half zo groot als de andere afstanden. Bij toonladders met een andere grondtoon liggen die 'halve afstanden' op andere (vergelijkbare) plekken.

De volgende tabel specificeert de EHMs. De kolommen daarin worden als volgt gebruikt:
- `EHM`: de notatie voor een EHM zoals je die zou intypen (de exacte syntax specificaties staan [verderop](#vsa-syntax)).
- `Voorbeeld`: hoe de EHM gebruikt wordt in een zangelement-scope.
- `Betekenis`: hoe de hoogte van de toon verandert (de beweging over de toonladder van de huidige grondtoon context).
- `Teken`: wat verschijnt er in visuele renderingen boven de tekst (de exacte grafische vorm wordt bepaald door de [renderregels](#vsa-rendering)).

|   EHM    | Voorbeeld      | Betekenis  | Teken |
| :-----: | :------------: | :--------: | ----- |
| `+/`    | `{+/tekst}`    | 1/2 omhoog | `+` gevolgd door 1 streep schuin omhoog |
| `/`     | `{/tekst}`     | 1 omhoog   | 1 streep schuin omhoog |
| `//`    | `{//tekst}`    | 2 omhoog   | 2 gestapelde strepen schuin omhoog (vgl.: `=` schuin omhoog) |
| `///`   | `{///tekst}`   | 3 omhoog   | 3 gestapelde strepen schuin omhoog |
| `////`  | `{////tekst}`  | 4 omhoog   | 4 gestapelde strepen schuin omhoog |
| `/////` | `{/////tekst}` | 5 omhoog   | 5 gestapelde strepen schuin omhoog |
| `-`     | `{-tekst}`     | zelfde hoogte | een horizontaal streepje |
| `-\`    | `{-\tekst}`    | 1/2 omlaag | een horizontaal streepje gevolgd door 1 streep schuin omlaag |
| `\`     | `{\tekst}`     | 1 omlaag   | 1 streep schuin omlaag |
| `\\`    | `{\\tekst}`    | 2 omlaag   | 2 gestapelde strepen schuin omlaag (vgl.: `=` schuin omlaag) |
| `\\\`   | `{\\\tekst}`   | 3 omlaag   | 3 gestapelde strepen schuin omlaag |
| `\\\\`  | `{\\\\tekst}`  | 4 omlaag   | 4 gestapelde strepen schuin omlaag |
| `\\\\\` | `{\\\\\tekst}` | 5 omlaag   | 5 gestapelde strepen schuin omlaag |
| `~`     | `{~tekst}`     | een lege ruimte boven het zangelement (nodig in samenstellingen van modifiers) |

Merk op dat in een EHM het teken `&` niet voorkomt - het wordt gebruikt om EHMs mee samen te stellen.

---

### 2.2 ELMs

De volgende tabel specificeert de **enkelvoudige lengte-modifiers (ELM's)** zoals die gebruikt worden in de markdown tekst die gerenderd moet gaan worden. Ook geeft de tabel een voorbeeld van hoe deze wordt gebruikt, en wat er onder het zangelement moet worden gerenderd. Deze tabel in beschrijft de betekenis van ELMs semantisch. De exacte syntax specificaties staan [verderop](#vsa-syntax); de exacte grafische vorm wordt bepaald door de [renderregels](#vsa-rendering).

De volgende tabel specificeert de ELMs. De kolommen daarin worden als volgt gebruikt:
- `ELM`: de notatie voor een ELM zoals je die zou intypen (de exacte syntax specificaties staan [verderop](#vsa-syntax)).
- `Voorbeeld`: hoe de ELM gebruikt wordt in een zangelement-scope.
- `Duur`: de lengte van de noot ten opzichte van de standaardlengte.
- `Teken`: wat verschijnt er in visuele renderingen onder de tekst (de exacte grafische vorm wordt bepaald door de [renderregels](#vsa-rendering)).

|  ELM  | Voorbeeld    | Duur  | Teken |
| :---: | :----------: | :---: | ----- |
| `_`   | `{tekst_}`   |  2 x  | een streep (soort underline) onder het zangelement |
| `__`  | `{tekst__}`  |  4 x  | twee gestapelde strepen (soort `=`) onder het zangelement |
| `___` | `{tekst___}` |  8 x  | drie gestapelde strepen onder het zangelement |
| `.`   | `{tekst.}`   | 1/2 x | een goed zichtbare (dikke) punt gecentreerd onder het zangelement |
| `..`  | `{tekst..}`  | 1/4 x | twee gestapelde dikke punten gecentreerd onder het zangelement |
| `...` | `{tekst...}` | 1/8 x | drie gestapelde dikke punten gecentreerd onder het zangelement |
| `~`   | `{tekst~}`   | 1x  x | een lege ruimte onder het zangelement (nodig in samenstellingen van modifiers) |

Merk op dat in een ELM de tekens `&` niet voorkomt - het wordt gebruikt om EHMs mee samen te stellen.

---

### 2.3 Toonladdermodel (do-context en stapstructuur)

De VSA-notatie is gebaseerd op een contextuele toonladder die wordt bepaald door de actuele **do-context** (tonica). Deze toonladder is niet noodzakelijk chromatisch of gelijkverdeeld, maar kan bestaan uit ongelijke stappen die aansluiten bij modale zangpraktijken.

Elke toonhoogte-markering definieert een initiële absolute toonhoogte. Deze toonhoogte fungeert als de grondtoon (de 'do') voor de gebruikte toonladder. Het wordt gebruikt als referentiepunt voor de interpretatie van alle volgende relatieve toonhoogtebewegingen. Voorbeeld: `[C4:]` geeft aan dat `C4` de grondtoon (do) is van de gebruikte toonladder.

Binnen een do-context wordt een geordende reeks toonladdergraden afgeleid:

do → re → mi → fa → sol → la → ti → do

Deze graden vormen een cyclische structuur. De afstand tussen opeenvolgende graden is niet uniform en wordt bepaald door een afzonderlijke **modusdefinitie**. Een modus definieert welke overgangen binnen de toonladder grote stappen (hele ladderstap) of kleine stappen (halve ladderstap) zijn. In de **majeurmodus** zijn de kleine stappen: `mi → fa` en `ti → do`. In de **natuurlijke mineurmodus** zijn de kleine stappen: `re → mi` en `sol → la`. Een EHM beschrijft een beweging over deze toonladder:

| EHM  | Betekenis |
|------|----------|
| `/`  | ga één ladderstap omhoog (en bij `//` ga je twee ladderstappen omhoog) |
| `\`  | ga één ladderstap omlaag (en bij `\\` ga je twee ladderstappen omlaag) |
| `-`  | blijf op dezelfde toon |

Een **ladderstap** is een overgang van één graad naar de volgende in de toonladderstructuur.

Sommige ladderovergangen kunnen intern worden onderverdeeld in twee gelijke delen. In dat geval zijn de volgende EHM’s toegestaan:

| EHM  | Betekenis |
|------|----------|
| `+/` | ga een halve ladderstap omhoog |
| `-\` | ga een halve ladderstap omlaag |

Een halve ladderstap is alleen geldig indien de overgang tussen twee opeenvolgende graden expliciet is gedefinieerd als deelbaar in twee gelijke subposities. Indien geen substructuur beschikbaar is voor de betreffende overgang, is het gebruik van `+/` of `-\` een semantische fout.

EHMs worden sequentieel toegepast op de actuele toonhoogte. Elke EHM resulteert in een nieuwe toonhoogte binnen de toonladdercontext. De opeenvolging `[C4:], /, \\, ///` specificeert de rij toonhoogtes `C4 (do), D4 (re), B3 (ti), E4 (mi)`.

De absolute toonhoogte in de toonhoogte-markering dient uitsluitend als startreferentie. Alle verdere toonhoogten worden afgeleid via de ladderstructuur en EHM-sequenties. De exacte frequentie van tussenliggende graden kan per implementatie of muzikale traditie verschillen, zolang de relatieve volgorde consistent blijft.

Dit model impliceert:

- VSA is primair een **relatieve notatie**
- toonafstanden zijn **contextafhankelijk**
- melodische beweging is **discreet en stap-gebaseerd**
- het systeem ondersteunt zowel diatonische als fijnmazigere (sub-stap) bewegingen

Voor export naar systemen zoals MusicXML moet de implementatie:

1. de do-context omzetten naar een absolute referentietoon
2. de toonladder expliciet materialiseren in concrete toonhoogten
3. ladderstappen en substappen converteren naar exacte intervallen (bijv. halve tonen)

Indien meerdere interpretaties van de toonladder mogelijk zijn, moet de implementatie een expliciete mappingstrategie specificeren.

### 2.4 Zangnotatie syntax (uitgebreide specificatie)

#### 2.4.1. Kernmodel (renderconcept)

De notatie is een overlay-systeem op lineaire tekst met één horizontale tekstas. Er zijn 3 lagen:

- Tekstlaag (baseline): doorlopende tekst, niet gesegmenteerd door layout
- Bovenlaag (pitch overlay): symbolen boven specifieke tekstspans
- Onderlaag (duration overlay): symbolen onder specifieke tekstspans

Belangrijk principe:
- Tekst blijft altijd één continue string
- Annotaties zijn gekoppeld aan spans (tekstsegmenten)

#### 2.4.2. Zangelement-scope

Een zangelement wordt gedefinieerd als:

{<opt_height_modifier><text_element><opt_length_modifier>}

Regels:
- Scope tussen { en }
- Whitespace binnen scope wordt genegeerd
- Tekstelement is verplicht, behalve speciale cases

#### 2.4.3. Overlay model

Span {
  text: string
  start_index: int
  end_index: int
  above: list<glyph>
  below: list<glyph>
}

#### 2.4.4. Hoogte-modifiers (EHM)

| EHM     | Betekenis |
|---------|-----------|
| /       | +1 omhoog |
| //      | +2 omhoog |
| ///     | +3 omhoog |
| ////    | +4 omhoog |
| /////   | +5 omhoog |
| \      | -1 omlaag |
| \\    | -2 omlaag |
| \\\   | -3 omlaag |
| \\\\ | -4 omlaag |
| \\\\\ | -5 omlaag |
| -       | neutraal  |
| +/      | accent    |
| -\     | mixed     |
| ~       | placeholder |

#### 2.4.5. Lengte-modifiers (ELM)

| ELM   | Betekenis |
|-------|----------|
| _     | duur 1   |
| __    | duur 2   |
| ___   | duur 3   |
| .     | kort     |
| ..    | korter x2|
| ~     | leeg     |

#### 2.4.6. Composities

Modifiers kunnen met & gecombineerd worden:
- gelijk aantal componenten boven/onder vereist
- elk component krijgt eigen sub-slot

#### 2.4.7. Render model

Y+
[boven annotations]
TEKST
[onder annotations]
Y-

#### 2.4.8. Span model

span_width = max(text_width, annotation_width + padding)

#### 2.4.9. Special cases

{:} = lijn glyph

#### 2.4.10. Abstract Syntax Tree (AST)

Document -> Span[]
Span -> text + above[] + below[]
Glyph -> type + value + level

---

## 3. Samengestelde en gecombineerde Modifiers

De elementaire bouwsteen van de VSA-notatie is de muzikale positie. Elke muzikale positie representeert precies één gezongen toon met een bepaalde relatieve toonhoogte en een bepaalde duur.

Een zangelement-scope zonder samengestelde modifiers bevat precies één muzikale positie. Bijvoorbeeld:

`{/tekst_}`

Dit betekent dat het zangelement tekst wordt gezongen op één toon, waarvan de toonhoogte wordt bepaald door `/` en de duur door `_`.

In de praktijk komt het echter regelmatig voor dat dezelfde lettergreep of hetzelfde tekstfragment over meerdere opeenvolgende tonen wordt gezongen. Dit wordt in de muziektheorie een melisma genoemd. De VSA-notatie ondersteunt dit door meerdere muzikale posities aan één zangelement te koppelen.

Een samengestelde modifier bestaat uit twee of meer EHMs of twee of meer ELMs, gescheiden door het teken `&`.

Elke enkelvoudige modifier (EHM of ELM) representeert precies één muzikale positie. Het aantal muzikale posities van een zangelement-scope is daarom gelijk aan het aantal enkelvoudige modifiers waaruit de samengestelde modifier bestaat. Zo bevat `{-&/tekst~&_}` twee muzikale posities. De eerste met toonhoogte `~` (zelfde hoogte als de voorganger) en duur `~` (standaardduur), en de tweede met toonhoogte `/` (een toon hoger) en duur `_` (twee keer de standaardduur). Het zangelement `tekst` wordt daardoor over twee opeenvolgende tonen gezongen.

Indien zowel een hoogte-modifier als een lengte-modifier aanwezig zijn, moeten zij hetzelfde aantal muzikale posities bevatten. Iedere muzikale positie moet immers zowel een toonhoogte als een duur hebben.

Samengestelde modifiers maken het mogelijk om melismatische passages vast te leggen zonder het zangelement zelf op te splitsen.

Hier is een aantal voorbeelden

| Voorbeeld     | Effect |
| ------------- | ------------------------------- |
| `{tekst}`     | Alleen `tekst`, dus zonder hoogte- of lengte notaties. Dit is dus hetzelfde als `tekst` zonder de haakjes |
| `{\\tekst}`   | Boven `tekst` verschijnt een stapeling van 2 strepen omlaag |
| `{tekst_&_}`  | Onder `tekst` verschijnt 1 streep gevolgd door 1 streep |
| `{//&\tekst}` | Boven `tekst` verschijnt een stapeling van 2 strepen omhoog gevolgd door 1 streep omlaag |
| `{/tekst__}`  | Boven `tekst` verschijnt een streep omhoog en onder eronder 1 stapeling van 2 strepen |
| `{/&\&/tekst_&~&~}` | Boven `tekst` verschijnt een streep shuin omhoog, dan een streep schuin omlaag en weer een streep schuin omhoog. Onder de tekst verschijnt in het eerste 'vak'een horizontale streep (die dus ongeveer een derde van de ruimte van de tekst inneemt), gevolgd door twee ruimtes die leeg zijn |
| `[:]`         | Dit speciale tekstelement wordt gerenderd als een horizontale lijn (ongeveer als een `-` maar liefst iets langer) |
| `[//:]`       | Een horizontale lijn (ongeveer als een `-` maar liefst iets langer), met daarboven een stapeling van 2 strepen omhoog |
| `{/&\tekst_}` | Dit levert een fout op omdat de hoogte-modifer uit twee EHMs is samengesteld, terwijl de lengte-modifer uit slechts één ELM bestaat |

---

## 4. Parsen van zangstukken {#vsa-syntax}

Een zangstuk wordt in zijn geheel geparst (en daarna gerenderd). Parsing zoekt uit waar het zangelement-scopes zijn, en wat daarin de modifiers en het zangelement zijn, zodat die kunnen worden gerenderd.

De VSA notatie (grammatica) specificeren we middels ISO-14977 EBNF aangevuld met informele karakterklassen die we beschrijven tussen ? ... ?. Hier is een samenvatting van de elementen die voor een beginner misschien niet intuitief duidelijk zijn:

| schrijfwijze | Betekenis |
| :----------: | :-------- |
| (* ... *)    | betekent: kommentaar - deze tekst is geen onderdeel van de eigenlijke specificatie |
| [ ... ]      | betekent: optioneel (0 of 1 keer) |
| { ... }      | betekent: herhaling (0 of meer keer) |
| ( ... )      | betekent: groepering (exact 1 keer, tenzij gecombineerd met ?, *, +) |
| ? ... ?      | betekent: een beschrijving in natuurlijke taal van het te specificeren element |

LET OP: een `\` in EBNF begint een escape-sequentie. Als we het karakter `\` willen opschrijven,
dan moeten we hem verdubbelen: in EBNF stelt `\\` dus het karakter `\` voor.

LET OP: Deze grammatica valideert uitsluitend de syntax van zangstukken. Semantische regels moeten na het parsen worden gecontroleerd.

~~~ EBNF

zangstuk ::=
    { whitespace }
    [ toonhoogte-markering ]
    { non-scopechar | scope }
    [ toonhoogte-markering ]
    { whitespace } ;

toonhoogte-markering ::=
   "[" [absolute-toonhoogte] [ hoogte-modifier ] ":" "]" ;

absolute-toonhoogte ::= toonnaam [alteratie] octaaf ;

toonnaam ::= "A" | "B" | "C" | "D" | "E" | "F" | "G" ;

alteratie ::=  "#" | "♯" | "b" | "♭" ;

octaaf ::= "0" | "1" | "2" | "3" | "4"| "5" | "6" | "7" | "8" ;

non-scopechar ::= ? elk Unicode karakter behalve "{" en "}" ? ;

scope ::= "{" [ hoogte-modifier ] zangelement [ lengte-modifier ] "}" ;

hoogte-modifier ::= EHM { "&" EHM } ;
lengte-modifier ::= ELM { "&" ELM } ;

hoogte-modifier :=
      "~"             (* lege ruimte *)
    | "+/"            (* halve toon omhoog *)
    | "/"             (* 1 hele toon omhoog *)
    | "//"            (* 2 hele tonen omhoog *)
    | "///"           (* 3 hele tonen omhoog *)
    | "////"          (* 4 hele tonen omhoog *)
    | "/////"         (* 5 hele tonen omhoog *)
    | "-\\"           (* stelt de string "-\"    voor ( halve toon omlaag) *)
    | "\\"            (* stelt de string "\"     voor ( 1 hele toon omlaag) *)
    | "\\\\"          (* stelt de string "\\"    voor ( 2 hele tonen omlaag) *)
    | "\\\\\\"        (* stelt de string "\\\"   voor ( 3 hele tonen omlaag) *)
    | "\\\\\\\\"      (* stelt de string "\\\\"  voor ( 4 hele tonen omlaag) *)
    | "\\\\\\\\\\" ;  (* stelt de string "\\\\\" voor ( 5 hele tonen omlaag) *)

EHM ::= hoogte-modifier
    | "-"             (* zelfde toon handhaven *)

ELM ::= "~"           (* lege ruimte *)
    | "_"             (* 2x lengte van standaardnoot *)
    | "__"            (* 4x lengte van standaardnoot *)
    | "___"           (* 8x lengte van standaardnoot *)
    | "."             (* halve lengte van standaardnoot *)
    | ".."            (* kwart lengte van standaardnoot *)
    | "..."           (* achtste lengte van standaardnoot *)

zangelement ::=
    zangelement-char
    { zangelement-char } ;

zangelement-char ::=
    ? any Unicode character except
      whitespace,
      {, },
      &, ~, +, -, \, /, _, ., : ? ;

~~~

Een EHM van het type +/ of -\ is alleen valide indien de huidige overgang in de toonladder een onderverdeling bevat die een halvering van de stap mogelijk maakt. Indien geen dergelijke onderverdeling bestaat, is de notatie semantisch ongeldig.


### Absolute en relatieve toonhoogte

De VSA-notatie legt toonhoogten primair relatief vast. Elke muzikale positie bevat een EHM die de toonhoogteverandering ten opzichte van de voorgaande muzikale positie specificeert. Een toonhoogte-markering kan daarnaast een absolute toonhoogte bevatten. Deze absolute toonhoogte dient als referentiepunt voor het bepalen van de werkelijke toonhoogte van alle daaropvolgende muzikale posities.

Voorbeeld: `[C4:] {\O}, {/Hei_}{\&/li}{/ge} {\&/God_&_}` produceert de toonreeks `B3 C4 B3 C4 D4 C4 D4` (uitgaande van de door de implementatie gehanteerde interpretatie van de EHM's).

## 5. Semantisch model van VSA

De VSA-notatie wordt geïnterpreteerd via een gelaagd toonmodel:

1. absolute toonhoogte (referentiepunt). Een absolute toonhoogte (bijv. C4) is een referentiepunt voor het hele zangstuk. Zij definieert de eerste "do".
2. do-context (tonica). De do-context is de actuele tonica binnen het zangstuk. Alle EHM-bewerkingen worden relatief geïnterpreteerd binnen de do-context.
3. modus (intervalstructuur). Een modus definieert de intervalstructuur van de toonladder. De modus bepaalt welke overgangen tussen opeenvolgende graden een grote stap of een kleine stap vormen.
4. toonladder (afgeleide graden). De toonladder wordt niet expliciet opgeslagen, maar afgeleid uit de `do-context` en d∈ `modus`. De toonladder bestaat uit een cyclische reeks graden: `do → re → mi → fa → sol → la → ti → do`.
5. muzikale positie (EHM + ELM). Elke EHM is een operator op de huidige toonladderpositie.

  - `/` verplaatst één graad omhoog
  - `\` verplaatst één graad omlaag
  - `-` behoudt de huidige graad
  - `+/` en `-\` verplaatsen een halve stap binnen de modusstructuur. Een halve stap is een verplaatsing tussen twee opeenvolgende graden die door de modus als deelbaar is gemarkeerd. Indien geen substructuur bestaat, is gebruik van `+/` of `-\` ongeldig.

De interpretatie van een VSA-zangstuk volgt deze volgorde: 

absolute toonhoogte
    ↓
do-context
    ↓
modus
    ↓
toonladder (afgeleid)
    ↓
EHM-sequenties
    ↓
muzikale posities
    ↓
rendering

## 6. Syntactische en Semantische Fouten

Een **syntactische fout** treedt op wanneer de invoer niet voldoet aan de grammatica zoals gespecificeerd in hoofdstuk "Parsen van zangstukken". 

| Voorbeeld     | Fout |
| ------------- | ---- |
| `{tekst`      | Ontbrekende afsluitende accolade. |
| `{tekst&&_}`  | Ongeldige modifier-syntax. |
| `{tekst _}`   | Whitespace binnen een zangelement-scope. |

Een parser moet syntactische fouten detecteren voordat semantische validatie plaatsvindt.

Een **semantische fout** treedt op wanneer de invoer syntactisch geldig is, maar niet voldoet aan de betekenisregels van de VSA-notatie.

| Voorbeeld     | Fout |
| ------------- | ---- |
| `{/&\tekst_}` | De hoogte-modifier bevat twee muzikale posities, terwijl de lengte-modifier slechts één muzikale positie bevat.
| `[-:]`        |Indien de implementatie vereist dat een begin-toonhoogtemarkering een daadwerkelijke toonhoogte specificeert.
| `[//:] tekst [/:]` | Eindtoonhoogte komt niet overeen met de berekende eindtoon van het zangstuk. (alleen indien je zo'n controle later zou willen toevoegen) |
| `[C4//:] {+/tekst}` | Bij een toonladder in C is de overgang `mi -> fa` een halve toon. Daar kun je niet nog eens de helft van nemen |
| `[C4///:] {-\tekst}` | Bij een toonladder in C is de overgang `mi -> fa` een halve toon. Daar kun je niet nog eens de helft van nemen |

Een renderer mag uitsluitend renderen nadat zowel syntactische als semantische validatie succesvol zijn afgerond. Daardoor kan een zangstuk makkelijk worden geprocest:

tekst -> lexen/parsen -> Abstract Syntax Tree (AST) -> semantische validatie -> rendering

## 7. Het renderen van zangstukken {#vsa-rendering}

Onder **renderen** verstaan we het omzetten van (geparste) vsa-notatie naar een andere weergave formaat (bijvoorbeeld HTML, SVG of PDF). Wij specificeren twee zulke weergave formaten:
1. SVG. Dit is een schaalbaar grafisch formaat dat alle browsers kunnen hanteren en laten zien. Het plaatje laat de tekst van het zangstuk zien met daarboven en daaronder de markeringen.
2. MusicXML. Dit is een data-formaat waarin allerlei karakteristieken van muziek op een standaard manier kunnen worden vastgelegd, zodat muziekprogrammas als MuseScore ze kunnen lezen, of dat je ze bijvoorbeeld met Verovio op websites als muziek kunt tonen, of laten afspelen.

### 7.1 Renderen naar SVG

Een zangstuk wordt (visueel) in zijn geheel gerenderd naar SVG. Een zangstuk kan worden opgevat als normale (leesbare) platte tekst (dus met whitespace, regeleindes en wat dies meer zij), bestaande uit karakters die op normale toetsenborden voorkomen of daarmee gemaakt kunnen worden, maar geen `{` en `}` tekens bevatten, omdat die nodig zijn om zangelement-scopes te kunnen onderscheiden van teksten die geen zangelement zijn. Het idee is dat teksten zowel in Nederlands, maar ook in Duits, Engels, Russisch, Grieks, Roemeens etc. kunnen worden behandeld. Daarom dienen renderers Unicode NFC te gebruiken.

Een samengestelde hoogte- of lengte-modifier bestaat uit een rij enkelvoudige modifiers. Elke enkelvoudige modifier definieert één muzikale positie. Het aantal muzikale posities noemen we N.

Het aantal muzikale posities van een modifier is gelijk aan het aantal enkelvoudige modifiers (EHM's respectievelijk ELM's) waaruit deze bestaat.

Indien zowel een hoogte- als lengte-modifier aanwezig zijn, moeten zij hetzelfde aantal muzikale posities bevatten. Is dat niet het geval, dan is sprake van een semantische fout.

Indien slechts één van beide modifiers aanwezig is, dan bepaalt die modifier het aantal muzikale posities. Voor de ontbrekende modifier wordt verondersteld dat deze uit hetzelfde aantal lege enkelvoudige modifiers (~) bestaat.

Indien zowel de hoogte- als lengte-modifier ontbreken, bestaat de zangelement-scope uit precies één muzikale positie, waarvan zowel de hoogte- als lengte-modifier impliciet leeg (~) zijn.

Een toonhoogte-markering van de vorm `[<absolute-toonhoogte><hoogte-modifier>:]` wordt gerenderd als een horizontale streep op de baseline van de tekst met daarboven de rendering van de opgegeven hoogte-modifier. De absolute toonhoogte maakt geen deel uit van de grafische weergave, maar dient als semantische informatie voor interpretatie, validatie en eventuele export naar andere muzieknotaties zoals MusicXML. Indien geen hoogte-modifier aanwezig is, wordt uitsluitend de horizontale streep weergegeven.

Een zang-element-scope wordt gerenderd op een grid van N kolommen en 3 rijen:

- de bovenste rij bevat de renderingen van de EHM's;
- de middelste rij bevat het zangelement;
- de onderste rij bevat de renderingen van de ELM's.

Kolom i representeert muzikale positie i.

#### 7.1.1 Bepaling van kolombreedtes en rijhoogtes

Hoogte van de bovenste rij = maximale hoogte van alle EHM-glyphs
Hoogte van de middelste rij = hoogte van een gewone tekst
Hoogte van de onderste rij = maximale hoogte van alle ELM-glyphs

Voor elke kolom i wordt een minimale kolombreedte W[i] bepaald.

W[i] is de grootste van:

- de minimale breedte die nodig is om EHM[i] volledig te renderen;
- de minimale breedte die nodig is om ELM[i] volledig te renderen;

TB = de breedte die minimaal nodig is om het zangelement te renderen.

De breedte van het volledige grid is:

    W = max(TB, Σ W[i])

Als TB > W, dan worden de kolommen proportioneel verbreed totdat de totale breedte van het grid gelijk is aan de breedte van het zangelement.

Als TB < W, dan behoudt het zangelement zijn normale typografische breedte, en wordt het zangelement horizontaal gecentreerd in de middelste rij van het grid.

Een mogelijk praktische uitvoering is om voor een zangelement-scope N kolom-achtige cellen te maken,
en aan de bovenkant de EHM[i] te renderen en aan de onderkant de ELM[i], en wel zodanig dat het zangelement
daar overheen gerenderd kan worden.

#### 7.1.2 Render-eenheid

Alle afmetingen worden uitgedrukt in een basiseenheid U.

U is gelijk aan de hoogte van een EHM-streep.

Hieruit volgen:

- lengte van een schuine streep = U
- lijndikte = U/8
- verticale afstand tussen gestapelde elementen = U
- diameter van een punt = U/4

#### 7.1.3 Rendering van EHMs

Een schuine streep omhoog wordt gerenderd als een lijnsegment:

- hoek: +45°
- lengte: U
- lijndikte: U/8

Een schuine streep omlaag wordt gerenderd als een lijnsegment:

- hoek: -45°
- lengte: U
- lijndikte: U/8

Gestapelde strepen worden verticaal boven elkaar geplaatst.

De verticale afstand tussen twee gestapelde strepen is gelijk aan de lengte van één streep.

#### 7.1.4 Rendering van ELMs

Een underscore (`_`) wordt gerenderd als een horizontale lijn.

De lijn:

- vult de volledige breedte van de kolom;
- wordt gecentreerd binnen de kolom;
- heeft dezelfde lijndikte als een EHM-streep.

Bij meerdere underscores worden de lijnen verticaal gestapeld.

Een punt (`.`) wordt gerenderd als een gevulde cirkel.

De diameter van de cirkel bedraagt tweemaal de lijndikte van een EHM-streep.

Meerdere punten worden verticaal gestapeld.

## 7.2 Renderen naar MusicXML

Het renderen van VSA naar MusicXML is bedoeld als een lossless (of near-lossless) vertaling van de muzikale structuur zoals vastgelegd in VSA naar een gestandaardiseerd muziekuitwisselingsformaat. MusicXML wordt hierbij gebruikt als representatie van melodie, ritme en tekstkoppeling per noot.

### 7.2.1 Algemene uitgangspunten

Bij conversie gelden de volgende aannames:

Maatsoort wordt niet expliciet gerepresenteerd vanuit VSA en is niet relevant voor de semantiek.
De standaardduur van een muzikale positie wordt gemapt naar een kwartnoot (quarter note).
Een kwartnoot wordt bij conventionele weergave geïnterpreteerd als circa 0,5 seconde bij tempo 120 BPM.
Tempo wordt standaard ingesteld op 120 BPM, tenzij extern gespecificeerd.

Elke muzikale positie uit VSA correspondeert met exact één MusicXML “note”-element, tenzij melismatische uitbreiding binnen een zangelement-scope anders vereist.

### 7.2.2 Absolute toonhoogtebepaling

De absolute toonhoogte in MusicXML wordt afgeleid uit de toonhoogte-markering. Een toonhoogte-markering van de vorm `[C4//:]` wordt geïnterpreteerd als:

- `C4` = absolute starttoon (MIDI- of MusicXML pitch)
- `//` = optionele initiële relatieve hoogte-modifier
- `:` = syntactische afsluiting van de toonhoogte-markering

De effectieve starttoonhoogte voor de eerste muzikale positie wordt als volgt bepaald:

Indien een toonhoogte-markering aanwezig is:
1. gebruik de daarin gespecificeerde absolute toon (bijv. C4)
2. pas optioneel de EHM-sequentie toe als initiële transformatie
3. Indien geen toonhoogte-markering aanwezig is:
4. gebruik de standaardtoonhoogte F4

De standaardtoonhoogte F4 fungeert als referentiepunt voor alle relatieve intervallen binnen het stuk.

### 7.2.3 Toonhoogteberekening per muzikale positie

Elke EHM binnen een hoogte-modifier bepaalt een relatieve stap ten opzichte van de vorige muzikale positie.

Voor MusicXML geldt:

- elke muzikale positie wordt een afzonderlijke <note>
- de pitch wordt cumulatief berekend
- de eerste positie gebruikt de starttoonhoogte uit de toonhoogte-markering

Indien een zangelement meerdere muzikale posities bevat (melisma), blijft het syllabe-veld identiek voor alle betrokken notes, conform MusicXML melisma-conventies.

### 7.2.4 Ritme en duur

Elke ELM binnen een lengte-modifier bepaalt de duur van een muzikale positie.

Mapping naar MusicXML:

- `~` → kwartnoot (default)
- `_` → halve noot
- `__` → hele noot
- `.` → achtste noot
- `..` → zestiende noot
combinaties worden omgerekend naar proportionele duurwaarden

Indien geen lengte-modifier aanwezig is, dan wordt standaard een kwartnoot gebruikt

Indien meerdere ELM’s aanwezig zijn binnen één zangelement, dan krijgt elke muzikale positie zijn eigen duration-waarde

### 7.2.5 Melismatische mapping

Indien een zangelement meerdere muzikale posities bevat, dan wordt dit in MusicXML weergegeven als één syllabe met syllabic="begin", gevolgd door extend- of middle-syllables afhankelijk van het aantal posities. Alle notes delen hetzelfde <lyric>-tekstfragment

Voorbeeldconcept:

VSA: één zangelement over N muzikale posities
MusicXML: N <note> elementen met gekoppelde lyric

### 7.2.6 Samenvatting conversieregel

Voor elke muzikale positie geldt:

1 VSA positie → 1 MusicXML note
Toonhoogte = cumulatief berekend uit starttoon + EHMs
Duur = mapping van ELM naar duration
Tekst = gekoppeld aan volledige zangelement-scope
Melisma = herhaalde notes met gekoppelde lyric
6.2.7 Fallback- en foutafhandeling

Indien tijdens conversie:

geen geldige toonhoogte kan worden afgeleid → gebruik F4
EHM/ELM inconsistent zijn in lengte → semantische fout (geen export)
onbekende modifiers voorkomen → conversie wordt afgebroken of gemarkeerd als invalid VSA

---

## 8. Voorbeeld van gebruik

Hieronder is een tekst die laat zien hoe deze notatie gebruikt gaat worden in een hugo markdown file:

~~~ markdown

# Troparia voor de zondagen

## Troparion toon 1

::: vsa-notatie
[:] Ter{/&/wijl_&_} {\\de} steen door de israëlie{/ten} {/ver}{/ze_}geld {was_}
{\en} de soldaten Uw allerzuiverst lichaam be{\waak_}{ten_}
O, Ver{/los_}{/ser_}, {\\zijt} Gij na drie {/da}{/gen} {/op_}gestaan
{\om} aan de wereld het Leven te {\schen_}{\ken_}
Daarom {/roe_}{/pen_} {\\de} hemelse mach{/ten} {/U} {/toe_}:
{\O} Levenschenker, {\e_}re zij {\U_},
{/e_}{/re_} {\\zij} Uw verrijze{/nis}, {/o} {/Chris_}{tus_},
{\e}re {\zij} {/Uw} {/Ko_}ning{schap_},
{\e}re zij {\Uw} {/Voor}{/zie_}nig{heid_},
// {\Gij} enig Mens{\lie_}{ven_}{\de_} [:]
:::

## Troparion toon 2

::: vsa-notatie
[/:] Toen {/Gij_} tot de dood {/zijt} {/ne_}{\der}ge{\daald_},
{\Gij} onsterfelijk {\le_}{\ven_}
{/hebt} Gij de {/ha_}des gedood door het hemellicht {/der} {/God_}{\heid}, o {\Heer_}
de gestorvenen hebt Gij opgewekt uit het {\do_}den{\rijk_}.
{/Al}le {/he_}melse machten hebben U toe {/ge}{/&\roe_&_}{\pen_},
Gij Schenker van het {\le_}{\ven_}.
// {//O} Christus {\on}{/ze} {/&\&/God_&~&~}, {\e_}{\re} zij {\U_} [:]
:::

## Troparion toon 5

[///:] {Komt_} ge{/lo_}{\\vi}{gen_}
{//laat} ons aanbidden en be{-&\&\zin_&-&-}{/gen},
het met de {Va_}der en de Geest me{\\de}{/eeu_}wi{\ge} {\woord_},
{///dat_} uit de Maagd omwille van onze verlossing {\is}{/ge} {/bo_}{\\ren_}
{//want} Hij heeft zich ver{-&\&\waar_&~&~}{/digd_},
om zich in het vlees aan het Kruis te {\\ver}{/&\he_&~}{\fen_},
{//Hij_} heeft de {/dood_} {\\on}der{gaan_}.
{//en} door Zijn roemrijke ver{rij_}{\&\ze}{/nis}
// {/heeft} Jok de {\do_}{\den_} {\op_}{/&\ge}{\wekt_} [:]

~~~

---