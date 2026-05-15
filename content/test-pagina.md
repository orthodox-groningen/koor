---
title: "Voorbeelden van shortcodes"
---

Deze pagina documenteert alle beschikbare shortcodes en hun gebruik.

---

## Spacer

De `spacer` shortcode voegt verticale ruimte toe. Gebruik `h` voor de hoogte (bijv. `1em`, `2rem`, `20px`).

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

De `koor-item` shortcode toont een kooritem met afbeelding en beschrijving. Parameters:
- `title` – Naam van het item
- `dir` – Directory waar de bestanden staan
- `base` – Bestandsnaam (zonder extensie)

**Voorbeeld:**
```
{​{< koor-item
    title="21 - Prokimen en Alleluja - toon 1"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>}}
```

{{< spacer h="1em" >}}

{{< koor-item
    title="21 - Prokimen en Alleluja - toon 1"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>}}

{{< spacer h="2em" >}}

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

{{< spacer h="1em" >}}

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

{{< spacer h="2em" >}}

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

{{< spacer h="2em" >}}

---
## Tips & Tricks

### Geneste Shortcodes
Je kunt shortcodes combineren voor meer complexe layouts:

```
{​{< spacer h="1em" >}}

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
