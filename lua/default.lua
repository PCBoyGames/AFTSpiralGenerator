local quips = {
	"An official Outfox tech demo!", --PCBoyGames
	"No squirrels were harmed in the making of this product.", --PCBoyGames
	"SPEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEN", --PCBoyGames
	"Just for me doing all of this, is Lua really that powerful?", --PCBoyGames
	"RANDOMLY GENERATED SUBTITLE", --PCBoyGames, inspired by TaroNuke
	"Yes, a tech demo that breaks boundaries that shouldn't be possible!", --PCBoyGames
	"A customizable hypnotic experience!", --PCBoyGames
	"Have you seen the top corners yet?", --PCBoyGames
	"Beware of possible flashing lights!", --PCBoyGames
	"私はあなたがこれが何であると思うかは気にしません。", --PCBoyGames
	"I could give less of a care if I'm using GitHub wrong.", --PCBoyGames, inspired by oatmealine and Jousway
	"Turn SmoothLines off for a more versatile visual experience.", --PCBoyGames
	"Use Points and Blending is optional! Use it if you want to draw with circles.", --PCBoyGames
	"I DIDN'T EDIT YOUR THEME, I SWEAR!" --PCBoyGames
}
local page = 1
local schemecons = math.random(0,4)/4
local schemechoose = math.random(1,3)
local colcol = {
	{math.random(0,4)/4,math.random(0,4)/4,math.random(0,4)/4},
	{math.random(0,4)/4,math.random(0,4)/4,math.random(0,4)/4},
	{math.random(0,4)/4,math.random(0,4)/4,math.random(0,4)/4},
	{math.random(0,4)/4,math.random(0,4)/4,math.random(0,4)/4},
}
for col = 1,#colcol do
	colcol[col][schemechoose] = schemecons
