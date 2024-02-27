#set par(justify: true)
#set text(
  font: "Latin Modern Roman",
  size: 10pt,
)

#set page(
  paper: "a4",
  header:[
    #set align(center)
    = Zadání semestrální práce B0B36DBS
    Jakub Adamec ---  adamej14\@fel.cvut.cz
  ],
  
  footer:[
    #set align(left)
    Praha, jaro 2024
    #set align(center)
    #counter(page).display(
      "1",
    )
  ],
  
)


== Návrh na práci
Systém správy letiště s evidencí letů, pasažérů, zaměstnanců a provozními daty. Například statistika letů v a mimo Schengenský prostor, počet odbavených pasažerů, případně jiná statistická data, která mohou pomoci s ekonomickou analýzou letiště.

//

== Motivace
Takový systém používá zřejmě každé letiště, toto by byl tedy pokus o návrh provedení pro nové letiště, které by v budoucnu mohlo vyrůst v Česku.

