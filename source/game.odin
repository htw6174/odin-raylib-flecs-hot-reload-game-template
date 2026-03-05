package game

import "core:fmt"
import "core:math"
import "core:math/linalg"
import ecs "flecs"
import "sim"
import rl "vendor:raylib"

TARGET_FPS :: 60
PIXEL_WINDOW_WIDTH :: 640
PIXEL_WINDOW_HEIGHT :: 480

Game_Memory :: struct {
	run:              bool, // Only mandatory field, needed by harness
	sim_run:          bool,
	tick_to_real:     f32,
	time_accumulator: f32,
	sim_state:        sim.State,
	camera_pos:       [3]f32,
	camera_zoom:      f32,
	world_camera:     rl.Camera3D,
	world_ui_camera:  rl.Camera2D,
	ui_camera:        rl.Camera2D,
	textures:         [dynamic]rl.Texture,
	// queries for access to sim data
	pos_q:            ^ecs.Query,
}

g: ^Game_Memory

init :: proc() {
	g = new(Game_Memory)
	g^ = Game_Memory {
		run          = true,
		textures     = make([dynamic]rl.Texture, 0),
		tick_to_real = 1.0 / 60,
		sim_run      = true,
		sim_state    = sim.make(),
	}

	sim.init(&g.sim_state)
	append(&g.textures, rl.LoadTexture("assets/round_cat.png"))

	g.pos_q = ecs.query_init(
		g.sim_state.world,
		&{terms = {0 = {id = ecs.id(g.sim_state.world, sim.Position)}}},
	)
}

fini :: proc() {
	delete(g.textures)
	sim.delete(&g.sim_state)
	free(g)
}

update :: proc() {
	s := &g.sim_state

	dT := rl.GetFrameTime()
	if g.sim_run {
		g.time_accumulator += dT
		for g.time_accumulator >= g.tick_to_real {
			sim.step(s)
			g.time_accumulator -= g.tick_to_real
		}
	} else {
		// manually run system for flecs REST module to update web UI
		rest_system := ecs.lookup(s.world, "flecs.rest.DequeueRest")
		ecs.run(s.world, rest_system, dT, nil)
	}
	interp := g.time_accumulator / g.tick_to_real

	input()
	draw(interp)
}

input :: proc() {
	dt := min(rl.GetFrameTime(), 1. / TARGET_FPS)

	if rl.IsKeyPressed(.ESCAPE) {
		g.run = false
	}

	move: rl.Vector2

	if rl.IsKeyDown(.UP) || rl.IsKeyDown(.W) {
		move.y -= 1
	}
	if rl.IsKeyDown(.DOWN) || rl.IsKeyDown(.S) {
		move.y += 1
	}
	if rl.IsKeyDown(.LEFT) || rl.IsKeyDown(.A) {
		move.x -= 1
	}
	if rl.IsKeyDown(.RIGHT) || rl.IsKeyDown(.D) {
		move.x += 1
	}

	if rl.IsKeyPressed(.SPACE) {
		g.sim_run = !g.sim_run
	}

	wheel := rl.GetMouseWheelMove()
	if wheel != 0 {
		g.camera_zoom += wheel * 0.5
	}

	move = linalg.normalize0(move)
	g.camera_pos.xy += move * dt * 100 * math.exp(-g.camera_zoom)
	g.camera_pos.z = -100
}

draw :: proc(sim_state_interp: f32) {
	rl.BeginDrawing()
	defer rl.EndDrawing()
	rl.ClearBackground(rl.BLACK)

	s := g.sim_state

	world: {
		g.world_camera = world_camera()
		rl.BeginMode3D(g.world_camera)
		defer rl.EndMode3D()

		// Draw entities as 3D billboards
		it := ecs.query_iter(s.world, g.pos_q)
		tex := g.textures[0]
		for ecs.query_next(&it) {
			pos_p := ecs.field(&it, sim.Position, 0)
			for i in 0 ..< it.count {
				pos := pos_p[i]
				rl.DrawBillboardPro(
					g.world_camera,
					tex,
					{0, 0, f32(tex.width), f32(tex.height)},
					{pos.x, pos.y, 0},
					{0, -1, 0},
					{10, 10},
					{5, 5},
					0,
					rl.WHITE,
				)
			}
		}
	}

	world_ui: {
		g.world_ui_camera = world_ui_camera()
		rl.BeginMode2D(g.world_ui_camera)
		defer rl.EndMode2D()

		mouse_world_pos := rl.GetScreenToWorld2D(rl.GetMousePosition(), g.world_ui_camera)

		//
		rl.DrawTextureV(g.textures[0], mouse_world_pos, rl.WHITE)

		// Draw name labels on entities
		it := ecs.query_iter(s.world, g.pos_q)
		for ecs.query_next(&it) {
			pos_p := ecs.field(&it, sim.Position, 0)
			for i in 0 ..< it.count {
				pos := pos_p[i]
				id := ([^]ecs.Entity)(it.entities)[i]
				name := ecs.get_name(s.world, id)
				if name == nil do name = fmt.ctprint(id)
				rl.DrawTextEx(rl.GetFontDefault(), name, {pos.x, pos.y}, 10, 1, rl.WHITE)
			}
		}
	}

	screen_ui: {
		ui_cam := ui_camera()
		rl.BeginMode2D(ui_cam)
		defer rl.EndMode2D()

		rl.DrawFPS(5, 5)
	}
}

world_camera :: proc() -> rl.Camera3D {
	//w := f32(rl.GetScreenWidth())
	h := f32(rl.GetScreenHeight())

	return {
		position = g.camera_pos,
		target = {g.camera_pos.x, g.camera_pos.y, g.camera_pos.z + 100},
		up = {0, -1, 0},
		fovy = math.exp(-g.camera_zoom) * h / (h / PIXEL_WINDOW_HEIGHT),
		projection = .ORTHOGRAPHIC,
	}
}

world_ui_camera :: proc() -> rl.Camera2D {
	w := f32(rl.GetScreenWidth())
	h := f32(rl.GetScreenHeight())

	return {
		zoom = math.exp(g.camera_zoom) * h / PIXEL_WINDOW_HEIGHT,
		target = g.camera_pos.xy,
		offset = {w / 2, h / 2},
	}
}

ui_camera :: proc() -> rl.Camera2D {
	return {zoom = f32(rl.GetScreenHeight()) / PIXEL_WINDOW_HEIGHT}
}
