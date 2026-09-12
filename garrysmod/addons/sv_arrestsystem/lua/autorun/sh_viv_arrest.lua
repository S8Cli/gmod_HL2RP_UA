--КОМАНДА ДЛЯ ОТОБРАЖЕНИЯ ЗОНЫ 'viv_view_jailzone'

VIV_JailerSystem = VIV_JailerSystem or {}
VIV_JailerSystem.config = VIV_JailerSystem.config or {}

VIV_JailerSystem.config.JailerNPCModel = "models/Combine_Soldier_PrisonGuard.mdl" -- Модель тюремника
VIV_JailerSystem.config.JailerNPCName = "Тюремник" -- Ім'я тюремника
VIV_JailerSystem.config.JailerNPCRistance = 250 -- Дистанція виявлення гравців
VIV_JailerSystem.config.JailerNPCNotPlayerRadius = "Зажадав потеревенити? Йди порушників шукай!" -- Повідомлення, якщо поруч з NPC немає порушників
VIV_JailerSystem.config.JailerNPCArrestReason = "Причина арешту:" -- Напис у меню арешту
VIV_JailerSystem.config.JailerNPCArrestDuration = "Тривалість арешту (в секундах):" -- Напис у меню арешту
VIV_JailerSystem.config.JailerNPCArrestNameButton = "Заарештувати" -- Напис на кнопці арешту
VIV_JailerSystem.config.JailerNPCArrestMinJailTime = 30 -- Мінімальний час ув'язнення в секундах
VIV_JailerSystem.config.JailerNPCArrestMaxJailTime = 900 -- Максимальний час ув'язнення в секундах
VIV_JailerSystem.config.JailerNPCArrestMessageArrestTarget = "Ви були заарештовані" -- Повідомлення при арешті
VIV_JailerSystem.config.JailerNPCArrestMessageUnArrestLeave = "Втеча з в'язниці" -- Причина розшуку при втечі з в'язниці
VIV_JailerSystem.config.JailerNPCArrestTimeUnArrestLeave = 120 -- Час у секундах, як довго триватиме розшук після втечі з в'язниці
VIV_JailerSystem.config.JailerNPCArrestZoneSteamIDView = "STEAM_0:0:131286356" -- SteamID для перегляду зони арешту
VIV_JailerSystem.config.JailerNPCArrestChatPrefix = "City34 Radio" -- префікс повідомлення при арешті

VIVASZone.Data = {}

VIVASZone:AddNewZone( "rp_city34_v1a", {
	Center = Vector( 1414, -3291, -279 ),
	SizeBackwards = Vector( 1800, -3400, -200 ),
	SizeForwards = Vector( 1014, -2809, -301 )
} )