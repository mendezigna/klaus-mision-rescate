extends Node

var test = false
var musicaActiva = false
var animacionBossHecha = false
var inicioNivel = false
var positionCheckPoint 
var tocoElCheckPoint = false
var mute = false
var nivelBoss = false
onready var musicaDeFondo = $MusicaDeFondo

func desactivarMusica():
	musicaActiva = false
	musicaDeFondo.playing = false
	
func activarMusica():
	musicaActiva = true
	musicaDeFondo.playing = true
	musicaDeFondo.stream_paused = false

func stopMusica():
	musicaDeFondo.stream_paused = true
	
func playMusica():
	musicaDeFondo.stream_paused = false
