extends Node

var test = false
var musicaActiva = false
var animacionBossHecha = false
var inicioNivel = false
var positionCheckPoint 

func desactivarMusica():
	musicaActiva = false
	$MusicaDeFondo.playing = false
	
func activarMusica():
	musicaActiva = true
	$MusicaDeFondo.playing = true
