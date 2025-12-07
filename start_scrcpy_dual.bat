@echo off
setlocal

:: Configuration
set Device1=6b0f0231
set Device2=b0434f37

:: Screen Layout
:: Screen: 2560x1440
:: Right 1/3 width = 853 pixels total
:: Split into two columns = 426 pixels each
:: Start X = 1707
:: Device 1 Pos: 1707
:: Device 2 Pos: 2133
:: Vertical Centering:
:: Phone Aspect Ratio: 20:9 (1080x2400)
:: Correct Quantity Height for 426 width = 426 * (2400/1080) ~= 947px
:: Top Margin = (1440 - 947) / 2 = ~246px

echo Launching scrcpy for devices...

:: Launch Device 1 (Left side of the strip)
start "" scrcpy.exe -s %Device1% --window-x 1708 --window-y 246 --window-width 426 --window-height 947

echo Waiting for 2 seconds to avoid conflict...
timeout /t 2 /nobreak >nul

:: Launch Device 2 (Right side of the strip)
start "" scrcpy.exe -s %Device2% --window-x 2134 --window-y 246 --window-width 426 --window-height 947

echo Launched scrcpy for devices %Device1% and %Device2% side-by-side on the right (Centered).
endlocal
