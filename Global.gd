extends Node

var test = false
var musicaActiva = false
var animacionBossHecha = false
var inicioNivel = false
var positionCheckPoint 
var tocoElCheckPoint = false
onready var musicaDeFondo = $MusicaDeFondo

func desactivarMusica():
	musicaActiva = false
	musicaDeFondo.playing = false
	
func activarMusica():
	musicaActiva = true
	musicaDeFondo.playing = true
