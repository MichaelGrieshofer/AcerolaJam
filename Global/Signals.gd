extends Node

signal player_entered_mech
signal player_left_mech

signal player_entered_area_without_mech

signal place_mech(pos)
signal place_player(pos)
signal pilot_mech

signal save_scene_path

signal set_camera_limits(left,top,right,bottom)

signal refill_player_health

#UI

signal player_health_changed
signal max_player_health_changed
signal mech_health_changed
signal max_mech_health_changed
signal mech_fuel_changed
signal max_mech_fuel_changed

signal update_player_max_health
signal update_mech_max_health
signal update_mech_fuel

