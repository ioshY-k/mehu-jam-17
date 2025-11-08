# camera_shake.gd
# Attach to a Camera2D node (Godot 4)
extends Camera2D

@export_category("Shake")
@export_range(0.01, 1.0, 0.01) var default_step := 0.05
@export var default_duration := 0.4
@export var default_magnitude := 12.0    # in pixels
@export var default_max_zoom := 0.08     # relative zoom variance

var _rng := RandomNumberGenerator.new()
var _shaking := false

func _ready():
	_rng.randomize()

# Public helper: einfache Aufrufsignatur
func shake_simple():
	shake(default_duration, default_magnitude, default_max_zoom, default_step)

# Hauptfunktion — asynchron (await) — führt den Shake aus
# duration: Gesamtzeit in Sekunden
# magnitude: maximale Positionsabweichung (px)
# max_zoom: maximale Abweichung am Zoom (absolute addition, z.B. 0.08)
# step: Dauer eines einzelnen "Sub-Tweens" (kleiner = schnelleres Rumble)
func shake(duration: float, magnitude: float = 12.0, max_zoom: float = 0.08, step: float = 0.05) -> void:
	if _shaking:
		# Wenn bereits shake läuft, optional: abbrechen und neu starten
		# Du kannst stattdessen auch return setzen, wenn du Overlap vermeiden willst.
		_shaking = false
		await get_tree().process_frame  # kurzer Break, damit laufende Tweens stoppen können

	_shaking = true
	var start_pos := position
	var start_zoom := zoom
	var elapsed := 0.0

	while elapsed < duration and _shaking:
		# zufälliges nächstes Ziel (position + zoom)
		var target_pos := start_pos + Vector2(
			_rng.randf_range(-magnitude, magnitude),
			_rng.randf_range(-magnitude, magnitude)
		)
		# Zoom als Vector2 (gleiche x/y)
		var zoom_variation := _rng.randf_range(-max_zoom, max_zoom)
		var target_zoom := start_zoom + Vector2(zoom_variation, zoom_variation)

		# Erstelle Tween für diese "Schüttel-Iteration"
		var tw := create_tween()
		tw.tween_property(self, "position", target_pos, step).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tw.tween_property(self, "zoom", target_zoom, step).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

		# warte bis diese Iteration fertig
		await tw.finished

		elapsed += step

	# Rückkehr zur Ausgangsposition mit einem kurzen Tween (glättet das Ende)
	if _shaking:
		var end_tw := create_tween()
		end_tw.tween_property(self, "position", start_pos, 0.12).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		end_tw.tween_property(self, "zoom", start_zoom, 0.12).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		await end_tw.finished

	_shaking = false

# Optional: Stoppe einen laufenden Shake sofort und bring Kamera zurück
func stop_shake(immediate: bool = false) -> void:
	_shaking = false
	if immediate:
		position = position  # bleibt, oder setze auf Startwert falls gespeichert
		# Wenn du Startwert zwischenspeicherst, kannst du ihn hier wiederherstellen.
