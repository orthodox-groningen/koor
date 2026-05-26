# YAML Render Architectuur (Technische Referentie)

````
Dit document is ooit gegenereerd en moet nog op 
bruikbaarheid en consistentie worden gecontroleerd.
````

Deze site gebruikt een YAML-gebaseerde render-architectuur voor het beheren en renderen van koormappen, media-assets en geneste groepen.

De architectuur is ontworpen om:

- robuust te zijn binnen Hugo
- diepe nesting te ondersteunen
- onderhoudbare YAML mogelijk te maken
- herhaling van paden te vermijden
- shortcode-complexiteit te vermijden

---

## 1. Architectuuroverzicht

De architectuur bestaat uit:

| Onderdeel | Locatie | Opmerkingen |
| --------- | ------- | ----------- |
| Markdown pagina's | `/content/` | Hierbinnen kunnen zo nodig subdirectories worden gebruikt. |
| YAML datasets | `/data/` | Hierbinnen kunnen subdirectories worden gebruikt die als `group` moeten worden opgegeven in de `render-data shortcode. |
| Shortcode | `/layouts/shortcodes/render-data.html` | Syntax: `{{</* render-data group="{{subdir}}" source="{{filenaam}}" */>}}` |
| Tree renderer | `/layouts/partials/render-tree.html` | |
| Asset resolver | `/layouts/partials/resolve-item.html` | |
| Inhoudelijke bestanden | `/static/` | Hierbinnen kunnen zo nodig subdirectories worden gebruikt. |

---

## 2. Werking in grote lijnen

Een markdown-bestand bevat:

```markdown
{{</* render-data group="groningen" source="goddelijke-liturgie" */>}}
```

Dit betekent:

- zoek YAML bestand: `/data/groningen/goddelijke-liturgie.yaml`
- laad daaruit de datastructuur
- render de boomstructuur
- zoek bijbehorende bestanden in `/static/`

---

## 3. Verplichte bestanden

### 3.1 Shortcode

Bestand:

```text
/layouts/shortcodes/render-data.html
```

Moet bestaan.

---

### 3.2 Tree renderer

Bestand:

```text
/layouts/partials/render-tree.html
```

Moet bestaan.

Verantwoordelijk voor:

- recursion
- groups
- items
- rendering van assets

---

### 3.3 Asset resolver

Bestand:

```text
/layouts/partials/resolve-item.html
```

Moet bestaan.

Verantwoordelijk voor:

- zoeken van bestanden
- type-detectie
- asset-opsomming

---

## 4. YAML datasets

### Locatie

Alle datasets staan onder:

```text
/data/
```

Bijvoorbeeld:

```text
/data/groningen/goddelijke-liturgie.yaml
```

---

## 5. Structuur van YAML bestanden

Een dataset bevat:

```yaml
items:
```

met daarin:

- `group`
- `item`
- `link`
- `include`

---

## 6. Group structuur

Een group groepeert andere groepen of items.

Voorbeeld:

```yaml
- type: group
  title: "Toon 1"
  base: "toon-1"
  items:
    - type: item
      title: "Prokimen"
      file: "prokimen"
```

---

### Group eigenschappen

| Eigenschap | Verplicht | Betekenis |
|---|---|---|
| type | ja | moet `group` zijn |
| title | ja | zichtbare titel |
| items | ja | lijst met children |
| base | nee | directory uitbreiding |

---

## 7. Item structuur

Een item verwijst naar bestanden.

Voorbeeld:

```yaml
- type: item
  title: "Trisagion"
  file: "trisagion"
```

---

### Item eigenschappen

| Eigenschap | Verplicht | Betekenis |
|---|---|---|
| type | ja | moet `item` zijn |
| title | ja | zichtbare titel |
| file | ja | basisnaam van bestanden |
| dir | nee | extra subdirectory |

---

## 8. Padopbouw

Paden worden opgebouwd uit:

```text
group.base + item.dir + item.file
```

---

## 9. Asset matching

De resolver zoekt:

```text
startsWith(file)
```

Dus:

```yaml
file: "trisagion"
```

matcht:

```text
trisagion.pdf
trisagion.jpg
trisagion.mp3
trisagion-S.mp3
trisagion-SATB.mp3
```

---

## 10. Ondersteunde bestandstypen

| Extensie | Type |
|---|---|
| .jpg | image |
| .png | image |
| .pdf | pdf |
| .mp3 | audio |
| .md | text |

Andere extensies worden als generiek `file` behandeld.

---

## 11. Controle van YAML syntax

Gebruik:

```cmd
hugo server
```

of:

```cmd
hugo
```

Syntaxfouten verschijnen direct in de console.

---

## 12. Veel voorkomende fouten

### Bestand niet gevonden

Controleer:

- group.base
- item.dir
- item.file
- daadwerkelijke directory

---

### YAML indentation fout

Gebruik altijd spaties, geen tabs.

Aanbevolen:

- 2 spaties per niveau

---

## 13. Aanbevolen workflow

1. Plaats bestanden in `/static/`
2. Maak of wijzig YAML
3. Start:

```cmd
hugo server
```

4. Controleer browser output
5. Controleer console op fouten
