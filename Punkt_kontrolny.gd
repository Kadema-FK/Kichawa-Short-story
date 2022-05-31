extends Control

onready var tekst = get_parent().get_node("Dialog").scena1
var zszokowana_chawa = preload("res://grafiki/Chawa_Chibi.png")
var smutna_chawa = preload("res://grafiki/Chawa.png")

var dialog_indeks = 0
var zakonczone
var aktywne

var imie

var pozycja
var nastroj

func _ready():
	poznajImie()
	
	

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
				if nastroj == "Smutny":
					$Chawa.texture = smutna_chawa
				else:
					$Chawa.texture = zszokowana_chawa
				
		if $Opcja1.text == "":
			$Opcja1.visible = false
		else:
			$Opcja1.visible = true
		
		if $Opcja2.text == "":
			$Opcja2.visible = false
		else:
			$Opcja2.visible = true

func poznajImie():
	$Wprowadz_imie.visible = true
	$TextBox.visible = true
	$TextBox/RichTextLabel.bbcode_text="Podaj swe imię i wejdź"


func wczytajDialog():
	if dialog_indeks < tekst.size():
		aktywne = true
		zakonczone = false
		
		$TextBox.visible = true
		$TextBox/RichTextLabel.bbcode_text=tekst[dialog_indeks]["Tekst"].replace("{{imie}}",imie)
		$TextBox/Label.text = tekst[dialog_indeks]["Imie"]
		$Opcja1.text = tekst[dialog_indeks]["Wybor"][0]
		$Opcja2.text = tekst[dialog_indeks]["Wybor"][1]
		
		pozycja = tekst[dialog_indeks]["Pozycja"]
		nastroj = tekst[dialog_indeks]["Nastroj"]
		
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


func _on_Wprowadz_imie_text_entered(new_text):
	$Wprowadz_imie.visible = false
	imie = new_text
	wczytajDialog()
