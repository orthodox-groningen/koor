---
title: "Referentie documentatie"
---

{{< include-md file="/content/snippets/documentatie-disclaimer" >}}

Dit is het naslagwerk voor het `render-data` systeem. Dit document beschrijft alle technische details, syntax-regels en mogelijkheden.

Voor een praktische handleiding met stap-voor-stap instructies, zie de [Beheer Handleiding](/beheer/beheer-handleiding).

---

## Overzicht: hoe werkt het systeem?

Het `render-data` systeem bestaat uit drie onderdelen:

1. **YAML-bestanden** (`/data/.../*.yaml`) — beschrijven de structuur en inhoud van koormappen
2. **Shortcode** (`{{</* render-data ... */}}`) — leest YAML en genereert de webpagina
3. **Mediabestanden** (`/static/koormappen/...`) — PDF's, MP3's, afbeeldingen, etc.

### Voorbeeld flow

```
/data/groningen/goddelijke-liturgie.yaml
    ↓
    (bevat: "file: 001-vredeslitanie")
    ↓
/static/koormappen/goddelijke-liturgie/
    ├── 001-vredeslitanie.pdf
    ├── 001-vredeslitanie.mp3
    └── 001-vredeslitanie-s.mp3
    ↓
shortcode in /content/groningen/koormap.md
    ↓
Website toont alle bestanden netjes georganiseerd
```

---

## Shortcode Syntax

### Basis

```markdown
{{</* render-data group="groningen" source="goddelijke-liturgie" */>}}
```

### Parameters

| Parameter | Type   | Verplicht | Beschrijving |
| --------- | ------ | :-------: | ------------ |
| `group`   | string | Ja | Subfolder onder `/data/` waar het YAML-bestand staat |
| `source`  | string | Ja | Bestandsnaam zonder `.yaml` extensie |

### Voorbeeld

```markdown
{{</* render-data group="groningen" source="goddelijke-liturgie" */>}}
```

Dit zoekt en laadt: `/data/groningen/goddelijke-liturgie.yaml`

---

## YAML Structuur

### Algemene regels

1. **Één root key verplicht**: elk YAML-bestand begint met `items:` op topniveau
2. **Alle entities moeten een type hebben**: `type: item`, `type: group`, `type: include`, of `type: link`
3. **Geen andere root-structuren**: je mag niet direct `- title:` op topniveau zetten

### Entity Types

Elk element in je YAML kan een van vier types zijn:

#### Type: `item`

Een lied of media-element dat naar bestanden verwijst.

**Vereiste velden:**
- `title` (string) — weergegeven naam
- `file` (string) — basisnaam van de bestanden (zonder extensie)

**Optionele velden:**
- `dir` (string, pad) — mappad (overriding van `base` van parent-group)

**Voorbeeld:**
```yaml
- type: item
  title: "(1) Vredeslitanie"
  file: "002-vredeslitanie"
```

**Wat gebeurt er?**

Het systeem zoekt naar alle bestanden die beginnen met `002-vredeslitanie`:
- `~.pdf` → als dit bestand (`002-vredeslitanie.pdf`) bestaat, wordt het door de PDF-viewer gerenderd
- `~.jpg`, `.png` → afbeeldingen
- `~.mp3`, `~-s.mp3`, `~-s2.mp3`, `~-a.mp3`, `~-a2.mp3`, `~-t.mp3`, `~-t2.mp3`, `~-b.mp3`  `~-b2.mp3`→ als een of meer van deze bestanden bestaan, worden voor elk van de bestaande bestanden een knop getoond waarmee je het bestand kan selecteren, alsmede een afspeler die het geselecteerde bestand dan kan afspelen. Het idee is dat:
  - `~.mp3` alle stemmen van het lied laat horen;
  - `~-s.mp3`, `~-a.mp3`, `~-t.mp3`, `~-b.mp3` de afzonderlijkje stemmen voor Sopraan, Alt, Tenor en Bas laat horen
  - `~-s2.mp3`, `~-a2.mp3`, `~-t2.mp3`, `~-b2.mp3` de afzonderlijkje stemmen voor Sopraan, Alt, Tenor en Bas laat horen, met zachtjes op de achtergrond ook de andere stemmen

#### Type: `group`

