function PowerSpeak{
  # Referer: https://github.com/outflanknl/Scripts/blob/master/PowerSpeak.ps1
  Param(
    [Parameter(Position=0, Mandatory = $False)]
		[String]
		$speak
  )
  add-type -assemblyname system.speech
  $PowerSpeak = New-Object System.Speech.Synthesis.SpeechSynthesizer
  $PowerSpeak.volume = 100
  if(-not $speak){
    $speak = "Con diez cañones por banda,
              Viento en popa, a toda vela,
              No corta el mar, sino vuela
              Un velero bergantín:
              Bajel pirata que llaman
              Por su bravura el Temido,
              En todo el mar conocido
              Del uno al otro confín.

              La luna en el mar rïela,
              En la lona gime el viento,
              Y alza en blando movimiento
              Olas de plata y azul;
              Y ve el capitán pirata,
              Cantando alegre en la popa,
              Asia a un lado, a otro Europa,
              Y allá a su frente Estambul.

              Navega, velero mío,
              Sin temor,
              Que ni enemigo navío,
              Ni tormenta, ni bonanza
              Tu rumbo a torcer alcanza,
              Ni a sujetar tu valor.

              Veinte presas
              Hemos hecho
              A despecho
              Del inglés,
              Y han rendido
              Sus pendones
              Cien naciones
              A mis pies.

              Que es mi barco mi tesoro,
              Que es mi Dios la libertad,
              Mi ley, la fuerza y el viento,
              Mi única patria la mar.

              Allá muevan feroz guerra
              Ciegos Reyes
              Por un palmo más de tierra,
              Que yo aquí tengo por mío
              Cuanto abarca el mar bravío,
              A quien nadie impuso leyes.

              Y no hay playa,
              Sea cualquiera,
              Ni bandera
              De esplendor,
              Que no sienta
              Mi derecho
              Y dé pecho
              A mi valor.

              Que es mi barco mi tesoro,
              Que es mi Dios la libertad,
              Mi ley, la fuerza y el viento,
              Mi única patria la mar.

              A la voz de ‘¡barco viene!’
              Es de ver
              Cómo vira y se previene
              A todo trapo a escapar:
              Que yo soy el rey del mar,
              Y mi furia es de temer.

               En las presas
              Yo divido
              Lo cogido
              Por igual.
              Sólo quiero
              Por riqueza
              La belleza
              Sin rival.

              Que es mi barco mi tesoro,
              Que es mi Dios la libertad,
              Mi ley, la fuerza y el viento,
              Mi única patria la mar.

              ¡Sentenciado estoy a muerte!
              Yo me río;
              No me abandone la suerte,
              Y al mismo que me condena
              Colgaré de alguna entena
              Quizá en su propio navío.

              Y si caigo,
              ¿Qué es la vida?
              Por perdida ya la di,
              Cuando el yugo
              Del esclavo,
              Como un bravo,
              Sacudí.

              Que es mi barco mi tesoro,
              Que es mi Dios la libertad,
              Mi ley, la fuerza y el viento,
              Mi única patria la mar.

              Son mi música mejor
              Aquilones,
              El estrépito y temblor
              De los cables sacudidos,
              Del ronco mar los bramidos
              Y el rugir de mis cañones.

              Y del trueno
              Al son violento,
              Y del viento
              Al rebramar,
              Yo me duermo
              Sosegado,
              Arrullado
              Por el mar.

              Que es mi barco mi tesoro,
              Que es mi Dios la libertad,
              Mi ley, la fuerza y el viento,
              Mi única patria la mar.
    "
    $speak="Un novato estaba tratando de arreglar una máquina Lisp rota apagando y encendiendo la alimentación. Knight, al ver lo que el estudiante estaba haciendo, habló severamente: No se puede arreglar una máquina simplemente pedaleándola sin entender lo que va mal. Knight apagó y encendió la máquina. La máquina funcionó."
  }
  $PowerSpeak.Speak($speak)  
}
