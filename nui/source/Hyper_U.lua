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


-- Events

_dxDrawText = dxDrawText
_dxDrawImage = dxDrawImage
_dxCreateFont = dxCreateFont
_removeEventHandler_ = removeEventHandler 
_dxDrawRectangle = dxDrawRectangle
_event = addEvent
_eventH = addEventHandler
util = cache.functions


----- Utils ----


function aToR(X, Y, sX, sY)
     
     local xd = X/resW or X
     
     local yd = Y/resH or Y
     
     local xsd = sX/resW or sX
     
     local ysd = sY/resH or sY
     
     return xd * screen[1], yd * screen[2], xsd * screen[1], ysd * screen[2]
     
end


function dxDrawRectangle(x, y, w, h, ...)
     
     local x, y, w, h = aToR(x, y, w, h)
     
     return _dxDrawRectangle(x, y, w, h, ...)
     
end


function dxDrawText(text, x, y, w, h, ...)
     
     local x, y, w, h = aToR(x, y, w, h)
     
     return _dxDrawText(text, x, y, w + x, h + y, ...)
     
end


function dxDrawImage(x, y, w, h, ...)
     
     local x, y, w, h = aToR(x, y, w, h)
     
     return _dxDrawImage(x, y, w, h, ...)
     
end


function dxCreateFont( filePath, size, ... )
     
     return _dxCreateFont( filePath, ( sx * size ), ... )
     
end


cache = {
     functions = { };
     fonts = { };
     buttons = { };
     lerps = { };
     text = dxDrawText;
     image = dxDrawImage;
     rectangle = dxDrawRectangle;
     data = getElementData;
     moneySuff = {'K', 'M', 'B', 'T', 'Q'};
     eventos = { };
     name = getPlayerName;
     money = getPlayerMoney;
     setData = setElementData;
     timer = setTimer;
     random = math.random;
     floor = math.floor;
     editbox = {
          actual = false;
          events = false;
          elements = { };
          selected = false;
     };
     scrollbar = {
          actual = false;
          events = false;
          elements = { };
     };
     indexgrid = { 
          ['grid'] = 0;
     };
}

 
util.register = function(event, ...)
     _event(event, true)
     _eventH(event, ...)
end


util.Cursor = function(x,y,w,h)
     local x, y, w, h = aToR(x, y, w, h)
     if isCursorShowing( ) then
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


util.Convert = function(cMoney, money_)
     didConvert = 0
     if not cMoney then
          return '?'
     end
     while cMoney / 1000 >= 1 do
          cMoney = cMoney / 1000
          didConvert = didConvert + 1
     end
     if didConvert > 0 then
          return money_..' ' .. string.format('%.2f', cMoney) .. cache.moneySuff[didConvert]
     else
          return money_..' ' .. cMoney
     end
end


util.RemoveHex = function(str) 
     return str:gsub('#%x%x%x%x%x%x', '') 
end 


util.getPlayerID = function(id)
     for i, v in ipairs(getElementsByType('player')) do
          if ( getElementData(v, 'ID') or 'N/A') == tonumber( id ) then
               return v
          end
     end
     return false
end


util.Acltable = function( player, acls )
     for i, v in ipairs( acls ) do
          if aclGetGroup( v ) then
               if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount( player )), aclGetGroup( v )) then
                    return true
               end
          end
     end
     return false
end


util.ConverTerTimer = function(sec)
     local temp = sec/60 
     local temp2 = (math.floor(temp)) 
     local temp3 = sec-(temp2*60) 
     if string.len(temp3) < 2 then 
          temp3 = '0'..tostring(temp3) 
     end 
     return tostring(temp2)..':'..tostring(temp3) 
end 


util.ConvertTimerSeconds = function(timer)
     if isTimer(timer) then
          local ms = getTimerDetails(timer)
          local m = math.floor(ms/60000)
          local s = math.floor((ms-m*60000)/1000)
          if m < 10 then m = '0'..m end
          if s < 10 then s = '0'..s end
          return m..':'..s
     end
end


function addEventHandler(event, element, handler)
     funcname = tostring(handler)
     if event == 'onClientRender' then 
          if not cache.eventos[tostring(event)] then
               cache.eventos[tostring(event)] = {}
          end 
          if not cache.eventos[tostring(event)][funcname] then
               cache.eventos[tostring(event)][funcname] = {}
          end 
          cache.eventos[tostring(event)][funcname][element] = true
     end
     return _eventH(event, element, handler)
