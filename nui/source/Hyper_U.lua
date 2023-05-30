--[[ 
╔══════════════════════════════════════════════════[ www.hyperscripts.com.br ]═════════════════════════════════════════════════════════════╗
 ___  ___      ___    ___ ________  _______   ________          ________  ________  ________  ___  ________  _________  ________      
|\  \|\  \    |\  \  /  /|\   __  \|\  ___ \ |\   __  \        |\   ____\|\   ____\|\   __  \|\  \|\   __  \|\___   ___\\   ____\     
\ \  \\\  \   \ \  \/  / | \  \|\  \ \   __/|\ \  \|\  \       \ \  \___|\ \  \___|\ \  \|\  \ \  \ \  \|\  \|___ \  \_\ \  \___|_    
 \ \   __  \   \ \    / / \ \   ____\ \  \_|/_\ \   _  _\       \ \_____  \ \  \    \ \   _  _\ \  \ \   ____\   \ \  \ \ \_____  \   
  \ \  \ \  \   \/  /  /   \ \  \___|\ \  \_|\ \ \  \\  \|       \|____|\  \ \  \____\ \  \\  \\ \  \ \  \___|    \ \  \ \|____|\  \  
   \ \__\ \__\__/  / /      \ \__\    \ \_______\ \__\\ _\         ____\_\  \ \_______\ \__\\ _\\ \__\ \__\        \ \__\  ____\_\  \ 
    \|__|\|__|\___/ /        \|__|     \|_______|\|__|\|__|       |\_________\|_______|\|__|\|__|\|__|\|__|         \|__| |\_________\
             \|___|/                                              \|_________|                                            \|_________|
  
╚══════════════════════════════════════════════════[ www.hyperscripts.com.br ]═════════════════════════════════════════════════════════════╝
--]]


----- Utils ----


function aToR(X, Y, sX, sY)

    local xd = X/resW or X

    local yd = Y/resH or Y

    local xsd = sX/resW or sX

    local ysd = sY/resH or sY

    return xd * screen[1], yd * screen[2], xsd * screen[1], ysd * screen[2]
    
end

_dxDrawRectangle = dxDrawRectangle

function dxDrawRectangle(x, y, w, h, ...)

    local x, y, w, h = aToR(x, y, w, h)

    return _dxDrawRectangle(x, y, w, h, ...)

end

_dxDrawText = dxDrawText

function dxDrawText(text, x, y, w, h, ...)

    local x, y, w, h = aToR(x, y, w, h)

    return _dxDrawText(text, x, y, w + x, h + y, ...)

end

_dxDrawImage = dxDrawImage

function dxDrawImage(x, y, w, h, ...)

    local x, y, w, h = aToR(x, y, w, h)

    return _dxDrawImage(x, y, w, h, ...)

end

_dxCreateFont = dxCreateFont

function dxCreateFont( filePath, size, ... )

    return _dxCreateFont( filePath, ( sx * size ), ... )

end

_event = addEvent
_eventH = addEventHandler

cache = {
    functions = { };
    EditBox = { };
    fonts = { };
    text = dxDrawText;
    image = dxDrawImage;
    rectangle = dxDrawRectangle;
    data = getElementData;
    floor = math.floor;
}


cache.functions.register =
function(event, ...)
    _event(event, true)
    _eventH(event, ...)
end

cache.functions.Cursor = 
function(x,y,w,h)
    local x, y, w, h = aToR(x, y, w, h)
    if isCursorShowing() then
        local mx, my = getCursorPosition()
        local resx, resy = guiGetScreenSize()
        mousex, mousey = mx * resx, my * resy
        if mousex > x and mousex < x + w and mousey > y and mousey < y + h then
            return true
        else
            return false
        end
    end
end

cache.functions.Redondo = 
function(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius
    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)
        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end

local moneySuff = {"K", "M", "B", "T", "Q"}


cache.functions.Convert = 
function(cMoney)
    didConvert = 0
    if not cMoney then
        return "?"
    end
    while cMoney / 1000 >= 1 do
        cMoney = cMoney / 1000
        didConvert = didConvert + 1
    end
    if didConvert > 0 then
        return "R$ " .. string.format("%.2f", cMoney) .. moneySuff[didConvert]
    else
        return "R$ " .. cMoney
    end
end

cache.functions.RemoveHex = 
function(str) 
    return str:gsub("#%x%x%x%x%x%x", "") 
end 

DrawCenter = 
function(text, x, y, w, h, color, scale, font)
    local Width = dxGetTextWidth(text, scale, font)
    local Height = dxGetFontHeight(scale, font)
    local PosX = (x + (w/2)) - (Width/2)
    local PosY = (y + (h/2)) - (Height/2)
    dxDrawText(text, PosX, PosY, 0, 0, color, scale, font)
