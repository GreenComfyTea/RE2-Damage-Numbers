local this = {};

local error_handler;

local sdk = sdk;
local tostring = tostring;
local pairs = pairs;
local ipairs = ipairs;
local tonumber = tonumber;
local require = require;
local pcall = pcall;
local table = table;
local string = string;
local Vector3f = Vector3f;
local d2d = d2d;
local math = math;
local json = json;
local log = log;
local fs = fs;
local next = next;
local type = type;
local setmetatable = setmetatable;
local getmetatable = getmetatable;
local assert = assert;
local select = select;
local coroutine = coroutine;
local utf8 = utf8;
local re = re;
local imgui = imgui;
local draw = draw;
local Vector2f = Vector2f;
local reframework = reframework;
local os = os;

local player_manager_name = "app.ropeway.PlayerManager";
local game_clock_name = "app.ropeway.GameClock";

this.player_manager = nil;
this.game_clock = nil;

function this.update()
	this.update_player_manager();
	this.update_game_clock();
end

function this.update_player_manager()
	this.player_manager = sdk.get_managed_singleton(player_manager_name);
	if this.player_manager == nil then
		error_handler.report("[singletons.update_player_manager] No PlayerManager");
	end

	return this.player_manager;
end

function this.update_game_clock()
	this.game_clock = sdk.get_managed_singleton(game_clock_name);
	if this.game_clock == nil then
		error_handler.report("[singletons.update_game_clock] No GameClock");
	end

	return this.game_clock;
end

function this.init_module()
	error_handler = require("Damage_Numbers.error_handler");

	this.update();
end

return this;
