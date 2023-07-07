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

-- Globals

local config = Hyper_Configs
local gerais = config['gerais']




-- Utils

_event = addEvent
_eventH = addEventHandler

util.register = function(event, ...)
     _event(event, true)
     _eventH(event, ...)
end

local util = cache.functions
local cache = {
     functions = { };
     moneySuff = {'K', 'M', 'B', 'T', 'Q'};
     name = getPlayerName;
     money = getPlayerMoney;
     setData = setElementData;
     timer = setTimer;
     random = math.random;
     floor = math.floor;
}


util.string.change = function(s, t)
     if not s or type (s) ~= 'string' then
          return error ('Bad argument #1 got \''..type (s)..'\'.');
     end
     
     for w in s:gmatch ('${(%w+)}') do
          s = s:gsub ('${'..w..'}', tostring ((t and t[w]) or 'undefined'));
     end
     
     return s;
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