end

getPlayerID = function(id)
    for i, v in ipairs(getElementsByType('player')) do
        if ( getElementData(v, 'ID') or 'N/A') == tonumber(id) then
            return v
        end
    end
    return false
end

cache.functions.Acltable = 
function(player,acls)
    for i,v in ipairs(acls) do
        if aclGetGroup(v) then
            if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup(v)) then
                return true
            end
        end
    end
    return false
end

cache.functions.ConverTerTimer = 
function(sec)
    iprint()
    local temp = sec/60 
    local temp2 = (math.floor(temp)) 
    local temp3 = sec-(temp2*60) 
    if string.len(temp3) < 2 then 
        temp3 = "0"..tostring(temp3) 
    end 
    return tostring(temp2)..":"..tostring(temp3) 
end 

cache.functions.ConvertTimerSeconds = 
function(timer)
    if isTimer(timer) then
        local ms = getTimerDetails(timer)
        local m = math.floor(ms/60000)
        local s = math.floor((ms-m*60000)/1000)
        if m < 10 then m = "0"..m end
        if s < 10 then s = "0"..s end
        return m..":"..s
    end
end

_eventH = addEventHandler
local eventos = { }

function addEventHandler(event, element, handler)
    funcname = tostring(handler)
    if event == "onClientRender" then 
        if not eventos[tostring(event)] then
            eventos[tostring(event)] = {}
        end 
        if not eventos[tostring(event)][funcname] then
            eventos[tostring(event)][funcname] = {}
        end 
        eventos[tostring(event)][funcname][element] = true
    end
    return _eventH(event, element, handler)
end

_removeEventHandler_ = removeEventHandler 

function removeEventHandler(event, element, handler)
    if event == "onClientRender" then 
        if eventos[tostring(event)] and eventos[tostring(event)][tostring(handler)] and eventos[tostring(event)][tostring(handler)][element] then 
            eventos[tostring(event)][tostring(handler)][root] = nil
        end
    end
    return _removeEventHandler_(event, element, handler)
end

cache.functions.EventoAtivo = function ( func )
    if type( func ) == 'function' then
        func = tostring(func)
        if eventos["onClientRender"] and eventos["onClientRender"][func] and eventos["onClientRender"][func][root] and type(eventos["onClientRender"][func][root]) == "boolean" then 
            return true
        end
    end
    return false
end

--local vehicle, model, dimension, interior = getVehicleProx(player, 4.0, 'vehicle')

getVehicleProx = function(player, dist, type_action)
    if player and dist and type_action then
        for i, v in ipairs(getElementsByType(type_action)) do
            local x, y, z = getElementPosition(v)
            local ax, ay, az = getElementPosition(player)
            if getDistanceBetweenPoints3D(x, y, z, ax, ay, az) <= tonumber(dist) then
                return v, getElementModel(v), getElementDimension(v), getElementInterior(v)
            end
        end
    end
    return false
end


cache.functions.getAclPlayer = 
function(player,acl)
    if aclGetGroup ( acl ) then
        if isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(player)), aclGetGroup(acl)) then
            return true
        end
    else
        outputDebugString ( "O Sistema não identificou a acl "..acl..", por favor crie a acl informada!", 3,5,162,238 ) 
    end
    return false
end

cache.functions.resultAcls = 
function(player,acl)
    result = 0
    for i, players in ipairs (getElementsByType("player")) do
        if not aclGetGroup ( acl ) then 
            outputDebugString ( "O Sistema não identificou a acl "..acl..", por favor crie a acl informada!", 3,5,162,238 ) 
            return
        end
        tableacl = aclGroupListObjects(aclGetGroup(acl))
        for i, v in ipairs(tableacl) do
            result = i
        end
    end
    return result
end

fonts = {}

cache.functions.getFont = 
function (dir, size, ...)
    if fileExists(dir) and tonumber(size) then
        if not fonts[dir] then
            fonts[dir] = {};
        end
        if fonts[dir][size] then
            return fonts[dir][size]
        else
            fonts[dir][size] = dxCreateFont(dir, size, ...);
            return fonts[dir][size];
        end
    end
    return "default";
end

------ EditBox


local editbox = {
    actual = false;
    events = false;
    elements = { };
    selected = false;
}

