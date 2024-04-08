local this = {};

local utils;
local singletons;
local config;
local customization_menu;
local enemy_handler;
local time;
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

this.player = {};
this.player.position = Vector3f.new(0, 0, 0);
this.player.is_aiming = false;

local player_manager_type_def = sdk.find_type_definition("app.ropeway.PlayerManager");
local get_current_position_method = player_manager_type_def:get_method("get_CurrentPosition");
local get_current_player_condition_method = player_manager_type_def:get_method("get_CurrentPlayerCondition");

local player_condition_type_def = sdk.find_type_definition("app.ropeway.survivor.player.PlayerCondition");
local get_is_hold_method = player_condition_type_def:get_method("get_IsHold");

function this.tick()
	local player_manager = singletons.player_manager;

	if player_manager == nil then
		error_handler.report("player_handler.tick", "No PlayerManager");
		return;
	end

	this.update_position(player_manager);
end

function this.update()
	local player_manager = singletons.player_manager;

	if player_manager == nil then
		error_handler.report("player_handler.update", "No PlayerManager");
		return;
	end

	this.update_is_aiming(player_manager);
end

function this.update_position(player_manager)
	local position = get_current_position_method:call(player_manager);

	if position == nil then
		error_handler.report("player_handler.update_position", "No Position");
		return;
	end

	this.player.position = position;
end

function this.update_is_aiming(player_manager)
	local player_condition = get_current_player_condition_method:call(player_manager);
	if player_condition == nil then
		error_handler.report("player_handler.update_is_aiming", "No PlayerCondition");
		return;
	end

	local is_hold = get_is_hold_method:call(player_condition);

	if is_hold == nil then
		error_handler.report("player_handler.update_is_aiming", "No IsHold");
		return;
	end

	this.player.is_aiming = is_hold;
end


function this.init_module()
	singletons = require("Damage_Numbers.singletons");
	customization_menu = require("Damage_Numbers.customization_menu");
	error_handler = require("Damage_Numbers.error_handler");
end

return this;