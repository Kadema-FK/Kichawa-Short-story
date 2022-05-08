extends Control

onready var tekst = get_parent().get_node("Dialog").scena1

var dialog_indeks = 0
var zakonczone
var aktywne

var pozycja
var nastroj

func _ready():
	wczytajDialog()
	

func _physics_process(_delta):
	if aktywne:
		if Input.is_action_just_pressed("ui_accept"):
			if zakonczone == true:
				wczytajDialog()
			else:
				$TextBox/Tween.stop_all()
				$TextBox/RichTextLabel.percent_visible = 1
				zakonczone = true
				
		if $TextBox/Label.text == "Kifo": #Zmienić na słownik?
			$Kifo.visible = true
			if pozycja != "":
				$Kifo.global_position = get_parent().get_node(pozycja).position

		if $TextBox/Label.text == "Chawa": #Zmienić na słownik?
			$Chawa.visible = true
			if pozycja != "":
				$Chawa.global_position = get_parent().get_node(pozycja).position
				
		if $Opcja1.text == "":
			$Opcja1.visible = false
		else:
			$Opcja1.visible = true
		
		if $Opcja2.text == "":
			$Opcja2.visible = false
		else:
			$Opcja2.visible = true


func wczytajDialog():
	if dialog_indeks < tekst.size():
		aktywne = true
		zakonczone = false
		
		$TextBox.visible = true
		$TextBox/RichTextLabel.bbcode_text=tekst[dialog_indeks]["Tekst"]
		$TextBox/Label.text = tekst[dialog_indeks]["Imie"]
		$Opcja1.text = tekst[dialog_indeks]["Wybor"][0]
		$Opcja2.text = tekst[dialog_indeks]["Wybor"][1]
		
		
		pozycja = tekst[dialog_indeks]["Pozycja"]
		
		$TextBox/RichTextLabel.percent_visible = 0
		$TextBox/Tween.interpolate_property(
			$TextBox/RichTextLabel, "percent_visible", 0, 1, 2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$TextBox/Tween.start()
	else:
		$TextBox.visible = false
		zakonczone = true
		aktywne = false
	dialog_indeks += 1
		


func _on_Tween_tween_completed(_object, _key):
	zakonczone = true


func _on_Opcja1_pressed():
	if $Opcja1.text == "opcja1":
		$Opcja1.text = ""
		$Opcja2.text = ""
		tekst = get_parent().get_node("Dialog").scena2
		dialog_indeks = 0
		wczytajDialog()


func _on_Opcja2_pressed():
	if $Opcja2.text == "opcja2":
		$Opcja1.text = ""
		$Opcja2.text = ""
		tekst = get_parent().get_node("Dialog").scena3
		dialog_indeks = 0
		wczytajDialog()
