---
title: "Shortcodes debug pagina"
---

Deze pagina bestaat voor ontwikkelaars om shortcodes mee te debuggen.

---

## Koor-item

---

{{< koor-item
    title="test met pdf en audio bestanden"
    dir="/koormappen/testmap"
    base="test-2"
>}}

{{< koor-item  
    title="Voetnoot"
    dir="/koormappen/heilige-liturgie" 
    file="voetnoot-bij-prokimen-melodien"
>}}

---

## Koor-group

---

{{< koor-group title="Toon 1" dir="/koormappen/heilige-liturgie" >}}
    {{< koor-item  base="021-prokimen-alleluja-toon-1" title="PDF (bladmuziek)" >}}
    {{< koor-item  base="test-2"                       title="Spul uit de testmap"   dir="/koormappen/testmap" >}}
    {{< koor-item  base="021-prokimen-zondag-toon-1"   title="Audio zonder dir-param" >}}
    {{< koor-item  base="021-alleluja-toon-1"          title="Audio met dir-param"  dir="/koormappen/heilige-liturgie" >}}
    <!-- {{< koor-item  file="voetnoot-bij-prokimen-melodien" title="Voetnoot" dir="/koormappen/heilige-liturgie" >}} -->
{{< /koor-group >}}

---
