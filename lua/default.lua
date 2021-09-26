local page = 1
local schemecons = math.random(0,4)/4
local schemechoose = math.random(1,3)
local limit = GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
local colcol = {}
for i = 1,limit do
	table.insert(colcol,{math.random(0,4)/4,math.random(0,4)/4,math.random(0,4)/4})
end
for col = 1,limit do
	colcol[col][schemechoose] = schemecons
end
local schemedifferpick = math.random(limit)
local schemediffer = math.random(-1,1)/4
colcol[schemedifferpick][schemechoose] = colcol[schemedifferpick][schemechoose]+schemediffer
if colcol[schemedifferpick][schemechoose] > 1 or colcol[schemedifferpick][schemechoose] < 0 then
	colcol[schemedifferpick][schemechoose] = colcol[schemedifferpick][schemechoose]-schemediffer
end
--This was in here for rounding fixes, but now that it's in the Lua lexicon for the latest versions of OF, I'm debating removing it from here.
function sigFig(num,figures)
	if num == 0 then return 0 end
	local x = figures-math.ceil(math.log10(math.abs(num)))
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
local tangents = math.random(1,2) == 1 and true or false
local speedmult = tangents and 0.1 or 1
if math.random(1,5) == 1 then
	speedmult = tangents and math.random(1,5)/10 or math.random(1,20)/10
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
local vertcomp = math.random(1,2) == 1 and true or false
local lastpress = 0
local xoffset = 0
local linetype = math.random(1,3)
local vistext = true
if math.random(1,10) == 1 then
	xoffset = math.random(-50,50)
end
local colorselect = 1
local hasnotfaded = true
local function InputHandler(event)
	if not event.DeviceInput then return end
	local etype = ToEnumShortString(event.type)
		if etype == "FirstPress" then
		MESSAGEMAN:Broadcast("ButtonPress",{button=event.DeviceInput.button})
	end