Een container voor meerdere items. Kan genest zijn.

**Vereiste velden:**
- `title` (string) — groepnaam
- `items` (lijst) — child-elementen

**Optionele velden:**
- `base` (string, pad) — mappad voor alle child-items (erft naar beneden)

**Voorbeeld:**
```yaml
- type: group
  title: "Goddelijke Liturgie"
  base: "koormappen/goddelijke-liturgie"
  items:
    - type: item
      title: "Vredeslitanie"
      file: "001-vredeslitanie"
    
    - type: group
      title: "Cherubijnen Hymnes"
      items:
        - type: item
          title: "Cherubijnen Hymne"
          file: "034-cherubijnen"
```

**Parent-child `base` overerving:**

Als een parent-group `base: "koormappen/goddelijke-liturgie"` heeft en een child-item
- geen eigen `dir` of `base` specificeert, erft deze `base`. 
- wel een `base`specificeert, maar geen `dir`, dan wordt `base` gelijk aan die van de parent-group waaraan de gespecificeerde `base` is geconcateneerd
- wel een `dir` specificeert, dan wordt `base` geljk aan deze `dir`. 

Dus voor het bovenstaande voorbeeld:
- item "Vredeslitanie" zoekt bestanden in `/static/koormappen/goddelijke-liturgie/`
- item "Cherubijnen Hymne" zoekt ook in `/static/koormappen/goddelijke-liturgie/` (erft van parent)

Wil je dieper nesten in het `base` pad van de parent, voeg dan een `base` toe:
```yaml
- type: item
  title: "Uitzonderingslied"
  base: "uitzonderingen"
  file: "999-bijzonder"
```
Als de parent een `base: "koormappen/goddelijke-liturgie"` heeft, dan zal bovengenoemd item bestanden zoeken in `koormappen/goddelijke-liturgie/uitzonderingen`.

Wil je een compleet ander pad voor een item, los van de `base` van de parent, dan voeg je `dir` toe:
```yaml
- type: item
  title: "Uitzonderingslied"
  file: "999-bijzonder"
  dir: "/koormappen/andere-locatie"
```
Nu worden bestanden gezocht in `/koormappen/andere-locatie`.

#### Type: `include`

Voeg herbruikbare Markdown-inhoud in.

**Vereiste velden:**
- `title` (string) — weergegeven naam
- `file` (string, pad) — bestand onder `/content/` (zonder `.md`)

**Voorbeeld:**
```yaml
- type: include
  title: "Veelgestelde vragen"
  file: "snippets/veelgestelde-vragen"
```

Dit voegt in: `/content/snippets/veelgestelde-vragen.md`

#### Type: `link`

Externe hyperlink.

**Vereiste velden:**
- `title` (string) — weergegeven tekst
- `url` (string) — externe URL

**Voorbeeld:**
```yaml
- type: link
  title: "Originele bron"
  url: "https://example.com/bron"
```

### Volledige structuur-voorbeeld

```yaml
items:

  - type: group
    title: "Goddelijke Liturgie"
    base: "koormappen/goddelijke-liturgie"
    items:

      - type: group
        title: "Opening"
        items:
          
          - type: item
            title: "Vredeslitanie"
            file: "001-vredeslitanie"
          
          - type: item
            title: "Eerste Antifoon"
            file: "002-eerste-antifoon"

      - type: group
        title: "Cherubijnen Hymne en Geloofsbeleidenis"
        items:
          
          - type: item
            title: "Cherubijnen Hymne (NL)"
            file: "034-cherubijnen-nl"
          
          - type: item
            title: "Cherubijnen Hymne (RU)"
            file: "034-cherubijnen-ru"
            dir: "/koormappen/varianten"
          
          - type: include
            title: "Voetnoot over melodieën"
            file: "snippets/voetnoot-melodien"
          
          - type: link
            title: "Copyright bron"
            url: "https://www.example.com"

      - type: item
        title: "Geloofsbeleidenis"
        file: "037-(18) geloofsbelijdenis"
```

---

## Directory-structuur

### YAML-bestanden

```
/data/
  ├── groningen/
  │   ├── goddelijke-liturgie.yaml
  │   └── huwelijk.yaml
  └── hemelum/
      ├── vespers.yaml
      └── liturgie.yaml
```

