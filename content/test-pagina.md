---
title: "Voorbeelden van shortcodes"
---

Deze pagina documenteert de belangrijkste shortcodes en bevat korte voorbeelden.

---

## Spacer

De `spacer` shortcode voegt verticale ruimte toe. Gebruik `h` voor de hoogte (bijv. `1em`, `2rem`, `20px`).

**Live voorbeeld:**

Deze tekst staat voor de short-code die een lege ruimte toevoegt van `3em`.
{{< spacer h="3em" >}}
Deze tekst staat erachter.

**Voorbeeld (hoe te schrijven):**

<!--
  Waarschuwing: dit codeblok bevat onzichtbare escape-tekens om te voorkomen
  dat Hugo de shortcode-syntax uitvoert. Laat deze regels ongemoeid als je het
  voorbeeld aanpast.
-->

````
{{​< spacer h="2em" >​}}
````

---

## Koor-item

Een `koor-item` is een verzameling bestanden die gaan over een een lied. In die verzameling kan een plaatje zitten (JPG of PNG), een PDF en ook audio bestanden voor individuele stemmen (S, A, T, B) en samen (SATB).

De `koor-item` shortcode toont de beschikbare inhoud van het item en voegt het in als een uitklapbare widget met PDF, audio en eventueel andere bestanden.

### Parameters (V/O = Verplicht/Optioneel)

| Param   |  V/O  | Omschrijving | Voorbeeld |
| :-----: | :---: | :----------- | :-------- |
| `title` |   V   | Naam van het item | `Prokimen en Alleluja (toon 1)` |
| `dir`   |   O   | Directory waar de bestanden staan. Optioneel als `koor-item` binnen een `koor-group` staat met `dir` ingesteld. | `/koormappen/heilige-liturgie` |
| `base`  |   V   | Bestandsnaam (zonder extensie) | `021-prokimen-alleluja-toon-1` |
| `link`  |   O   | URL naar een externe bron/website | `https://www.universaledition.com/en/Works/Cherubim/P0213837` |

**Voorbeeld (hoe te schrijven):**

<!--
  Waarschuwing: dit codeblok gebruikt onzichtbare escape-tekens zodat Hugo
  de shortcode niet uitvoert in de bronweergave. Bewerk de regels alleen als
  je deze escapes behoudt of op dezelfde manier vervangt.
-->

````
{{​< koor-item
    title="Prokimen en Alleluja (toon 1)"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>​}}
````

**Live voorbeeld:**

{{< koor-item
    title="Prokimen en Alleluja (toon 1)"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>}}

---

## Koor-group

Een `koor-group` groepeert meerdere `koor-item`-shortcodes onder één titel. Als je een gemeenschappelijke `dir` opgeeft in de groep, mogen de kinderen dat pad overslaan.

### Voorbeeld

<!--
  Waarschuwing: dit codeblok gebruikt onzichtbare escape-tekens zodat Hugo
  de shortcode niet uitvoert in de bronweergave. Bewerk de regels alleen als
  je deze escapes behoudt of op dezelfde manier vervangt.
-->

````
{{< koor-group title="Toon 1" dir="/koormappen/heilige-liturgie" >}}
    {{< koor-item  base="021-prokimen-alleluja-toon-1" title="Prokimen en Alleluja (bladmuziek)" >}}
    {{< koor-item  base="021-prokimen-zondag-toon-1"   title="Prokimen van de zondag (audio))" >}}
    {{< koor-item  base="021-alleluja-toon-1"          title="Alleluja (audio)" >}}
    {{< include-md file="voetnoot-bij-prokimen-melodien" title="Voetnoot" >}}
{{< /koor-group >}}
````

{{< koor-group title="Toon 1" dir="/koormappen/heilige-liturgie" >}}
    {{< koor-item  base="021-prokimen-alleluja-toon-1" title="Prokimen en Alleluja (bladmuziek)" >}}
    {{< koor-item  base="021-prokimen-zondag-toon-1"   title="Prokimen van de zondag (audio))" >}}
    {{< koor-item  base="021-alleluja-toon-1"          title="Alleluja (audio)" >}}
    {{< include-md file="voetnoot-bij-prokimen-melodien" title="Voetnoot" >}}
{{< /koor-group >}}

In dit voorbeeld gebruiken de `koor-item`-shortcodes dezelfde directory als de groep, zonder dat die per item herhaald hoeft te worden.

---

## Tabs

De `tabs` shortcode creëert een tab-interface. Omdat geneste shortcodes soms lastig te parsen zijn in Hugo, geef ik hieronder een eenvoudige en betrouwbare werkwijze: schrijf de tab-UI als plain HTML en zet de shortcodes binnen de tab-content. Shortcodes worden binnen HTML gewoon gerenderd.

> Let op: zorg dat de HTML-tagregels niet met 4 of meer spaties beginnen, want dan behandelt Markdown ze als een codeblok.

### Voorbeeld: Simpele HTML-tabs (werkt betrouwbaar)

**Voorbeeld (hoe te schrijven):**

<!--
  Waarschuwing: het codevoorbeeld hieronder bevat onzichtbare escape-tekens
  voor Hugo-shortcodes. Bewerk deze regels alleen als je deze escapes behoudt.
-->

