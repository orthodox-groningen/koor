---
title: "Beheer handleiding"
---

{{< include-md file=content/snippets/documentatie-disclaimer >}}

Dit document beschrijft hoe je als beheerder koormappen aanmaakt en beheert met het `render-data` systeem. Je vindt hier praktische stappen voor dagelijks werk: hoe voeg je liederen toe, wijzig je inhoud en voeg je audio- of pdf-bestanden in.

Dit document is geschreven voor beheerders die bekend zijn met GitHub en git-workflows. Zie de [Referentie Documentatie](/beheer/referentie-doc) voor technische details en alle mogelijkheden.


---

## Hoe werkt het systeem?

Het `render-data` systeem geeft je twee dingen:

1. **YAML-bestanden** onder `/data/` die beschrijven wat in een koormap zit
2. **Een shortcode** die deze YAML-bestanden leest en automatisch een nette webpagina maakt

Jij voert het beheer uit door:
- YAML-bestanden aan te maken en te wijzigen via GitHub
- Bestanden (PDF's, MP3's, afbeeldingen) toe te voegen aan `/static/koormappen/`
- Koormap-pagina's aan te maken met de `render-data` shortcode

---

## Snelstart: Je eerste koormap

### Stap 1: Maak een YAML-bestand aan

Ga naar GitHub, folder `/data/groningen/` (of waar jouw koormap hoort), en maak een nieuw bestand aan met een duidelijke naam, bijvoorbeeld:

```
/data/groningen/mijn-nieuwe-koormap.yaml
```

Begin met deze basis-structuur:

```yaml
items:
  - type: group
    title: "Naam van de Koormap"
    base: "koormappen/groningen/mijn-nieuwe-koormap"
    items:
      # Hier voeg je later liederen toe
```

**Wat betekent dit?**
- `items:` — dit moet ALTIJD het topniveau zijn
- `type: group` — dit groepeert alle liederen samen
- `title:` — dit verschijnt bovenaan op de pagina
- `base:` — het mappad waar jouw bestanden staan (zie Stap 3)

### Stap 2: Maak een koormap-pagina

Maak een nieuw bestand onder `/content/groningen/` (of dezelfde locatie als je YAML):

```
/content/groningen/mijn-nieuwe-koormap.md
```

Voeg deze inhoud in:

```markdown
---
title: "Mijn Nieuwe Koormap"
---

{{</* render-data group="groningen" source="mijn-nieuwe-koormap" */>}}
```

**Let op:** `source` verwijst naar je YAML-bestandsnaam **zonder** `.yaml`

### Stap 3: Upload je bestanden

Maak een map onder `/static/koormappen/` voor je liederen. De paden moeten precies overeenkomen met wat je in het YAML-bestand hebt gezet:

```
/static/koormappen/groningen/mijn-nieuwe-koormap/
    ├── 001-vredeslitanie.pdf
    ├── 001-vredeslitanie.mp3
    ├── 001-vredeslitanie-s.mp3
    ├── 002-eerste-antifoon.pdf
    ├── 002-eerste-antifoon.mp3
    └── ...
```

### Stap 4: Voeg liederen toe aan het YAML-bestand

Nu voeg je entries toe voor elk lied. Bewerk je YAML:

```yaml
items:
  - type: group
    title: "Goddelijke Liturgie"
    base: "koormappen/groningen/mijn-nieuwe-koormap"
    items:
      - type: item
        title: "Vredeslitanie"
        file: "001-vredeslitanie"

      - type: item
        title: "Eerste Antifoon"
        file: "002-eerste-antifoon"
```

**Wat gebeurt er?**
- `type: item` — dit is een lied
- `title:` — hoe het lied heet op de website
- `file:` — de naam van je bestanden **zonder** extensie (`.pdf`, `.mp3`, etc.)

Het systeem zoekt automatisch naar alle bestanden die beginnen met `001-vredeslitanie`: `.pdf`, `.mp3`, `-s.mp3`, enzovoorts.

---

## Gebruikelijke taken

### Nieuw lied toevoegen aan bestaande koormap

1. **Voeg je bestanden toe**: zet je PDF's, MP3's en andere bestanden in de koormap onder `/static/koormappen/`
2. **Voeg een item toe aan het YAML**: 
   ```yaml
   - type: item
     title: "Naam van het lied"
     file: "nummering-en-naam"
   ```