end
local t = Def.ActorFrame{
	OnCommand = function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
		self:playcommand("Update")
		SCREENMAN:GetTopScreen():GetChild('Underlay'):visible(false)
		SCREENMAN:GetTopScreen():GetChild('Overlay'):GetChildAt(1):visible(false)
	end,
	ButtonPressMessageCommand = function(self,param)
		--I may need this later.
		--SCREENMAN:SystemMessage(param.button)
		if page == 1 then
			if param.button == "DeviceButton_q" then
				angle = angle-1
				if angle == -1 then
					angle = 359
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_w" then
				angle = angle+1
				angle = math.mod(angle,360)
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_a" then
				speedmult = speedmult-0.1
				if speedmult <= 0.1 then
					speedmult = 0.1
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_s" then
				speedmult = speedmult+0.1
				if speedmult <= 0.1 then
					speedmult = 0.1
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_z" then
				widthpathmult = widthpathmult-1
				if widthpathmult < 0 then
					widthpathmult = 0
				else
					MESSAGEMAN:Broadcast("ClearBack")
				end
			elseif param.button == "DeviceButton_x" then
				widthpathmult = widthpathmult+1
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_7" then
				animfactor1 = animfactor1-0.05
				if (animfactor1 > 0 and animfactor1 < 0.01) or (animfactor1 < 0 and animfactor1 > -0.01) then
					animfactor1 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_8" then
				animfactor1 = animfactor1+0.05
				if (animfactor1 > 0 and animfactor1 < 0.01) or (animfactor1 < 0 and animfactor1 > -0.01) then
					animfactor1 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_9" then
				animfactor2 = animfactor2-0.05
				if (animfactor2 > 0 and animfactor2 < 0.01) or (animfactor2 < 0 and animfactor2 > -0.01) then
					animfactor2 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_0" then
				animfactor2 = animfactor2+0.05
				if (animfactor2 > 0 and animfactor2 < 0.01) or (animfactor2 < 0 and animfactor2 > -0.01) then
					animfactor2 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_6" then
				if vertcomp then
					vertcomp = false
				else
					vertcomp = true
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_u" then
				animoffset1 = animoffset1-0.05
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
				animoffset1 = animoffset1+0.05
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
				animoffset2 = animoffset2-0.05
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
				animoffset2 = animoffset2+0.05
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
				xoffset = xoffset-1
				if (xoffset > 0 and xoffset < 0.01) or (xoffset < 0 and xoffset > -0.01) then
					xoffset = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_2" then
				xoffset = xoffset+1
				if (xoffset > 0 and xoffset < 0.01) or (xoffset < 0 and xoffset > -0.01) then
					xoffset = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_h" then
				animoffset3 = animoffset3-0.05
				if (animoffset3 > 0 and animoffset3 < 0.01) or (animoffset3 < 0 and animoffset3 > -0.01) then
					animoffset3 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_j" then
				animoffset3 = animoffset3+0.05
				if (animoffset3 > 0 and animoffset3 < 0.01) or (animoffset3 < 0 and animoffset3 > -0.01) then
					animoffset3 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_k" then
				animoffset4 = animoffset4-0.05
				if (animoffset4 > 0 and animoffset4 < 0.01) or (animoffset4 < 0 and animoffset4 > -0.01) then
					animoffset4 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_l" then
				animoffset4 = animoffset4+0.05
				if (animoffset4 > 0 and animoffset4 < 0.01) or (animoffset4 < 0 and animoffset4 > -0.01) then
					animoffset4 = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_3" then
				if tangents then
					tangents = false
				else
					tangents = true
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_4" then
				linetype = linetype-1
				if linetype < 1 then
					linetype = 3
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_5" then
				linetype = linetype+1
				if linetype > 3 then
					linetype = 1
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_left ctrl" then
				angle = math.random(1,359)
				tangents = math.random(1,2) == 1 and true or false
				speedmult = tangents and math.random(1,5)/10 or math.random(1,20)/10
				widthpathmult = math.random(0,5)
				animfactor1 = math.random(-20,20)/20
				animfactor2 = math.random(-20,20)/20
				animoffset1 = math.random(0,39)/20
				animoffset2 = math.random(0,39)/20
				animoffset3 = math.random(-10,10)/20
				animoffset4 = math.random(-10,10)/20
				vertcomp = math.random(1,2) == 1 and true or false
				xoffset = math.random(-50,50)
				linetype = math.random(1,3)
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_space" then
				if vistext then
					vistext = false
				else
					vistext = true
				end
			elseif param.button == "DeviceButton_right" and vistext then
				page = 2
			end
		elseif page == 2 then
			if param.button == "DeviceButton_up" then
				if colorselect > 1 then
					colorselect = colorselect-1
				end
			elseif param.button == "DeviceButton_down" then
				if colorselect < limit then
					colorselect = colorselect+1
				end
			elseif param.button == "DeviceButton_1" then
				colcol[colorselect][1] = colcol[colorselect][1]+0.25
				if colcol[colorselect][1] >= 1.25 then
					colcol[colorselect][1] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_2" then
				colcol[colorselect][2] = colcol[colorselect][2]+0.25
				if colcol[colorselect][2] >= 1.25 then
					colcol[colorselect][2] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_3" then
				colcol[colorselect][3] = colcol[colorselect][3]+0.25
				if colcol[colorselect][3] >= 1.25 then
					colcol[colorselect][3] = 0
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_left ctrl" then
				colcol = {}
				schemecons = math.random(0,4)/4
				schemechoose = math.random(1,3)
				for i = 1,limit do
					table.insert(colcol,{math.random(0,4)/4,math.random(0,4)/4,math.random(0,4)/4})
				end
				for col = 1,limit do
					colcol[col][schemechoose] = schemecons
				end
				schemedifferpick = math.random(limit)
				schemediffer = math.random(-1,1)/4
				colcol[schemedifferpick][schemechoose] = colcol[schemedifferpick][schemechoose] + schemediffer
				if colcol[schemedifferpick][schemechoose] > 1 or colcol[schemedifferpick][schemechoose] < 0 then
					colcol[schemedifferpick][schemechoose] = colcol[schemedifferpick][schemechoose] - schemediffer
				end
				MESSAGEMAN:Broadcast("ClearBack")
			elseif param.button == "DeviceButton_space" then
				if vistext then
					vistext = false
				else
					vistext = true
				end
			elseif param.button == "DeviceButton_left" and vistext then
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
				if SCREENMAN:GetTopScreen():GetChild('ScoreP2') then SCREENMAN:GetTopScreen():GetChild('ScoreP2'):visible(false) end
				if SCREENMAN:GetTopScreen():GetChild('LifeP2') then SCREENMAN:GetTopScreen():GetChild('LifeP2'):visible(false) end
			end
			for i,v in pairs(onplayers) do
				if v then
					visible_aft = 1
					rotationz_aft = angle
					trails_aft = 0
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
						if tangents then
							poptions[i]:Flip((animfactor1/2)*math.tan((animoffset1*math.pi)+math.pi*(2*speedmult)*(GAMESTATE:GetSongBeat()-lastpress)/4)+(animfactor1/2)+animoffset3,999)
							poptions[i]:Invert((animfactor2/2)*math.tan((animoffset2*math.pi)+math.pi*(2*speedmult)*(GAMESTATE:GetSongBeat()-lastpress)/4)+(animfactor2/2)+animoffset4,999)
						else
							poptions[i]:Flip((animfactor1/2)*math.sin((animoffset1*math.pi)+math.pi*(2*speedmult)*(GAMESTATE:GetSongBeat()-lastpress)/4)+(animfactor1/2)+animoffset3,999)
							poptions[i]:Invert((animfactor2/2)*math.sin((animoffset2*math.pi)+math.pi*(2*speedmult)*(GAMESTATE:GetSongBeat()-lastpress)/4)+(animfactor2/2)+animoffset4,999)
						end
						poptions[i]:NotePath(1,999)
						poptions[i]:NotePathWidth(widthpathmult,999)
						poptions[i]:NotePathDrawMode(linetype == 1 and 7 or linetype == 2 and 9 or 10)
						--Values 0 - 10
						--Please mess with this later.
						--https://cdn.discordapp.com/attachments/586285188158586881/891503458518171648/unknown.png
						poptions[i]:Alternate(1,999)
						for col = 1,limit do
							poptions[i]:NotePathNumGradientPoints(col,1)
							poptions[i]:NotePathGradientPoint(col,1,0)
							poptions[i]:NotePathGradientColor(col,1,colcol[col][1],colcol[col][2],colcol[col][3],1)
						end
						if vertcomp then
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
		self:sleep(0.01):queuecommand("Update")
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
		self:visible(false):sleep(0.01):queuecommand("Sync")
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
			self:rotationz(rotationz_aft):sleep(0.01):queuecommand("StateChangeUpdate")
		end
	},
	Def.Quad{
		OnCommand = function(self)
			self:diffuse(Color.Black):diffusealpha(trails_aft):Center():FullScreen():queuecommand("StateChangeUpdate")
		end,
		StateChangeUpdateCommand = function(self)
			self:diffusealpha(trails_aft):sleep(0.01):queuecommand("StateChangeUpdate")
		end
	}
}
t[#t+1] = Def.Sprite{
	OnCommand = function(self)
		self:SetTexture(spiral_aft:GetTexture()):Center():diffusealpha(visible_aft):queuecommand("StateChangeUpdate")
	end,
	StateChangeUpdateCommand = function(self)
		self:diffusealpha(visible_aft):sleep(0.01):queuecommand("StateChangeUpdate")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(5):y(5):halign(0):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateText")
	end,
	UpdateTextCommand = function(self)
		if page == 1 and vistext then
			self:settext("(1/2) XOffset: "..xoffset.."\n(Q/W) Angle: "..angle.."\n(A/S) Speed: "..speedmult.."\n(Z/X) Width: "..(widthpathmult*100).."%"):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(0.01):queuecommand("UpdateText")
	end
}
for col=1,limit do
	t[#t+1] = Def.BitmapText{
		Font = "_consolas 24px.ini",
		OnCommand = function(self)
			self:x(5):y(SCREEN_CENTER_Y+(30*(col-(limit/2)))):halign(0):valign(1):queuecommand("UpdateColors")
		end,
		UpdateColorsCommand = function(self)
			if page == 2 and vistext then
				local zero = (col < 10) and "0" or ""
				local colorcursor = (col == colorselect) and " <" or ""
				self:settext(zero..col..": "..(colcol[col][1]*4)..","..(colcol[col][2]*4)..","..(colcol[col][3]*4)..colorcursor):shadowlength(1):shadowcolor(color("1,1,1,1")):diffuse(color(""..colcol[col][1]..","..colcol[col][2]..","..colcol[col][3]..",1")):diffusealpha(1)
			else
				self:diffusealpha(0)
			end
			self:sleep(0.01):queuecommand("UpdateColors")
		end
	}