end


function removeEventHandler(event, element, handler)
     if event == 'onClientRender' then 
          if cache.eventos[tostring(event)] and cache.eventos[tostring(event)][tostring(handler)] and cache.eventos[tostring(event)][tostring(handler)][element] then 
               cache.eventos[tostring(event)][tostring(handler)][root] = nil
          end
     end
     return _removeEventHandler_(event, element, handler)
end


util.EventoAtivo = function ( func )
     if type( func ) == 'function' then
          func = tostring(func)
          if cache.eventos['onClientRender'] and cache.eventos['onClientRender'][func] and cache.eventos['onClientRender'][func][root] and type(cache.eventos['onClientRender'][func][root]) == 'boolean' then 
               return true
          end
     end
     return false
end


util.getVehicleProx = function(player, dist, type_action)
     if player and dist and type_action then
          for i, v in ipairs(getElementsByType( type_action )) do
               local x, y, z = getElementPosition(v)
               local ax, ay, az = getElementPosition(player)
               if getDistanceBetweenPoints3D(x, y, z, ax, ay, az) <= tonumber(dist) then
                    return v, getElementModel(v), getElementDimension(v), getElementInterior(v)
               end
          end
     end
     return false
end


util.getAclPlayer = function( player, acl )
     if aclGetGroup ( acl ) then
          if isObjectInACLGroup('user.' ..getAccountName(getPlayerAccount(player)), aclGetGroup( acl )) then
               return true
          end
     else
          outputDebugString ( 'O Sistema não identificou a acl '..acl..', por favor crie a acl informada!', 3,5,162,238 ) 
     end
     return false
end


util.resultAcls = function(player,acl)
     result = 0
     for i, players in ipairs (getElementsByType('player')) do
          if not aclGetGroup ( acl ) then 
               outputDebugString ( 'O Sistema não identificou a acl '..acl..', por favor crie a acl informada!', 3,5,162,238 ) 
               return
          end
          tableacl = aclGroupListObjects(aclGetGroup(acl))
          for i, v in ipairs(tableacl) do
               result = i
          end
     end
     return result
end


