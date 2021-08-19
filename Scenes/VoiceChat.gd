extends Node2D

onready var voice = $VoiceOrchestrator

func _ready():
	voice.connect("received_voice_data", self, "_received_voice_data")
	voice.connect("sent_voice_data", self, "_sent_voice_data")

func _on_SpeakButton_pressed():
	voice.recording = true

func _received_voice_data(data: PoolRealArray, id: int) -> void:
	print(id)
	print("recibiendo")

func _sent_voice_data(data: PoolRealArray, id) -> void:
	print("enviando a ", id)
