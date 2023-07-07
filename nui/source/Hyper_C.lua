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


-- Resolution

screen = { guiGetScreenSize() }
resW, resH = 1366, 768
sx, sy = screen[1]/resW, screen[2]/resH


-- Globals


--local anim = interpolateBetween(-361, 0, 0, 356, 0, 0, (getTickCount() - tick)/1500, 'OutElastic')

-- local alpha = interpolateBetween(0, 0, 0, 150, 0, 0, ((getTickCount() - tick) / 500), 'Linear')

-- util.createEditBox('pix', 584, 337, 198, 50, {using = false, font = util.Fonts('Montserrat-Bold', 10), masked = false, onlynumber = false, textalign = 'center', maxcharacters = 50, othertext = 'Chave pix', text = {255, 255, 255, 255}, selected = {255, 255, 255, 255}}, true)

-- util.dxDestroyAllEditBox( )
-- util.dxDestroyEditBox( 'pix' )
-- util.dxGetEditBoxText( 'pix' )
-- util.dxSetEditBoxText ('pix', 'texto')


-- dxSetBlendMode('add')
-- util.drawRect(436, 288, 493, 182, 7, tocolor(12, 12, 12, alpha), '#FF0000', 0, false)
-- dxSetBlendMode('blend')


-- cache['text']('Pesquisar ID', 520, 250, 98, 19, tocolor(45, 45, 54, 255), 1.0, util.Fonts('Montserrat-Bold', 10), 'center', 'top', false, false, false, false, false)
-- cache['image'](740, 253, 22, 22, 'nui/interface/search.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
-- cache['rectangle'](785, 490, 297, 5, tocolor(255, 255, 255, 255), false)

--util.resetLerps( )
--util.resetLerp(0, 255)
--createLerp(0, 255, 1000) - tocolor
--(130 + createLerp(0, 647, 1000, true)) - render

--util.EventoAtivo( render )
--util.register