-- JSModMenu.lua - Versão inicial do JSModMenu para GTA V
-- Dependências: Kiddion's, Yim Menu, YimStuff

-- Define o nome e inicializa o menu
local JSModMenu = {}
JSModMenu.name = "JSModMenu"
JSModMenu.version = "1.0"

-- Função para inicializar o menu principal
function JSModMenu.init()
    -- Adiciona o título do menu
    menu.add_action(JSModMenu.name .. " v" .. JSModMenu.version, function() end)
    
    -- Submenu de Jogador (opções como invencibilidade, teleportar)
    menu.add_submenu("Opções de Jogador", function()
        -- Invencibilidade
        menu.add_toggle("Invencibilidade", function() return JSModMenu.isInvincible end, function(value) JSModMenu.toggleInvincibility(value) end)
        
        -- Teleportar para Waypoint
        menu.add_action("Teleportar para Waypoint", function() JSModMenu.teleportToWaypoint() end)
        
        -- Ajuste de Velocidade
        menu.add_slider("Velocidade", 1, 100, function() return JSModMenu.speed end, function(value) JSModMenu.speed = value end)
    end)
end

-- Função para ativar/desativar invencibilidade
function JSModMenu.toggleInvincibility(enable)
    if enable then
        -- Exemplo de comando para invencibilidade usando YimStuff
        PLAYER.SET_PLAYER_INVINCIBLE(PLAYER.PLAYER_ID(), true)
    else
        PLAYER.SET_PLAYER_INVINCIBLE(PLAYER.PLAYER_ID(), false)
    end
    JSModMenu.isInvincible = enable
end

-- Função para teletransportar o jogador para o waypoint marcado
function JSModMenu.teleportToWaypoint()
    local waypoint = HUD.GET_FIRST_BLIP_INFO_ID(HUD.BLIP_WAYPOINT)
    if waypoint ~= 0 then
        local pos = HUD.GET_BLIP_COORDS(waypoint)
        ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z)
    else
        menu.notify("Waypoint não encontrado!", "JSModMenu", 5)
    end
end

-- Configuração de velocidade
JSModMenu.speed = 10  -- Velocidade padrão
function JSModMenu.adjustSpeed()
    PLAYER.SET_PLAYER_SPEED(PLAYER.PLAYER_ID(), JSModMenu.speed)
end

-- Inicializa o menu quando o script é carregado
JSModMenu.init()