3. **Commit & push**: voer je wijzigingen in via GitHub en wacht tot de preview-site is gegenereerd

### Audio-stemmen toevoegen

Als je aparte stemmen hebt (sopraan, alt, tenor, bas), geef deze dezelfde basisnaam met een suffix:

```
/static/koormappen/groningen/mijn-koormap/
    ├── 001-vredeslitanie.pdf
    ├── 001-vredeslitanie.mp3      (volledig lied)
    ├── 001-vredeslitanie-s.mp3    (sopraan)
    ├── 001-vredeslitanie-a.mp3    (alt)
    ├── 001-vredeslitanie-t.mp3    (tenor)
    └── 001-vredeslitanie-b.mp3    (bas)
```

Op de website verschijnen deze automatisch als aparte knoppen.

### Liederen groeperen

Je kunt liederen in groepen organiseren. Dit is nuttig als je bijvoorbeeld verschillende delen van de liturgie hebt:

```yaml
items:
  - type: group
    title: "Goddelijke Liturgie"
    base: "koormappen/groningen/goddelijke-liturgie"
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
        title: "Cherubijnen Hymne"
        items:
          - type: item
            title: "Cherubijnen Hymne (NL)"
            file: "034-cherubijnen-hymne"
```

---

## Best Practices

### Bestandsnamen

Gebruik consistente naamgeving zodat het systeem alles kan vinden:

✅ **Goed:**
```
001-vredeslitanie.pdf
001-vredeslitanie.mp3
001-vredeslitanie-s.mp3
002-eerste-antifoon.pdf
```

❌ **Niet goed:**
```
vredeslitanie.pdf
vredeslitanie eng.mp3     (spaties in stembenamingen werken niet)
Antifoon 1.pdf            (onvoorspelbare nummering)
```

### Git workflow

1. **Maak een branch**: `git checkout -b feature/nieuwe-koormap`
2. **Voeg/wijzig bestanden**: upload via GitHub of bewerk lokaal
3. **Commit met duidelijke bericht**: "Add nieuwe koormap: Goddelijke Liturgie"
4. **Push en maak Pull Request**: verifieer via preview-site
5. **Merge naar main**: nadat alles werkt

### Test je wijzigingen

Na elke wijziging:
1. Commit en push naar GitHub
2. Wacht tot de preview-site is gebuild (~2 minuten)
3. Controleer op `https://orthodox-ronl.github.io/koor/preview/` of alles correct wordt weergegeven
4. Test de audio- en PDF-links

### Externe links toevoegen

Je kunt ook externe links opnemen (bijv. naar origineelbron):

```yaml
- type: link
  title: "Copyright info"
  url: "https://www.example.com/bron"
```

---

## Problemen oplossen

### "Bestanden niet gevonden" of afbeelding verschijnt niet

**Oorzaken:**
- Mappad in `base` klopt niet met werkelijke `/static/` mappenstructuur
- Bestandsnaam in `file` komt niet overeen met werkelijke bestanden (let op spaties en nummering)
- Je hebt `.pdf`, `.mp3` enz. in de `file` naam gezet (mag niet)

**Oplossing:**
- Controleer paden exact
- Zorg dat bestandsnamen beginnen met hetzelfde (bijv. `001-vredeslitanie`)

### Pagina laadt niet of YAML-fout

**Oorzaken:**
- YAML-syntax fout (spaties, dubbelepunten, inkeping)
- `items:` root key ontbreekt

**Oplossing:**
- Check je YAML-syntax op fout
- Zorg dat elk item een `type` heeft
- Controleer inspringingen (moet 2 of 4 spaties consistent zijn)

### Wijzigingen verschijnen niet op preview-site

- Wacht enkele minuten; GitHub Actions bouwt de site automatisch
- Check op GitHub of de workflow is geslaagd (groen vinkje) of gefaald (rood kruis)
- Zet je browser-cache uit of gebruik Ctrl+Shift+R om opnieuw in te laden

---

## Volgende stappen

Zie de [Referentie Documentatie](render-data-referentie-doc.md) voor:
- Geavanceerde YAML-structuren (herbruikbare snippets, geneste groepen)
- Alle configuratieopties van de shortcode
- Gedetailleerde directory-structuren