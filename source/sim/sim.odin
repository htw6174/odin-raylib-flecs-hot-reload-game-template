package sim
import ecs "../flecs"
// import "core:math"
// import "core:math/linalg"
import "core:math/rand"

// Sim timesteps always represent a fixed time interval. Use to convert to seconds for rendering and set speeds based on seconds.
STEPS_PER_SECOND :: 60

State :: struct {
	step:  int,
	world: ^ecs.World,
}

// NB: non-struct aliased types must be distinct to get a unique component ID
Position :: distinct [2]f32
Velocity :: distinct [2]f32

Stats :: struct {
	str: int,
	agi: int,
	int: int,
}

make :: proc(allocator := context.allocator) -> State {
	return {}
}

delete :: proc(s: ^State) {
	ecs.fini(s.world)
}

copy :: proc(dst: ^State, src: ^State) {
	// TODO copy world stste
}

init :: proc(s: ^State) {
	s.step = 0
	s.world = ecs.init()
	ecs.import_module(s.world, ecs.FlecsRestImport, "FlecsRest")
	ecs.set_id(
		s.world,
		ecs.FLECS_IDEcsRestID_,
		ecs.FLECS_IDEcsRestID_,
		size_of(ecs.Ecs_Rest),
		&ecs.Ecs_Rest{},
	)

	w := s.world
	_ = ecs.component(w, Stats)
	_ = ecs.component(w, Position)
	_ = ecs.component(w, Velocity)
	scope := ecs.set_name(w, 0, "Dudes")
	for i in 0 ..< 100 {
		_ = i
		e := ecs.new(w)
		ecs.set(w, e, &Position{rand.float32_range(-100, 100), rand.float32_range(-100, 100)})
		ecs.set(w, e, &Velocity{rand.float32_range(-100, 100), rand.float32_range(-100, 100)})
		ecs.add_pair(w, e, ecs.EcsChildOf, scope)
	}

	_ = ecs.system(w, system_move, ecs.EcsOnUpdate, "Position, Velocity")
}

step :: proc(s: ^State) {
	s.step += 1
	ecs.progress(s.world, 1.0 / STEPS_PER_SECOND)
}

system_move :: proc "c" (it: ^ecs.Iter) {
	pos := ecs.field(it, Position, 0)
	vel := ecs.field(it, Velocity, 1)
	for i in 0 ..< it.count {
		pos[i].xy += vel[i].xy * it.delta_time
		if pos[i].x < -100 || pos[i].x > 100 {
			vel[i].x *= -1
		}
		if pos[i].y < -100 || pos[i].y > 100 {
			vel[i].y *= -1
		}
	}
}

CheckCollisionRects :: proc(pos1, size1, pos2, size2: [2]f32) -> bool {
	return(
		(pos1.x < (pos2.x + size2.x) && (pos1.x + size1.x) > pos2.x) &&
		(pos1.y < (pos2.y + size2.y) && (pos1.y + size1.y) > pos2.y) \
	)
}
