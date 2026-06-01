---
title: "YAML PDF rendering test"
---

De renderingen van de hoofdstukjes "## PDF test (render-data)" en "## PDF test (koor-group, koor-item)" 
(in het bestand "content\beheer\yaml-pdf-rendering-test.md") moeten identiek zijn.
Als dat niet zo is, dan moet gekeken worden hoe de shortcode voor `render-data`,
c.q. alle onderliggende partial shortcodes en andere zaken, zodanig moeten worden
aangepast dat dit wel het geval is.  
Code die (direct of indirect) wordt gebruikt door de shortcodes
`koor-group` en/of `koor-item` MAG NIET WORDEN GEWIJZIGD.

## PDF test (render-data)

{{< render-data group="test" source="pdftests" >}}

## PDF test (koor-group, koor-item)

{{< koor-group title="PDF test lijst" >}}
    {{< koor-item dir="/koormappen/testmap" base="test" title="Testlied" >}}
    {{< koor-item dir="/koormappen/testmap" base="test-A" title="Test-A" >}}
    {{< koor-item dir="/koormappen/testmap/images" base="kruisje" title="Kruisje" >}}
{{< /koor-group >}}
