extends Node

var test = false
var musicaActiva = false
var animacionBossHecha = false

func desactivarMusica():
	musicaActiva = false
	$MusicaDeFondo.playing = false
	
func activarMusica():
	musicaActiva = true
	$MusicaDeFondo.playing = true