De `group` parameter in de shortcode verwijst naar de folder onder `/data/`:
```markdown
{{</* render-data group="groningen" source="goddelijke-liturgie" */>}}
```
zoekt `/data/groningen/goddelijke-liturgie.yaml`

### Mediabestanden

```
/static/koormappen/
  ├── goddelijke-liturgie/
  │   ├── 001-vredeslitanie.pdf
  │   ├── 001-vredeslitanie.mp3
  │   ├── 001-vredeslitanie-s.mp3
  │   ├── 002-eerste-antifoon.pdf
  │   └── ...
  ├── huwelijk/
  │   ├── 101-intrede-bruidegom.pdf
  │   └── ...
  └── hemelum/
      └── ...
```

De `base` parameter in YAML verwijst naar paden onder `/static/`:
```yaml
base: "koormappen/goddelijke-liturgie"
```
zoekt bestanden in `/static/koormappen/goddelijke-liturgie/`

### Markdown-bestanden (content)

```
/content/
  ├── _index.md (homepage met links naar koormappen)
  ├── groningen/
  │   ├── koormap-goddelijke-liturgie.md (bevat shortcode)
  │   └── koormap-huwelijk.md
  └── hemelum/
      └── koormap.md
```

---

## Bestandsnaamconventies

### Audio-bestanden met stemmingen

Basisbestand + stemming-suffix:

```
001-vredeslitanie.mp3        (volledig lied/mix)
001-vredeslitanie-s.mp3      (sopraan)
001-vredeslitanie-a.mp3      (alt)
001-vredeslitanie-t.mp3      (tenor)
001-vredeslitanie-b.mp3      (bas)
001-vredeslitanie-s2.mp3     (sopraan met op de andere stemmen op de achtergrond)
001-vredeslitanie-a2.mp3     (alt met op de andere stemmen op de achtergrond)
001-vredeslitanie-t2.mp3     (tenor met op de andere stemmen op de achtergrond)
001-vredeslitanie-b2.mp3     (bas met op de andere stemmen op de achtergrond)
```

**Ondersteunde stemmings-suffixen:**
- `-s.mp3` en `-s2.mp3` — sopraan
- `-a.mp3` en `-a2.mp3` — alt
- `-t.mp3` en `-t2.mp3` — tenor
- `-b.mp3` en `-b2.mp3` — bas
- (meer kunnen later worden toegevoegd)

### Ondersteunde bestandstypen

| Type | Extensie | Weergave |
|------|----------|----------|
| PDF | `.pdf` | Viewer met paginanavigatie |
| Audio | `.mp3` | Audioknoppen (+ apart per stem als beschikbaar) |
| Afbeeldingen | `.jpg`, `.png` | Inline afbeelding |

---

## Technische Details

### Pad-resolutie

1. **Item krijgt `dir` mee**: gebruik die
   ```yaml
   - type: item
     file: "999-lied"
     dir: "/koormappen/bijzonder"
     # zoekt in /static/koormappen/bijzonder/
   ```

2. **Geen `dir`, wel parent-`base`**: erven van parent
   ```yaml
   - type: group
     base: "koormappen/liturgie"
     items:
       - type: item
         file: "001-lied"
         # zoekt in /static/koormappen/liturgie/ (erft base)
   ```

3. **Geen `dir`, geen parent-`base`**: error
   ```yaml
   - type: item
     file: "001-lied"
     # ❌ Waar moet ik zoeken?
   ```

### YAML-validatie

Fouten die voorkomen moeten worden:

❌ **Fout: geen root `items`**
```yaml
- type: group
  title: "Liturgie"
  # ← root level moet `items:` zijn
```

❌ **Fout: entity zonder `type`**
```yaml
items:
  - title: "Vredeslitanie"
    file: "001"
    # ← missing `type`
```

❌ **Fout: onbekend `type`**
```yaml
items:
  - type: playlist
    title: "Mijn playlist"
    # ← `type: playlist` bestaat niet
```

✅ **Goed:**
```yaml
items:
  - type: group
    title: "Goddelijke Liturgie"
    items:
      - type: item
        title: "Vredeslitanie"
        file: "001-vredeslitanie"
```

### Bestandsresolutie

