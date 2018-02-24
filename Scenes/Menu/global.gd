extends Node

const MENU_MUSIC = preload ("res://Music/dangerous_hills.ogg")

var level = 0
var unlocked_levels = 1
var onscreen_controls = true

func release_all():
	pass

func _ready():
	load_game()	
	
	
func toggle_on_screen_buttons(pressed):
	onscreen_controls = pressed	
	save_game()

func save_game(): 
	print ("saving")
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var data = {
		unlocked_levels=unlocked_levels,
		onscreen_controls=onscreen_controls
	}
	save_game.store_line(data.to_json())
	save_game.close()	
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error!  We don't have a save to load.
	save_game.open("user://savegame.save", File.READ)		
	
	print ("Load save")
	var current_line = {}	
	
	current_line.parse_json(save_game.get_line())	
	unlocked_levels = current_line["unlocked_levels"]
	
	#current_line.parse_json(save_game.get_line())
	onscreen_controls = current_line["onscreen_controls"]
	
	