util.createEditBox = function(identify, x, y, width, height, options, postGUI)
     local postGUI = postGUI or false
     
     if not cache.editbox.elements[identify] then
          cache.editbox.elements[identify] = {
               text = '';
               position = {x, y, width, height};
               options = {
                    using = options.using;
                    font = options.font or 'default';
                    masked = options.masked or false;
                    onlynumber = options.onlynumber or false;
                    textalign = options.textalign or 'center';
                    maxcharacters = options.maxcharacters or 32;
                    othertext = options.othertext or 'Digite aqui';
                    cache_othertext = options.othertext or 'Digite aqui';
                    text = options.text; 
                    selected = options.selected;
               };
               manager = {
                    tick;
               };
          }
          
          if next (cache.editbox.elements) and not editbox.events then
               addEventHandler ('onClientKey', root, util.onClientKeyEditBox)
               addEventHandler ('onClientClick', root, util.onClientClickEditBox)
               addEventHandler ('onClientPaste', root, util.onClientPasteEditBox)
               addEventHandler ('onClientCharacter', root, util.onClientCharacterEditBox)
               editbox.events = true
          end
     else
          local v = cache.editbox.elements[identify]
          local x, y, width, height = unpack (v.position)
          
          v.text = tostring (v.text)
          
          local text = (#v.text ~= 0 and v.options.masked and string.gsub (v.text, '.', '*') or #v.text == 0 and v.options.othertext or v.text)
          local textWidth = dxGetTextWidth (text, 1, v.options.font) or 0
          
          dxDrawText (text, x, y, width, height, tocolor (unpack (v.options.text)), 1, v.options.font, (textWidth > width and 'right' or 'left'), v.options.textalign, (textWidth > width), false, postGUI)
          
          if v.options.using then
               if text ~= '' and text ~= v.options.othertext then
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


util.dxDestroyAllEditBox = function( )
     if not next (cache.editbox.elements) then
          return false
     end
     cache.editbox.elements = { }
     editbox.actual = false
     editbox.selected = false
     if editbox.events then
          removeEventHandler('onClientKey', root, util.onClientKeyEditBox)
          removeEventHandler('onClientClick', root, util.onClientClickEditBox)
          removeEventHandler('onClientPaste', root, util.onClientPasteEditBox)
          removeEventHandler('onClientCharacter', root, util.onClientCharacterEditBox)
          editbox.events = false
     end
     return true
end
     

util.dxDestroyEditBox = function(identify)
     if not cache.editbox.elements[identify] then
          return false
     end
     cache.editbox.elements[identify] = nil
     if editbox.actual == identify then
          editbox.actual = false
          editbox.selected = false
     end
     if not next (cache.editbox.elements) and editbox.events then
          removeEventHandler ('onClientKey', root, util.onClientKeyEditBox)
          removeEventHandler ('onClientClick', root, util.onClientClickEditBox)
          removeEventHandler ('onClientPaste', root, util.onClientPasteEditBox)
          removeEventHandler ('onClientCharacter', root, util.onClientCharacterEditBox)
          editbox.events = false
     end
     return true
end
    

util.dxGetEditBoxText = function(identify)
     if not cache.editbox.elements[identify] then
          return false
     end
     return cache.editbox.elements[identify].text
end
   

util.dxSetEditBoxText = function(identify, text)
     if not cache.editbox.elements[identify] then
          return false
     end
     cache.editbox.elements[identify].text = text
     return true
end
    

util.dxSetEditBoxOption = function(identify, option, value)
     if not cache.editbox.elements[identify] then
          return false
     end
     cache.editbox.elements[identify].options[option] = value
     return true
end
     

util.onClientKeyEditBox = function(key, press)
     if not editbox.actual then
          return false
     end
     local v = cache.editbox.elements[editbox.actual]
     if key == 'backspace' then
          if press then
               if editbox.selected then
                    if #v.text ~= 0 then
                         v.text = ''
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
     if key == 'v' and getKeyState ('lctrl') then
          return
     end
     if key == 'a' and getKeyState ('lctrl') and #v.text ~= 0 then
          if editbox.selected ~= false then
               return
          end
          editbox.selected = editbox.actual
          return
     end
     if key == 'c' and getKeyState ('lctrl') and #v.text ~= 0 then
          if not editbox.selected then
               return
          end
          setClipboard (v.text)
          return
     end
     cancelEvent( )
end
     

util.onClientClickEditBox = function(button, state)
          if button == 'left' and state == 'down' then
               for i, v in pairs (cache.editbox.elements) do
                    if util.Cursor (unpack (v.position)) then
                         if editbox.actual then
                              cache.editbox.elements[editbox.actual].options.using = false
                              editbox.actual = false
                              editbox.selected = false
                         end
                         cache.editbox.elements[i].options.using = true
                         editbox.actual = i
                         cache.editbox.elements[editbox.actual].options.othertext = ''
                    else
                         if editbox.actual ~= false and editbox.actual == i then
                         cache.editbox.elements[editbox.actual].options.othertext = cache.editbox.elements[editbox.actual].options.cache_othertext
                         cache.editbox.elements[i].options.using = false
                         editbox.actual = false
                         editbox.selected = false
                    end
               end
          end
     end
end
     

util.onClientPasteEditBox = function(textPaste)
     if not editbox.actual then
          return false
     end
     if textPaste == '' then
          return false
     end
     cache.editbox.elements[editbox.actual].text = (editbox.selected and textPaste or cache.editbox.elements[editbox.actual].text..''..textPaste)
     if editbox.selected ~= false then
          editbox.selected = false
     end
end
     

util.onClientCharacterEditBox = function(key)
     if not editbox.actual then
          return false
     end
     local v = cache.editbox.elements[editbox.actual]
     v.text = tostring (v.text)
     if #v.text < v.options.maxcharacters then
          if v.options.onlynumber and tonumber (key) then
               if editbox.selected ~= false then
                    v.text = tonumber (key)
                    editbox.selected = false
                    return
               end
               v.text = tonumber (v.text..''..key)
          elseif not v.options.onlynumber and tostring (characterDetect) then
               if editbox.selected ~= false then
                    v.text = key
                    editbox.selected = false
                    return
               end
               v.text = v.text..''..key
          end
     end
end
     

util.drawRect = function (x, y, width, height, radius, color, colorStroke, sizeStroke, postGUI)
     colorStroke = tostring(colorStroke)
     sizeStroke = tostring(sizeStroke)
     
     if (not cache.buttons[radius]) then
          local raw = string.format([[
          <svg width='%s' height='%s' fill='none' xmlns='http://www.w3.org/2000/svg'>
          <mask id='path_inside' fill='#FFFFFF' >
          <rect width='%s' height='%s' rx='%s' />
          </mask>
          <rect opacity='1' width='%s' height='%s' rx='%s' fill='#FFFFFF' stroke='%s' stroke-width='%s' mask='url(#path_inside)'/>
          </svg>
          ]], width, height, width, height, radius, width, height, radius, colorStroke, sizeStroke)
          cache.buttons[radius] = svgCreate(width, height, raw)
     end
     if (cache.buttons[radius]) then -- Se já existir um botão com o mesmo Radius, reaproveitaremos o mesmo, para não criar outro.
          dxDrawImage(x, y, width, height, cache.buttons[radius], 0, 0, 0, color, postGUI)
     end
end
     
     
util.cache.fonts = function(font, size)
     if (not cache.cache.fonts[font]) then
          cache.cache.fonts[font] = { }
     end
     if (not cache.cache.fonts[font][size]) then
          cache.cache.fonts[font][size] = dxCreateFont('nui/cache.fonts/'..font..'.ttf', size, false, 'cleartype') or 'default-bold'
     end
     
     return cache.cache.fonts[font][size]
end
     

util.dxCreateScrollBar = function(identify, x, y, width, height, maximo, colors, values, postGUI, rounded, tabela)
     postGUI = (postGUI or false)
     if not cache.scrollbar.elements[identify] then
          local dividir = #tabela - maximo 
          if dividir == 1 then 
               dividir = 2 
          end
          cache.scrollbar.elements[identify] = {
               positions = {
                    offset = y;
                    size = (height/dividir);
                    default = {x, y, width, height};
               };
               actual = 1;
               using = false;
               values = values;
               table = tabela,
               visual = maximo,
          }
          if not cache.scrollbar.events then
               addEventHandler('onClientClick', root, util.dxClickScroll)
               cache.scrollbar.events = true
          end
     else
          cache.scrollbar.elements[identify]['table'] = tabela
          local v = cache.scrollbar.elements[identify]
          local x, y, w, h = unpack (v.positions.default)
          if v.using then
               local cursor = (Vector2 (getCursorPosition ()).y * Vector2 (guiGetScreenSize ()).y)
               local actualValue = math.ceil ((cache.scrollbar.elements[cache.scrollbar.actual].positions.offset - y) / (((y + h - v.positions.size) - y) / cache.scrollbar.elements[cache.scrollbar.actual].values))
               cache.scrollbar.elements[cache.scrollbar.actual].positions.offset = (cursor <= y and y or cursor >= (y + h - v.positions.size) and (y + h - v.positions.size) or cursor)
               cache.scrollbar.elements[cache.scrollbar.actual].actual = (actualValue <= 1 and 1 or actualValue >= cache.scrollbar.elements[cache.scrollbar.actual].values and cache.scrollbar.elements[cache.scrollbar.actual].values or actualValue)
               local x, y, w, h = unpack (cache.scrollbar.elements[cache.scrollbar.actual].positions.default)
               local novoValor = math.ceil ((cache.scrollbar.elements[cache.scrollbar.actual].positions.offset - y) / (((y + h - cache.scrollbar.elements[cache.scrollbar.actual].positions.size) - y) / cache.scrollbar.elements[cache.scrollbar.actual].values))
               cache.indexgrid[cache.scrollbar.actual] = novoValor - 1
               if cache.indexgrid[cache.scrollbar.actual] < 0 then 
                    cache.indexgrid[cache.scrollbar.actual] = 0 
               end
               if not cache.scrollbar.elements[cache.scrollbar.actual].table[(novoValor + (cache.scrollbar.elements[cache.scrollbar.actual].visual + 1))] then 
                    cache.indexgrid[cache.scrollbar.actual] = #cache.scrollbar.elements[cache.scrollbar.actual].table - cache.scrollbar.elements[cache.scrollbar.actual].visual
               end
          end
          util.drawRect(x, y, w, h, rounded + 0.1, tocolor (unpack (colors.background)), false, false, postGUI)
          util.drawRect(x, v.positions.offset, w, v.positions.size, rounded, (v.using and tocolor (unpack (colors.using)) or tocolor (unpack (colors.scroll))), false, false, postGUI)
     end
end
 

util.dxDestroyScrollBar = function(identify)
     if not cache.scrollbar.elements[identify] then
          return false
     end
     if cache.scrollbar.actual ~= false and cache.scrollbar.actual == identify then
          cache.scrollbar.actual = false
     end
     cache.scrollbar.elements[identify] = nil
     if not next (cache.scrollbar.elements) and cache.scrollbar.events then
          removeEventHandler ("onClientClick", root, util.dxClickScroll)
          cache.scrollbar.events = false
     end
     return true
end
 

util.dxGetPropertiesScrollBar = function(identify)
     if not cache.scrollbar.elements[identify] then
          return { }
     end
     return cache.scrollbar.elements[identify]
end
 

util.dxUpdateScrollBarOffset = function(identify, value)
     if not cache.scrollbar.elements[identify] then
          return false
     end
     local v = cache.scrollbar.elements[identify]
     local x, y, w, h = unpack (v.positions.default)
     
     cache.scrollbar.elements[identify].actual = (value <= 1 and 1 or value >= v.values and v.values or value)
     
     local newValues = {
          lastIndex = (y + (((y + h - v.positions.size) - y) / cache.scrollbar.elements[identify].values) * (v.values - 1));
          newPosition = (y + (((y + h - v.positions.size) - y) / cache.scrollbar.elements[identify].values) * (v.actual - 1));
     }
     
     cache.scrollbar.elements[identify].positions.offset = (newValues.newPosition >= newValues.lastIndex and (y + h - v.positions.size) or newValues.newPosition)
     return true
end


util.dxClickScroll = function(button, state)
     if button == "left" and state == "down" then
          for i in pairs (cache.scrollbar.elements) do
               if util.Cursor (cache.scrollbar.elements[i].positions.default[1], cache.scrollbar.elements[i].positions.offset, cache.scrollbar.elements[i].positions.default[3], cache.scrollbar.elements[i].positions.size) or util.Cursor (unpack (cache.scrollbar.elements[i].positions.default)) then
                    cache.scrollbar.elements[i].using = true
                    cache.scrollbar.actual = i
                    break
               end
          end
     elseif button == "left" and state == "up" then
          if not cache.scrollbar.actual then
               return false
          end
          cache.scrollbar.elements[cache.scrollbar.actual].using = false
          cache.scrollbar.actual = false
     end
end


util.getSearch = function ( name )
     local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
     local table_item = { }
     if name then
          if infos then
               for i, v in ipairs( infos ) do
                    local name_ = v['name']:gsub("#%x%x%x%x%x%x", ""):lower()
                    if name_:find(name, 1, true) then
                         table.insert(table_item, v)
                    end
               end
          end
     end
     return table_item
end


createLerp = function(valor1, valor2, time, subtrair)
     local valorreturn = valor1
     if not cache.lerps[ valor1 ] then
          cache.lerps[ valor1 ] = { }
          cache.lerps[ valor1 ][ valor2 ] = getTickCount( ) 
     else 
          if not cache.lerps[ valor1 ][ valor2 ] then
               cache.lerps[valor1][ valor2 ] = getTickCount( ) 
          end
     end
     local tempo = getTickCount( ) - cache.lerps[ valor1 ][ valor2 ]
     if tempo >= time then 
          valorreturn = valor2 
     else
          valorreturn = util.lerp(valor1, valor2, tempo/time)
     end
     if subtrair then
          valorreturn = valorreturn - valor2
     end
     return valorreturn
end 


util.resetLerps = function( )
     cache.lerps = { }
end


util.resetLerp = function( valor1, valor2 )
     if cache.lerps[ valor1 ][ valor2 ] then
          cache.lerps[ valor1 ] = { }
     end
end


util.lerp = function (a, b, k)
     if (a > b)then
          local _a = a;
          a = b;
          b = _a;
     end
     local result = a * (1-k) + b * k
     if result >= b then
          result = b
     elseif result <= a then
          result = a
     end
     return result
end