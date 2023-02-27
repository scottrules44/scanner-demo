local scanner = require "plugin.scanner"
local widget = require "widget"
local json = require "json"
local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
local title = display.newText("Scanner Plugin", display.contentCenterX, 40, native.systemFontBold, 20)
title:setFillColor(0)
------

local function appPermissionsListener( event )
    for k,v in pairs( event.grantedAppPermissions ) do
        if ( v == "Camera" ) then
            print( "Camera permission granted!" )
        end
    end
end


----

local androidPermissions = widget.newButton( {
    x = display.contentCenterX,
    y= display.contentCenterY-50,
    label = "Android Camera Permissions",
    onRelease = function (  )
        local options =
        {
            appPermission = "Camera",
            urgency = "Critical",
            listener = appPermissionsListener,
            rationaleTitle = "Camera access required",
            rationaleDescription = "Camera access is required to take QR Scanning. Re-request now?",
            settingsRedirectTitle = "Alert",
            settingsRedirectDescription = "Without the ability to take photos, this app cannot properly function. Please grant camera access within Settings."
        }
        native.showPopup( "requestAppPermission", options )
    end
} )
local show = widget.newButton( {
    x = display.contentCenterX,
    y= display.contentCenterY+90,
    label = "Scan QR",
    onRelease = function (  )
        scanner.show({hideFlash=true, hideCameraSwitch=true, scanFor={"qr"}, title="Scanner QR Plugin", closeTitle="close", listener=function  (e)
            if(e.status == "gotCode")then
                print("Got Code:"..e.code)
            else
                print(e.status)
            end
        end})
        timer.performWithDelay( 9000, function()
            scanner.close()
        end )

    end
} )