-- editbox's create's
function createEditBox (identify, x, y, width, height, options, postGUI)
    local postGUI = postGUI or false

    if not editbox.elements[identify] then
        editbox.elements[identify] = {
            text = "";
            position = {x, y, width, height};
         --    colors = colors or {text = {255, 255, 255, 255}, selected = {139, 0, 255, 75}};
            options = {
                using = options.using;
                font = options.font or "default";
                masked = options.masked or false;
                onlynumber = options.onlynumber or false;
                textalign = options.textalign or "center";
                maxcharacters = options.maxcharacters or 32;
                othertext = options.othertext or "Digite aqui";
                cache_othertext = options.othertext or "Digite aqui";
                text = options.text; 
                selected = options.selected;
            };
            manager = {
                tick;
            };
        }

        if next (editbox.elements) and not editbox.events then
            addEventHandler ("onClientKey", getRootElement (), onClientKeyEditBox)
            addEventHandler ("onClientClick", getRootElement (), onClientClickEditBox)
            addEventHandler ("onClientPaste", getRootElement (), onClientPasteEditBox)
            addEventHandler ("onClientCharacter", getRootElement (), onClientCharacterEditBox)
            editbox.events = true
        end
    else
        local v = editbox.elements[identify]
        local x, y, width, height = unpack (v.position)

        v.text = tostring (v.text)

        local text = (#v.text ~= 0 and v.options.masked and string.gsub (v.text, ".", "*") or #v.text == 0 and v.options.othertext or v.text)
        local textWidth = dxGetTextWidth (text, 1, v.options.font) or 0

        dxDrawText (text, x, y, width, height, tocolor (unpack (v.options.text)), 1, v.options.font, (textWidth > width and "right" or "left"), v.options.textalign, (textWidth > width), false, postGUI)

        if v.options.using then
            if text ~= "" and text ~= v.options.othertext then
                dxDrawRectangle ((textWidth <= 0 and x or textWidth >= (width - 2.5) and (x + width - 2.5) or (x + textWidth)), y + 2.5, 1, height - 5, tocolor (v.options.text[1], v.options.text[2], v.options.text[3], math.abs (math.sin (getTickCount() / v.options.text[4]) * 255)), postGUI)
            else
                dxDrawRectangle (x + 1, y + 2.5, 1, height - 5, tocolor (v.options.text[1], v.options.text[2], v.options.text[3], math.abs (math.sin (getTickCount() / v.options.text[4]) * 255)), postGUI)
            end
            if editbox.selected ~= nil and editbox.selected == identify then
                dxDrawRectangle (x, y + 2.5, (textWidth > width and width or textWidth), height - 5, tocolor (unpack (v.options.selected)), postGUI)
            end
            if v.manager.tick ~= nil and (getTickCount () >= v.manager.tick + 150) then
                v.text = string.sub (v.text, 1, math.max (#v.text - 1), 0)
            end
        end
    end
end

-- editbox's function's
function dxDestroyAllEditBox ()
    if not next (editbox.elements) then
        return false
    end
    editbox.elements = { }
    editbox.actual = false
    editbox.selected = false
    if editbox.events then
        removeEventHandler ("onClientKey", getRootElement (), onClientKeyEditBox)
        removeEventHandler ("onClientClick", getRootElement (), onClientClickEditBox)
        removeEventHandler ("onClientPaste", getRootElement (), onClientPasteEditBox)
        removeEventHandler ("onClientCharacter", getRootElement (), onClientCharacterEditBox)
        editbox.events = false
    end
    return true
end

function dxDestroyEditBox (identify)
    if not editbox.elements[identify] then
        return false
    end
    editbox.elements[identify] = nil
    if editbox.actual == identify then
        editbox.actual = false
        editbox.selected = false
    end
    if not next (editbox.elements) and editbox.events then
        removeEventHandler ("onClientKey", getRootElement (), onClientKeyEditBox)
        removeEventHandler ("onClientClick", getRootElement (), onClientClickEditBox)
        removeEventHandler ("onClientPaste", getRootElement (), onClientPasteEditBox)
        removeEventHandler ("onClientCharacter", getRootElement (), onClientCharacterEditBox)
        editbox.events = false
    end
    return true
end

function dxGetEditBoxText (identify)
    if not editbox.elements[identify] then
        return false
    end
    return editbox.elements[identify].text
end

function dxSetEditBoxText (identify, text)
    if not editbox.elements[identify] then
        return false
    end
    editbox.elements[identify].text = text
    return true
end

function dxSetEditBoxOption (identify, option, value)
    if not editbox.elements[identify] then
        return false
    end
    editbox.elements[identify].options[option] = value
    return true
end

-- editbox's event's
function onClientKeyEditBox (key, press)
    if not editbox.actual then
        return false
    end
    local v = editbox.elements[editbox.actual]
    if key == "backspace" then
        if press then
            if editbox.selected then
                if #v.text ~= 0 then
                    v.text = ""
                    editbox.selected = false
                end
            else
                v.text = tostring (v.text)
                if #v.text ~= 0 and (#v.text - 1) >= 0 then
                    v.text = string.sub (v.text, 1, #v.text - 1)
                    v.manager.tick = getTickCount ()
                else
                    if v.manager.tick ~= nil then
                        v.manager.tick = nil
                    end
                end
            end
        else
            if v.manager.tick ~= nil then
                v.manager.tick = nil
            end
        end
    end
    if key == "v" and getKeyState ("lctrl") then
        return
    end
    if key == "a" and getKeyState ("lctrl") and #v.text ~= 0 then
        if editbox.selected ~= false then
            return
        end
        editbox.selected = editbox.actual
        return
    end
    if key == "c" and getKeyState ("lctrl") and #v.text ~= 0 then
        if not editbox.selected then
            return
        end
        setClipboard (v.text)
        return
    end
    cancelEvent ()
end

function onClientClickEditBox (button, state)
    if button == "left" and state == "down" then
        for i, v in pairs (editbox.elements) do
            if cache.functions.Cursor (unpack (v.position)) then
                if editbox.actual then
                    editbox.elements[editbox.actual].options.using = false
                    editbox.actual = false
                    editbox.selected = false
                end
                editbox.elements[i].options.using = true
                editbox.actual = i
                editbox.elements[editbox.actual].options.othertext = ''
            else
                if editbox.actual ~= false and editbox.actual == i then
                    editbox.elements[editbox.actual].options.othertext = editbox.elements[editbox.actual].options.cache_othertext
                    editbox.elements[i].options.using = false
                    editbox.actual = false
                    editbox.selected = false
                end
            end
        end
    end
end

function onClientPasteEditBox (textPaste)
    if not editbox.actual then
        return false
    end
    if textPaste == "" then
        return false
    end
    editbox.elements[editbox.actual].text = (editbox.selected and textPaste or editbox.elements[editbox.actual].text..""..textPaste)
    if editbox.selected ~= false then
        editbox.selected = false
    end
end

function onClientCharacterEditBox (key)
    if not editbox.actual then
        return false
    end
    local v = editbox.elements[editbox.actual]
    v.text = tostring (v.text)
    if #v.text < v.options.maxcharacters then
        if v.options.onlynumber and tonumber (key) then
            if editbox.selected ~= false then
                v.text = tonumber (key)
                editbox.selected = false
                return
            end
            v.text = tonumber (v.text..""..key)
        elseif not v.options.onlynumber and tostring (characterDetect) then
            if editbox.selected ~= false then
                v.text = key
                editbox.selected = false
                return
            end
            v.text = v.text..""..key
        end
    end
end



local buttons = {}

cache.functions.drawRect = function (x, y, width, height, radius, color, colorStroke, sizeStroke, postGUI)
    colorStroke = tostring(colorStroke)
    sizeStroke = tostring(sizeStroke)
    
    if (not buttons[radius]) then
        local raw = string.format([[
        <svg width='%s' height='%s' fill='none' xmlns='http://www.w3.org/2000/svg'>
        <mask id='path_inside' fill='#FFFFFF' >
        <rect width='%s' height='%s' rx='%s' />
        </mask>
        <rect opacity='1' width='%s' height='%s' rx='%s' fill='#FFFFFF' stroke='%s' stroke-width='%s' mask='url(#path_inside)'/>
        </svg>
        ]], width, height, width, height, radius, width, height, radius, colorStroke, sizeStroke)
        buttons[radius] = svgCreate(width, height, raw)
    end
    if (buttons[radius]) then -- Se já existir um botão com o mesmo Radius, reaproveitaremos o mesmo, para não criar outro.
        dxDrawImage(x, y, width, height, buttons[radius], 0, 0, 0, color, postGUI)
    end
end


cache.functions.Fonts = function(font, size)
    if (not cache.fonts[font]) then
        cache.fonts[font] = { }
    end
    if (not cache.fonts[font][size]) then
        cache.fonts[font][size] = dxCreateFont('nui/fonts/'..font..'.ttf', size, false, 'cleartype') or 'default-bold'
    end

    return cache.fonts[font][size]
end


function string.change (s, t) -- print (string.change ('O Jogador ${player} (${id}) comprou x${coins} coins e recebeu ${item}.', { ['player'] = '@Thigas', ['id'] = '0', ['coins'] = math.random (10, 2500) }));
    if not s or type (s) ~= 'string' then
        return error ('Bad argument #1 got \''..type (s)..'\'.');
    end
    
    for w in s:gmatch ('${(%w+)}') do
        s = s:gsub ('${'..w..'}', tostring ((t and t[w]) or 'undefined'));
    end
    
    return s;
end
