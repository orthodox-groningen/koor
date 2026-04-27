---
title: "Testpagina"
---

Dit is een voorbeeldpagina waarin verschillende bestanden uit de centrale library worden gebruikt.

---


## 🖼️ Afbeelding tonen (PNG/JPG)

Afbeelding uit de library, direct zichtbaar in de pagina:

<img 
  src="/koormappen/heilige-liturgie/voetnoot-bij-prokimen-melodien.jpg" 
  alt="Voorbeeld afbeelding" 
  style="max-width:100%; height:auto;" />

---

## 🎵 MP3 afspelen via knop

Klik op de knop om audio af te spelen:

<audio id="audio1" src="/koormappen/heilige-liturgie/audio/Alleluja-melodielijn-toon-1.mp3"></audio>

<button onclick="document.getElementById('audio1').currentTime=0; document.getElementById('audio1').play()">
  ▶ Afspelen
</button>

<button onclick="document.getElementById('audio1').pause()">
  ⏸ Pauze
</button>

---

## 📄 PDF tonen (embedded, niet downloaden)

De PDF wordt direct in de pagina weergegeven via een ingebedde viewer:

<iframe 
  src="/koormappen/heilige-liturgie/021-prokimen-alleluja-toon-1.pdf"
  width="100%" 
  height="600px">
</iframe>

---

## Samenvatting

- PDF wordt ingebed via `<iframe>`
- Afbeelding wordt getoond via `<img>`
- Audio wordt bestuurd via HTML audio + knoppen