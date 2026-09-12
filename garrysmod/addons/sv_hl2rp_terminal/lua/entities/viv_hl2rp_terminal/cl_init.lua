include('shared.lua')

local font1 = "Roboto"
surface.CreateFont( "DisplayStatusCodeInHUD", {
	font = "Roboto",
	size = 30,
	weight = 300, 
	extended = true
} )
surface.CreateFont( "terminal_name", {
	font = font1, -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 60,
	weight = 500,
	extended = true
} )
surface.CreateFont( "terminal_name2", {
	font = font1, -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 35,
	weight = 500,
	extended = true
} )
surface.CreateFont( "terminal_name3", {
	font = font1, -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 25,
	weight = 500,
	extended = true
} )
surface.CreateFont( "terminal_button", {
	font = font1, -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 30,
	weight = 500,
	extended = true
} )
surface.CreateFont( "terminal_button2", {
	font = font1, -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 25,
	weight = 500,
	extended = true
} )
surface.CreateFont( "terminal_loginpass", {
	font = font1, -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 50,
	weight = 500,
	extended = true
} )
surface.CreateFont( "aboutEnt", {
	font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 35,
	weight = 500,
	extended = true
} )



function ENT:Draw()
    self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), -90)
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 512 then
		cam.Start3D2D(Pos + Ang:Up() * 1, Ang, 0.11)
			draw.SimpleTextOutlined("Термінал ЦО", "aboutEnt", 15, -500,  Color(65, 131, 215,200), 1, 0, 0.9,Color(0,0,0,200) )
		cam.End3D2D()
	end
end



