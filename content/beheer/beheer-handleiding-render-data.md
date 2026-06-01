# Beheerhandleiding

````
Dit document is ooit gegenereerd en moet nog op 
bruikbaarheid en consistentie worden gecontroleerd.
````

Deze handleiding is bedoeld voor degenen die het dagelijkse beheer uitvoeren van koormappen en hun inhoud.
De handleiding beschrijft eerst de ruwe opzet van het beheer, en gaat vervolgens in op de details.

---

## 1. Beheersstructuur

Om koormappen en hun inhoud te beheren moet duidelijk zijn wat we daaronder verstaan,
uit welke bestanden dat allemaal bestaat en waar die te vinden zijn.

1. De **inhoud van koormappen** bestaat uit 'liederen', waarbij elk 'lied' op verschillende
manieren kan worden gerepresenteerd, bijvoorbeeld als audio, als muziek-tekst, enz.
Daarom is aan elk lied een verzameling bestanden (audio, pdf's, afbeeldingen enz.)
gerelateerd die elk op hun eigen wijze een lied representeren. 

2. Een **liednaam** is een tekst die gebruikt wordt om naar een lied te verwijzen. 
Op dit moment zijn er nog geen conventies voor het kiezen van liednamen,
maar het is goed denkbaar dat die er op enig moment zullen komen.

3. Een **representatie label** is een tekst die, wanneer hij achter een liednaam wordt geplakt,
de filenaam is van het bestand dat de betreffende representatie van het lied is dat door
de liednaam wordt geidentificeerd. Voorbeelden van representatie-labels zijn: 
  - `.pdf`, `.jpg`, `.png` voor visuele representaties, bijvoorbeeld van teksten en/of muziek;
  - `.mp3` voor audio bestanden die het lied laten horen;
  - `-s.mp3`, `-a.mp3`, `-t.mp3`, `-b.mp3` voor audiobestanden die de individuele zangstemmen
    van het lied laten horen

4. Alle bestanden die hetzelfde lied (op verschillende manieren) representeren staan in dezelfde directory.
Op dit moment staan al dit soort bestanden in `/static/koormappen/`, maar dat kan veranderen.
Het lied met liednaam `002-(1a) vredeslitanie` kan door verschillende bestanden worden gerepresenteerd,
  - `002-(1a) vredeslitanie.pdf` voor de muziek met tekst van het lied die kan worden afgedrukt,
  - `002-(1a) vredeslitanie.mp3` voor een gezongen versie van het lied die kan worden afgespeeld,
  - `002-(1a) vredeslitanie-s.mp3` voor een afspeelbare versie van de sopraan-partij van het lied,
  - enzovoorts. 

5. Een **koormap** bestaat uit een lijst (van lijsten) van liederen, die wordt gespecificeerd 
als een [YAML](https://yaml.com/resources/) bestand. Deze yaml-bestanden staan in (een subdirectory)
van de directory `/data/`. 
De structuur van deze yaml bestanden is beschreven in het hoofdstuk [YAML bestanden](#yaml-bestand).

---

## 2. Koormap pagina's {#koormap-bestand}

Elke koormap heeft een eigen `.md` bestand (in directory `/content/`). Je mag zelf de bestandsnaam kiezen
en zorg er ook voor dat de home pagina `/content/_index.md` een link naar dit bestand bevat.

De pagina zelf kun je opmaken zoals je wilt. Ergens op die pagina wil je de inhoud van de koormap laten zien.
Op die plaats zet je de volgende shortcode neer:

<!-- Om te voorkomen dat HUGO de onderstaande short-code uitvoert, staat hij in commentaar -->
```` markdown
{{</* render-data group="{{group}}" source="{{source}}" */>}}
````

waarbij: 

| Parameter | Betekenis |
| --------- | --------- |
| group     | de map onder `/data/` waar het yaml bestand staat dat de inhoud van de koormap specificeert |
| source    | naam van het YAML bestand (zonder de extensie `.yaml`) |

Het yaml bestand `/data/{{group}}/{{source}}.yaml` beschrijft dan de inhoud van de betreffende koormap.
[Verderop](#yaml-bestand) staat hoe zo'n .yaml-bestand er uit moet zien.

**Voorbeeld**: de koormap die in Groningen wordt gebruikt voor de Goddelijke Liturgie kun je
dus renderen via de volgende shortcode:

<!-- Om te voorkomen dat HUGO de onderstaande short-code uitvoert, staat hij in commentaar -->
```` markdown
{{</* render-data group="groningen" source="goddelijke-liturgie" */>}}
````

en de inhoud van deze koormap wordt dan dus beschreven in het bestand `/data/groningen/goddelijke-liturgie.yaml`.

---

## 4. YAML bestanden {#yaml-bestand}

De inhoud van elke koormap wordt gespecificeerd door een .yaml bestand.
De .yaml bestanden zitten in mappen `/data/{{group}}/`,
waarbij `{{group}}` de naam is van de locatie waar de map wordt gebruikt,

Voorbeeld:

```text
/data/groningen/goddelijke-liturgie.yaml
```

De .yaml bestanden zijn gestructureerde tekst-bestanden waarin de inhoud 
is opgeschreven in [YAML](https://yaml.com/resources/).

Wij gebruiken de volgende yaml structuur:

````yaml
# 1. ELK YAML BESTAND BEGINT ALTIJD MET EXACT 1 ROOT KEY: items.
#    ER ZIJN GEEN ANDERE ROOT STRUCTUREN TOEGESTAAN
#    (dus `- title:` direct op root level mag niet)

items: 

# ALLE ENTITIES ONDER DE ROOT KEY MOETEN EEN `type` HEBBEN:
# - item   → bestand of media
# - group  → geneste structuur
# - include → herbruikbare tekst/snippet
# - link   → externe URL
# HIERONDER VOLGEN VOORBEELDEN HIERVAN

  - type: group

# een entiteit van het type 'group' mag of moet alleen de volgende elementen bevatten:
# - title (verplicht) → tekst die in de inhoudsopgave wordt getoond
# - base  (optioneel) → pad, relatief tov de omliggende structuur, 
#                       dat het base-pad voor de group-items specificeert
# - items (verplicht) → een lijst van de items in de group structuur.

      title: "(15) Cherubijnen hymnes"
      items:

# Een entiteit van het type `item` mag of moet de volgende elementen bevatten:
# - title (verplicht) → tekst die in de inhoudsopgave wordt getoond
# - file  (verplicht) → tekst die gebruikt wordt als eerste deel van inhouds-bestanden
# - dir   (optioneel) → pad, relatief tov `/static/`, waar de inhouds-bestanden staan
#                       (default is het pad, relatief tov `/static/`, dat is geconstrueerd uit
#                        de `base` parameters van omliggende entiteiten van het type `group`)
        - type: item
          title: "(15c) Cherubijnen hymne (NL, Kastorski)"
          file: "034-(15c) cherubijnen hymne (kastorski - nl)"

        - type: item
          title: "(15c) Cherubijnen hymne (KS, Kastorski)"
          file: "034-(15c) cherubijnen hymne (kastorski - ru)"
          dir: "/koormappen/goddelijke-liturgie"

# Een entiteit van het type `link` mag of moet de volgende elementen bevatten:
# - title (verplicht) → tekst die in de inhoudsopgave wordt getoond
# - url   (verplicht) → URL waar de inhoud van de entiteit wordt getoond.
        - type: link
          title: "Cherubijnen hymne (copyright)"
          url: "https://www.universaledition.com/en/Works/Cherubim/P0213837"

# Een entiteit van het type `include` mag of moet de volgende elementen bevatten:
# - title (verplicht) → tekst die in de inhoudsopgave wordt getoond
# - file  (verplicht) → pad+bestandsnaam (zonder extensie), relatief tov `/content/`, 
#                       van het markdown file dat wordt ge-include
        - type: include
          title: "Voetnoot"
          file: "includes/voetnoot-bij-prokimen-melodien"
````