end
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(5):y(SCREEN_HEIGHT-270):halign(0):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdateDetails")
	end,
	UpdateDetailsCommand = function(self)
		if page == 1 and vistext then
			local iscomptrue = vertcomp and "ON" or "OFF"
			local istantrue = tangents and "Tan" or "Sin"
			self:settext("(3) AnimType: "..istantrue.."\n(4/5) NPType: "..linetype.."\n(6) CompNP: "..iscomptrue.."\n(7/8) FlAmt: "..animfactor1.."\n(9/0) InAmt: "..animfactor2.."\n(U/I) FlTOff: "..animoffset1.."\n(O/P) InTOff: "..animoffset2.."\n(H/J) FlAOff: "..animoffset3.."\n(K/L) InAOff: "..animoffset4):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(0.01):queuecommand("UpdateDetails")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(SCREEN_WIDTH-5):y(SCREEN_HEIGHT-30):halign(1):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):settext("A.2-W5"):queuecommand("UpdateVersion")
	end,
	UpdateVersionCommand = function(self)
		if vistext then
			self:diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(0.01):queuecommand("UpdateVersion")
	end
}
t[#t+1] = Def.BitmapText{
	Font = "_consolas 24px.ini",
	OnCommand = function(self)
		self:x(SCREEN_WIDTH-5):y(5):halign(1):valign(0):shadowlength(1):shadowcolor(color("1,1,1,1")):queuecommand("UpdatePage")
	end,
	UpdatePageCommand = function(self)
		if vistext then
			self:settext("(L-CTRL) Quick Controls\n(Page "..page.."/2)"):diffusealpha(1)
		else
			self:diffusealpha(0)
		end
		self:sleep(0.01):queuecommand("UpdatePage")
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
		self:sleep(0.01):queuecommand("WaitForEnd")
	end
}
t[#t+1] = Def.Actor{
	OnCommand = function(self)
		MESSAGEMAN:Broadcast("ClearBack")
	end,
	ClearBackMessageCommand = function(self)
		trails_aft = 1
		visible_aft = 0
		self:sleep(0.02):queuecommand("RestoreBack")
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