Voor `file: "001-vredeslitanie"` zoekt het systeem naar:

```
/static/{base}/
  001-vredeslitanie.pdf      ← PDF?
  001-vredeslitanie.mp3      ← Volledige audio?
  001-vredeslitanie-s.mp3    ← Sopraan?
  001-vredeslitanie-a.mp3    ← Alt?
  001-vredeslitanie-t.mp3    ← Tenor?
  001-vredeslitanie-b.mp3    ← Bas?
  001-vredeslitanie.jpg      ← Afbeelding?
  001-vredeslitanie.png
```

Gevonden bestanden worden allemaal op de pagina getoond.

---

## Best Practices

### Naamgeving

- Begin met nummering: `001-`, `002-`, etc. (makkelijk sorteren)
- Gebruik spellingsconventies consistent
- Geen spaties in stemmings-suffixen: `001-vredeslitanie-s.mp3` niet `001-vredeslitanie -s.mp3`

### Organisatie

- **Groepeer logisch**: deel liturgie in onderdelen (Opening, Cherubijnen, etc.)
- **Erven `base` waar mogelijk**: zet `base` op top-level group, niet op elk item
- **Override `dir` alleen als nodig**: als item in ander mappad staat

### Onderhoud

- Houd `/data/` en `/static/` in sync: als je YAML wijzigt, zorg dat bestanden er zijn
- Commit YAML-wijzigingen atomair: één lied toevoegen = één commit
- Voeg voetnoten toe via `type: include` voor herbruikbare inhoud

---

## Voorbeelden

### Voorbeeld 1: Eenvoudige structuur

```yaml
items:
  - type: group
    title: "Eenvoudige Liturgie"
    base: "koormappen/eenvoudig"
    items:
      - type: item
        title: "Intrede"
        file: "001-intrede"
      
      - type: item
        title: "Vredeslitanie"
        file: "002-vredeslitanie"
```

### Voorbeeld 2: Geneste groepen

```yaml
items:
  - type: group
    title: "Volledige Liturgie"
    base: "koormappen/liturgie"
    items:
      
      - type: group
        title: "Deel I: Opening"
        items:
          - type: item
            title: "Vredeslitanie"
            file: "001-vredeslitanie"
      
      - type: group
        title: "Deel II: Cherubijnen"
        items:
          - type: item
            title: "Cherubijnen Hymne"
            file: "034-cherubijnen"
          
          - type: include
            title: "Noot over melodie"
            file: "snippets/melodie-noot"
```

### Voorbeeld 3: Gemengde content

```yaml
items:
  - type: group
    title: "Koormap met externe referenties"
    base: "koormappen/gemengd"
    items:
      
      - type: item
        title: "Hymne"
        file: "001-hymne"
      
      - type: include
        title: "Achtergrond"
        file: "beheer/hymne-achtergrond"
      
      - type: link
        title: "Originele bron"
        url: "https://example.com/hymne"
      
      - type: item
        title: "Alternatieve versie"
        file: "001-hymne-alt"
        dir: "/koormappen/varianten"
```

---

## Veel voorkomende vragen

### Kan ik bestanden in twee copmappen gebruiken?

Nee, elk `file` hoort in één mappad. Wil je hetzelfde bestand ergens anders gebruiken, maak een kopie of voeg het toe aan beide mappen.

### Kan ik volgorde van items veranderen?

Ja, de volgorde in het YAML-bestand bepaalt de volgorde op de website.

### Wat gebeurt er als een bestand niet bestaat?

Het systeem geeft geen foutmelding, maar het bestand verschijnt niet op de pagina. Check je `/static/` mappen.

### Kan ik afbeeldingen inline tonen?

Ja, `.jpg` en `.png` worden automatisch weergegeven als afbeelding naast de audioknoppen.

### Hoe voeg ik meer stemmingen toe (bijv. twee sopranen)?

Momenteel ondersteunen we: `-s`, `-a`, `-t`, `-b`. Wil je meer, neem contact op met de beheerder van de code.

---

## Zie ook

- [Beheer Handleiding](render-data-beheer-handleiding.md) — praktische stap-voor-stap instructies
- Hugo shortcode documentatie: `/layouts/shortcodes/render-data.html`
- YAML syntax: https://yaml.org/spec/