local function TerminalMenu()


	local menu = vgui.Create( "DPanel" )
		menu:SetPos( 0, 0 ) -- Set the position of the panel
		menu:SetSize(ScrW(), ScrH())
		menu:MakePopup()


	-- для лерпов
	local box, text = draw.RoundedBox, draw.SimpleText
	local ply, job = LocalPlayer(), LocalPlayer():getDarkRPVar("job")
	local wx1,wx2,wx3,wx4,wx5,wx6 = 0,0,0,0,0,0
	local x, y, col = ScrW(), ScrH(), Color
	local hovColor = Color(34, 167, 240, 100)


	-- первый этап
		function menu:Paint( w, h )
			wx1 = Lerp( FrameTime() * 1.25, wx1, 30 )
			wx2 = Lerp(FrameTime() * 0.85, wx2, 255)
			box( 0,  0, 0, w, h, Color( 0, 0, 0, 165 ) )
			text( "ТЕРМІНАЛ КОМБІНАТУ", "terminal_name", w / 2 - 260, 25, Color(255,255,255, wx2))
			-- text( ":выполните вход в систему:", "terminal_name2", w / 2 - 170, 150 + wx1, Color(255,255,255, wx2))
		end

		timer.Simple(1, function()


			local cancelbutton = vgui.Create( "DButton", menu)
				cancelbutton:SetPos(x / 2 - 80, y / 2 + 90)
				cancelbutton:SetSize(215, 40)
				cancelbutton:SetText("")
				cancelbutton:SetFont("Trebuchet18")
				function cancelbutton:DoClick()
					menu:Remove()
					surface.PlaySound( "ptmenu/click1.wav" )
				end
				function cancelbutton:Paint()
					wx3 = Lerp(FrameTime() * 0.15, wx3, 255)
					if self:IsHovered() then
						box(0,0,0, 250, 33, hovColor)
						text('Скасування', 'terminal_button', 5, 0, Color(15,15,15) )
					else
						box(0,0,0, 250, 33, Color(15, 15, 15, 200))
						text('Скасування', 'terminal_button', 5, 0, col(255,255,255, wx3) )
					end
				end 	

			local startbutton = vgui.Create( "DButton", menu)
				startbutton:SetPos(x / 2 - 80, y / 2 + 50)
				startbutton:SetSize(215, 40)
				startbutton:SetText("")
				startbutton:SetFont("Trebuchet18")
				function startbutton:Paint()
					wx3 = Lerp(FrameTime() * 0.15, wx3, 255)
					if self:IsHovered() then
						box(0,0,0, 250, 33, hovColor)
						text('Виконати вхід', 'terminal_button', 5, 0, Color(5,5,5) )
					else
						box(0,0,0, 250, 33, Color(15, 15, 15, 200))
						text('Виконати вхід', 'terminal_button', 5, 0, col(255,255,255, wx3) )
					end
				end 

				-- вторая волна нахой


				function startbutton:DoClick()
					startbutton:Remove()
					cancelbutton:Remove()
					surface.PlaySound( "ptmenu/click1.wav" )
					-- мур 22:20
					local timerA = 0.7
					local subColor = Color(240, 240, 240)

					surface.PlaySound('ambient/machines/keyboard_fast3_1second.wav')
					local login_bar = vgui.Create( "DLabel", menu )
						login_bar:SetPos(0,0)
						login_bar:SetSize(ScrW(), ScrH())
						login_bar:SetText("")
						function login_bar:Paint( w, h )
							box(0, x/2-100,y/2-20,200,40,Color(20,20,20,200))
							text(math.random(1,9), "terminal_loginpass", x/2-105,y/2-20, Color(255,255,255))
						end
						timer.Simple(0.15, function()
							function login_bar:Paint( w, h )
								box(0, x/2-100,y/2-20,200,40,Color(20,20,20,200))
								text("*"..math.random(1,9), "terminal_loginpass", x/2-105,y/2-20, Color(255,255,255))
							end

							timer.Simple(0.15, function()
								function login_bar:Paint( w, h )
									box(0, x/2-100,y/2-20,200,40,Color(20,20,20,200))
									text("**"..math.random(1,9), "terminal_loginpass", x/2-105,y/2-20, Color(255,255,255))
								end
								timer.Simple(0.15, function()
									function login_bar:Paint( w, h )
										box(0, x/2-100,y/2-20,200,40,Color(20,20,20,200))
										text("***"..math.random(1,9), "terminal_loginpass", x/2-105,y/2-20, Color(255,255,255))
									end
									timer.Simple(0.15, function()
										function login_bar:Paint( w, h )
											box(0, x/2-100,y/2-20,200,40,Color(20,20,20,200))
											text("****"..math.random(1,9), "terminal_loginpass", x/2-105,y/2-20, Color(255,255,255))
										end
										timer.Simple(0.15, function()
											function login_bar:Paint( w, h )
												box(0, x/2-100,y/2-20,200,40,Color(20,20,20,200))
												text("*****"..math.random(1,9), "terminal_loginpass", x/2-105,y/2-20, Color(255,255,255))
											end
											timer.Simple(0.15, function()
												function login_bar:Paint( w, h )
													box(0, x/2-100,y/2-20,200,40,Color(20,20,20,200))
													text("******"..math.random(1,9), "terminal_loginpass", x/2-105,y/2-20, Color(255,255,255))
												end
											end)
										end)
									end)
								end)
							end)
						end)



					timer.Simple(1.15, function()
					login_bar:Remove()
					local progress = vgui.Create( "DLabel", menu )
						progress:SetPos(0,0)
						progress:SetSize(ScrW(), ScrH())
						progress:SetText("")
						function progress:Paint( w, h )
							text( "Ініціалізація...", "terminal_name2", x/2-170, 190, subColor)
						end
						timer.Simple(timerA, function()
							function progress:Paint( w, h )
								text( "Пошук даних запиту...", "terminal_name2", x/2-200, 190, subColor)
							end
							timer.Simple(timerA, function()
								function progress:Paint( w, h )
									text( "Реєструєм дані про вхід в систему...", "terminal_name2", x/2-250, 190, subColor)
								end
								timer.Simple(timerA, function()
									function progress:Paint( w, h )
										text( "Завантажуєм актуальні дані...", "terminal_name2", x/2-200, 190, subColor)
									end
									timer.Simple(timerA, function()
										function progress:Paint( w, h )
											text( "Імпорт даних...", "terminal_name2", x/2-200, 190, subColor)
										end
										timer.Simple(timerA, function()
											function progress:Paint( w, h )
												text( "Очікуєм підключення.", "terminal_name2", x/2-170, 190, subColor)
											end
											timer.Simple(timerA, function()
												function progress:Paint( w, h )
													text( "Очікуєм підключення..", "terminal_name2", x/2-170, 190, subColor)
												end
												timer.Simple(timerA, function()
													function progress:Paint( w, h )
														text( "Очікуєм підключення...", "terminal_name2", x/2-170, 190, subColor)
													end
													timer.Simple(timerA, function()
														function progress:Paint( w, h )
															text( "Вхід виконано!", "terminal_name2", x/2-140, 190, subColor)
														end
														surface.PlaySound("buttons/combine_button1.wav")

														--[[====================]]
														--[[	термінал ЦОП	]]
														--[[====================]]

														progress:Remove()
														local t_nick = vgui.Create( "DLabel", menu)
														t_nick:SetPos(25, 25)
														t_nick:SetSize(330, 40)
														t_nick:SetText("")
														local wx = 0
														function t_nick:Paint()
															wx3 = Lerp(FrameTime() * 0.15, wx3, 255)
															box(0, 0, 0, 330, 33, Color(15,15,15,200))
															text(ply:Nick(), 'terminal_button2', 10, 5, Color(255,255,255, 255))
														end 
														local t_button_close = vgui.Create( "DButton", menu)
														t_button_close:SetPos(25, 63)
														t_button_close:SetSize(330, 40)
														t_button_close:SetText("")
														t_button_close:SetFont("Trebuchet18")
														function t_button_close:DoClick()
														menu:Remove() surface.PlaySound( "ptmenu/click1.wav" ) end
														t_button_close.OnCursorEntered = function() 
															surface.PlaySound("ptmenu/scroll.wav")
														end
														function t_button_close:Paint()
															if self:IsHovered() then
																box(0,0,0, 330, 33, Color(207, 0, 15, 200))
																text('Закрити ', 'terminal_button2', 10, 5, Color(5,5,5) )
															else
																box(0,0,0, 330, 33, Color(15, 15, 15, 200))
																text('Закрити', 'terminal_button2', 10, 5, col(255,255,255, 255) )
															end
														end
--[[													local t_button_HEALTH = vgui.Create( "DButton", menu)
														t_button_HEALTH:SetPos(25, y-40)
														t_button_HEALTH:SetSize(193, 40)
														t_button_HEALTH:SetText("")
														t_button_HEALTH:SetFont("Trebuchet18")
														function t_button_HEALTH:DoClick()
														local netName = "terminalCP_health"
														net.Start(netName) net.WriteEntity(LocalPlayer()) net.SendToServer()
														surface.PlaySound( "ptmenu/click1.wav" ) end
														function t_button_HEALTH:Paint()
															if self:IsHovered() then
																box(0,0,0, 193, 33, hovColor)
																text('Вылечиться', 'terminal_button2', 10, 5, Color(5,5,5) )
															else
																box(0,0,0, 193, 33, Color(15, 15, 15, 200))
																text('Вылечиться', 'terminal_button2', 10, 5, col(255,255,255, 255) )
															end
														end
														t_button_HEALTH.OnCursorEntered = function() 
															surface.PlaySound("ptmenu/scroll.wav")
														end]]
														-- второй этаж
														local t_button_DoRedCode = vgui.Create( "DButton", menu)
														t_button_DoRedCode:SetPos(25, y-80)
														t_button_DoRedCode:SetSize(193, 40)
														t_button_DoRedCode:SetText("")
														t_button_DoRedCode:SetFont("Trebuchet18")
														function t_button_DoRedCode:DoClick()
														if LocalPlayer():Team() == TEAM_ADMIN or LocalPlayer():Team() == TEAM_DIS or LocalPlayer():Team() == TEAM_SEC or LocalPlayer():Team() == TEAM_ADMINISTRATOR then
														local netName = "terminalCP_redcode"
														net.Start(netName) net.SendToServer()
														surface.PlaySound( "ptmenu/click1.wav" ) 
														end
														end
														function t_button_DoRedCode:Paint()
															if self:IsHovered() then
																if ( GetGlobalBool( "YellowCode") == false and GetGlobalBool( "WorkingPhase" ) == false ) then
																	if ( GetGlobalBool( "RedCode") == false ) then
																		box(0,0,0, 193, 33, hovColor)
																		text('Запустити Жовтий код', 'terminal_button2', 10, 5, Color(5,5,5) )
																	else
																		box(0,0,0, 193, 33, Color(255,0,0, 100))
																		text('Вимкнути Жовтий код', 'terminal_button2', 10, 5, Color(5,5,5) )
																	end
																else
																	box(0,0,0, 193, 33, Color(200,200,200,100))
																	text('[БЕЗ ДОСТУПУ]', 'terminal_button2', 10, 5, Color(5,5,5) )
																end
															else
																box(0,0,0, 193, 33, Color(15, 15, 15, 200))
																text('Жовтий код', 'terminal_button2', 10, 5, col(255,255,255, 255) )
															end
														end
														t_button_DoRedCode.OnCursorEntered = function() 
															surface.PlaySound("ptmenu/scroll.wav")
														end
														local t_button_DoYellowCode = vgui.Create( "DButton", menu)
														t_button_DoYellowCode:SetPos(225, y-80)
														t_button_DoYellowCode:SetSize(193, 40)
														t_button_DoYellowCode:SetText("")
														t_button_DoYellowCode:SetFont("Trebuchet18")
														function t_button_DoYellowCode:DoClick()
														if LocalPlayer():Team() == TEAM_ADMIN or LocalPlayer():Team() == TEAM_DIS or LocalPlayer():Team() == TEAM_SEC or LocalPlayer():Team() == TEAM_ADMINISTRATOR then

														local netName = "terminalCP_yellowcode"
														net.Start(netName) net.SendToServer()
														surface.PlaySound( "ptmenu/click1.wav" ) 
													end
														end
														function t_button_DoYellowCode:Paint()
															if self:IsHovered() then
																if ( GetGlobalBool( "RedCode") == false and GetGlobalBool( "WorkingPhase" ) == false ) then
																	if ( GetGlobalBool( "YellowCode") == false ) then
																		box(0,0,0, 193, 33, hovColor)
																		text("Включити Жовтий код", 'terminal_button2', 10, 5, Color(5,5,5) )
																	else
																		box(0,0,0, 193, 33, Color(255,0,0, 100))
																		text("Вимкнути Жовтий код", 'terminal_button2', 10, 5, Color(5,5,5) )
																	end
																else
																	box(0,0,0, 193, 33, Color(200,200,200,100))
																	text('[БЕЗ ДОСТУПУ]', 'terminal_button2', 10, 5, Color(5,5,5) )
																end
															else
																box(0,0,0, 193, 33, Color(15, 15, 15, 200))
																text('Жовтий код', 'terminal_button2', 10, 5, col(255,255,255, 255) )
															end
														end
														t_button_DoYellowCode.OnCursorEntered = function() 
															surface.PlaySound("ptmenu/scroll.wav")
														end
														local t_button_WorkingPhase = vgui.Create( "DButton", menu)
														t_button_WorkingPhase:SetPos(425, y-80)
														t_button_WorkingPhase:SetSize(193, 40)
														t_button_WorkingPhase:SetText("")
														t_button_WorkingPhase:SetFont("Trebuchet18")
														function t_button_WorkingPhase:DoClick()
														if LocalPlayer():Team() == TEAM_ADMIN or LocalPlayer():Team() == TEAM_DIS or LocalPlayer():Team() == TEAM_SEC or LocalPlayer():Team() == TEAM_ADMINISTRATOR then

														local netName = "terminalCP_workingphase"
														net.Start(netName) net.SendToServer()
														surface.PlaySound( "ptmenu/click1.wav" ) 
													end
														end
														function t_button_WorkingPhase:Paint()
															if self:IsHovered() then
																if ( GetGlobalBool( "RedCode") == false and GetGlobalBool( "YellowCode" ) == false ) then
																	if ( GetGlobalBool( "WorkingPhase") == false ) then
																		box(0,0,0, 193, 33, hovColor)
																		text('Запустить', 'terminal_button2', 10, 5, Color(5,5,5) )
																	else
																		box(0,0,0, 193, 33, Color(255,0,0, 100))
																		text('Вимкнути', 'terminal_button2', 10, 5, Color(5,5,5) )
																	end
																else
																	box(0,0,0, 193, 33, Color(200,200,200,100))
																	text('[БЕЗ ДОСТУПУ]', 'terminal_button2', 10, 5, Color(5,5,5) )
																end
															else
																box(0,0,0, 193, 33, Color(15, 15, 15, 200))
																text('Рабоча фаза', 'terminal_button2', 10, 5, col(255,255,255, 255) )
															end
														end
														t_button_WorkingPhase.OnCursorEntered = function() 
															surface.PlaySound("ptmenu/scroll.wav")
														end
														local t_button_DEMOTE = vgui.Create( "DButton", menu)
														t_button_DEMOTE:SetPos(425, y-40)
														t_button_DEMOTE:SetSize(193, 40)
														t_button_DEMOTE:SetText("")
														t_button_DEMOTE:SetFont("Trebuchet18")
														function t_button_DEMOTE:DoClick()
														if LocalPlayer():Team() == TEAM_ADMIN or LocalPlayer():Team() == TEAM_DIS or LocalPlayer():Team() == TEAM_SEC or LocalPlayer():Team() == TEAM_ADMINISTRATOR then
														local dispatch_list = vgui.Create("MList",menu)

															dispatch_list:SetSize(200,200)
															for k, v in pairs (player.GetAll()) do
																dispatch_list:AddItem(v:Nick(), function () 
																	local netName = "terminalCP_demote"
																	net.Start(netName) net.WriteEntity(v) net.SendToServer()
																end)
															end
															surface.PlaySound( "ptmenu/click1.wav" ) 
														end
														end
														function t_button_DEMOTE:Paint()
															if self:IsHovered() then
																box(0,0,0, 193, 33, hovColor)
																text('Звільнити', 'terminal_button2', 10, 5, Color(5,5,5) )
															else
																box(0,0,0, 193, 33, Color(15, 15, 15, 200))
																text('Звільнити', 'terminal_button2', 10, 5, col(255,255,255, 255) )
															end
														end
														t_button_DEMOTE.OnCursorEntered = function() 
															surface.PlaySound("ptmenu/scroll.wav")
														end
														-- end
														local t_button_AMMO = vgui.Create( "DButton", menu)
														t_button_AMMO:SetPos(25, y-40)
														t_button_AMMO:SetSize(193, 40)
														t_button_AMMO:SetText("")
														t_button_AMMO:SetFont("Trebuchet18")
														function t_button_AMMO:DoClick()
														local netName = "terminalCP_ammo"
														net.Start(netName) net.WriteEntity(LocalPlayer()) net.SendToServer()
														surface.PlaySound( "ptmenu/click1.wav" ) end
														function t_button_AMMO:Paint()
															if self:IsHovered() then
																box(0,0,0, 193, 33, hovColor)
																text('Взяти кулі', 'terminal_button2', 10, 5, Color(5,5,5) )
															else
																box(0,0,0, 193, 33, Color(15, 15, 15, 200))
																text('Взяти кулі', 'terminal_button2', 10, 5, col(255,255,255, 255) )
															end
														end
														t_button_AMMO.OnCursorEntered = function() 
															surface.PlaySound("ptmenu/scroll.wav")
														end
														-- local t_button_WEAPONS = vgui.Create( "DButton", menu)
														-- t_button_WEAPONS:SetPos(225, y-40)
														-- t_button_WEAPONS:SetSize(193, 40)
														-- t_button_WEAPONS:SetText("")
														-- t_button_WEAPONS:SetFont("Trebuchet18")
														-- function t_button_WEAPONS:DoClick()
														-- local netName = "terminalCP_weapons"
														-- net.Start(netName) net.WriteEntity(LocalPlayer()) net.SendToServer()
														-- surface.PlaySound( "ptmenu/click1.wav" ) end
														-- function t_button_WEAPONS:Paint()
														-- 	if self:IsHovered() then
														-- 		box(0,0,0, 193, 33, hovColor)
														-- 		text('Получити озброєння', 'terminal_button2', 10, 5, Color(5,5,5) )
														-- 	else
														-- 		box(0,0,0, 193, 33, Color(15, 15, 15, 200))
														-- 		text('Получити озброєння', 'terminal_button2', 10, 5, col(255,255,255, 255) )
														-- 	end
														-- end
														-- t_button_WEAPONS.OnCursorEntered = function() 
														-- 	surface.PlaySound("ptmenu/scroll.wav")
														-- end      


														--[[====================]]
														--[[====================]]
														--[[====================]]
													end)
												end)
											end)
										end)
									end)
								end)
							end)
						end)
					end)


				end


	end)

