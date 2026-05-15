---
title: "Voorbeelden van shortcodes"
---

Deze pagina documenteert alle beschikbare shortcodes en hun gebruik.

---

## Spacer

De `spacer` shortcode voegt verticale ruimte toe. Gebruik de optionele `h` voor de hoogte (bijv. `1em`, `2rem`, `20px`).

{{< spacer h="1em" >}}

**Voorbeeld:**
```
eerste regel voor de shortcode.  
tweede regel voor de shortcode.
{​{< spacer h="2em" >}}
regel na de shortcode.
```

{{< spacer h="2em" >}}

---

## Koor-item

Een 'koor-item' is een verzameling bestanden die gaan over een een lied. In die verzameling kan een plaatje zitten (JPG of PNG), een PDF, en ook audio bestanden (voor individuele stemmen S, A, T, B en samen SATB)

De `koor-item` shortcode rendert als een element uit een inhoudsopgave die je kunt uitklappen. Als je dat doet, worden de bestaande bestanden uit de verzameling getoond, of in geval van audio kunnen ze worden afgespeeld.

| Parameter | Omschrijving | Voorbeeld |
| :-------: | :----------- | :-------- |
| `title`   | (verplicht) Naam van het item | `Prokimen en Alleluja (toon 1)` |
| `dir`     | (verplicht) Directory waar de bestanden staan | `/koormappen/heilige-liturgie` |
| `base`    | (verplicht) Bestandsnaam (zonder extensie) | `021-prokimen-alleluja-toon-1` |
| `link`    | (optioneel) URL, die wijst naar een (externe) bron/website | `https://www.universaledition.com/en/Works/Cherubim/P0213837` |

**Voorbeeld:**
```
{​{< koor-item
    title="Prokimen en Alleluja (toon 1)"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>}}
```

{​{< koor-item
    title="Prokimen en Alleluja (toon 1)"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>}}

---

## Tabs

De `tabs` shortcode maakt een tabinterface voor het weergeven van verschillende content. Parameters:
- `default` – Welke tab standaard geopend is (0 = eerste, 1 = tweede, etc.)
- `group` – Optioneel: tabs met dezelfde groepnaam schakelen synchroon

### Voorbeeld 1: Basis tabs

**Markdown:**
```
{​{< tabs default="0" >}}
  {​{< tab label="Python" >}}
```python
print("Hello, World!")
```
  {​{< /tab >}}

  {​{< tab label="JavaScript" >}}
```javascript
console.log("Hello, World!");
```
  {​{< /tab >}}

  {​{< tab label="Go" >}}
```go
fmt.Println("Hello, World!")
```
  {​{< /tab >}}
{​{< /tabs >}}
```

**Live voorbeeld:**

{{< tabs default="0" >}}
  {{< tab label="Python" >}}
```python
print("Hello, World!")
```
  {{< /tab >}}

  {{< tab label="JavaScript" >}}
```javascript
console.log("Hello, World!");
```
  {{< /tab >}}

  {{< tab label="Go" >}}
```go
fmt.Println("Hello, World!")
```
  {{< /tab >}}
{{< /tabs >}}


### Voorbeeld 2: Tabs met HTML-content

Je kunt ook normale markdown/HTML in tabs zetten:

{{< tabs default="1" >}}
  {{< tab label="Toon 1" >}}
Dit is een beschrijving van **toon 1**. Je kunt markdown gebruiken!

- Bullet 1
- Bullet 2
- Bullet 3
  {{< /tab >}}

  {{< tab label="Toon 2" >}}
Dit is een beschrijving van **toon 2**. 

> Dit is een quote in een tab

Merk op dat `default="1"` deze tab standaard opent.
  {{< /tab >}}

  {{< tab label="Toon 3" >}}
Dit is een beschrijving van **toon 3**.

Alle markdown features werken:
- **Vet**
- *Cursief*
- `Code`
  {{< /tab >}}
{{< /tabs >}}

---
### Voorbeeld 3: Tabs met echte Koor-shortcodes

Dit voorbeeld laat zien hoe je tabs combineert met koor-shortcodes:

{{< tabs default="0" >}}
  {{< tab label="Enkel Item" >}}

{{< koor-item
    title="21 - Prokimen en Alleluja - toon 1"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>}}

  {{< /tab >}}

  {{< tab label="Groep met Items" >}}

{{< koor-group title="Heilige Liturgie Tonen" >}}

{{< koor-item
    title="Toon 1 - Prokimen"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>}}

{{< koor-item
    title="Toon 2 - Prokimen"
    dir="/koormappen/heilige-liturgie"
    base="022-prokimen-alleluja-toon-2"
>}}

{{< /koor-group >}}

  {{< /tab >}}

  {{< tab label="Included Snippet" >}}

{{< include-md file="content/snippets/test-snippet.md" >}}

  {{< /tab >}}

{{< /tabs >}}

---
## Tips & Tricks

### Geneste Shortcodes
Je kunt shortcodes combineren voor meer complexe layouts:

```

{​{< tabs default="0" >}}
  {​{< tab label="Voorbeeld 1" >}}
{​{< koor-item
    title="Item 1"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>}}
  {​{< /tab >}}

  {​{< tab label="Voorbeeld 2" >}}
{​{< koor-item
    title="Item 2"
    dir="/koormappen/concert"
    base="some-other-file"
>}}
  {​{< /tab >}}
{​{< /tabs >}}

{​{< spacer h="1em" >}}
```

### Synchronized Tabs (Group)
Wanneer je dezelfde `group` naam gebruikt, schakelen alle tabs met die groep tegelijk:

```
{​{< tabs default="0" group="language" >}}
  {​{< tab label="Nederlands" >}}
Hallo, Wereld!
  {​{< /tab >}}
  {​{< tab label="Engels" >}}
Hello, World!
  {​{< /tab >}}
{​{< /tabs >}}

{​{< spacer h="2em" >}}

{​{< tabs default="0" group="language" >}}
  {​{< tab label="Nederlands" >}}
Goedemorgen
  {​{< /tab >}}
  {​{< tab label="Engels" >}}
Good morning
  {​{< /tab >}}
{​{< /tabs >}}
```