end
local schemedifferpick = math.random(#colcol)
local schemediffer = math.random(-1,1)/4
colcol[schemedifferpick][schemechoose] = colcol[schemedifferpick][schemechoose] + schemediffer
if colcol[schemedifferpick][schemechoose] > 1 or colcol[schemedifferpick][schemechoose] < 0 then
	colcol[schemedifferpick][schemechoose] = colcol[schemedifferpick][schemechoose] - schemediffer
end
local colappend = {
	"3/4/5",
	"E/R/T",
	"D/F/G",
	"C/V/B"
}
--This was in here for rounding fixes, but now that it's in the Lua lexicon for the latest versions of OF, I'm debating removing it from here.
function sigFig(num,figures)
	if num == 0 then return 0 end
    local x=figures - math.ceil(math.log10(math.abs(num)))
    return(math.floor(num*10^x+0.5)/10^x)
end
local didwehide = false
local poptions = {GAMESTATE:GetPlayerState(0):GetPlayerOptions('ModsLevel_Song'),GAMESTATE:GetPlayerState(1):GetPlayerOptions('ModsLevel_Song')}
local onplayers = {nil, nil}
local rotationz_aft, trails_aft, visible_aft
local angle = math.random(1,359)
while math.mod(angle,15) == 0 or angle < 15 or angle > 345 do
	angle = math.random(1,359)
end
local speedmult = 1
if math.random(1,5) == 1 then
	speedmult = math.random(1,20)/10
end
local widthpathmult = math.random(0,5)
if math.random(1,10) == 1 then
	widthpathmult = widthpathmult*2
end
local animfactor1 = math.random(-20,20)/20
local animfactor2 = math.random(-20,20)/20
local animoffset1 = math.random(0,39)/20
local animoffset2 = math.random(0,39)/20
local animoffset3 = math.random(-10,10)/20
local animoffset4 = math.random(-10,10)/20
local vertcomp = math.random(0,1)
local lastpress = 0
local xoffset = 0
local resetval = math.random(1,#colcol)
if math.random(1,10) == 1 then
	xoffset = math.random(-50,50)
end
local hasnotfaded = true
local function InputHandler(event)
	if not event.DeviceInput then return end
	local etype = ToEnumShortString(event.type)
		if etype == "FirstPress" then
		MESSAGEMAN:Broadcast("ButtonPress",{button=event.DeviceInput.button})
	end
end
if GAMESTATE:IsPlayerEnabled(0) and GAMESTATE:IsPlayerEnabled(1) then
	SCREENMAN:GetTopScreen():GetChild('Underlay'):GetChildAt(5):GetChildAt(2):settext("TECH DEMO")
	SCREENMAN:GetTopScreen():GetChild('Underlay'):GetChildAt(5):GetChildAt(3):settext("Contributed by PCBoyGames")
	SCREENMAN:GetTopScreen():GetChild('Underlay'):GetChildAt(6):GetChildAt(1):halign(0.5):valign(0.5):xy(-640,-240):zoom(2):wag():settext("CURRENTLY GENERATING...")
	SCREENMAN:GetTopScreen():GetChild('Underlay'):GetChildAt(6):GetChildAt(2):halign(0.5):valign(0.5):xy(-640,200):settext(quips[math.random(1,#quips)]):sleep(2):decelerate(1):y(-100)
	SCREENMAN:GetTopScreen():GetChild('Underlay'):GetChildAt(6):GetChildAt(3):visible(false)
else
	SCREENMAN:GetTopScreen():GetChild('Underlay'):GetChildAt(5):GetChildAt(1):halign(0.5):valign(0.5):xy(-640,-240):zoom(2):wag():settext("CURRENTLY GENERATING...")
	SCREENMAN:GetTopScreen():GetChild('Underlay'):GetChildAt(5):GetChildAt(2):halign(0.5):valign(0.5):xy(-640,200):settext(quips[math.random(1,#quips)]):sleep(2):decelerate(1):y(-100)
	SCREENMAN:GetTopScreen():GetChild('Underlay'):GetChildAt(5):GetChildAt(3):visible(false)
end
SCREENMAN:GetTopScreen():GetChild('Underlay'):GetChildAt(2):diffusealpha(0):sleep(1):diffusealpha(1):y(-10):accelerate(1):y(SCREEN_TOP):sleep(2):decelerate(1):y(-10):sleep(0):diffusealpha(0)
SCREENMAN:GetTopScreen():GetChild('Underlay'):GetChildAt(4):GetChildAt(2):settext("TECH DEMO")
SCREENMAN:GetTopScreen():GetChild('Underlay'):GetChildAt(4):GetChildAt(3):settext("Contributed by PCBoyGames")
SCREENMAN:GetTopScreen():y(2*SCREEN_HEIGHT):decelerate(0.6):y(0):sleep(5):decelerate(0.5):y(SCREEN_HEIGHT):sleep(1):y(-1*SCREEN_HEIGHT):accelerate(0.5):y(0)
local t = Def.ActorFrame{
	OnCommand = function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
		self:playcommand("Update")
		SCREENMAN:GetTopScreen():GetChild('Underlay'):visible(false)
		SCREENMAN:GetTopScreen():GetChild('Overlay'):GetChildAt(1):visible(false)
		if GAMESTATE:IsPlayerEnabled(0) and GAMESTATE:IsPlayerEnabled(1) then
			SCREENMAN:GetTopScreen():GetChildAt(34):GetChildAt(1):GetChildAt(2):diffuse(color(""..colcol[resetval][1]..","..colcol[resetval][2]..","..colcol[resetval][3]..",1")):decelerate(1):diffuse(Color.Black):decelerate(1)
		else
			SCREENMAN:GetTopScreen():GetChildAt(27):GetChildAt(1):GetChildAt(2):diffuse(color(""..colcol[resetval][1]..","..colcol[resetval][2]..","..colcol[resetval][3]..",1")):decelerate(1):diffuse(Color.Black):decelerate(1)
		end
	end,
	InitCommand = function(self)
		self:queuecommand("CheckForGameplay")
	end,
	CheckForGameplayCommand = function(self)
	--Note to self: the problem with this is an option I cannot easily check nor control. Wait for the pause menu to be named.
		if SCREENMAN:GetTopScreen():GetName() == "ScreenGameplay" then
			if GAMESTATE:IsPlayerEnabled(0) and GAMESTATE:IsPlayerEnabled(1) then
				SCREENMAN:GetTopScreen():GetChild('Overlay'):GetChildAt(2):GetChildAt(4):x(SCREEN_CENTER_X+500)
				SCREENMAN:GetTopScreen():GetChild('Overlay'):GetChildAt(2):GetChildAt(4):GetChildAt(1):GetChildAt(3):settext("Continue")
				SCREENMAN:GetTopScreen():GetChild('Overlay'):GetChildAt(2):GetChildAt(4):GetChildAt(2):GetChildAt(3):settext("Smart Regenerate")
				SCREENMAN:GetTopScreen():GetChild('Overlay'):GetChildAt(2):GetChildAt(4):GetChildAt(3):GetChildAt(3):settext("Exit Demo")
			end
			SCREENMAN:GetTopScreen():GetChild('Overlay'):GetChildAt(2):GetChildAt(3):x(SCREEN_CENTER_X-500)
			SCREENMAN:GetTopScreen():GetChild('Overlay'):GetChildAt(2):GetChildAt(3):GetChildAt(1):GetChildAt(3):settext("Continue")
			SCREENMAN:GetTopScreen():GetChild('Overlay'):GetChildAt(2):GetChildAt(3):GetChildAt(2):GetChildAt(3):settext("Smart Regenerate")
			SCREENMAN:GetTopScreen():GetChild('Overlay'):GetChildAt(2):GetChildAt(3):GetChildAt(3):GetChildAt(3):settext("Exit Demo")
		end
	end,
	ButtonPressMessageCommand = function(self,param)
		--I may need this later.
		--SCREENMAN:SystemMessage(param.button)
		if page == 1 then
			if param.button == "DeviceButton_q" then
				angle = angle - 1
				if angle == -1 then
					angle = 359
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_w" then
				angle = angle + 1
				angle = math.mod(angle,360)
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_a" then
				speedmult = speedmult - 0.1
				if speedmult <= 0.1 then
					speedmult = 0.1
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_s" then
				speedmult = speedmult + 0.1
				if speedmult <= 0.1 then
					speedmult = 0.1
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_z" then
				widthpathmult = widthpathmult - 1
				if (widthpathmult > 0 and widthpathmult < 0.01) or (widthpathmult < 0 and widthpathmult > -0.01) then
					widthpathmult = 0
				end
				if widthpathmult < 0.1 and widthpathmult > 0 then
					widthpathmult = 0.1
				end
				if widthpathmult > -0.1 and widthpathmult < 0 then
					widthpathmult = -0.1
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_x" then
				widthpathmult = widthpathmult + 1
				if (widthpathmult > 0 and widthpathmult < 0.01) or (widthpathmult < 0 and widthpathmult > -0.01) then
					widthpathmult = 0
				end
				if widthpathmult < 0.1 and widthpathmult > 0 then
					widthpathmult = 0.1
				end
				if widthpathmult > -0.1 and widthpathmult < 0 then
					widthpathmult = -0.1
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_3" then
				colcol[1][1] = colcol[1][1]+0.25
				if colcol[1][1] >= 1.25 then
					colcol[1][1] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_4" then
				colcol[1][2] = colcol[1][2]+0.25
				if colcol[1][2] >= 1.25 then
					colcol[1][2] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_5" then
				colcol[1][3] = colcol[1][3]+0.25
				if colcol[1][3] >= 1.25 then
					colcol[1][3] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_e" then
				colcol[2][1] = colcol[2][1]+0.25
				if colcol[2][1] >= 1.25 then
					colcol[2][1] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_r" then
				colcol[2][2] = colcol[2][2]+0.25
				if colcol[2][2] >= 1.25 then
					colcol[2][2] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_t" then
				colcol[2][3] = colcol[2][3]+0.25
				if colcol[2][3] >= 1.25 then
					colcol[2][3] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_d" then
				colcol[3][1] = colcol[3][1]+0.25
				if colcol[3][1] >= 1.25 then
					colcol[3][1] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_f" then
				colcol[3][2] = colcol[3][2]+0.25
				if colcol[3][2] >= 1.25 then
					colcol[3][2] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_g" then
				colcol[3][3] = colcol[3][3]+0.25
				if colcol[3][3] >= 1.25 then
					colcol[3][3] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_c" then
				colcol[4][1] = colcol[4][1]+0.25
				if colcol[4][1] >= 1.25 then
					colcol[4][1] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_v" then
				colcol[4][2] = colcol[4][2]+0.25
				if colcol[4][2] >= 1.25 then
					colcol[4][2] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_b" then
				colcol[4][3] = colcol[4][3]+0.25
				if colcol[4][3] >= 1.25 then
					colcol[4][3] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_7" then
				animfactor1 = animfactor1 - 0.05
				if (animfactor1 > 0 and animfactor1 < 0.01) or (animfactor1 < 0 and animfactor1 > -0.01) then
					animfactor1 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_8" then
				animfactor1 = animfactor1 + 0.05
				if (animfactor1 > 0 and animfactor1 < 0.01) or (animfactor1 < 0 and animfactor1 > -0.01) then
					animfactor1 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_9" then
				animfactor2 = animfactor2 - 0.05
				if (animfactor2 > 0 and animfactor2 < 0.01) or (animfactor2 < 0 and animfactor2 > -0.01) then
					animfactor2 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_0" then
				animfactor2 = animfactor2 + 0.05
				if (animfactor2 > 0 and animfactor2 < 0.01) or (animfactor2 < 0 and animfactor2 > -0.01) then
					animfactor2 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_6" then
				if vertcomp == 0 then
					vertcomp = 1
				elseif vertcomp == 1 then
					vertcomp = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_u" then
				animoffset1 = animoffset1 - 0.05
				if animoffset1 > 1.99 then
					animoffset1 = 0
				end
				if animoffset1 < 0 then
					animoffset1 = 1.95
				end
				if (animoffset1 > 0 and animoffset1 < 0.01) or (animoffset1 < 0 and animoffset1 > -0.01) then
					animoffset1 = 0
				end
				animoffset1 = sigFig(animoffset1,3)
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_i" then
				animoffset1 = animoffset1 + 0.05
				if animoffset1 > 1.99 then
					animoffset1 = 0
				end
				if animoffset1 < 0 then
					animoffset1 = 1.95
				end
				if (animoffset1 > 0 and animoffset1 < 0.01) or (animoffset1 < 0 and animoffset1 > -0.01) then
					animoffset1 = 0
				end
				animoffset1 = sigFig(animoffset1,3)
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_o" then
				animoffset2 = animoffset2 - 0.05
				if animoffset2 > 1.99 then
					animoffset2 = 0
				end
				if animoffset2 < 0 then
					animoffset2 = 1.95
				end
				if (animoffset2 > 0 and animoffset2 < 0.01) or (animoffset2 < 0 and animoffset2 > -0.01) then
					animoffset2 = 0
				end
				animoffset2 = sigFig(animoffset2,3)
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_p" then
				animoffset2 = animoffset2 + 0.05
				if animoffset2 > 1.99 then
					animoffset2 = 0
				end
				if animoffset2 < 0 then
					animoffset2 = 1.95
				end
				if (animoffset2 > 0 and animoffset2 < 0.01) or (animoffset2 < 0 and animoffset2 > -0.01) then
					animoffset2 = 0
				end
				animoffset2 = sigFig(animoffset2,3)
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_1" then
				xoffset = xoffset - 1
				if (xoffset > 0 and xoffset < 0.01) or (xoffset < 0 and xoffset > -0.01) then
					xoffset = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_2" then
				xoffset = xoffset + 1
				if (xoffset > 0 and xoffset < 0.01) or (xoffset < 0 and xoffset > -0.01) then
					xoffset = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_h" then
				animoffset3 = animoffset3 - 0.05
				if (animoffset3 > 0 and animoffset3 < 0.01) or (animoffset3 < 0 and animoffset3 > -0.01) then
					animoffset3 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_j" then
				animoffset3 = animoffset3 + 0.05
				if (animoffset3 > 0 and animoffset3 < 0.01) or (animoffset3 < 0 and animoffset3 > -0.01) then
					animoffset3 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_k" then
				animoffset4 = animoffset4 - 0.05
				if (animoffset4 > 0 and animoffset4 < 0.01) or (animoffset4 < 0 and animoffset4 > -0.01) then
					animoffset4 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_l" then
				animoffset4 = animoffset4 + 0.05
				if (animoffset4 > 0 and animoffset4 < 0.01) or (animoffset4 < 0 and animoffset4 > -0.01) then
					animoffset4 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_right alt" then
				colcol = {
					{math.random(0,4)/4,math.random(0,4)/4,math.random(0,4)/4},
					{math.random(0,4)/4,math.random(0,4)/4,math.random(0,4)/4},
					{math.random(0,4)/4,math.random(0,4)/4,math.random(0,4)/4},
					{math.random(0,4)/4,math.random(0,4)/4,math.random(0,4)/4},
				}
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_right ctrl" then
				angle = math.random(1,359)
				speedmult = math.random(5,20)/10
				widthpathmult = math.random(0,5)
				animfactor1 = math.random(-20,20)/20
				animfactor2 = math.random(-20,20)/20
				animoffset1 = math.random(0,39)/20
				animoffset2 = math.random(0,39)/20
				animoffset3 = math.random(-10,10)/20
				animoffset4 = math.random(-10,10)/20
				vertcomp = math.random(0,1)
				xoffset = math.random(-50,50)
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_right" then
				page = 2
			end
		elseif page == 2 then
			if param.button == "DeviceButton_left" then
				page = 1
			end
		end
	end,
	UpdateCommand = function(self)
		if GAMESTATE:GetSongBeat() >= 0 and not didwehide then			
			onplayers[1] = SCREENMAN:GetTopScreen():GetChild('PlayerP1')
			onplayers[2] = SCREENMAN:GetTopScreen():GetChild('PlayerP2')
			if GAMESTATE:IsPlayerEnabled(0) then
				if SCREENMAN:GetTopScreen():GetChild('ScoreP1') then SCREENMAN:GetTopScreen():GetChild('ScoreP1'):visible(false) end
				if SCREENMAN:GetTopScreen():GetChild('LifeP1') then SCREENMAN:GetTopScreen():GetChild('LifeP1'):visible(false) end
			end
			if GAMESTATE:IsPlayerEnabled(1) then
				SCREENMAN:GetTopScreen():GetChild('ScoreP2'):visible(false)
				SCREENMAN:GetTopScreen():GetChild('LifeP2'):visible(false)
			end
			for i,v in pairs(onplayers) do
				if v then
					visible_aft = 1
					rotationz_aft = angle
					trails_aft = 0.0
					poptions[i]:Cover(999,999)
					poptions[i]:Dark(1,999)
					v:x(SCREEN_CENTER_X)
				end
			end
			didwehide = true
		end
		if didwehide then
			for i,v in pairs(onplayers) do
				if v then
					if GAMESTATE:GetSongBeat() > 0 then
						v:x(SCREEN_CENTER_X+xoffset)
						rotationz_aft = angle
						poptions[i]:Stealth(1,999)
						poptions[i]:Hidden(1,999)
						poptions[i]:StealthPastReceptors(1,999)
						poptions[i]:Flip((animfactor1/2)*math.sin((animoffset1*math.pi)+math.pi*(2*speedmult)*(GAMESTATE:GetSongBeat()-lastpress)/4)+(animfactor1/2)+animoffset3,999)
						poptions[i]:Invert((animfactor2/2)*math.sin((animoffset2*math.pi)+math.pi*(2*speedmult)*(GAMESTATE:GetSongBeat()-lastpress)/4)+(animfactor2/2)+animoffset4,999)
						poptions[i]:NotePath(1,999)
						poptions[i]:NotePathWidth(widthpathmult,999)
						poptions[i]:Alternate(1,999)
						for col = 1,#colcol do
							poptions[i]:NotePathNumGradientPoints(col,1)
							poptions[i]:NotePathGradientPoint(col,1,0)
							poptions[i]:NotePathGradientColor(col,1,colcol[col][1],colcol[col][2],colcol[col][3],1)
						end
						if vertcomp == 1 then
							if i == 1 then
								poptions[i]:Reverse(0.5*math.sin(math.pi*(2*speedmult)*(GAMESTATE:GetSongBeat()-lastpress)/4)+0.5,999)
							else
								poptions[i]:Reverse(0.5*math.sin(math.pi+math.pi*(2*speedmult)*(GAMESTATE:GetSongBeat()-lastpress)/4)+0.5,999)
							end
						else
							if i == 1 then
								poptions[i]:Reverse(0,999)
							else
								poptions[i]:Reverse(1,999)
							end
						end
						if math.mod((2*speedmult)*(GAMESTATE:GetSongBeat()-lastpress),64) > 32 then
							poptions[i]:Reverse(0.5,999)
							poptions[i]:NotePath(0,999)
						end
					end
				end
			end
		end
		self:sleep(1/60):queuecommand("Update")
	end
}
t[#t+1] = Def.ActorFrameTexture{
	InitCommand= function(self)
		self:SetTextureName('spiral_aft')
		self:SetWidth(SCREEN_WIDTH)
		self:SetHeight(SCREEN_HEIGHT)
		self:EnableDepthBuffer(true)
		self:EnableAlphaBuffer(true)
		self:EnableFloat(false)
		self:EnablePreserveTexture(true)
		self:visible(true)
		self:Create()
		spiral_aft = self
		spiral_aft_height_ratio = SCREEN_HEIGHT / spiral_aft:GetTexture():GetTextureHeight()
		spiral_aft_width_ratio =  SCREEN_WIDTH / spiral_aft:GetTexture():GetTextureWidth()
	end,
	OnCommand= function(self)
		self:playcommand("Sync")
	end,
	SyncCommand= function(self)
		self:visible(true):Draw():playcommand("Wait")
	end,
	WaitCommand=function(self)
		self:visible(false):sleep(1/60):queuecommand("Sync")
	end,
	Def.Quad{
		OnCommand = function(self)
			self:diffuse(Color.Black):diffusealpha(0.5):Center():FullScreen()
		end
	},
	Def.Sprite{
		Name= "aft_self1",
		OnCommand= function(self)
			spiral_aftdecay1 = self
			self:SetTexture(spiral_aft2:GetTexture()):Center()
		end,
	},
	Def.ActorProxy{
		Name = "GetP1Proxy",
		OnCommand = function(self)
			if SCREENMAN:GetTopScreen():GetChild('PlayerP1') then
				self:SetTarget(SCREENMAN:GetTopScreen():GetChild('PlayerP1'))
			end
		end
	},
	Def.ActorProxy{
		Name = "GetP2Proxy",
		OnCommand = function(self)
			if SCREENMAN:GetTopScreen():GetChild('PlayerP2') then
				self:SetTarget(SCREENMAN:GetTopScreen():GetChild('PlayerP2'))
			end
		end
	}
}
t[#t+1] = Def.ActorFrameTexture{
	InitCommand= function(self)
		self:SetTextureName('spiral_aft2')
		self:SetWidth(SCREEN_WIDTH)
		self:SetHeight(SCREEN_HEIGHT)
		self:EnableDepthBuffer(true)
		self:EnableAlphaBuffer(true)
		self:EnableFloat(false)
		self:EnablePreserveTexture(true)
		self:visible(true)
		self:Create()
		spiral_aft2 = self
		spiral_aft_height_ratio = SCREEN_HEIGHT / spiral_aft:GetTexture():GetTextureHeight()
		spiral_aft_width_ratio =  SCREEN_WIDTH / spiral_aft:GetTexture():GetTextureWidth()
		self:queuecommand("StateChangeUpdate")
	end,
	Def.Sprite{
		Name= "aft_self1",
		OnCommand= function(self)
			spiral_aftdecay2 = self
			self:SetTexture(spiral_aft:GetTexture()):Center()
		end,
		StateChangeUpdateCommand = function(self)
			self:rotationz(rotationz_aft)
			self:sleep(1/60):queuecommand("StateChangeUpdate")
		end
	},
	Def.Quad{
		OnCommand = function(self)
			self:diffuse(Color.Black):diffusealpha(trails_aft):Center():FullScreen():queuecommand("StateChangeUpdate")
		end,
		StateChangeUpdateCommand = function(self)
			self:diffusealpha(trails_aft)
			self:sleep(1/60):queuecommand("StateChangeUpdate")
		end
	}
}
t[#t+1] = Def.Sprite{
	OnCommand = function(self)
		self:SetTexture(spiral_aft:GetTexture()):Center():diffusealpha(visible_aft):queuecommand("StateChangeUpdate")
	end,
	StateChangeUpdateCommand = function(self)
		self:diffusealpha(visible_aft)
		self:sleep(1/60):queuecommand("StateChangeUpdate")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(5):y(5):halign(0):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateText")
	end,
	UpdateTextCommand = function(self)
		if page == 1 then
			self:settext("(1/2) XOffset: "..xoffset.."\n(Q/W) Angle: "..angle.."\n(A/S) Speed: "..speedmult.."\n(Z/X) Width: "..(widthpathmult*100).."%"):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(1/60):queuecommand("UpdateText")
	end
}
for col=1,#colcol do
	local colappendtext = colappend[col]
	t[#t+1] = Def.BitmapText{
		Font = "_consolas 24px.ini",
		OnCommand = function(self)
			self:x(5):y(95+(60*col)):halign(0):valign(0):settext("("..colappendtext..") "..col):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateColors")
		end,
		UpdateColorsCommand = function(self)
			if page == 1 then
				self:diffuse(color(""..colcol[col][1]..","..colcol[col][2]..","..colcol[col][3]..",1")):diffusealpha(1)
			else
				self:diffusealpha(0)
			end
			self:sleep(1/60):queuecommand("UpdateColors")
		end
	}
	t[#t+1] = Def.BitmapText{
		Font = "_consolas 24px.ini",
		OnCommand = function(self)
			self:x(5):y(65+(60*col)):halign(0):valign(0):settext(colappendtext.." "..col):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateColors")
		end,
		UpdateColorsCommand = function(self)
			if page == 1 then
				self:settext((colcol[col][1]*4)..","..(colcol[col][2]*4)..","..(colcol[col][3]*4)):diffuse(color(""..colcol[col][1]..","..colcol[col][2]..","..colcol[col][3]..",1")):diffusealpha(1)
			else
				self:diffusealpha(0)
			end
			self:sleep(1/60):queuecommand("UpdateColors")
		end
	}
end
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(5):y(SCREEN_HEIGHT-210):halign(0):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateCompression")
	end,
	UpdateCompressionCommand = function(self)
		if page == 1 then
			local iscomptrue = ((vertcomp == 1) and "ON" or "OFF")
			self:settext("(6) CompNP: "..iscomptrue):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(1/60):queuecommand("UpdateCompression")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(5):y(SCREEN_HEIGHT-180):halign(0):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateFactorA")
	end,
	UpdateFactorACommand = function(self)
		if page == 1 then
			self:settext("(7/8) FlAmt: "..animfactor1):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(1/60):queuecommand("UpdateFactorA")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(5):y(SCREEN_HEIGHT-150):halign(0):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateFactorB")
	end,
	UpdateFactorBCommand = function(self)
		if page == 1 then
			self:settext("(9/0) InAmt: "..animfactor2):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(1/60):queuecommand("UpdateFactorB")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(5):y(SCREEN_HEIGHT-120):halign(0):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateOffsetA")
	end,
	UpdateOffsetACommand = function(self)
		if page == 1 then
			self:settext("(U/I) FlTOff: "..animoffset1):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(1/60):queuecommand("UpdateOffsetA")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(5):y(SCREEN_HEIGHT-90):halign(0):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateOffsetB")
	end,
	UpdateOffsetBCommand = function(self)
		if page == 1 then
			self:settext("(O/P) InTOff: "..animoffset2):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(1/60):queuecommand("UpdateOffsetB")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(5):y(SCREEN_HEIGHT-60):halign(0):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateOffsetC")
	end,
	UpdateOffsetCCommand = function(self)
		if page == 1 then
			self:settext("(H/J) FlAOff: "..animoffset3):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(1/60):queuecommand("UpdateOffsetC")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(5):y(SCREEN_HEIGHT-30):halign(0):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateOffsetD")
	end,
	UpdateOffsetDCommand = function(self)
		if page == 1 then
			self:settext("(K/L) InAOff: "..animoffset4):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(1/60):queuecommand("UpdateOffsetD")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(SCREEN_WIDTH-5):y(SCREEN_HEIGHT-30):halign(1):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):settext("A.2-W4")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(SCREEN_WIDTH-5):y(5):halign(1):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):settext("(R-ALT) Quick Colors")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(SCREEN_WIDTH-5):y(35):halign(1):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):settext("(R-CTRL) Quick Controls")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(5):y(SCREEN_CENTER_Y):halign(0):valign(0.5):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateWIPFeature")
	end,
	UpdateWIPFeatureCommand = function(self)
		if page == 2 then
			self:settext("This feature\nis a WIP!\n\nCheck back\nsometime soon!"):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(1/60):queuecommand("UpdateWIPFeature")
	end
}
t[#t+1] = Def.Quad{
	OnCommand = function(self)
		self:diffuse(Color.Black):Center():FullScreen():diffusealpha(0):queuecommand("WaitForEnd")
	end,
	WaitForEndCommand = function(self)
		if GAMESTATE:GetSongBeat() > 7180 and hasnotfaded then
			hasnotfaded = false
			self:decelerate(5):diffusealpha(1)
		end
		self:sleep(1/60):queuecommand("WaitForEnd")
	end
}
t[#t+1] = Def.Actor{
	OnCommand = function(self)
		MESSAGEMAN:Broadcast("ClearBack")
	end,
	ClearBackMessageCommand = function(self)
		trails_aft = 1
		visible_aft = 0
		self:sleep(1/50):queuecommand("RestoreBack")
		lastpress = GAMESTATE:GetSongBeat()
	end,
	RestoreBackCommand = function(self)
		trails_aft = 0
		visible_aft = 1
	end
}
t[#t+1] = Def.Actor{
	InitCommand = function(self)
		self:sleep(math.huge)
	end
}
return t