end
usermessage.Hook("CPTerminalOpen", TerminalMenu)

hook.Add("HUDPaint","StatusesHl2rp",function(ply)
	if ( GetGlobalBool( "RedCode") == true ) then
		draw.SimpleTextOutlined("Оголошено Жовтий код", "DisplayStatusCodeInHUD", ScrW() / 2, 25,  Color(243, 156, 18,200), 1, 0, 0.9,Color(0,0,0,200) )
	elseif ( GetGlobalBool("YellowCode") == true) then
		draw.SimpleTextOutlined("Оголошено Червоний код", "DisplayStatusCodeInHUD", ScrW() / 2, 25,  Color(239, 72, 54,200), 1, 0, 0.9,Color(0,0,0,200) )
	elseif ( GetGlobalBool( "WorkingPhase") == true ) then
		draw.SimpleTextOutlined("Оголошена Робоча фаза", "DisplayStatusCodeInHUD", ScrW() / 2, 25,  Color(5, 168, 255,200), 1, 0, 0.9,Color(0,0,0,200) )
	end
end)

net.Receive("redcodestarted",function()
	if timer.Exists("doredcodesound") == false then
		timer.Create("doredcodesound",0,0,function()
			surface.PlaySound( "" )
		end)
	end
end)

net.Receive("soundtoclient", function()
	snd = net.ReadString()
	surface.PlaySound(snd)
end)

net.Receive("redcodestop",function(ply)
	LocalPlayer():ConCommand( "stopsound" )
	timer.Remove("doredcodesound")
end)
