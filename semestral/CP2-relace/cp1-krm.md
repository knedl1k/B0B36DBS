<ul>
    <li>Letiste(<u>ICAO kod</u>, nazev, mesto, stat) </li>
    <li>Let(<u>cislo letu, cas odletu</u>, <u>cislo letu, cas priletu</u>, ICAO_kod_prilet, ICAO_kod_odlet)</li>
    <ul>
        <li>
            FK: (ICAO_kod_prilet) ⊆ Letiste(ICAO_kod)
        </li>
        <li>
            FK: (ICAO_kod_odlet) ⊆ Letiste(ICAO_kod)
        </li>
    </ul>
    <li>Navazuje_na(<u>cislo letu, cas odletu, navazuje</u>)</li>
    <ul>
        <li>
            FK: (cislo_letu, cas_odletu) ⊆ Let(cislo_letu, cas_odletu)
        </li>
        <li>
            FK: (navazuje) ⊆ Let(cislo_letu, cas_odletu)
        </li>
    </ul>
    <li>Aerolinka(<u>kod spolecnosti</u>, nazev, zeme puvodu) </li>
    <li>Zajistuje(<u>kod spolecnosti, cislo letu, cas odletu</u>)</li>
    <ul>
        <li>
            FK: (kod_spolecnosti) ⊆ Aerolinka(kod_spolecnosti)
        </li>
        <li>
            FK: (cislo_letu, cas_odletu) ⊆ Let(cislo_letu, cas_odletu)
        </li>
    </ul>
    <li>Letadlo(<u>registracni znacka </u>, vlastnik) </li>
    <li>Leti(<u>registracni znacka</u>, <u>cislo letu, cas odletu</u>)</li>
    <ul>
        <li>
            FK: (registracni_znacka) ⊆ Letadlo(registracni_znacka)
        </li>
        <li>
            FK: (cislo_letu, cas_odletu) ⊆ Let(cislo_letu, cas_odletu)
        </li>
    </ul>
    <li>Nakladni(<u>registracni znacka</u>, nosnost) </li>
    <ul>
        <li>FK: (registracni_znacka) ⊆ Letadlo(registracni_znacka) </li>
    </ul>
    <li>Civilni(<u>registracni znacka</u>, kapacita_pasazeru) </li>
    <ul>
        <li>FK: (registracni_znacka) ⊆ Letadlo(registracni_znacka) </li>
    </ul>
    <li>Pasazer(<u>cislo pasu</u>, datum_narozeni, krestni_jmeno, prijmeni, registracni_znacka)</li>
    <ul>
        <li>
            FK: (registracni_znacka) ⊆ Letadlo(registracni_znacka)
        </li>
    </ul>
    <li>Krestni_jmeno(<u>cislo pasu, krestni jmeno</u>)</li>
    <ul>
        <li>
            FK: (cislo_pasu) ⊆ Pasazer(cislo_pasu)
        </li>
    </ul> 
    <li>Zavazadlo(<u>datum, cislo letu, cislo pasu</u>, hmotnost)</li>
    <ul>
        <li>FK: (cislo_pasu) ⊆ Pasazer(cislo_pasu) </li>
    </ul>



</ul>