````html
<div class="tabs-container" data-group="manual-1" data-default="0">
<div class="tabs-list">
<button class="tab-trigger active" data-tab="0">Enkel Item</button>
<button class="tab-trigger" data-tab="1">Groep met Items</button>
<button class="tab-trigger" data-tab="2">Included Snippet</button>
</div>

<div class="tabs-content">
<div class="tab-pane active" data-tab="0">
{{​< koor-item
    title="21 - Prokimen en Alleluja - toon 1"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>​}}
</div>

<div class="tab-pane" data-tab="1">
{{​< koor-group title="Heilige Liturgie Tonen" >​}}

{{​< koor-item
    title="Toon 1 - Prokimen"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>​}}

{{​< koor-item
    title="Toon 2 - Prokimen"
    dir="/koormappen/heilige-liturgie"
    base="022-prokimen-alleluja-toon-2"
>​}}

{{​< /koor-group >​}}
</div>

<div class="tab-pane" data-tab="2">
{{​< include-md file="content/snippets/test-snippet.md" >​}}
</div>
</div>
</div>
````

**Live voorbeeld:**

<div class="tabs-container" data-group="manual-1" data-default="0">
<div class="tabs-list">
<button class="tab-trigger active" data-tab="0">Enkel Item</button>
<button class="tab-trigger" data-tab="1">Groep met Items</button>
<button class="tab-trigger" data-tab="2">Included Snippet</button>
</div>

<div class="tabs-content">
<div class="tab-pane active" data-tab="0">
{{< koor-item
    title="21 - Prokimen en Alleluja - toon 1"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>}}
</div>

<div class="tab-pane" data-tab="1">
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
</div>

<div class="tab-pane" data-tab="2">
{{< include-md file="content/snippets/test-snippet.md" >}}
</div>
</div>
</div>

---

## Tips & Tricks

### Geneste Shortcodes
Je kunt shortcodes combineren; als je voorbeeldcode wilt laten zien gebruik dan een hogere fence (vier backticks) om conflicten met interne fenced codeblocks te voorkomen.

<!--
  Waarschuwing: het voorbeeld hieronder gebruikt onzichtbare tekens om te voorkomen
  dat Hugo de shortcode-syntax uitvoert. Bewerk deze regels alleen als je begrijpt
  dat je de extra onzichtbare spaties (zero-width spaces) moet behouden of op
  dezelfde manier moet vervangen.
-->

````
{{​< tabs default="0" >​}}
  {{​< tab label="Voorbeeld 1" >​}}
    {{​< koor-item
        title="Item 1"
        dir="/koormappen/heilige-liturgie"
        base="021-prokimen-alleluja-toon-1"
    >​}}
  {{​< /tab >​}}
  {{​< tab label="Voorbeeld 2" >​}}
    {{​< koor-item
        title="Item 2"
        dir="/koormappen/concert"
        base="some-other-file"
    >​}}
  {{​< /tab >​}}
{{​< /tabs >​}}

{{​< spacer h="1em" >​}}
````

> Let op: het bovenstaande codeblok bevat onzichtbare escape-tekens in de regels hierboven. Bewerk de shortcode-syntax alleen als je de zero-width spaces behoudt.

**Live voorbeeld:**

<div class="tabs-container" data-group="manual-demo-1" data-default="0">
<div class="tabs-list">
<button class="tab-trigger active" data-tab="0">Voorbeeld 1</button>
<button class="tab-trigger" data-tab="1">Voorbeeld 2</button>
</div>

<div class="tabs-content">
<div class="tab-pane active" data-tab="0">
{{< koor-item
    title="Item 1"
    dir="/koormappen/heilige-liturgie"
    base="021-prokimen-alleluja-toon-1"
>}}
</div>
<div class="tab-pane" data-tab="1">
{{< koor-item
    title="Item 2"
    dir="/koormappen/concert"
    base="some-other-file"
>}}
</div>
</div>
</div>

### Synchronized Tabs (Group)
Wanneer je dezelfde `group` naam gebruikt, schakelen alle tabs met die groep tegelijk:

<!--
  Waarschuwing: ook hier gebruiken we onzichtbare tekens in de codeblokregels
  om Hugo niet te laten parsen. Laat deze regels ongemoeid tenzij je de
  escapes consistent behoudt.
-->

```
{{​< tabs default="0" group="language" >​}}
  {{​< tab label="Nederlands" >​}}
    Hallo, Wereld!
  {{​< /tab >​}}
  {{​< tab label="Engels" >​}}
    Hello, World!
  {{​< /tab >​}}
{{​< /tabs >​}}

{{​< spacer h="2em" >​}}
```

> Let op: dit codeblok bevat onzichtbare escape-tekens in de regels hierboven. Bewerk de shortcode-syntax alleen als je de zero-width spaces behoudt.

**Live voorbeeld:**

<div class="tabs-container" data-group="manual-demo-2" data-default="0">
<div class="tabs-list">
<button class="tab-trigger active" data-tab="0">Nederlands</button>
<button class="tab-trigger" data-tab="1">Engels</button>
</div>

<div class="tabs-content">
<div class="tab-pane active" data-tab="0">
Hallo, Wereld!
</div>
<div class="tab-pane" data-tab="1">
Hello, World!
</div>
</div>
</div>
