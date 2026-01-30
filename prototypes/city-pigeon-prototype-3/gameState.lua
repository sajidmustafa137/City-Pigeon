local loadStartMenu = require("gameStates/loadStartMenu")
local loadSelectMenu = require("gameStates/loadSelectMenu")
local loadLevel = require("gameStates/loadLevel")
local loadPauseMenu = require("gameStates/loadPauseMenu")
local currentGameState = require("gameStates/currentGameState")
local currentLevel = require("levels/currentLevel")

local function getCurrentState()
    if currentGameState == "loadStartMenu" then
        return loadStartMenu
    elseif currentGameState == "loadSelectMenu" then
        return loadSelectMenu
    elseif currentGameState == "loadLevel" then
        return loadLevel
    elseif currentGameState == "loadPauseMenu" then
        return loadPauseMenu
    end
end

local function initialize()
    getCurrentState().initialize()
end

local function update(dt)
    getCurrentState().update(dt)
end

local function draw()
    getCurrentState().draw()
end

return {
    initialize = initialize,
    update = update,
    draw = draw,
}