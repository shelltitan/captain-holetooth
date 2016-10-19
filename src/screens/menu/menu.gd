
extends Control

# Game Title
export (NodePath) var game_title_path
onready var game_title = get_node(game_title_path)

# Menu Buttons
export (NodePath) var menu_buttons_path
onready var menu_buttons = get_node(menu_buttons_path)

# Options Screen
export (NodePath) var options_screen_path
onready var options_screen = get_node(options_screen_path)

# Music Player
export (NodePath) var music_player_path
onready var music_player = get_node(music_player_path)

# Music Volume Slider
export (NodePath) var music_volume_slider_path
onready var music_volume_slider = get_node(music_volume_slider_path)

# Current Language Locale
var current_locale = TranslationServer.get_locale()


# -- START --
func _ready():
	# Update music player volume the initial music volume stored in global
	music_volume_slider.set_value(global.music.volume * 100)
	
	# Updates locale on scene
	update_locale()


# -- BUTTON PRESSES --
# Start Game
func _on_startbutton_pressed():
	transition.fade_to("res://src/screens/intro/intro.tscn")

# Options
func _on_optionsbutton_pressed():
	options_screen.show()

# Exit
func _on_exitbutton_pressed():
	options_screen.hide()

# Close Options
func _on_btn_close_options_pressed():
	options_screen.hide()

# Change Language to German
func _on_de_button_pressed():
	TranslationServer.set_locale("de_DE")
	get_tree().reload_current_scene()

# Change Language to English
func _on_en_button_pressed():
	TranslationServer.set_locale("en_GB")
	get_tree().reload_current_scene()


# -- LOCALE / LANGUAGES --
# Updates all locale on Main Menu according to current_locale selected
func update_locale():
	# Update Locale Text
	menu_buttons.get_node("startbutton").set_text(tr("KEY_START"))
	menu_buttons.get_node("optionsbutton").set_text(tr("KEY_OPTIONS"))
	options_screen.get_node("settings").set_tab_title(0, tr("KEY_GENERAL_INFO"))
	options_screen.get_node("settings").set_tab_title(1, tr("KEY_AUDIO"))
	options_screen.get_node("settings").set_tab_title(2, tr("KEY_DEBUG"))
	options_screen.get_node("settings").set_tab_title(3, tr("KEY_CREDITS"))
	
	# Setup Language buttons
	# - German
	if current_locale == "de_DE":
		var tex_de = ResourceLoader.load("res://src/screens/menu/scn1_menu_gametitle_DE.tex")
		game_title.set_texture(tex_de)
	
	# - English
	if current_locale == "en_GB":
		var tex_en = ResourceLoader.load("res://src/screens/menu/scn1_menu_gametitle_EN.tex")
		game_title.set_texture(tex_en)


# -- MUSIC --
# Updates global music volume when slider has been changed
func _on_music_volume_value_changed( value ):
	# Set global music volume
	global.music.volume = value/100
	
	# Update music player volume
	music_player.set_volume(global.music.volume)


# -- DEBUG --
# DEBUG: Jump to scene 3
func _on_jump_scn3_pressed():
	print("Debug: Jumping to Scene 3")
	transition.fade_to("res://src/levels/forest/forest.tscn")

# DEBUG: Jump to scene 4
func _on_jump_scn4_pressed():
	print("Debug: Jumping to Scene 4")
	transition.fade_to("res://src/levels/mountain/mountain.tscn")

# DEBUG: Jump to scene 5
func _on_jump_scn5_pressed():
	print("Debug: Jumping to Scene 5")
	transition.fade_to("res://src/levels/flyhome/flyhome.tscn")

# DEBUG: Jump to minigame
func _on_jump_minigame_pressed():
	print("Debug: Jumping to minigame")
	transition.fade_to("res://src/levels/yan-kandy-minigame/prototype.tscn")

func _on_jump_castle_pressed():
	print("Debug: Jumping to minigame")
	transition.fade_to("res://src/levels/castle/castle.tscn")
