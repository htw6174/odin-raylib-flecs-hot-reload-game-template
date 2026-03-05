// Comment out this line when using as DLL
package flecs

import "core:c"

foreign import lib "lib/libflecs.so"
_ :: lib

/**
* @defgroup c C API
*
* @{
* @}
*/

/**
* @defgroup core Core
* @ingroup c
* Core ECS functionality (entities, storage, queries).
*
* @{
*/

/**
* @defgroup options API defines
* Defines for customizing compile time features.
*
* @{
*/

/* Flecs version macros */
FLECS_VERSION_MAJOR    :: 4  /**< Flecs major version. */
FLECS_VERSION_MINOR    :: 1  /**< Flecs minor version. */
FLECS_VERSION_PATCH    :: 4  /**< Flecs patch version. */
FLECS_HI_COMPONENT_ID  :: 256
FLECS_HI_ID_RECORD_ID  :: 1024
FLECS_SPARSE_PAGE_BITS :: 6
FLECS_ENTITY_PAGE_BITS :: 10
FLECS_ID_DESC_MAX      :: 32
FLECS_EVENT_DESC_MAX   :: 8

/** @def FLECS_VARIABLE_COUNT_MAX
* Maximum number of query variables per query */
FLECS_VARIABLE_COUNT_MAX       :: 64
FLECS_TERM_COUNT_MAX           :: 32
FLECS_TERM_ARG_COUNT_MAX       :: 16
FLECS_QUERY_VARIABLE_COUNT_MAX :: 64
FLECS_QUERY_SCOPE_NESTING_MAX  :: 8
FLECS_DAG_DEPTH_MAX            :: 128

/** @def FLECS_TREE_SPAWNER_DEPTH_CACHE_SIZE
* Size of depth cache in tree spawner component. Higher values speed up prefab
* instantiation for deeper hierarchies, at the cost of slightly more memory.
*/
FLECS_TREE_SPAWNER_DEPTH_CACHE_SIZE :: (6)

////////////////////////////////////////////////////////////////////////////////
//// World flags
////////////////////////////////////////////////////////////////////////////////
EcsWorldQuitWorkers           :: (1<<0)
EcsWorldReadonly              :: (1<<1)
EcsWorldInit                  :: (1<<2)
EcsWorldQuit                  :: (1<<3)
EcsWorldFini                  :: (1<<4)
EcsWorldMeasureFrameTime      :: (1<<5)
EcsWorldMeasureSystemTime     :: (1<<6)
EcsWorldMultiThreaded         :: (1<<7)
EcsWorldFrameInProgress       :: (1<<8)

////////////////////////////////////////////////////////////////////////////////
//// OS API flags
////////////////////////////////////////////////////////////////////////////////
EcsOsApiHighResolutionTimer   :: (1<<0)
EcsOsApiLogWithColors         :: (1<<1)
EcsOsApiLogWithTimeStamp      :: (1<<2)
EcsOsApiLogWithTimeDelta      :: (1<<3)

////////////////////////////////////////////////////////////////////////////////
//// Entity flags (set in upper bits of ecs_record_t::row)
////////////////////////////////////////////////////////////////////////////////
EcsEntityIsId                 :: (1<<31)
EcsEntityIsTarget             :: (1<<30)
EcsEntityIsTraversable        :: (1<<29)
EcsEntityHasDontFragment      :: (1<<28)

////////////////////////////////////////////////////////////////////////////////
//// Id flags (used by ecs_component_record_t::flags)
////////////////////////////////////////////////////////////////////////////////
EcsIdOnDeleteRemove            :: (1<<0)
EcsIdOnDeleteDelete            :: (1<<1)
EcsIdOnDeletePanic             :: (1<<2)
EcsIdOnDeleteMask             :: (EcsIdOnDeletePanic|EcsIdOnDeleteRemove|EcsIdOnDeleteDelete)
EcsIdOnDeleteTargetRemove      :: (1<<3)
EcsIdOnDeleteTargetDelete      :: (1<<4)
EcsIdOnDeleteTargetPanic       :: (1<<5)
EcsIdOnDeleteTargetMask       :: (EcsIdOnDeleteTargetPanic|EcsIdOnDeleteTargetRemove|EcsIdOnDeleteTargetDelete)
EcsIdOnInstantiateOverride     :: (1<<6)
EcsIdOnInstantiateInherit      :: (1<<7)
EcsIdOnInstantiateDontInherit  :: (1<<8)
EcsIdOnInstantiateMask        :: (EcsIdOnInstantiateOverride|EcsIdOnInstantiateInherit|EcsIdOnInstantiateDontInherit)
EcsIdExclusive                 :: (1<<9)
EcsIdTraversable               :: (1<<10)
EcsIdPairIsTag                 :: (1<<11)
EcsIdWith                      :: (1<<12)
EcsIdCanToggle                 :: (1<<13)
EcsIdIsTransitive              :: (1<<14)
EcsIdInheritable               :: (1<<15)
EcsIdHasOnAdd                  :: (1<<16) /* Same values as table flags */
EcsIdHasOnRemove               :: (1<<17)
EcsIdHasOnSet                  :: (1<<18)
EcsIdHasOnTableCreate          :: (1<<19)
EcsIdHasOnTableDelete          :: (1<<20)
EcsIdSparse                    :: (1<<21)
EcsIdDontFragment              :: (1<<22)
EcsIdMatchDontFragment         :: (1<<23) /* For (*, T) wildcards */
EcsIdOrderedChildren           :: (1<<24)
EcsIdSingleton                 :: (1<<25)
EcsIdEventMask                :: (EcsIdHasOnAdd|EcsIdHasOnRemove|EcsIdHasOnSet|EcsIdHasOnTableCreate|EcsIdHasOnTableDelete|EcsIdSparse|EcsIdOrderedChildren)
EcsIdPrefabChildren            :: (1<<26)
EcsIdMarkedForDelete           :: (1<<30)

////////////////////////////////////////////////////////////////////////////////
//// Bits set in world->non_trivial array
////////////////////////////////////////////////////////////////////////////////
EcsNonTrivialIdSparse          :: (1<<0)
EcsNonTrivialIdNonFragmenting  :: (1<<1)
EcsNonTrivialIdInherit         :: (1<<2)

////////////////////////////////////////////////////////////////////////////////
//// Iterator flags (used by ecs_iter_t::flags)
////////////////////////////////////////////////////////////////////////////////
EcsIterIsValid                 :: (1<<0)  /* Does iterator contain valid result */
EcsIterNoData                  :: (1<<1)  /* Does iterator provide (component) data */
EcsIterNoResults               :: (1<<2)  /* Iterator has no results */
EcsIterMatchEmptyTables        :: (1<<3)  /* Match empty tables */
EcsIterIgnoreThis              :: (1<<4)  /* Only evaluate non-this terms */
EcsIterTrivialChangeDetection  :: (1<<5)
EcsIterHasCondSet              :: (1<<6)  /* Does iterator have conditionally set fields */
EcsIterProfile                 :: (1<<7)  /* Profile iterator performance */
EcsIterTrivialSearch           :: (1<<8)  /* Trivial iterator mode */
EcsIterTrivialTest             :: (1<<11) /* Trivial test mode (constrained $this) */
EcsIterTrivialCached           :: (1<<14) /* Trivial search for cached query */
EcsIterCached                  :: (1<<15) /* Cached query */
EcsIterFixedInChangeComputed   :: (1<<16) /* Change detection for fixed in terms is done */
EcsIterFixedInChanged          :: (1<<17) /* Fixed in terms changed */
EcsIterSkip                    :: (1<<18) /* Result was skipped for change detection */
EcsIterCppEach                 :: (1<<19) /* Uses C++ 'each' iterator */
EcsIterImmutableCacheData      :: (1<<21) /* Internally used by engine to indicate immutable arrays from cache */

/* Same as event flags */
EcsIterTableOnly               :: (1<<20)  /* Result only populates table */

////////////////////////////////////////////////////////////////////////////////
//// Event flags (used by ecs_event_decs_t::flags)
////////////////////////////////////////////////////////////////////////////////
EcsEventTableOnly              :: (1<<20) /* Table event (no data, same as iter flags) */
EcsEventNoOnSet                :: (1<<16) /* Don't emit OnSet for inherited ids */

////////////////////////////////////////////////////////////////////////////////
//// Query flags (used by ecs_query_t::flags)
////////////////////////////////////////////////////////////////////////////////

/* Flags that can only be set by the query implementation */
EcsQueryMatchThis             :: (1<<11) /* Query has terms with $this source */
EcsQueryMatchOnlyThis         :: (1<<12) /* Query only has terms with $this source */
EcsQueryMatchOnlySelf         :: (1<<13) /* Query has no terms with up traversal */
EcsQueryMatchWildcards        :: (1<<14) /* Query matches wildcards */
EcsQueryMatchNothing          :: (1<<15) /* Query matches nothing */
EcsQueryHasCondSet            :: (1<<16) /* Query has conditionally set fields */
EcsQueryHasPred               :: (1<<17) /* Query has equality predicates */
EcsQueryHasScopes             :: (1<<18) /* Query has query scopes */
EcsQueryHasRefs               :: (1<<19) /* Query has terms with static source */
EcsQueryHasOutTerms           :: (1<<20) /* Query has [out] terms */
EcsQueryHasNonThisOutTerms    :: (1<<21) /* Query has [out] terms with no $this source */
EcsQueryHasChangeDetection    :: (1<<22) /* Query has monitor for change detection */
EcsQueryIsTrivial             :: (1<<23) /* Query can use trivial evaluation function */
EcsQueryHasCacheable          :: (1<<24) /* Query has cacheable terms */
EcsQueryIsCacheable           :: (1<<25) /* All terms of query are cacheable */
EcsQueryHasTableThisVar       :: (1<<26) /* Does query have $this table var */
EcsQueryCacheYieldEmptyTables :: (1<<27) /* Does query cache empty tables */
EcsQueryTrivialCache          :: (1<<28) /* Trivial cache (no wildcards, traversal, order_by, group_by, change detection) */
EcsQueryNested                :: (1<<29) /* Query created by a query (for observer, cache) */
EcsQueryCacheWithFilter       :: (1<<30)
EcsQueryValid                 :: (1<<31)

////////////////////////////////////////////////////////////////////////////////
//// Term flags (used by ecs_term_t::flags_)
////////////////////////////////////////////////////////////////////////////////
EcsTermMatchAny               :: (1<<0)
EcsTermMatchAnySrc            :: (1<<1)
EcsTermTransitive             :: (1<<2)
EcsTermReflexive              :: (1<<3)
EcsTermIdInherited            :: (1<<4)
EcsTermIsTrivial              :: (1<<5)
EcsTermIsCacheable            :: (1<<6)
EcsTermIsScope                :: (1<<7)
EcsTermIsMember               :: (1<<8)
EcsTermIsToggle               :: (1<<9)
EcsTermIsSparse               :: (1<<10)
EcsTermIsOr                   :: (1<<11)
EcsTermDontFragment           :: (1<<12)
EcsTermNonFragmentingChildOf  :: (1<<13)

////////////////////////////////////////////////////////////////////////////////
//// Observer flags (used by ecs_observer_t::flags)
////////////////////////////////////////////////////////////////////////////////
EcsObserverMatchPrefab         :: (1<<1)  /* Same as query*/
EcsObserverMatchDisabled       :: (1<<2)  /* Same as query*/
EcsObserverIsMulti             :: (1<<3)  /* Does observer have multiple terms */
EcsObserverIsMonitor           :: (1<<4)  /* Is observer a monitor */
EcsObserverIsDisabled          :: (1<<5)  /* Is observer entity disabled */
EcsObserverIsParentDisabled    :: (1<<6)  /* Is module parent of observer disabled  */
EcsObserverBypassQuery         :: (1<<7)  /* Don't evaluate query for multi-component observer*/
EcsObserverYieldOnCreate       :: (1<<8)  /* Yield matching entities when creating observer */
EcsObserverYieldOnDelete       :: (1<<9)  /* Yield matching entities when deleting observer */
EcsObserverKeepAlive           :: (1<<11) /* Observer keeps component alive (same value as EcsTermKeepAlive) */

////////////////////////////////////////////////////////////////////////////////
//// Table flags (used by ecs_table_t::flags)
////////////////////////////////////////////////////////////////////////////////
EcsTableHasBuiltins            :: (1<<0)  /* Does table have builtin components */
EcsTableIsPrefab               :: (1<<1)  /* Does the table store prefabs */
EcsTableHasIsA                 :: (1<<2)  /* Does the table have IsA relationship */
EcsTableHasMultiIsA            :: (1<<3)  /* Does table have multiple IsA pairs */
EcsTableHasChildOf             :: (1<<4)  /* Does the table type ChildOf relationship */
EcsTableHasParent              :: (1<<5)  /* Does the table type Parent component */
EcsTableHasName                :: (1<<6)  /* Does the table type have (Identifier, Name) */
EcsTableHasPairs               :: (1<<7)  /* Does the table type have pairs */
EcsTableHasModule              :: (1<<8)  /* Does the table have module data */
EcsTableIsDisabled             :: (1<<9)  /* Does the table type has EcsDisabled */
EcsTableNotQueryable           :: (1<<10)  /* Table should never be returned by queries */
EcsTableHasCtors               :: (1<<11)
EcsTableHasDtors               :: (1<<12)
EcsTableHasCopy                :: (1<<13)
EcsTableHasMove                :: (1<<14)
EcsTableHasToggle              :: (1<<15)
EcsTableHasOnAdd               :: (1<<16) /* Same values as id flags */
EcsTableHasOnRemove            :: (1<<17)
EcsTableHasOnSet               :: (1<<18)
EcsTableHasOnTableCreate       :: (1<<19)
EcsTableHasOnTableDelete       :: (1<<20)
EcsTableHasSparse              :: (1<<21)
EcsTableHasDontFragment        :: (1<<22)
EcsTableOverrideDontFragment   :: (1<<23)
EcsTableHasOrderedChildren     :: (1<<24)
EcsTableHasOverrides           :: (1<<25)
EcsTableHasTraversable         :: (1<<27)
EcsTableEdgeReparent           :: (1<<28)
EcsTableMarkedForDelete        :: (1<<29)

/* Composite table flags */
EcsTableHasLifecycle     :: (EcsTableHasCtors|EcsTableHasDtors)
EcsTableIsComplex        :: (EcsTableHasLifecycle|EcsTableHasToggle|EcsTableHasSparse)
EcsTableHasAddActions    :: (EcsTableHasIsA|EcsTableHasCtors|EcsTableHasOnAdd|EcsTableHasOnSet)
EcsTableHasRemoveActions :: (EcsTableHasIsA|EcsTableHasDtors|EcsTableHasOnRemove)
EcsTableEdgeFlags        :: (EcsTableHasOnAdd|EcsTableHasOnRemove|EcsTableHasSparse)
EcsTableAddEdgeFlags     :: (EcsTableHasOnAdd|EcsTableHasSparse)
EcsTableRemoveEdgeFlags  :: (EcsTableHasOnRemove|EcsTableHasSparse|EcsTableHasOrderedChildren)

////////////////////////////////////////////////////////////////////////////////
//// Aperiodic action flags (used by ecs_run_aperiodic)
////////////////////////////////////////////////////////////////////////////////
EcsAperiodicComponentMonitors  :: (1<<2)  /* Process component monitors */
EcsAperiodicEmptyQueries       :: (1<<4)  /* Process empty queries */

/* Utility types to indicate usage as bitmask */
Flags8  :: u8
Flags16 :: u16
Flags32 :: u32
Flags64 :: u64

/* Keep unsigned integers out of the codebase as they do more harm than good */
Size :: i32

////////////////////////////////////////////////////////////////////////////////
//// Magic numbers for sanity checking
////////////////////////////////////////////////////////////////////////////////

/* Magic number to identify the type of the object */
ecs_world_t_magic     :: (0x65637377)
ecs_stage_t_magic     :: (0x65637373)
ecs_query_t_magic     :: (0x65637375)
ecs_observer_t_magic  :: (0x65637362)

////////////////////////////////////////////////////////////////////////////////
//// Entity id macros
////////////////////////////////////////////////////////////////////////////////
ROW_MASK                  :: (0x0FFFFFFF)
ROW_FLAGS_MASK            :: (~u64(ROW_MASK))
ID_FLAGS_MASK             :: (0xF<<60)
ENTITY_MASK               :: (0xFFFFFFFF)
GENERATION_MASK           :: (0xFFFF<<32)
COMPONENT_MASK            :: (~u64(ID_FLAGS_MASK))

/** Ids are the things that can be added to an entity.
* An id can be an entity or pair, and can have optional id flags. */
Id :: u64

/** An entity identifier.
* Entity ids consist out of a number unique to the entity in the lower 32 bits,
* and a counter used to track entity liveliness in the upper 32 bits. When an
* id is recycled, its generation count is increased. This causes recycled ids
* to be very large (>4 billion), which is normal. */
Entity :: Id

/** A type is a list of (component) ids.
* Types are used to communicate the "type" of an entity. In most type systems a
* typeof operation returns a single type. In ECS however, an entity can have
* multiple components, which is why an ECS type consists of a vector of ids.
*
* The component ids of a type are sorted, which ensures that it doesn't matter
* in which order components are added to an entity. For example, if adding
* Position then Velocity would result in type [Position, Velocity], first
* adding Velocity then Position would also result in type [Position, Velocity].
*
* Entities are grouped together by type in the ECS storage in tables. The
* storage has exactly one table per unique type that is created by the
* application that stores all entities and components for that type. This is
* also referred to as an archetype.
*/
Type :: struct {
	array: ^Id, /**< Array with ids. */
	count: i32, /**< Number of elements in array. */
}

World            :: struct {}
Stage            :: struct {}
Table            :: struct {}
Component_Record :: struct {}

/** A poly object.
* A poly (short for polymorph) object is an object that has a variable list of
* capabilities, determined by a mixin table. This is the current list of types
* in the flecs API that can be used as an ecs_poly_t:
*
* - ecs_world_t
* - ecs_stage_t
* - ecs_query_t
*
* Functions that accept an ecs_poly_t argument can accept objects of these
* types. If the object does not have the requested mixin the API will throw an
* assert.
*
* The poly/mixin framework enables partially overlapping features to be
* implemented once, and enables objects of different types to interact with
* each other depending on what mixins they have, rather than their type
* (in some ways it's like a mini-ECS). Additionally, each poly object has a
* header that enables the API to do sanity checking on the input arguments.
*/
Poly   :: struct {}
Mixins :: struct {}

/** Header for ecs_poly_t objects. */
Header :: struct {
	type:     i32,     /**< Magic number indicating which type of flecs object */
	refcount: i32,     /**< Refcount, to enable RAII handles */
	mixins:   ^Mixins, /**< Table with offsets to (optional) mixins */
}

/** A component column. */
Vec :: struct {
	array: rawptr,
	count: i32,
	size:  i32,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	vec_init                      :: proc(allocator: ^Allocator, vec: ^Vec, size: Size, elem_count: i32) ---
	vec_init_w_dbg_info           :: proc(allocator: ^Allocator, vec: ^Vec, size: Size, elem_count: i32, type_name: cstring) ---
	vec_init_if                   :: proc(vec: ^Vec, size: Size) ---
	vec_fini                      :: proc(allocator: ^Allocator, vec: ^Vec, size: Size) ---
	vec_reset                     :: proc(allocator: ^Allocator, vec: ^Vec, size: Size) -> ^Vec ---
	vec_clear                     :: proc(vec: ^Vec) ---
	vec_append                    :: proc(allocator: ^Allocator, vec: ^Vec, size: Size) -> rawptr ---
	vec_remove                    :: proc(vec: ^Vec, size: Size, elem: i32) ---
	vec_remove_ordered            :: proc(v: ^Vec, size: Size, index: i32) ---
	vec_remove_last               :: proc(vec: ^Vec) ---
	vec_copy                      :: proc(allocator: ^Allocator, vec: ^Vec, size: Size) -> Vec ---
	vec_copy_shrink               :: proc(allocator: ^Allocator, vec: ^Vec, size: Size) -> Vec ---
	vec_reclaim                   :: proc(allocator: ^Allocator, vec: ^Vec, size: Size) ---
	vec_set_size                  :: proc(allocator: ^Allocator, vec: ^Vec, size: Size, elem_count: i32) ---
	vec_set_min_size              :: proc(allocator: ^Allocator, vec: ^Vec, size: Size, elem_count: i32) ---
	vec_set_min_size_w_type_info  :: proc(allocator: ^Allocator, vec: ^Vec, size: Size, elem_count: i32, ti: ^Type_Info) ---
	vec_set_min_count             :: proc(allocator: ^Allocator, vec: ^Vec, size: Size, elem_count: i32) ---
	vec_set_min_count_zeromem     :: proc(allocator: ^Allocator, vec: ^Vec, size: Size, elem_count: i32) ---
	vec_set_count                 :: proc(allocator: ^Allocator, vec: ^Vec, size: Size, elem_count: i32) ---
	vec_set_count_w_type_info     :: proc(allocator: ^Allocator, vec: ^Vec, size: Size, elem_count: i32, ti: ^Type_Info) ---
	vec_set_min_count_w_type_info :: proc(allocator: ^Allocator, vec: ^Vec, size: Size, elem_count: i32, ti: ^Type_Info) ---
	vec_grow                      :: proc(allocator: ^Allocator, vec: ^Vec, size: Size, elem_count: i32) -> rawptr ---
	vec_count                     :: proc(vec: ^Vec) -> i32 ---
	vec_size                      :: proc(vec: ^Vec) -> i32 ---
	vec_get                       :: proc(vec: ^Vec, size: Size, index: i32) -> rawptr ---
	vec_first                     :: proc(vec: ^Vec) -> rawptr ---
	vec_last                      :: proc(vec: ^Vec, size: Size) -> rawptr ---
}

/** The number of elements in a single page */
FLECS_SPARSE_PAGE_SIZE :: (1<<FLECS_SPARSE_PAGE_BITS)

Sparse_Page :: struct {
	sparse: ^i32,   /* Sparse array with indices to dense array */
	data:   rawptr, /* Store data in sparse array to reduce  
                                 * indirection and provide stable pointers. */
}

Sparse :: struct {
	dense:          Vec,  /* Dense array with indices to sparse array. The
                              * dense array stores both alive and not alive
                              * sparse indices. The 'count' member keeps
                              * track of which indices are alive. */
	pages:          Vec,  /* Chunks with sparse arrays & data */
	size:           Size, /* Element size */
	count:          i32,  /* Number of alive entries */
	max_id:         u64,  /* Local max index (if no global is set) */
	allocator:      ^Allocator,
	page_allocator: ^Block_Allocator,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Initialize sparse set */
	flecs_sparse_init :: proc(result: ^Sparse, allocator: ^Allocator, page_allocator: ^Block_Allocator, size: Size) ---
	flecs_sparse_fini :: proc(sparse: ^Sparse) ---

	/** Remove all elements from sparse set */
	flecs_sparse_clear :: proc(sparse: ^Sparse) ---

	/** Add element to sparse set, this generates or recycles an id */
	flecs_sparse_add :: proc(sparse: ^Sparse, elem_size: Size) -> rawptr ---

	/** Get last issued id. */
	flecs_sparse_last_id :: proc(sparse: ^Sparse) -> u64 ---

	/** Generate or recycle a new id. */
	flecs_sparse_new_id :: proc(sparse: ^Sparse) -> u64 ---

	/** Remove an element */
	flecs_sparse_remove :: proc(sparse: ^Sparse, size: Size, id: u64) -> bool ---

	/** Remove an element, increase generation */
	flecs_sparse_remove_w_gen :: proc(sparse: ^Sparse, size: Size, id: u64) -> bool ---

	/** Test if id is alive, which requires the generation count to match. */
	flecs_sparse_is_alive :: proc(sparse: ^Sparse, id: u64) -> bool ---

	/** Get value from sparse set by dense id. This function is useful in
	* combination with flecs_sparse_count for iterating all values in the set. */
	flecs_sparse_get_dense :: proc(sparse: ^Sparse, elem_size: Size, index: i32) -> rawptr ---

	/** Get the number of alive elements in the sparse set. */
	flecs_sparse_count :: proc(sparse: ^Sparse) -> i32 ---

	/** Check if sparse set has id */
	flecs_sparse_has :: proc(sparse: ^Sparse, id: u64) -> bool ---

	/** Like get_sparse, but don't care whether element is alive or not. */
	flecs_sparse_get :: proc(sparse: ^Sparse, elem_size: Size, id: u64) -> rawptr ---

	/** Create element by (sparse) id. */
	flecs_sparse_insert :: proc(sparse: ^Sparse, elem_size: Size, id: u64) -> rawptr ---

	/** Get or create element by (sparse) id. */
	flecs_sparse_ensure :: proc(sparse: ^Sparse, elem_size: Size, id: u64, is_new: ^bool) -> rawptr ---

	/** Fast version of ensure, no liveliness checking */
	flecs_sparse_ensure_fast :: proc(sparse: ^Sparse, elem_size: Size, id: u64) -> rawptr ---

	/** Get pointer to ids (alive and not alive). Use with count() or size(). */
	flecs_sparse_ids    :: proc(sparse: ^Sparse) -> ^u64 ---
	flecs_sparse_shrink :: proc(sparse: ^Sparse) ---

	/* Publicly exposed APIs
	* These APIs are not part of the public API and as a result may change without
	* notice (though they haven't changed in a long time). */
	sparse_init      :: proc(sparse: ^Sparse, elem_size: Size) ---
	sparse_add       :: proc(sparse: ^Sparse, elem_size: Size) -> rawptr ---
	sparse_last_id   :: proc(sparse: ^Sparse) -> u64 ---
	sparse_count     :: proc(sparse: ^Sparse) -> i32 ---
	sparse_get_dense :: proc(sparse: ^Sparse, elem_size: Size, index: i32) -> rawptr ---
	sparse_get       :: proc(sparse: ^Sparse, elem_size: Size, id: u64) -> rawptr ---
}

Block_Allocator_Block :: struct {
	memory: rawptr,
	next:   ^Block_Allocator_Block,
}

Block_Allocator_Chunk_Header :: struct {
	next: ^Block_Allocator_Chunk_Header,
}

Block_Allocator :: struct {
	data_size:        i32,
	chunk_size:       i32,
	chunks_per_block: i32,
	block_size:       i32,
	head:             ^Block_Allocator_Chunk_Header,
	block_head:       ^Block_Allocator_Block,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	flecs_ballocator_init     :: proc(ba: ^Block_Allocator, size: Size) ---
	flecs_ballocator_new      :: proc(size: Size) -> ^Block_Allocator ---
	flecs_ballocator_fini     :: proc(ba: ^Block_Allocator) ---
	flecs_ballocator_free     :: proc(ba: ^Block_Allocator) ---
	flecs_balloc              :: proc(allocator: ^Block_Allocator) -> rawptr ---
	flecs_balloc_w_dbg_info   :: proc(allocator: ^Block_Allocator, type_name: cstring) -> rawptr ---
	flecs_bcalloc             :: proc(allocator: ^Block_Allocator) -> rawptr ---
	flecs_bcalloc_w_dbg_info  :: proc(allocator: ^Block_Allocator, type_name: cstring) -> rawptr ---
	flecs_bfree               :: proc(allocator: ^Block_Allocator, memory: rawptr) ---
	flecs_bfree_w_dbg_info    :: proc(allocator: ^Block_Allocator, memory: rawptr, type_name: cstring) ---
	flecs_brealloc            :: proc(dst: ^Block_Allocator, src: ^Block_Allocator, memory: rawptr) -> rawptr ---
	flecs_brealloc_w_dbg_info :: proc(dst: ^Block_Allocator, src: ^Block_Allocator, memory: rawptr, type_name: cstring) -> rawptr ---
	flecs_bdup                :: proc(ba: ^Block_Allocator, memory: rawptr) -> rawptr ---
}

/** Stack allocator for quick allocation of small temporary values */
Stack_Page :: struct {
	data: rawptr,
	next: ^Stack_Page,
	sp:   i16,
	id:   u32,
}

Stack_Cursor :: struct {
	prev:    ^Stack_Cursor,
	page:    ^Stack_Page,
	sp:      i16,
	is_free: bool,
	owner:   ^Stack,
}

Stack :: struct {
	first:        ^Stack_Page,
	tail_page:    ^Stack_Page,
	tail_cursor:  ^Stack_Cursor,
	cursor_count: i32,
}

FLECS_STACK_PAGE_OFFSET :: (Size)((((((c.size_t)(size_of(Stack_Page)))-1)/((c.size_t)(16)))+1)*((c.size_t)(16)))
FLECS_STACK_PAGE_SIZE   :: (1024-FLECS_STACK_PAGE_OFFSET)

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	flecs_stack_init           :: proc(stack: ^Stack) ---
	flecs_stack_fini           :: proc(stack: ^Stack) ---
	flecs_stack_alloc          :: proc(stack: ^Stack, size: Size, align: Size) -> rawptr ---
	flecs_stack_calloc         :: proc(stack: ^Stack, size: Size, align: Size) -> rawptr ---
	flecs_stack_free           :: proc(ptr: rawptr, size: Size) ---
	flecs_stack_reset          :: proc(stack: ^Stack) ---
	flecs_stack_get_cursor     :: proc(stack: ^Stack) -> ^Stack_Cursor ---
	flecs_stack_restore_cursor :: proc(stack: ^Stack, cursor: ^Stack_Cursor) ---
}

Map_Data :: u64
Map_Key  :: Map_Data
Map_Val  :: Map_Data

/* Map type */
Bucket_Entry :: struct {
	key:   Map_Key,
	value: Map_Val,
	next:  ^Bucket_Entry,
}

Bucket :: struct {
	first: ^Bucket_Entry,
}

Map :: struct {
	buckets:       ^Bucket,
	bucket_count:  i32,
	count:         u32,
	bucket_shift:  u32,
	allocator:     ^Allocator,
	change_count:  i32,     /* Track modifications while iterating */
	last_iterated: Map_Key, /* Currently iterated element */
}

Map_Iter :: struct {
	_map:         ^Map,
	bucket:       ^Bucket,
	entry:        ^Bucket_Entry,
	res:          ^Map_Data,
	change_count: i32,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Initialize new map. */
	map_init :: proc(_map: ^Map, allocator: ^Allocator) ---

	/** Initialize new map if uninitialized, leave as is otherwise */
	map_init_if :: proc(_map: ^Map, allocator: ^Allocator) ---

	/** Reclaim map memory.  */
	map_reclaim :: proc(_map: ^Map) ---

	/** Deinitialize map. */
	map_fini :: proc(_map: ^Map) ---

	/** Get element for key, returns NULL if they key doesn't exist. */
	map_get :: proc(_map: ^Map, key: Map_Key) -> ^Map_Val ---

	/* Get element as pointer (auto-dereferences _ptr) */
	map_get_deref_ :: proc(_map: ^Map, key: Map_Key) -> rawptr ---

	/** Get or insert element for key. */
	map_ensure :: proc(_map: ^Map, key: Map_Key) -> ^Map_Val ---

	/** Get or insert pointer element for key, allocate if the pointer is NULL */
	map_ensure_alloc :: proc(_map: ^Map, elem_size: Size, key: Map_Key) -> rawptr ---

	/** Insert element for key. */
	map_insert :: proc(_map: ^Map, key: Map_Key, value: Map_Val) ---

	/** Insert pointer element for key, populate with new allocation. */
	map_insert_alloc :: proc(_map: ^Map, elem_size: Size, key: Map_Key) -> rawptr ---

	/** Remove key from map. */
	map_remove :: proc(_map: ^Map, key: Map_Key) -> Map_Val ---

	/* Remove pointer element, free if not NULL */
	map_remove_free :: proc(_map: ^Map, key: Map_Key) ---

	/** Remove all elements from map. */
	map_clear :: proc(_map: ^Map) ---

	/** Return iterator to map contents. */
	map_iter :: proc(_map: ^Map) -> Map_Iter ---

	/** Return whether map iterator is valid. */
	map_iter_valid :: proc(iter: ^Map_Iter) -> bool ---

	/** Obtain next element in map from iterator. */
	map_next :: proc(iter: ^Map_Iter) -> bool ---

	/** Copy map. */
	map_copy :: proc(dst: ^Map, src: ^Map) ---
}

foreign lib {
	ecs_block_allocator_alloc_count : i64
	ecs_block_allocator_free_count  : i64
	ecs_stack_allocator_alloc_count : i64
	ecs_stack_allocator_free_count  : i64
}

Allocator :: struct {
	chunks: Block_Allocator,
	sizes:  Sparse, /* <size, block_allocator_t> */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	flecs_allocator_init :: proc(a: ^Allocator) ---
	flecs_allocator_fini :: proc(a: ^Allocator) ---
	flecs_allocator_get  :: proc(a: ^Allocator, size: Size) -> ^Block_Allocator ---
	flecs_strdup         :: proc(a: ^Allocator, str: cstring) -> cstring ---
	flecs_strfree        :: proc(a: ^Allocator, str: cstring) ---
	flecs_dup            :: proc(a: ^Allocator, size: Size, src: rawptr) -> rawptr ---
}

STRBUF_INIT              :: (Strbuf){}
STRBUF_SMALL_STRING_SIZE :: (512)
STRBUF_MAX_LIST_DEPTH    :: (32)

Strbuf_List_Elem :: struct {
	count:     i32,
	separator: cstring,
}

Strbuf :: struct {
	content:      cstring,
	length:       Size,
	size:         Size,
	list_stack:   [32]Strbuf_List_Elem,
	list_sp:      i32,
	small_string: [512]i8,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/* Append format string to a buffer.
	* Returns false when max is reached, true when there is still space */
	strbuf_append :: proc(buffer: ^Strbuf, fmt: cstring, #c_vararg _: ..any) ---

	/* Append format string with argument list to a buffer.
	* Returns false when max is reached, true when there is still space */
	strbuf_vappend :: proc(buffer: ^Strbuf, fmt: cstring, args: c.va_list) ---

	/* Append string to buffer.
	* Returns false when max is reached, true when there is still space */
	strbuf_appendstr :: proc(buffer: ^Strbuf, str: cstring) ---

	/* Append character to buffer.
	* Returns false when max is reached, true when there is still space */
	strbuf_appendch :: proc(buffer: ^Strbuf, ch: i8) ---

	/* Append int to buffer.
	* Returns false when max is reached, true when there is still space */
	strbuf_appendint :: proc(buffer: ^Strbuf, v: i64) ---

	/* Append float to buffer.
	* Returns false when max is reached, true when there is still space */
	strbuf_appendflt :: proc(buffer: ^Strbuf, v: f64, nan_delim: i8) ---

	/* Append boolean to buffer.
	* Returns false when max is reached, true when there is still space */
	strbuf_appendbool :: proc(buffer: ^Strbuf, v: bool) ---

	/* Append source buffer to destination buffer.
	* Returns false when max is reached, true when there is still space */
	strbuf_mergebuff :: proc(dst_buffer: ^Strbuf, src_buffer: ^Strbuf) ---

	/* Append n characters to buffer.
	* Returns false when max is reached, true when there is still space */
	strbuf_appendstrn :: proc(buffer: ^Strbuf, str: cstring, n: i32) ---

	/* Return result string */
	strbuf_get :: proc(buffer: ^Strbuf) -> cstring ---

	/* Return small string from first element (appends \0) */
	strbuf_get_small :: proc(buffer: ^Strbuf) -> cstring ---

	/* Reset buffer without returning a string */
	strbuf_reset :: proc(buffer: ^Strbuf) ---

	/* Push a list */
	strbuf_list_push :: proc(buffer: ^Strbuf, list_open: cstring, separator: cstring) ---

	/* Pop a new list */
	strbuf_list_pop :: proc(buffer: ^Strbuf, list_close: cstring) ---

	/* Insert a new element in list */
	strbuf_list_next :: proc(buffer: ^Strbuf) ---

	/* Append character to as new element in list. */
	strbuf_list_appendch :: proc(buffer: ^Strbuf, ch: i8) ---

	/* Append formatted string as a new element in list */
	strbuf_list_append :: proc(buffer: ^Strbuf, fmt: cstring, #c_vararg _: ..any) ---

	/* Append string as a new element in list */
	strbuf_list_appendstr :: proc(buffer: ^Strbuf, str: cstring) ---

	/* Append string as a new element in list */
	strbuf_list_appendstrn :: proc(buffer: ^Strbuf, str: cstring, n: i32) ---
	strbuf_written         :: proc(buffer: ^Strbuf) -> i32 ---
}

/** Time type. */
Time :: struct {
	sec:     u32, /**< Second part. */
	nanosec: u32, /**< Nanosecond part. */
}

foreign lib {
	/**< malloc count. */
	ecs_os_api_malloc_count : i64 /**< malloc count. */

	/**< realloc count. */
	ecs_os_api_realloc_count : i64 /**< realloc count. */

	/**< calloc count. */
	ecs_os_api_calloc_count : i64 /**< calloc count. */

	/**< free count. */
	ecs_os_api_free_count : i64 /**< free count. */
}

/* Use handle types that _at least_ can store pointers */
Os_Thread :: c.uintptr_t /**< OS thread. */
Os_Cond   :: c.uintptr_t /**< OS cond. */
Os_Mutex  :: c.uintptr_t /**< OS mutex. */
Os_Dl     :: c.uintptr_t /**< OS dynamic library. */
Os_Sock   :: c.uintptr_t /**< OS socket. */

/** 64 bit thread id. */
Os_Thread_Id :: u64

/** Generic function pointer type. */
Os_Proc :: proc "c" ()

/** OS API init. */
Os_Api_Init :: proc "c" ()

/** OS API deinit. */
Os_Api_Fini :: proc "c" ()

/** OS API malloc function type. */
Os_Api_Malloc :: proc "c" (size: Size) -> rawptr

/** OS API free function type. */
Os_Api_Free :: proc "c" (ptr: rawptr)

/** OS API realloc function type. */
Os_Api_Realloc :: proc "c" (ptr: rawptr, size: Size) -> rawptr

/** OS API calloc function type. */
Os_Api_Calloc :: proc "c" (size: Size) -> rawptr

/** OS API strdup function type. */
Os_Api_Strdup :: proc "c" (str: cstring) -> cstring

/** OS API thread_callback function type. */
Os_Thread_Callback :: proc "c" (rawptr) -> rawptr

/** OS API thread_new function type. */
Os_Api_Thread_New :: proc "c" (callback: Os_Thread_Callback, param: rawptr) -> Os_Thread

/** OS API thread_join function type. */
Os_Api_Thread_Join :: proc "c" (thread: Os_Thread) -> rawptr

/** OS API thread_self function type. */
Os_Api_Thread_Self :: proc "c" () -> Os_Thread_Id

/** OS API task_new function type. */
Os_Api_Task_New :: proc "c" (callback: Os_Thread_Callback, param: rawptr) -> Os_Thread

/** OS API task_join function type. */
Os_Api_Task_Join :: proc "c" (thread: Os_Thread) -> rawptr

/* Atomic increment / decrement */
/** OS API ainc function type. */
Os_Api_Ainc :: proc "c" (value: ^i32) -> i32

/** OS API lainc function type. */
Os_Api_Lainc :: proc "c" (value: ^i64) -> i64

/* Mutex */
/** OS API mutex_new function type. */
Os_Api_Mutex_New :: proc "c" () -> Os_Mutex

/** OS API mutex_lock function type. */
Os_Api_Mutex_Lock :: proc "c" (mutex: Os_Mutex)

/** OS API mutex_unlock function type. */
Os_Api_Mutex_Unlock :: proc "c" (mutex: Os_Mutex)

/** OS API mutex_free function type. */
Os_Api_Mutex_Free :: proc "c" (mutex: Os_Mutex)

/* Condition variable */
/** OS API cond_new function type. */
Os_Api_Cond_New :: proc "c" () -> Os_Cond

/** OS API cond_free function type. */
Os_Api_Cond_Free :: proc "c" (cond: Os_Cond)

/** OS API cond_signal function type. */
Os_Api_Cond_Signal :: proc "c" (cond: Os_Cond)

/** OS API cond_broadcast function type. */
Os_Api_Cond_Broadcast :: proc "c" (cond: Os_Cond)

/** OS API cond_wait function type. */
Os_Api_Cond_Wait :: proc "c" (cond: Os_Cond, mutex: Os_Mutex)

/** OS API sleep function type. */
Os_Api_Sleep :: proc "c" (sec: i32, nanosec: i32)

/** OS API enable_high_timer_resolution function type. */
Os_Api_Enable_High_Timer_Resolution :: proc "c" (enable: bool)

/** OS API get_time function type. */
Os_Api_Get_Time :: proc "c" (time_out: ^Time)

/** OS API now function type. */
Os_Api_Now :: proc "c" () -> u64

/** OS API log function type. */
Os_Api_Log :: proc "c" (level: i32, file: cstring, line: i32, msg: cstring)

/** OS API abort function type. */
Os_Api_Abort :: proc "c" ()

/** OS API dlopen function type. */
Os_Api_Dlopen :: proc "c" (libname: cstring) -> Os_Dl

/** OS API dlproc function type. */
Os_Api_Dlproc :: proc "c" (lib: Os_Dl, procname: cstring) -> Os_Proc

/** OS API dlclose function type. */
Os_Api_Dlclose :: proc "c" (lib: Os_Dl)

/** OS API module_to_path function type. */
Os_Api_Module_To_Path :: proc "c" (module_id: cstring) -> cstring

/* Performance tracing */
Os_Api_Perf_Trace :: proc "c" (filename: cstring, line: c.size_t, name: cstring)

/** OS API interface. */
Os_Api :: struct {
	/* API init / deinit */
	init_: Os_Api_Init, /**< init callback. */
	fini_: Os_Api_Fini, /**< fini callback. */

	/* Memory management */
	malloc_:  Os_Api_Malloc,  /**< malloc callback. */
	realloc_: Os_Api_Realloc, /**< realloc callback. */
	calloc_:  Os_Api_Calloc,  /**< calloc callback. */
	free_:    Os_Api_Free,    /**< free callback. */

	/* Strings */
	strdup_: Os_Api_Strdup, /**< strdup callback. */

	/* Threads */
	thread_new_:  Os_Api_Thread_New,  /**< thread_new callback. */
	thread_join_: Os_Api_Thread_Join, /**< thread_join callback. */
	thread_self_: Os_Api_Thread_Self, /**< thread_self callback. */

	/* Tasks */
	task_new_:  Os_Api_Thread_New,  /**< task_new callback. */
	task_join_: Os_Api_Thread_Join, /**< task_join callback. */

	/* Atomic increment / decrement */
	ainc_:  Os_Api_Ainc,  /**< ainc callback. */
	adec_:  Os_Api_Ainc,  /**< adec callback. */
	lainc_: Os_Api_Lainc, /**< lainc callback. */
	ladec_: Os_Api_Lainc, /**< ladec callback. */

	/* Mutex */
	mutex_new_:    Os_Api_Mutex_New,  /**< mutex_new callback. */
	mutex_free_:   Os_Api_Mutex_Free, /**< mutex_free callback. */
	mutex_lock_:   Os_Api_Mutex_Lock, /**< mutex_lock callback. */
	mutex_unlock_: Os_Api_Mutex_Lock, /**< mutex_unlock callback. */

	/* Condition variable */
	cond_new_:       Os_Api_Cond_New,       /**< cond_new callback. */
	cond_free_:      Os_Api_Cond_Free,      /**< cond_free callback. */
	cond_signal_:    Os_Api_Cond_Signal,    /**< cond_signal callback. */
	cond_broadcast_: Os_Api_Cond_Broadcast, /**< cond_broadcast callback. */
	cond_wait_:      Os_Api_Cond_Wait,      /**< cond_wait callback. */

	/* Time */
	sleep_:    Os_Api_Sleep,    /**< sleep callback. */
	now_:      Os_Api_Now,      /**< now callback. */
	get_time_: Os_Api_Get_Time, /**< get_time callback. */

	/* Logging */
	log_: Os_Api_Log, /**< log callback.
                            * The level should be interpreted as:
                            * >0: Debug tracing. Only enabled in debug builds.
                            *  0: Tracing. Enabled in debug/release builds.
                            * -2: Warning. An issue occurred, but operation was successful.
                            * -3: Error. An issue occurred, and operation was unsuccessful.
                            * -4: Fatal. An issue occurred, and application must quit. */

	/* Application termination */
	abort_: Os_Api_Abort, /**< abort callback. */

	/* Dynamic library loading */
	dlopen_:  Os_Api_Dlopen,  /**< dlopen callback. */
	dlproc_:  Os_Api_Dlproc,  /**< dlproc callback. */
	dlclose_: Os_Api_Dlclose, /**< dlclose callback. */

	/* Overridable function that translates from a logical module id to a
	* shared library filename */
	module_to_dl_: Os_Api_Module_To_Path, /**< module_to_dl callback. */

	/* Overridable function that translates from a logical module id to a
	* path that contains module-specif resources or assets */
	module_to_etc_: Os_Api_Module_To_Path, /**< module_to_etc callback. */

	/* Performance tracing */
	perf_trace_push_: Os_Api_Perf_Trace,

	/* Performance tracing */
	perf_trace_pop_:     Os_Api_Perf_Trace,
	log_level_:          i32,     /**< Tracing level. */
	log_indent_:         i32,     /**< Tracing indentation level. */
	log_last_error_:     i32,     /**< Last logged error code. */
	log_last_timestamp_: i64,     /**< Last logged timestamp. */
	flags_:              Flags32, /**< OS API flags */
	log_out_:            rawptr,  /**< File used for logging output (type is FILE*)
                                                    * (hint, log_ decides where to write) */
}

foreign lib {
	/** Static OS API variable with configured callbacks. */
	ecs_os_api : Os_Api
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Initialize OS API.
	* This operation is not usually called by an application. To override callbacks
	* of the OS API, use the following pattern:
	*
	* @code
	* ecs_os_set_api_defaults();
	* ecs_os_api_t os_api = ecs_os_get_api();
	* os_api.abort_ = my_abort;
	* ecs_os_set_api(&os_api);
	* @endcode
	*/
	os_init :: proc() ---

	/** Deinitialize OS API.
	* This operation is not usually called by an application.
	*/
	os_fini :: proc() ---

	/** Override OS API.
	* This overrides the OS API struct with new values for callbacks. See
	* ecs_os_init() on how to use the function.
	*
	* @param os_api Pointer to struct with values to set.
	*/
	os_set_api :: proc(os_api: ^Os_Api) ---

	/** Get OS API.
	*
	* @return A value with the current OS API callbacks
	* @see ecs_os_init()
	*/
	os_get_api :: proc() -> Os_Api ---

	/** Set default values for OS API.
	* This initializes the OS API struct with default values for callbacks like
	* malloc and free.
	*
	* @see ecs_os_init()
	*/
	os_set_api_defaults :: proc() ---

	/** Log at debug level.
	*
	* @param file The file to log.
	* @param line The line to log.
	* @param msg The message to log.
	*/
	os_dbg :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Log at trace level.
	*
	* @param file The file to log.
	* @param line The line to log.
	* @param msg The message to log.
	*/
	os_trace :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Log at warning level.
	*
	* @param file The file to log.
	* @param line The line to log.
	* @param msg The message to log.
	*/
	os_warn :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Log at error level.
	*
	* @param file The file to log.
	* @param line The line to log.
	* @param msg The message to log.
	*/
	os_err :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Log at fatal level.
	*
	* @param file The file to log.
	* @param line The line to log.
	* @param msg The message to log.
	*/
	os_fatal :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Convert errno to string.
	*
	* @param err The error number.
	* @return A string describing the error.
	*/
	os_strerror :: proc(err: i32) -> cstring ---

	/** Utility for assigning strings.
	* This operation frees an existing string and duplicates the input string.
	*
	* @param str Pointer to a string value.
	* @param value The string value to assign.
	*/
	os_strset           :: proc(str: ^cstring, value: cstring) ---
	os_perf_trace_push_ :: proc(file: cstring, line: c.size_t, name: cstring) ---
	os_perf_trace_pop_  :: proc(file: cstring, line: c.size_t, name: cstring) ---

	/** Sleep with floating point time.
	*
	* @param t The time in seconds.
	*/
	sleepf :: proc(t: f64) ---

	/** Measure time since provided timestamp.
	* Use with a time value initialized to 0 to obtain the number of seconds since
	* the epoch. The operation will write the current timestamp in start.
	*
	* Usage:
	* @code
	* ecs_time_t t = {};
	* ecs_time_measure(&t);
	* // code
	* double elapsed = ecs_time_measure(&t);
	* @endcode
	*
	* @param start The starting timestamp.
	* @return The time elapsed since start.
	*/
	time_measure :: proc(start: ^Time) -> f64 ---

	/** Calculate difference between two timestamps.
	*
	* @param t1 The first timestamp.
	* @param t2 The first timestamp.
	* @return The difference between timestamps.
	*/
	time_sub :: proc(t1: Time, t2: Time) -> Time ---

	/** Convert time value to a double.
	*
	* @param t The timestamp.
	* @return The timestamp converted to a double.
	*/
	time_to_double :: proc(t: Time) -> f64 ---

	/** Return newly allocated memory that contains a copy of src.
	*
	* @param src The source pointer.
	* @param size The number of bytes to copy.
	* @return The duplicated memory.
	*/
	os_memdup :: proc(src: rawptr, size: Size) -> rawptr ---

	/** Are heap functions available? */
	os_has_heap :: proc() -> bool ---

	/** Are threading functions available? */
	os_has_threading :: proc() -> bool ---

	/** Are task functions available? */
	os_has_task_support :: proc() -> bool ---

	/** Are time functions available? */
	os_has_time :: proc() -> bool ---

	/** Are logging functions available? */
	os_has_logging :: proc() -> bool ---

	/** Are dynamic library functions available? */
	os_has_dl :: proc() -> bool ---

	/** Are module path functions available? */
	os_has_modules :: proc() -> bool ---
}

/** Function prototype for runnables (systems, observers).
* The run callback overrides the default behavior for iterating through the
* results of a runnable object.
*
* The default runnable iterates the iterator, and calls an iter_action (see
* below) for each returned result.
*
* @param it The iterator to be iterated by the runnable.
*/
Run_Action :: proc "c" (it: ^Iter)

/** Function prototype for iterables.
* A system may invoke a callback multiple times, typically once for each
* matched table.
*
* @param it The iterator containing the data for the current match.
*/
Iter_Action :: proc "c" (it: ^Iter)

/** Function prototype for iterating an iterator.
* Stored inside initialized iterators. This allows an application to iterate
* an iterator without needing to know what created it.
*
* @param it The iterator to iterate.
* @return True if iterator has no more results, false if it does.
*/
Iter_Next_Action :: proc "c" (it: ^Iter) -> bool

/** Function prototype for freeing an iterator.
* Free iterator resources.
*
* @param it The iterator to free.
*/
Iter_Fini_Action :: proc "c" (it: ^Iter)

/** Callback used for comparing components */
Order_By_Action :: proc "c" (e1: Entity, ptr1: rawptr, e2: Entity, ptr2: rawptr) -> i32

/** Callback used for sorting the entire table of components */
Sort_Table_Action :: proc "c" (world: ^World, table: ^Table, entities: ^Entity, ptr: rawptr, size: i32, lo: i32, hi: i32, order_by: Order_By_Action)

/** Callback used for grouping tables in a query */
Group_By_Action :: proc "c" (world: ^World, table: ^Table, group_id: Id, ctx: rawptr) -> u64

/** Callback invoked when a query creates a new group. */
Group_Create_Action :: proc "c" (world: ^World, group_id: u64, group_by_ctx: rawptr) -> rawptr

/** Callback invoked when a query deletes an existing group. */
Group_Delete_Action :: proc "c" (world: ^World, group_id: u64, group_ctx: rawptr, group_by_ctx: rawptr)

/** Initialization action for modules */
Module_Action :: proc "c" (world: ^World)

/** Action callback on world exit */
Fini_Action :: proc "c" (world: ^World, ctx: rawptr)

/** Function to cleanup context data */
Ctx_Free :: proc "c" (ctx: rawptr)

/** Callback used for sorting values */
Compare_Action :: proc "c" (ptr1: rawptr, ptr2: rawptr) -> i32

/** Callback used for hashing values */
Hash_Value_Action :: proc "c" (ptr: rawptr) -> u64

/** Constructor/destructor callback */
Xtor :: proc "c" (ptr: rawptr, count: i32, type_info: ^Type_Info)

/** Copy is invoked when a component is copied into another component. */
Copy :: proc "c" (dst_ptr: rawptr, src_ptr: rawptr, count: i32, type_info: ^Type_Info)

/** Move is invoked when a component is moved to another component. */
Move :: proc "c" (dst_ptr: rawptr, src_ptr: rawptr, count: i32, type_info: ^Type_Info)

/** Compare hook to compare component instances */
Cmp :: proc "c" (a_ptr: rawptr, b_ptr: rawptr, type_info: ^Type_Info) -> i32

/** Equals operator hook */
Equals :: proc "c" (a_ptr: rawptr, b_ptr: rawptr, type_info: ^Type_Info) -> bool

/** Destructor function for poly objects. */
Flecs_Poly_Dtor :: proc "c" (poly: ^Poly)

/** Specify read/write access for term */
Inout_Kind :: enum u32 {
	InOutDefault = 0, /**< InOut for regular terms, In for shared terms */
	InOutNone    = 1, /**< Term is neither read nor written */
	InOutFilter  = 2, /**< Same as InOutNone + prevents term from triggering observers */
	InOut        = 3, /**< Term is both read and written */
	In           = 4, /**< Term is only read */
	Out          = 5, /**< Term is only written */
}

/** Specify operator for term */
Oper_Kind :: enum u32 {
	And      = 0, /**< The term must match */
	Or       = 1, /**< One of the terms in an or chain must match */
	Not      = 2, /**< The term must not match */
	Optional = 3, /**< The term may match */
	AndFrom  = 4, /**< Term must match all components from term id */
	OrFrom   = 5, /**< Term must match at least one component from term id */
	NotFrom  = 6, /**< Term must match none of the components from term id */
}

/** Specify cache policy for query */
Query_Cache_Kind :: enum u32 {
	Default = 0, /**< Behavior determined by query creation context */
	Auto    = 1, /**< Cache query terms that are cacheable */
	All     = 2, /**< Require that all query terms can be cached */
	None    = 3, /**< No caching */
}

/* Term id flags  */

/** Match on self.
* Can be combined with other term flags on the ecs_term_t::flags_ field.
* \ingroup queries
*/
EcsSelf                       :: (1<<63)

/** Match by traversing upwards.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsUp                         :: (1<<62)

/** Traverse relationship transitively.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsTrav                       :: (1<<61)

/** Sort results breadth first.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsCascade                    :: (1<<60)

/** Iterate groups in descending order.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsDesc                       :: (1<<59)

/** Term id is a variable.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsIsVariable                 :: (1<<58)

/** Term id is an entity.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsIsEntity                   :: (1<<57)

/** Term id is a name (don't attempt to lookup as entity).
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsIsName                     :: (1<<56)

/** All term traversal flags.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsTraverseFlags              :: (EcsSelf|EcsUp|EcsTrav|EcsCascade|EcsDesc)

/** All term reference kind flags.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsTermRefFlags               :: (EcsTraverseFlags|EcsIsVariable|EcsIsEntity|EcsIsName)

/** Type that describes a reference to an entity or variable in a term. */
Term_Ref :: struct {
	id:   Entity,  /**< Entity id. If left to 0 and flags does not 
                                 * specify whether id is an entity or a variable
                                 * the id will be initialized to #EcsThis.
                                 * To explicitly set the id to 0, leave the id
                                 * member to 0 and set #EcsIsEntity in flags. */
	name: cstring, /**< Name. This can be either the variable name
                                 * (when the #EcsIsVariable flag is set) or an
                                 * entity name. When ecs_term_t::move is true,
                                 * the API assumes ownership over the string and
                                 * will free it when the term is destroyed. */
}

/** Type that describes a term (single element in a query). */
Term :: struct {
	id:          Id,       /**< Component id to be matched by term. Can be
                                 * set directly, or will be populated from the
                                 * first/second members, which provide more
                                 * flexibility. */
	src:         Term_Ref, /**< Source of term */
	first:       Term_Ref, /**< Component or first element of pair */
	second:      Term_Ref, /**< Second element of pair */
	trav:        Entity,   /**< Relationship to traverse when looking for the
                                 * component. The relationship must have
                                 * the `Traversable` property. Default is `IsA`. */
	inout:       i16,      /**< Access to contents matched by term */
	oper:        i16,      /**< Operator of term */
	field_index: i8,       /**< Index of field for term in iterator */
	flags_:      Flags16,  /**< Flags that help eval, set by ecs_query_init() */
}

/** Queries are lists of constraints (terms) that match entities.
* Created with ecs_query_init().
*/
Query :: struct {
	hdr:          Header,  /**< Object header */
	terms:        ^Term,   /**< Query terms */
	sizes:        ^i32,    /**< Component sizes. Indexed by field */
	ids:          ^Id,     /**< Component ids. Indexed by field */
	bloom_filter: u64,     /**< Bitmask used to quickly discard tables */
	flags:        Flags32, /**< Query flags */
	var_count:    i8,      /**< Number of query variables */
	term_count:   i8,      /**< Number of query terms */
	field_count:  i8,      /**< Number of fields returned by query */

	/* Bitmasks for quick field information lookups */
	fixed_fields:           Flags32,          /**< Fields with a fixed source */
	var_fields:             Flags32,          /**< Fields with non-$this variable source */
	static_id_fields:       Flags32,          /**< Fields with a static (component) id */
	data_fields:            Flags32,          /**< Fields that have data */
	write_fields:           Flags32,          /**< Fields that write data */
	read_fields:            Flags32,          /**< Fields that read data */
	row_fields:             Flags32,          /**< Fields that must be acquired with field_at */
	shared_readonly_fields: Flags32,          /**< Fields that don't write shared data */
	set_fields:             Flags32,          /**< Fields that will be set */
	cache_kind:             Query_Cache_Kind, /**< Caching policy of query */
	vars:                   ^cstring,         /**< Array with variable names for iterator */
	ctx:                    rawptr,           /**< User context to pass to callback */
	binding_ctx:            rawptr,           /**< Context to be used for language bindings */
	entity:                 Entity,           /**< Entity associated with query (optional) */
	real_world:             ^World,           /**< Actual world. */
	world:                  ^World,           /**< World or stage query was created with. */
	eval_count:             i32,              /**< Number of times query is evaluated */
}

/** An observer reacts to events matching a query.
* Created with ecs_observer_init().
*/
Observer :: struct {
	hdr:   Header, /**< Object header */
	query: ^Query, /**< Observer query */

	/** Observer events */
	events:            [8]Entity,
	event_count:       i32,         /**< Number of events */
	callback:          Iter_Action, /**< See ecs_observer_desc_t::callback */
	run:               Run_Action,  /**< See ecs_observer_desc_t::run */
	ctx:               rawptr,      /**< Observer context */
	callback_ctx:      rawptr,      /**< Callback language binding context */
	run_ctx:           rawptr,      /**< Run language binding context */
	ctx_free:          Ctx_Free,    /**< Callback to free ctx */
	callback_ctx_free: Ctx_Free,    /**< Callback to free callback_ctx */
	run_ctx_free:      Ctx_Free,    /**< Callback to free run_ctx */
	observable:        ^Observable, /**< Observable for observer */
	world:             ^World,      /**< The world */
	entity:            Entity,      /**< Entity associated with observer */
}

/** @} */

/** Type that contains component lifecycle callbacks.
*
* @ingroup components
*/

/* Flags that can be used to check which hooks a type has set */
TYPE_HOOK_CTOR                   :: ((Flags32)(10))
TYPE_HOOK_DTOR                   :: ((Flags32)(11))
TYPE_HOOK_COPY                   :: ((Flags32)(12))
TYPE_HOOK_MOVE                   :: ((Flags32)(13))
TYPE_HOOK_COPY_CTOR              :: ((Flags32)(14))
TYPE_HOOK_MOVE_CTOR              :: ((Flags32)(15))
TYPE_HOOK_CTOR_MOVE_DTOR         :: ((Flags32)(16))
TYPE_HOOK_MOVE_DTOR              :: ((Flags32)(17))
TYPE_HOOK_CMP                    :: ((Flags32)(18))
TYPE_HOOK_EQUALS                 :: ((Flags32)(19))

/* Flags that can be used to set/check which hooks of a type are invalid */
TYPE_HOOK_CTOR_ILLEGAL           :: ((Flags32)(110))
TYPE_HOOK_DTOR_ILLEGAL           :: ((Flags32)(112))
TYPE_HOOK_COPY_ILLEGAL           :: ((Flags32)(113))
TYPE_HOOK_MOVE_ILLEGAL           :: ((Flags32)(114))
TYPE_HOOK_COPY_CTOR_ILLEGAL      :: ((Flags32)(115))
TYPE_HOOK_MOVE_CTOR_ILLEGAL      :: ((Flags32)(116))
TYPE_HOOK_CTOR_MOVE_DTOR_ILLEGAL :: ((Flags32)(117))
TYPE_HOOK_MOVE_DTOR_ILLEGAL      :: ((Flags32)(118))
TYPE_HOOK_CMP_ILLEGAL            :: ((Flags32)(119))
TYPE_HOOK_EQUALS_ILLEGAL         :: ((Flags32)(120))

/* All valid hook flags */
TYPE_HOOKS :: (TYPE_HOOK_CTOR|TYPE_HOOK_DTOR|TYPE_HOOK_COPY|TYPE_HOOK_MOVE|TYPE_HOOK_COPY_CTOR|TYPE_HOOK_MOVE_CTOR|TYPE_HOOK_CTOR_MOVE_DTOR|TYPE_HOOK_MOVE_DTOR|TYPE_HOOK_CMP|TYPE_HOOK_EQUALS)

/* All invalid hook flags */
TYPE_HOOKS_ILLEGAL :: (TYPE_HOOK_CTOR_ILLEGAL|TYPE_HOOK_DTOR_ILLEGAL|TYPE_HOOK_COPY_ILLEGAL|TYPE_HOOK_MOVE_ILLEGAL|TYPE_HOOK_COPY_CTOR_ILLEGAL|TYPE_HOOK_MOVE_CTOR_ILLEGAL|TYPE_HOOK_CTOR_MOVE_DTOR_ILLEGAL|TYPE_HOOK_MOVE_DTOR_ILLEGAL|TYPE_HOOK_CMP_ILLEGAL|TYPE_HOOK_EQUALS_ILLEGAL)

Type_Hooks :: struct {
	ctor: Xtor, /**< ctor */
	dtor: Xtor, /**< dtor */
	copy: Copy, /**< copy assignment */
	move: Move, /**< move assignment */

	/** Ctor + copy */
	copy_ctor: Copy,

	/** Ctor + move */
	move_ctor: Move,

	/** Ctor + move + dtor (or move_ctor + dtor).
	* This combination is typically used when a component is moved from one
	* location to a new location, like when it is moved to a new table. If
	* not set explicitly it will be derived from other callbacks. */
	ctor_move_dtor: Move,

	/** Move + dtor.
	* This combination is typically used when a component is moved from one
	* location to an existing location, like what happens during a remove. If
	* not set explicitly it will be derived from other callbacks. */
	move_dtor: Move,

	/** Compare hook */
	cmp: Cmp,

	/** Equals hook */
	equals: Equals,

	/** Hook flags.
	* Indicates which hooks are set for the type, and which hooks are illegal.
	* When an ILLEGAL flag is set when calling ecs_set_hooks() a hook callback
	* will be set that panics when called. */
	flags: Flags32,

	/** Callback that is invoked when an instance of a component is added. This
	* callback is invoked before triggers are invoked. */
	on_add: Iter_Action,

	/** Callback that is invoked when an instance of the component is set. This
	* callback is invoked before triggers are invoked, and enable the component
	* to respond to changes on itself before others can. */
	on_set: Iter_Action,

	/** Callback that is invoked when an instance of the component is removed.
	* This callback is invoked after the triggers are invoked, and before the
	* destructor is invoked. */
	on_remove: Iter_Action,

	/** Callback that is invoked with the existing and new value before the
	* value is assigned. Invoked after on_add and before on_set. Registering
	* an on_replace hook prevents using operations that return a mutable
	* pointer to the component like get_mut, ensure and emplace. */
	on_replace:         Iter_Action,
	ctx:                rawptr,   /**< User defined context */
	binding_ctx:        rawptr,   /**< Language binding context */
	lifecycle_ctx:      rawptr,   /**< Component lifecycle context (see meta add-on)*/
	ctx_free:           Ctx_Free, /**< Callback to free ctx */
	binding_ctx_free:   Ctx_Free, /**< Callback to free binding_ctx */
	lifecycle_ctx_free: Ctx_Free, /**< Callback to free lifecycle_ctx */
}

/** Type that contains component information (passed to ctors/dtors/...)
*
* @ingroup components
*/
Type_Info :: struct {
	size:      Size,       /**< Size of type */
	alignment: Size,       /**< Alignment of type */
	hooks:     Type_Hooks, /**< Type hooks */
	component: Entity,     /**< Handle to component (do not set) */
	name:      cstring,    /**< Type name. */
}

Data              :: struct {}
Query_Cache_Match :: struct {}
Query_Cache_Group :: struct {}

/** All observers for a specific event */
Event_Record :: struct {
	_any:          ^Event_Id_Record,
	wildcard:      ^Event_Id_Record,
	wildcard_pair: ^Event_Id_Record,
	event_ids:     Map, /* map<id, ecs_event_id_record_t> */
	event:         Entity,
}

Event_Id_Record :: struct {}

Observable :: struct {
	on_add:           Event_Record,
	on_remove:        Event_Record,
	on_set:           Event_Record,
	on_wildcard:      Event_Record,
	events:           Sparse, /* sparse<event, ecs_event_record_t> */
	global_observers: Vec,    /* vector<ecs_observable_t> */
	last_observer_id: u64,
}

/** Range in table */
Table_Range :: struct {
	table:  ^Table,
	offset: i32, /* Leave both members to 0 to cover entire table */
	count:  i32,
}

/** Value of query variable */
Var :: struct {
	range:  Table_Range, /* Set when variable stores a range of entities */
	entity: Entity,      /* Set when variable stores single entity */
}

/** Cached reference. */
Ref :: struct {
	entity:             Entity,  /* Entity */
	id:                 Entity,  /* Component id */
	table_id:           u64,     /* Table id for detecting ABA issues */
	table_version_fast: u32,     /* Fast change detection w/false positives */
	table_version:      u16,     /* Change detection */
	record:             ^Record, /* Entity index record */
	ptr:                rawptr,  /* Cached component pointer */
}

/* Page-iterator specific data */
Page_Iter :: struct {
	offset:    i32,
	limit:     i32,
	remaining: i32,
}

/* Worker-iterator specific data */
Worker_Iter :: struct {
	index: i32,
	count: i32,
}

/* Convenience struct to iterate table array for id */
Table_Cache_Iter :: struct {
	cur, next:  ^Table_Cache_Hdr,
	iter_fill:  bool,
	iter_empty: bool,
}

/** Each iterator */
Each_Iter :: struct {
	it: Table_Cache_Iter,

	/* Storage for iterator fields */
	ids:     Id,
	sources: Entity,
	sizes:   Size,
	columns: i32,
	trs:     ^Table_Record,
}

Query_Op_Profile :: struct {
	count: [2]i32, /* 0 = enter, 1 = redo */
}

/** Query iterator */
Query_Iter :: struct {
	vars:       ^Var,          /* Variable storage */
	query_vars: ^Query_Var,    /* Query variable metadata */
	ops:        ^Query_Op,     /* Query plan operations */
	op_ctx:     ^Query_Op_Ctx, /* Operation-specific state */
	written:    ^u64,

	/* Cached iteration */
	group:             ^Query_Cache_Group, /* Currently iterated group */
	tables:            ^Vec,               /* Currently iterated table vector (vec<ecs_query_cache_match_t>) */
	all_tables:        ^Vec,               /* Different from .tables if iterating wildcard matches (vec<ecs_query_cache_match_t>) */
	elem:              ^Query_Cache_Match, /* Current cache entry */
	cur, all_cur:      i32,                /* Indices into tables & all_tables */
	profile:           ^Query_Op_Profile,
	op:                i16,                /* Currently iterated query plan operation (index into ops) */
	iter_single_group: bool,
}

Query_Var    :: struct {} /* Query variable metadata */
Query_Op     :: struct {} /* Query plan operations */
Query_Op_Ctx :: struct {} /* Operation-specific state */

/* Private iterator data. Used by iterator implementations to keep track of
* progress & to provide builtin storage. */
Iter_Private :: struct {
	iter: struct #raw_union {
		query:  Query_Iter,
		page:   Page_Iter,
		worker: Worker_Iter,
		each:   Each_Iter,
	}, /* Iterator specific data */

	entity_iter:  rawptr,        /* Query applied after matching a table */
	stack_cursor: ^Stack_Cursor, /* Stack cursor to restore to */
}

/* Data structures that store the command queue */
Commands :: struct {
	queue:   Vec,
	stack:   Stack,  /* Temp memory used by deferred commands */
	entries: Sparse, /* <entity, op_entry_t> - command batching */
}

/** This is the largest possible component id. Components for the most part
* occupy the same id range as entities, however they are not allowed to overlap
* with (8) bits reserved for id flags. */
MAX_COMPONENT_ID :: (~((u32)(ID_FLAGS_MASK>>32)))

/** The maximum number of nested function calls before the core will throw a
* cycle detected error */
MAX_RECURSION :: (512)

/** Maximum length of a parser token (used by parser-related addons) */
MAX_TOKEN_SIZE :: (256)

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Convert a C module name into a path.
	* This operation converts a PascalCase name to a path, for example MyFooModule
	* into my.foo.module.
	*
	* @param c_name The C module name
	* @return The path.
	*/
	flecs_module_path_from_c :: proc(c_name: cstring) -> cstring ---

	/** Constructor that zeromem's a component value.
	*
	* @param ptr Pointer to the value.
	* @param count Number of elements to construct.
	* @param type_info Type info for the component.
	*/
	flecs_default_ctor :: proc(ptr: rawptr, count: i32, type_info: ^Type_Info) ---

	/** Create allocated string from format.
	*
	* @param fmt The format string.
	* @param args Format arguments.
	* @return The formatted string.
	*/
	flecs_vasprintf :: proc(fmt: cstring, args: c.va_list) -> cstring ---

	/** Create allocated string from format.
	*
	* @param fmt The format string.
	* @return The formatted string.
	*/
	flecs_asprintf :: proc(fmt: cstring, #c_vararg _: ..any) -> cstring ---

	/** Write an escaped character.
	* Write a character to an output string, insert escape character if necessary.
	*
	* @param out The string to write the character to.
	* @param in The input character.
	* @param delimiter The delimiter used (for example '"')
	* @return Pointer to the character after the last one written.
	*/
	flecs_chresc :: proc(out: cstring, _in: i8, delimiter: i8) -> cstring ---

	/** Parse an escaped character.
	* Parse a character with a potential escape sequence.
	*
	* @param in Pointer to character in input string.
	* @param out Output string.
	* @return Pointer to the character after the last one read.
	*/
	flecs_chrparse :: proc(_in: cstring, out: cstring) -> cstring ---

	/** Write an escaped string.
	* Write an input string to an output string, escape characters where necessary.
	* To determine the size of the output string, call the operation with a NULL
	* argument for 'out', and use the returned size to allocate a string that is
	* large enough.
	*
	* @param out Pointer to output string (must be).
	* @param size Maximum number of characters written to output.
	* @param delimiter The delimiter used (for example '"').
	* @param in The input string.
	* @return The number of characters that (would) have been written.
	*/
	flecs_stresc :: proc(out: cstring, size: Size, delimiter: i8, _in: cstring) -> Size ---

	/** Return escaped string.
	* Return escaped version of input string. Same as flecs_stresc(), but returns an
	* allocated string of the right size.
	*
	* @param delimiter The delimiter used (for example '"').
	* @param in The input string.
	* @return Escaped string.
	*/
	flecs_astresc :: proc(delimiter: i8, _in: cstring) -> cstring ---

	/** Skip whitespace and newline characters.
	* This function skips whitespace characters.
	*
	* @param ptr Pointer to (potential) whitespaces to skip.
	* @return Pointer to the next non-whitespace character.
	*/
	flecs_parse_ws_eol :: proc(ptr: cstring) -> cstring ---

	/** Parse digit.
	* This function will parse until the first non-digit character is found. The
	* provided expression must contain at least one digit character.
	*
	* @param ptr The expression to parse.
	* @param token The output buffer.
	* @return Pointer to the first non-digit character.
	*/
	flecs_parse_digit :: proc(ptr: cstring, token: cstring) -> cstring ---

	/* Convert identifier to snake case */
	flecs_to_snake_case :: proc(str: cstring) -> cstring ---
}

/* Suspend/resume readonly state. To fully support implicit registration of
* components, it should be possible to register components while the world is
* in readonly mode. It is not uncommon that a component is used first from
* within a system, which are often ran while in readonly mode.
*
* Suspending readonly mode is only allowed when the world is not multithreaded.
* When a world is multithreaded, it is not safe to (even temporarily) leave
* readonly mode, so a multithreaded application should always explicitly
* register components in advance.
*
* These operations also suspend deferred mode.
*
* Functions are public to support language bindings.
*/
Suspend_Readonly_State :: struct {
	is_readonly:  bool,
	is_deferred:  bool,
	cmd_flushing: bool,
	defer_count:  i32,
	scope:        Entity,
	with:         Entity,
	cmd_stack:    [2]Commands,
	cmd:          ^Commands,
	stage:        ^Stage,
}

@(default_calling_convention="c")
foreign lib {
	flecs_suspend_readonly :: proc(world: ^World, state: ^Suspend_Readonly_State) -> ^World ---
	flecs_resume_readonly  :: proc(world: ^World, state: ^Suspend_Readonly_State) ---

	/** Number of observed entities in table.
	* Operation is public to support test cases.
	*
	* @param table The table.
	*/
	flecs_table_observed_count :: proc(table: ^Table) -> i32 ---

	/** Print backtrace to specified stream.
	*
	* @param stream The stream to use for printing the backtrace.
	*/
	flecs_dump_backtrace :: proc(stream: rawptr) ---

	/** Increase refcount of poly object.
	*
	* @param poly The poly object.
	* @return The refcount after incrementing.
	*/
	flecs_poly_claim_ :: proc(poly: ^Poly) -> i32 ---

	/** Decrease refcount of poly object.
	*
	* @param poly The poly object.
	* @return The refcount after decrementing.
	*/
	flecs_poly_release_ :: proc(poly: ^Poly) -> i32 ---

	/** Return refcount of poly object.
	*
	* @param poly The poly object.
	* @return Refcount of the poly object.
	*/
	flecs_poly_refcount :: proc(poly: ^Poly) -> i32 ---

	/** Get unused index for static world local component id array.
	* This operation returns an unused index for the world-local component id
	* array. This index can be used by language bindings to obtain a component id.
	*
	* @return Unused index for component id array.
	*/
	flecs_component_ids_index_get :: proc() -> i32 ---

	/** Get world local component id.
	*
	* @param world The world.
	* @param index Component id array index.
	* @return The component id.
	*/
	flecs_component_ids_get :: proc(world: ^World, index: i32) -> Entity ---

	/** Get alive world local component id.
	* Same as flecs_component_ids_get, but return 0 if component is no longer
	* alive.
	*
	* @param world The world.
	* @param index Component id array index.
	* @return The component id.
	*/
	flecs_component_ids_get_alive :: proc(world: ^World, index: i32) -> Entity ---

	/** Set world local component id.
	*
	* @param world The world.
	* @param index Component id array index.
	* @param id The component id.
	*/
	flecs_component_ids_set :: proc(world: ^World, index: i32, id: Entity) ---

	/** Query iterator function for trivially cached queries.
	* This operation can be called if an iterator matches the conditions for
	* trivial iteration:
	*
	* @param it The query iterator.
	* @return Whether the query has more results.
	*/
	flecs_query_trivial_cached_next :: proc(it: ^Iter) -> bool ---

	/** Check if current thread has exclusive access to world.
	* This operation checks if the current thread is allowed to access the world.
	* The operation is called by internal functions before mutating the world, and
	* will panic if the current thread does not have exclusive access to the world.
	*
	* Exclusive access is controlled by the ecs_exclusive_access_begin() and
	* ecs_exclusive_access_end() operations.
	*
	* This operation is public so that it shows up in stack traces, but code such
	* as language bindings or wrappers could also use it to verify that the world
	* is accessed from the correct thread.
	*
	* @param world The world.
	*/
	flecs_check_exclusive_world_access_write :: proc(world: ^World) ---

	/** Same as flecs_check_exclusive_world_access_write, but for read access.
	*
	* @param world The world.
	*/
	flecs_check_exclusive_world_access_read :: proc(world: ^World) ---

	/** End deferred mode (executes commands when stage->deref becomes 0). */
	flecs_defer_end :: proc(world: ^World, stage: ^Stage) -> bool ---
}

Hm_Bucket :: struct {
	keys:   Vec,
	values: Vec,
}

Hashmap :: struct {
	hash:       Hash_Value_Action,
	compare:    Compare_Action,
	key_size:   Size,
	value_size: Size,
	impl:       Map,
}

Flecs_Hashmap_Iter :: struct {
	it:     Map_Iter,
	bucket: ^Hm_Bucket,
	index:  i32,
}

Flecs_Hashmap_Result :: struct {
	key:   rawptr,
	value: rawptr,
	hash:  u64,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	flecs_hashmap_init_          :: proc(hm: ^Hashmap, key_size: Size, value_size: Size, hash: Hash_Value_Action, compare: Compare_Action, allocator: ^Allocator) ---
	flecs_hashmap_fini           :: proc(_map: ^Hashmap) ---
	flecs_hashmap_get_           :: proc(_map: ^Hashmap, key_size: Size, key: rawptr, value_size: Size) -> rawptr ---
	flecs_hashmap_ensure_        :: proc(_map: ^Hashmap, key_size: Size, key: rawptr, value_size: Size) -> Flecs_Hashmap_Result ---
	flecs_hashmap_set_           :: proc(_map: ^Hashmap, key_size: Size, key: rawptr, value_size: Size, value: rawptr) ---
	flecs_hashmap_remove_        :: proc(_map: ^Hashmap, key_size: Size, key: rawptr, value_size: Size) ---
	flecs_hashmap_remove_w_hash_ :: proc(_map: ^Hashmap, key_size: Size, key: rawptr, value_size: Size, hash: u64) ---
	flecs_hashmap_get_bucket     :: proc(_map: ^Hashmap, hash: u64) -> ^Hm_Bucket ---
	flecs_hm_bucket_remove       :: proc(_map: ^Hashmap, bucket: ^Hm_Bucket, hash: u64, index: i32) ---
	flecs_hashmap_copy           :: proc(dst: ^Hashmap, src: ^Hashmap) ---
	flecs_hashmap_iter           :: proc(_map: ^Hashmap) -> Flecs_Hashmap_Iter ---
	flecs_hashmap_next_          :: proc(it: ^Flecs_Hashmap_Iter, key_size: Size, key_out: rawptr, value_size: Size) -> rawptr ---
}

/** Record for entity index. */
Record :: struct {
	table: ^Table, /**< Identifies a type (and table) in world */
	row:   u32,    /**< Table row of the entity */
	dense: i32,    /**< Index in dense array of entity index */
}

/** Header for table cache elements. */
Table_Cache_Hdr :: struct {
	cr:         ^Component_Record, /**< Component record for component. */
	table:      ^Table,            /**< Table associated with element. */
	prev, next: ^Table_Cache_Hdr,  /**< Next/previous elements for id in table cache. */
}

/** Record that stores location of a component in a table.
* Table records are registered with component records, which allows for quickly
* finding all tables for a specific component. */
Table_Record :: struct {
	hdr:    Table_Cache_Hdr, /**< Table cache header */
	index:  i16,             /**< First type index where id occurs in table */
	count:  i16,             /**< Number of times id occurs in table */
	column: i16,             /**< First column index where id occurs */
}

/** Type that contains information about which components got added/removed on
* a table edge. */
Table_Diff :: struct {
	added:         Type, /* Components added between tables */
	removed:       Type, /* Components removed between tables */
	added_flags:   Flags32,
	removed_flags: Flags32,
}

/* Tracks which/how many non-fragmenting children are stored in table for parent. */
Parent_Record :: struct {
	entity: u32, /* If table only contains a single entity for parent, this will contain the entity id (without generation). */
	count:  i32, /* The number of children for a parent in the table. */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Find record for entity.
	* An entity record contains the table and row for the entity.
	*
	* To use ecs_record_t::row as the record in the table, use:
	*   ECS_RECORD_TO_ROW(r->row)
	*
	* This removes potential entity bitflags from the row field.
	*
	* @param world The world.
	* @param entity The entity.
	* @return The record, NULL if the entity does not exist.
	*/
	record_find :: proc(world: ^World, entity: Entity) -> ^Record ---

	/** Get entity corresponding with record.
	* This operation only works for entities that are not empty.
	*
	* @param record The record for which to obtain the entity id.
	* @return The entity id for the record.
	*/
	record_get_entity :: proc(record: ^Record) -> Entity ---

	/** Begin exclusive write access to entity.
	* This operation provides safe exclusive access to the components of an entity
	* without the overhead of deferring operations.
	*
	* When this operation is called simultaneously for the same entity more than
	* once it will throw an assert. Note that for this to happen, asserts must be
	* enabled. It is up to the application to ensure that access is exclusive, for
	* example by using a read-write mutex.
	*
	* Exclusive access is enforced at the table level, so only one entity can be
	* exclusively accessed per table. The exclusive access check is thread safe.
	*
	* This operation must be followed up with ecs_write_end().
	*
	* @param world The world.
	* @param entity The entity.
	* @return A record to the entity.
	*/
	write_begin :: proc(world: ^World, entity: Entity) -> ^Record ---

	/** End exclusive write access to entity.
	* This operation ends exclusive access, and must be called after
	* ecs_write_begin().
	*
	* @param record Record to the entity.
	*/
	write_end :: proc(record: ^Record) ---

	/** Begin read access to entity.
	* This operation provides safe read access to the components of an entity.
	* Multiple simultaneous reads are allowed per entity.
	*
	* This operation ensures that code attempting to mutate the entity's table will
	* throw an assert. Note that for this to happen, asserts must be enabled. It is
	* up to the application to ensure that this does not happen, for example by
	* using a read-write mutex.
	*
	* This operation does *not* provide the same guarantees as a read-write mutex,
	* as it is possible to call ecs_read_begin() after calling ecs_write_begin(). It is
	* up to application has to ensure that this does not happen.
	*
	* This operation must be followed up with ecs_read_end().
	*
	* @param world The world.
	* @param entity The entity.
	* @return A record to the entity.
	*/
	read_begin :: proc(world: ^World, entity: Entity) -> ^Record ---

	/** End read access to entity.
	* This operation ends read access, and must be called after ecs_read_begin().
	*
	* @param record Record to the entity.
	*/
	read_end :: proc(record: ^Record) ---

	/** Get component from entity record.
	* This operation returns a pointer to a component for the entity
	* associated with the provided record. For safe access to the component, obtain
	* the record with ecs_read_begin() or ecs_write_begin().
	*
	* Obtaining a component from a record is faster than obtaining it from the
	* entity handle, as it reduces the number of lookups required.
	*
	* @param world The world.
	* @param record Record to the entity.
	* @param id The (component) id.
	* @return Pointer to component, or NULL if entity does not have the component.
	*
	* @see ecs_record_ensure_id()
	*/
	record_get_id :: proc(world: ^World, record: ^Record, id: Id) -> rawptr ---

	/** Same as ecs_record_get_id(), but returns a mutable pointer.
	* For safe access to the component, obtain the record with ecs_write_begin().
	*
	* @param world The world.
	* @param record Record to the entity.
	* @param id The (component) id.
	* @return Pointer to component, or NULL if entity does not have the component.
	*/
	record_ensure_id :: proc(world: ^World, record: ^Record, id: Id) -> rawptr ---

	/** Test if entity for record has a (component) id.
	*
	* @param world The world.
	* @param record Record to the entity.
	* @param id The (component) id.
	* @return Whether the entity has the component.
	*/
	record_has_id :: proc(world: ^World, record: ^Record, id: Id) -> bool ---

	/** Get component pointer from column/record.
	* This returns a pointer to the component using a table column index. The
	* table's column index can be found with ecs_table_get_column_index().
	*
	* Usage:
	* @code
	* ecs_record_t *r = ecs_record_find(world, entity);
	* int32_t column = ecs_table_get_column_index(world, table, ecs_id(Position));
	* Position *ptr = ecs_record_get_by_column(r, column, sizeof(Position));
	* @endcode
	*
	* @param record The record.
	* @param column The column index in the entity's table.
	* @param size The component size.
	* @return The component pointer.
	*/
	record_get_by_column :: proc(record: ^Record, column: i32, size: c.size_t) -> rawptr ---

	/** Get component record for component id.
	*
	* @param world The world.
	* @param id The component id.
	* @return The component record, or NULL if it doesn't exist.
	*/
	flecs_components_get :: proc(world: ^World, id: Id) -> ^Component_Record ---

	/* Ensure component record for component id
	*
	* @param world The world.
	* @param id The component id.
	* @return The new or existing component record.
	*/
	flecs_components_ensure :: proc(world: ^World, id: Id) -> ^Component_Record ---

	/** Get component id from component record.
	*
	* @param cr The component record.
	* @return The component id.
	*/
	flecs_component_get_id :: proc(cr: ^Component_Record) -> Id ---

	/** Get component flags for component.
	*
	* @param id The component id.
	* @return The flags for the component id.
	*/
	flecs_component_get_flags :: proc(world: ^World, id: Id) -> Flags32 ---

	/** Get type info for component record.
	*
	* @param cr The component record.
	* @return The type info struct, or NULL if component is a tag.
	*/
	flecs_component_get_type_info :: proc(cr: ^Component_Record) -> ^Type_Info ---

	/** Find table record for component record.
	* This operation returns the table record for the table/component record if it
	* exists. If the record exists, it means the table has the component.
	*
	* @param cr The component record.
	* @param table The table.
	* @return The table record if the table has the component, or NULL if not.
	*/
	flecs_component_get_table :: proc(cr: ^Component_Record, table: ^Table) -> ^Table_Record ---

	/** Ger parent record for component/table.
	* A parent record stores how many children for a parent are stored in the
	* specified table. If the table only stores a single child, the parent record
	* will also store the entity id of that child.
	*
	* This information is used by queries to determine whether an O(n) search
	* through the table is required to find all children for the parent. If the
	* table only contains a single child the query can use
	* ecs_parent_record_t::entity directly, otherwise it has to do a scan.
	*
	* The component record specified to this function must be a ChildOf pair. Only
	* tables with children that use the non-fragmenting hierarchy storage will have
	* parent records.
	*
	* @param cr The ChildOf component record.
	* @param table The table to check the number of children for.
	* @return The parent record if it exists, NULL if it does not.
	*/
	flecs_component_get_parent_record :: proc(cr: ^Component_Record, table: ^Table) -> ^Parent_Record ---

	/** Return hierarchy depth for component record.
	* The specified component record must be a ChildOf pair. This function does not
	* compute the depth, it just returns the precomputed depth that is updated
	* automatically when hierarchy changes happen.
	*
	* @param cr The ChildOf component record.
	* @return The depth of the parent's children in the hierarchy.
	*/
	flecs_component_get_childof_depth :: proc(cr: ^Component_Record) -> i32 ---

	/** Create component record iterator.
	* A component record iterator iterates all tables for the specified component
	* record.
	*
	* The iterator should be used like this:
	*
	* @code
	* ecs_table_cache_iter_t it;
	* if (flecs_component_iter(cr, &it)) {
	*   const ecs_table_record_t *tr;
	*   while ((tr = flecs_component_next(&it))) {
	*     ecs_table_t *table = tr->hdr.table;
	*     // ...
	*   }
	* }
	* @endcode
	*
	* @param cr The component record.
	* @param iter_out Out parameter for the iterator.
	* @return True if there are results, false if there are no results.
	*/
	flecs_component_iter :: proc(cr: ^Component_Record, iter_out: ^Table_Cache_Iter) -> bool ---

	/** Get next table record for iterator.
	* Returns next table record for iterator.
	*
	* @param iter The iterator.
	* @return The next table record, or NULL if there are no more results.
	*/
	flecs_component_next :: proc(iter: ^Table_Cache_Iter) -> ^Table_Record ---
}

/** Struct returned by flecs_table_records(). */
Table_Records :: struct {
	array: ^Table_Record,
	count: i32,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Get table records.
	* This operation returns an array with all records for the specified table.
	*
	* @param table The table.
	* @return The table records for the table.
	*/
	flecs_table_records :: proc(table: ^Table) -> Table_Records ---

	/** Get component record from table record.
	*
	* @param tr The table record.
	* @return The component record.
	*/
	flecs_table_record_get_component :: proc(tr: ^Table_Record) -> ^Component_Record ---

	/** Get table id.
	* This operation returns a unique numerical identifier for a table.
	*
	* @param table The table.
	* @return The table records for the table.
	*/
	flecs_table_id :: proc(table: ^Table) -> u64 ---

	/** Find table by adding id to current table.
	* Same as ecs_table_add_id, but with additional diff parameter that contains
	* information about the traversed edge.
	*
	* @param world The world.
	* @param table The table.
	* @param id_ptr Pointer to component id to add.
	* @param diff Information about traversed edge (out parameter).
	* @return The table that was traversed to.
	*/
	flecs_table_traverse_add :: proc(world: ^World, table: ^Table, id_ptr: ^Id, diff: ^Table_Diff) -> ^Table ---
}

/** Utility to hold a value of a dynamic type. */
Value :: struct {
	type: Entity, /**< Type of value. */
	ptr:  rawptr, /**< Pointer to value. */
}

/** Used with ecs_entity_init().
*
* @ingroup entities
*/
Entity_Desc :: struct {
	_canary:    i32,     /**< Used for validity testing. Must be 0. */
	id:         Entity,  /**< Set to modify existing entity (optional) */
	parent:     Entity,  /**< Parent entity. */
	name:       cstring, /**< Name of the entity. If no entity is provided, an
                           * entity with this name will be looked up first. When
                           * an entity is provided, the name will be verified
                           * with the existing entity. */
	sep:        cstring, /**< Optional custom separator for hierarchical names.
                           * Leave to NULL for default ('.') separator. Set to
                           * an empty string to prevent tokenization of name. */
	root_sep:   cstring, /**< Optional, used for identifiers relative to root */
	symbol:     cstring, /**< Optional entity symbol. A symbol is an unscoped
                           * identifier that can be used to lookup an entity. The
                           * primary use case for this is to associate the entity
                           * with a language identifier, such as a type or
                           * function name, where these identifiers differ from
                           * the name they are registered with in flecs. For
                           * example, C type "EcsPosition" might be registered
                           * as "flecs.components.transform.Position", with the
                           * symbol set to "EcsPosition". */
	use_low_id: bool,    /**< When set to true, a low id (typically reserved for
                           * components) will be used to create the entity, if
                           * no id is specified. */

	/** 0-terminated array of ids to add to the entity. */
	add: ^Id,

	/** 0-terminated array of values to set on the entity. */
	set: ^Value,

	/** String expression with components to add */
	add_expr: cstring,
}

/** Used with ecs_bulk_init().
*
* @ingroup entities
*/
Bulk_Desc :: struct {
	_canary:  i32,     /**< Used for validity testing. Must be 0. */
	entities: ^Entity, /**< Entities to bulk insert. Entity ids provided by
                             * the application must be empty (cannot
                             * have components). If no entity ids are provided, the
                             * operation will create 'count' new entities. */
	count:    i32,     /**< Number of entities to create/populate */
	ids:      [32]Id,  /**< Ids to create the entities with */
	data:     ^rawptr, /**< Array with component data to insert. Each element in
                        * the array must correspond with an element in the ids
                        * array. If an element in the ids array is a tag, the
                        * data array must contain a NULL. An element may be
                        * set to NULL for a component, in which case the
                        * component will not be set by the operation. */
	table:    ^Table,  /**< Table to insert the entities into. Should not be set
                         * at the same time as ids. When 'table' is set at the
                         * same time as 'data', the elements in the data array
                         * must correspond with the ids in the table's type. */
}

/** Used with ecs_component_init().
*
* @ingroup components
*/
Component_Desc :: struct {
	_canary: i32, /**< Used for validity testing. Must be 0. */

	/** Existing entity to associate with observer (optional) */
	entity: Entity,

	/** Parameters for type (size, hooks, ...) */
	type: Type_Info,
}

/** Iterator.
* Used for iterating queries. The ecs_iter_t type contains all the information
* that is provided by a query, and contains all the state required for the
* iterator code.
*
* Functions that create iterators accept as first argument the world, and as
* second argument the object they iterate. For example:
*
* @code
* ecs_iter_t it = ecs_query_iter(world, q);
* @endcode
*
* When this code is called from a system, it is important to use the world
* provided by its iterator object to ensure thread safety. For example:
*
* @code
* void Collide(ecs_iter_t *it) {
*   ecs_iter_t qit = ecs_query_iter(it->world, Colliders);
* }
* @endcode
*
* An iterator contains resources that need to be released. By default this
* is handled by the last call to next() that returns false. When iteration is
* ended before iteration has completed, an application has to manually call
* ecs_iter_fini() to release the iterator resources:
*
* @code
* ecs_iter_t it = ecs_query_iter(world, q);
* while (ecs_query_next(&it)) {
*   if (cond) {
*     ecs_iter_fini(&it);
*     break;
*   }
* }
* @endcode
*
* @ingroup queries
*/
Iter :: struct {
	/* World */
	world:      ^World, /**< The world. Can point to stage when in deferred/readonly mode. */
	real_world: ^World, /**< Actual world. Never points to a stage. */

	/* Matched data */
	offset:           i32,            /**< Offset relative to current table */
	count:            i32,            /**< Number of entities to iterate */
	entities:         ^Entity,        /**< Entity identifiers */
	ptrs:             ^rawptr,        /**< Component pointers. If not set or if it's NULL for a field, use it.trs. */
	trs:              ^^Table_Record, /**< Info on where to find field in table */
	sizes:            ^Size,          /**< Component sizes */
	table:            ^Table,         /**< Current table */
	other_table:      ^Table,         /**< Prev or next table when adding/removing */
	ids:              ^Id,            /**< (Component) ids */
	sources:          ^Entity,        /**< Entity on which the id was matched (0 if same as entities) */
	constrained_vars: Flags64,        /**< Bitset that marks constrained variables */
	set_fields:       Flags32,        /**< Fields that are set */
	ref_fields:       Flags32,        /**< Bitset with fields that aren't component arrays */
	row_fields:       Flags32,        /**< Fields that must be obtained with field_at */
	up_fields:        Flags32,        /**< Bitset with fields matched through up traversal */

	/* Input information */
	system:    Entity, /**< The system (if applicable) */
	event:     Entity, /**< The event (if applicable) */
	event_id:  Id,     /**< The (component) id for the event */
	event_cur: i32,    /**< Unique event id. Used to dedup observer calls */

	/* Query information */
	field_count: i8,     /**< Number of fields in iterator */
	term_index:  i8,     /**< Index of term that emitted an event.
                                   * This field will be set to the 'index' field
                                   * of an observer term. */
	query:       ^Query, /**< Query being evaluated */

	/* Context */
	param:        rawptr, /**< Param passed to ecs_run */
	ctx:          rawptr, /**< System context */
	binding_ctx:  rawptr, /**< System binding context */
	callback_ctx: rawptr, /**< Callback language binding context */
	run_ctx:      rawptr, /**< Run language binding context */

	/* Time */
	delta_time:        f32, /**< Time elapsed since last frame */
	delta_system_time: f32, /**< Time elapsed since last system invocation */

	/* Iterator counters */
	frame_offset: i32, /**< Offset relative to start of iteration */

	/* Misc */
	flags:          Flags32,      /**< Iterator flags */
	interrupted_by: Entity,       /**< When set, system execution is interrupted */
	priv_:          Iter_Private, /**< Private data */

	/* Chained iterators */
	next:     Iter_Next_Action, /**< Function to progress iterator */
	callback: Iter_Action,      /**< Callback of system or observer */
	fini:     Iter_Fini_Action, /**< Function to cleanup iterator resources */
	chain_it: ^Iter,            /**< Optional, allows for creating iterator chains */
}

/** Query must match prefabs.
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
* \ingroup queries
*/
EcsQueryMatchPrefab           :: (1<<1)

/** Query must match disabled entities.
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
* \ingroup queries
*/
EcsQueryMatchDisabled         :: (1<<2)

/** Query must match empty tables.
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
* \ingroup queries
*/
EcsQueryMatchEmptyTables      :: (1<<3)

/** Query may have unresolved entity identifiers.
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
* \ingroup queries
*/
EcsQueryAllowUnresolvedByName :: (1<<6)

/** Query only returns whole tables (ignores toggle/member fields).
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
* \ingroup queries
*/
EcsQueryTableOnly             :: (1<<7)

/** Enable change detection for query.
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
*
* Adding this flag makes it possible to use ecs_query_changed() and
* ecs_iter_changed() with the query. Change detection requires the query to be
* cached. If cache_kind is left to the default value, this flag will cause it
* to default to EcsQueryCacheAuto.
*
* \ingroup queries
*/
EcsQueryDetectChanges         :: (1<<8)

/** Used with ecs_query_init().
*
* \ingroup queries
*/
Query_Desc :: struct {
	/** Used for validity testing. Must be 0. */
	_canary: i32,

	/** Query terms */
	terms: [32]Term,

	/** Query DSL expression (optional) */
	expr: cstring,

	/** Caching policy of query */
	cache_kind: Query_Cache_Kind,

	/** Flags for enabling query features */
	flags: Flags32,

	/** Callback used for ordering query results. If order_by_id is 0, the
	* pointer provided to the callback will be NULL. If the callback is not
	* set, results will not be ordered. */
	order_by_callback: Order_By_Action,

	/** Callback used for ordering query results. Same as order_by_callback,
	* but more efficient. */
	order_by_table_callback: Sort_Table_Action,

	/** Component to sort on, used together with order_by_callback or
	* order_by_table_callback. */
	order_by: Entity,

	/** Component id to be used for grouping. Used together with the
	* group_by_callback. */
	group_by: Id,

	/** Callback used for grouping results. If the callback is not set, results
	* will not be grouped. When set, this callback will be used to calculate a
	* "rank" for each entity (table) based on its components. This rank is then
	* used to sort entities (tables), so that entities (tables) of the same
	* rank are "grouped" together when iterated. */
	group_by_callback: Group_By_Action,

	/** Callback that is invoked when a new group is created. The return value of
	* the callback is stored as context for a group. */
	on_group_create: Group_Create_Action,

	/** Callback that is invoked when an existing group is deleted. The return
	* value of the on_group_create callback is passed as context parameter. */
	on_group_delete: Group_Delete_Action,

	/** Context to pass to group_by */
	group_by_ctx: rawptr,

	/** Function to free group_by_ctx */
	group_by_ctx_free: Ctx_Free,

	/** User context to pass to callback */
	ctx: rawptr,

	/** Context to be used for language bindings */
	binding_ctx: rawptr,

	/** Callback to free ctx */
	ctx_free: Ctx_Free,

	/** Callback to free binding_ctx */
	binding_ctx_free: Ctx_Free,

	/** Entity associated with query (optional) */
	entity: Entity,
}

/** Used with ecs_observer_init().
*
* @ingroup observers
*/
Observer_Desc :: struct {
	/** Used for validity testing. Must be 0. */
	_canary: i32,

	/** Existing entity to associate with observer (optional) */
	entity: Entity,

	/** Query for observer */
	query: Query_Desc,

	/** Events to observe (OnAdd, OnRemove, OnSet) */
	events: [8]Entity,

	/** When observer is created, generate events from existing data. For example,
	* #EcsOnAdd `Position` would match all existing instances of `Position`. */
	yield_existing: bool,

	/** Global observers are tied to the lifespan of the world. Creating a
	* global observer does not create an entity, and therefore
	* ecs_observer_init will not return an entity handle. */
	global_observer: bool,

	/** Callback to invoke on an event, invoked when the observer matches. */
	callback: Iter_Action,

	/** Callback invoked on an event. When left to NULL the default runner
	* is used which matches the event with the observer's query, and calls
	* 'callback' when it matches.
	* A reason to override the run function is to improve performance, if there
	* are more efficient way to test whether an event matches the observer than
	* the general purpose query matcher. */
	run: Run_Action,

	/** User context to pass to callback */
	ctx: rawptr,

	/** Callback to free ctx */
	ctx_free: Ctx_Free,

	/** Context associated with callback (for language bindings). */
	callback_ctx: rawptr,

	/** Callback to free callback ctx. */
	callback_ctx_free: Ctx_Free,

	/** Context associated with run (for language bindings). */
	run_ctx: rawptr,

	/** Callback to free run ctx. */
	run_ctx_free: Ctx_Free,

	/** Used for internal purposes. Do not set. */
	last_event_id: ^i32,
	term_index_:   i8,
	flags_:        Flags32,
}

/** Used with ecs_emit().
*
* @ingroup observers
*/
Event_Desc :: struct {
	/** The event id. Only observers for the specified event will be notified */
	event: Entity,

	/** Component ids. Only observers with a matching component id will be
	* notified. Observers are guaranteed to get notified once, even if they
	* match more than one id. */
	ids: ^Type,

	/** The table for which to notify. */
	table: ^Table,

	/** Optional 2nd table to notify. This can be used to communicate the
	* previous or next table, in case an entity is moved between tables. */
	other_table: ^Table,

	/** Limit notified entities to ones starting from offset (row) in table */
	offset: i32,

	/** Limit number of notified entities to count. offset+count must be less
	* than the total number of entities in the table. If left to 0, it will be
	* automatically determined by doing `ecs_table_count(table) - offset`. */
	count: i32,

	/** Single-entity alternative to setting table / offset / count */
	entity: Entity,

	/** Optional context.
	* The type of the param must be the event, where the event is a component.
	* When an event is enqueued, the value of param is coped to a temporary
	* storage of the event type. */
	param: rawptr,

	/** Same as param, but with the guarantee that the value won't be modified.
	* When an event with a const parameter is enqueued, the value of the param
	* is copied to a temporary storage of the event type. */
	const_param: rawptr,

	/** Observable (usually the world) */
	observable: ^Poly,

	/** Event flags */
	flags: Flags32,
}

/** Type with information about the current Flecs build */
Build_Info :: struct {
	compiler:      cstring,  /**< Compiler used to compile flecs */
	addons:        ^cstring, /**< Addons included in build */
	flags:         ^cstring, /**< Compile time settings */
	version:       cstring,  /**< Stringified version */
	version_major: i16,      /**< Major flecs version */
	version_minor: i16,      /**< Minor flecs version */
	version_patch: i16,      /**< Patch flecs version */
	debug:         bool,     /**< Is this a debug build */
	sanitize:      bool,     /**< Is this a sanitize build */
	perf_trace:    bool,     /**< Is this a perf tracing build */
}

/** Type that contains information about the world. */
World_Info :: struct {
	last_component_id:          Entity, /**< Last issued component entity id */
	min_id:                     Entity, /**< First allowed entity id */
	max_id:                     Entity, /**< Last allowed entity id */
	delta_time_raw:             f32,    /**< Raw delta time (no time scaling) */
	delta_time:                 f32,    /**< Time passed to or computed by ecs_progress() */
	time_scale:                 f32,    /**< Time scale applied to delta_time */
	target_fps:                 f32,    /**< Target fps */
	frame_time_total:           f32,    /**< Total time spent processing a frame */
	system_time_total:          f32,    /**< Total time spent in systems */
	emit_time_total:            f32,    /**< Total time spent notifying observers */
	merge_time_total:           f32,    /**< Total time spent in merges */
	rematch_time_total:         f32,    /**< Time spent on query rematching */
	world_time_total:           f64,    /**< Time elapsed in simulation */
	world_time_total_raw:       f64,    /**< Time elapsed in simulation (no scaling) */
	frame_count_total:          i64,    /**< Total number of frames */
	merge_count_total:          i64,    /**< Total number of merges */
	eval_comp_monitors_total:   i64,    /**< Total number of monitor evaluations */
	rematch_count_total:        i64,    /**< Total number of rematches */
	id_create_total:            i64,    /**< Total number of times a new id was created */
	id_delete_total:            i64,    /**< Total number of times an id was deleted */
	table_create_total:         i64,    /**< Total number of times a table was created */
	table_delete_total:         i64,    /**< Total number of times a table was deleted */
	pipeline_build_count_total: i64,    /**< Total number of pipeline builds */
	systems_ran_total:          i64,    /**< Total number of systems ran */
	observers_ran_total:        i64,    /**< Total number of times observer was invoked */
	queries_ran_total:          i64,    /**< Total number of times a query was evaluated */
	tag_id_count:               i32,    /**< Number of tag (no data) ids in the world */
	component_id_count:         i32,    /**< Number of component (data) ids in the world */
	pair_id_count:              i32,    /**< Number of pair ids in the world */
	table_count:                i32,    /**< Number of tables */
	creation_time:              u32,    /**< Time when world was created */

	cmd: struct {
		add_count:             i64, /**< Add commands processed */
		remove_count:          i64, /**< Remove commands processed */
		delete_count:          i64, /**< Delete commands processed */
		clear_count:           i64, /**< Clear commands processed */
		set_count:             i64, /**< Set commands processed */
		ensure_count:          i64, /**< Ensure/emplace commands processed */
		modified_count:        i64, /**< Modified commands processed */
		discard_count:         i64, /**< Commands discarded, happens when entity is no longer alive when running the command */
		event_count:           i64, /**< Enqueued custom events */
		other_count:           i64, /**< Other commands processed */
		batched_entity_count:  i64, /**< Entities for which commands were batched */
		batched_command_count: i64, /**< Commands batched */
	}, /**< Command statistics. */

	name_prefix: cstring, /**< Value set by ecs_set_name_prefix(). Used
                                       * to remove library prefixes of symbol
                                       * names (such as `Ecs`, `ecs_`) when
                                       * registering them as names. */
}

/** Type that contains information about a query group. */
Query_Group_Info :: struct {
	id:          u64,
	match_count: i32,    /**< How often tables have been matched/unmatched */
	table_count: i32,    /**< Number of tables in group */
	ctx:         rawptr, /**< Group context, returned by on_group_create */
}

/** A (string) identifier. Used as pair with #EcsName and #EcsSymbol tags */
Ecs_Identifier :: struct {
	value:      cstring,  /**< Identifier string */
	length:     Size,     /**< Length of identifier */
	hash:       u64,      /**< Hash of current value */
	index_hash: u64,      /**< Hash of existing record in current index */
	index:      ^Hashmap, /**< Current index */
}

/** Component information. */
Ecs_Component :: struct {
	size:      Size, /**< Component size */
	alignment: Size, /**< Component alignment */
}

/** Component for storing a poly object */
Ecs_Poly :: struct {
	poly: ^Poly, /**< Pointer to poly object */
}

/** When added to an entity this informs serialization formats which component
* to use when a value is assigned to an entity without specifying the
* component. This is intended as a hint, serialization formats are not required
* to use it. Adding this component does not change the behavior of core ECS
* operations. */
Ecs_Default_Child_Component :: struct {
	component: Id, /**< Default component id. */
}

/* Non-fragmenting ChildOf relationship. */
Ecs_Parent :: struct {
	value: Entity,
}

/* Component with data to instantiate a non-fragmenting tree. */
Tree_Spawner_Child :: struct {
	child_name:   cstring, /* Name of prefab child */
	table:        ^Table,  /* Table in which child will be stored */
	child:        u32,     /* Prefab child entity (without generation) */
	parent_index: i32,     /* Index into children vector */
}

Tree_Spawner :: struct {
	children: Vec, /* vector<ecs_tree_spawner_child_t> */
}

Ecs_Tree_Spawner :: struct {
	/* Tree instantiation cache, indexed by depth. Tables will have a
	* (ParentDepth, depth) pair indicating the hierarchy depth. This means that
	* for different depths, the tables the children are created in will also be
	* different. Caching tables for different depths therefore speeds up
	* instantiating trees even when the top level entity is not at the root. */
	data: [6]Tree_Spawner,
}

foreign lib {
	/** Indicates that the id is a pair. */
	ECS_PAIR : Id

	/** Automatically override component when it is inherited */
	ECS_AUTO_OVERRIDE : Id

	/** Adds bitset to storage which allows component to be enabled/disabled */
	ECS_TOGGLE : Id

	/** Indicates that the target of a pair is an integer value. */
	ECS_VALUE_PAIR                      : Id
	FLECS_IDEcsComponentID_             : Entity
	FLECS_IDEcsIdentifierID_            : Entity
	FLECS_IDEcsPolyID_                  : Entity
	FLECS_IDEcsParentID_                : Entity
	FLECS_IDEcsTreeSpawnerID_           : Entity
	FLECS_IDEcsDefaultChildComponentID_ : Entity

	/** Relationship storing the entity's depth in a non-fragmenting hierarchy. */
	EcsParentDepth : Entity

	/** Tag added to queries. */
	EcsQuery : Entity

	/** Tag added to observers. */
	EcsObserver : Entity

	/** Tag added to systems. */
	EcsSystem                   : Entity
	FLECS_IDEcsTickSourceID_    : Entity
	FLECS_IDEcsPipelineQueryID_ : Entity
	FLECS_IDEcsTimerID_         : Entity
	FLECS_IDEcsRateFilterID_    : Entity

	/** Root scope for builtin flecs entities */
	EcsFlecs : Entity

	/** Core module scope */
	EcsFlecsCore : Entity

	/** Entity associated with world (used for "attaching" components to world) */
	EcsWorld : Entity

	/** Wildcard entity ("*"). Matches any id, returns all matches. */
	EcsWildcard : Entity

	/** Any entity ("_"). Matches any id, returns only the first. */
	EcsAny : Entity

	/** This entity. Default source for queries. */
	EcsThis : Entity

	/** Variable entity ("$"). Used in expressions to prefix variable names */
	EcsVariable : Entity

	/** Marks a relationship as transitive.
	* Behavior:
	*
	* @code
	*   if R(X, Y) and R(Y, Z) then R(X, Z)
	* @endcode
	*/
	EcsTransitive : Entity

	/** Marks a relationship as reflexive.
	* Behavior:
	*
	* @code
	*   R(X, X) == true
	* @endcode
	*/
	EcsReflexive : Entity

	/** Ensures that entity/component cannot be used as target in `IsA` relationship.
	* Final can improve the performance of queries as they will not attempt to
	* substitute a final component with its subsets.
	*
	* Behavior:
	*
	* @code
	*   if IsA(X, Y) and Final(Y) throw error
	* @endcode
	*/
	EcsFinal : Entity

	/** Mark component as inheritable.
	* This is the opposite of Final. This trait can be used to enforce that queries
	* take into account component inheritance before inheritance (IsA)
	* relationships are added with the component as target.
	*/
	EcsInheritable : Entity

	/** Relationship that specifies component inheritance behavior. */
	EcsOnInstantiate : Entity

	/** Override component on instantiate.
	* This will copy the component from the base entity `(IsA target)` to the
	* instance. The base component will never be inherited from the prefab. */
	EcsOverride : Entity

	/** Inherit component on instantiate.
	* This will inherit (share) the component from the base entity `(IsA target)`.
	* The component can be manually overridden by adding it to the instance. */
	EcsInherit : Entity

	/** Never inherit component on instantiate.
	* This will not copy or share the component from the base entity `(IsA target)`.
	* When the component is added to an instance, its value will never be copied
	* from the base entity. */
	EcsDontInherit : Entity

	/** Marks relationship as commutative.
	* Behavior:
	*
	* @code
	*   if R(X, Y) then R(Y, X)
	* @endcode
	*/
	EcsSymmetric : Entity

	/** Can be added to relationship to indicate that the relationship can only occur
	* once on an entity. Adding a 2nd instance will replace the 1st.
	*
	* Behavior:
	*
	* @code
	*   R(X, Y) + R(X, Z) = R(X, Z)
	* @endcode
	*/
	EcsExclusive : Entity

	/** Marks a relationship as acyclic. Acyclic relationships may not form cycles. */
	EcsAcyclic : Entity

	/** Marks a relationship as traversable. Traversable relationships may be
	* traversed with "up" queries. Traversable relationships are acyclic. */
	EcsTraversable : Entity

	/** Ensure that a component always is added together with another component.
	*
	* Behavior:
	*
	* @code
	*   If With(R, O) and R(X) then O(X)
	*   If With(R, O) and R(X, Y) then O(X, Y)
	* @endcode
	*/
	EcsWith : Entity

	/** Ensure that relationship target is child of specified entity.
	*
	* Behavior:
	*
	* @code
	*   If OneOf(R, O) and R(X, Y), Y must be a child of O
	*   If OneOf(R) and R(X, Y), Y must be a child of R
	* @endcode
	*/
	EcsOneOf : Entity

	/** Mark a component as toggleable with ecs_enable_id(). */
	EcsCanToggle : Entity

	/** Can be added to components to indicate it is a trait. Traits are components
	* and/or tags that are added to other components to modify their behavior.
	*/
	EcsTrait : Entity

	/** Ensure that an entity is always used in pair as relationship.
	*
	* Behavior:
	*
	* @code
	*   e.add(R) panics
	*   e.add(X, R) panics, unless X has the "Trait" trait
	* @endcode
	*/
	EcsRelationship : Entity

	/** Ensure that an entity is always used in pair as target.
	*
	* Behavior:
	*
	* @code
	*   e.add(T) panics
	*   e.add(T, X) panics
	* @endcode
	*/
	EcsTarget : Entity

	/** Can be added to relationship to indicate that it should never hold data,
	* even when it or the relationship target is a component. */
	EcsPairIsTag : Entity

	/** Tag to indicate name identifier */
	EcsName : Entity

	/** Tag to indicate symbol identifier */
	EcsSymbol : Entity

	/** Tag to indicate alias identifier */
	EcsAlias : Entity

	/** Used to express parent-child relationships. */
	EcsChildOf : Entity

	/** Used to express inheritance relationships. */
	EcsIsA : Entity

	/** Used to express dependency relationships */
	EcsDependsOn : Entity

	/** Used to express a slot (used with prefab inheritance) */
	EcsSlotOf : Entity

	/** Tag that when added to a parent ensures stable order of ecs_children result. */
	EcsOrderedChildren : Entity

	/** Tag added to module entities */
	EcsModule : Entity

	/** Tag added to prefab entities. Any entity with this tag is automatically
	* ignored by queries, unless #EcsPrefab is explicitly queried for. */
	EcsPrefab : Entity

	/** When this tag is added to an entity it is skipped by queries, unless
	* #EcsDisabled is explicitly queried for. */
	EcsDisabled : Entity

	/** Trait added to entities that should never be returned by queries. Reserved
	* for internal entities that have special meaning to the query engine, such as
	* #EcsThis, #EcsWildcard, #EcsAny. */
	EcsNotQueryable : Entity

	/** Event that triggers when an id is added to an entity */
	EcsOnAdd : Entity

	/** Event that triggers when an id is removed from an entity */
	EcsOnRemove : Entity

	/** Event that triggers when a component is set for an entity */
	EcsOnSet : Entity

	/** Event that triggers observer when an entity starts/stops matching a query */
	EcsMonitor : Entity

	/** Event that triggers when a table is created. */
	EcsOnTableCreate : Entity

	/** Event that triggers when a table is deleted. */
	EcsOnTableDelete : Entity

	/** Relationship used for specifying cleanup behavior. */
	EcsOnDelete : Entity

	/** Relationship used to define what should happen when a target entity (second
	* element of a pair) is deleted. */
	EcsOnDeleteTarget : Entity

	/** Remove cleanup policy. Must be used as target in pair with #EcsOnDelete or
	* #EcsOnDeleteTarget. */
	EcsRemove : Entity

	/** Delete cleanup policy. Must be used as target in pair with #EcsOnDelete or
	* #EcsOnDeleteTarget. */
	EcsDelete : Entity

	/** Panic cleanup policy. Must be used as target in pair with #EcsOnDelete or
	* #EcsOnDeleteTarget. */
	EcsPanic : Entity

	/** Mark component as singleton. Singleton components may only be added to
	* themselves. */
	EcsSingleton : Entity

	/** Mark component as sparse */
	EcsSparse : Entity

	/** Mark component as non-fragmenting */
	EcsDontFragment : Entity

	/** Marker used to indicate `$var == ...` matching in queries. */
	EcsPredEq : Entity

	/** Marker used to indicate `$var == "name"` matching in queries. */
	EcsPredMatch : Entity

	/** Marker used to indicate `$var ~= "pattern"` matching in queries. */
	EcsPredLookup : Entity

	/** Marker used to indicate the start of a scope (`{`) in queries. */
	EcsScopeOpen : Entity

	/** Marker used to indicate the end of a scope (`}`) in queries. */
	EcsScopeClose : Entity

	/** Tag used to indicate query is empty.
	* This tag is removed automatically when a query becomes non-empty, and is not
	* automatically re-added when it becomes empty.
	*/
	EcsEmpty               : Entity
	FLECS_IDEcsPipelineID_ : Entity /**< Pipeline component id. */

	/**< OnStart pipeline phase. */
	EcsOnStart : Entity /**< OnStart pipeline phase. */

	/**< PreFrame pipeline phase. */
	EcsPreFrame : Entity /**< PreFrame pipeline phase. */

	/**< OnLoad pipeline phase. */
	EcsOnLoad : Entity /**< OnLoad pipeline phase. */

	/**< PostLoad pipeline phase. */
	EcsPostLoad : Entity /**< PostLoad pipeline phase. */

	/**< PreUpdate pipeline phase. */
	EcsPreUpdate : Entity /**< PreUpdate pipeline phase. */

	/**< OnUpdate pipeline phase. */
	EcsOnUpdate : Entity /**< OnUpdate pipeline phase. */

	/**< OnValidate pipeline phase. */
	EcsOnValidate : Entity /**< OnValidate pipeline phase. */

	/**< PostUpdate pipeline phase. */
	EcsPostUpdate : Entity /**< PostUpdate pipeline phase. */

	/**< PreStore pipeline phase. */
	EcsPreStore : Entity /**< PreStore pipeline phase. */

	/**< OnStore pipeline phase. */
	EcsOnStore : Entity /**< OnStore pipeline phase. */

	/**< PostFrame pipeline phase. */
	EcsPostFrame : Entity /**< PostFrame pipeline phase. */

	/**< Phase pipeline phase. */
	EcsPhase : Entity /**< Phase pipeline phase. */

	/**< Tag added to enum/bitmask constants. */
	EcsConstant : Entity /**< Tag added to enum/bitmask constants. */
}

/** The first user-defined component starts from this id. Ids up to this number
* are reserved for builtin components */
EcsFirstUserComponentId :: (8)

/** The first user-defined entity starts from this id. Ids up to this number
* are reserved for builtin entities */
EcsFirstUserEntityId :: (FLECS_HI_COMPONENT_ID+128)

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new world.
	* This operation automatically imports modules from addons Flecs has been built
	* with, except when the module specifies otherwise.
	*
	* @return A new world
	*/
	init :: proc() -> ^World ---

	/** Create a new world with just the core module.
	* Same as ecs_init(), but doesn't import modules from addons. This operation is
	* faster than ecs_init() and results in less memory utilization.
	*
	* @return A new tiny world
	*/
	mini :: proc() -> ^World ---

	/** Create a new world with arguments.
	* Same as ecs_init(), but allows passing in command line arguments. Command line
	* arguments are used to:
	* - automatically derive the name of the application from argv[0]
	*
	* @return A new world
	*/
	init_w_args :: proc(argc: i32, argv: [^]cstring) -> ^World ---

	/** Delete a world.
	* This operation deletes the world, and everything it contains.
	*
	* @param world The world to delete.
	* @return Zero if successful, non-zero if failed.
	*/
	fini :: proc(world: ^World) -> i32 ---

	/** Returns whether the world is being deleted.
	* This operation can be used in callbacks like type hooks or observers to
	* detect if they are invoked while the world is being deleted.
	*
	* @param world The world.
	* @return True if being deleted, false if not.
	*/
	is_fini :: proc(world: ^World) -> bool ---

	/** Register action to be executed when world is destroyed.
	* Fini actions are typically used when a module needs to clean up before a
	* world shuts down.
	*
	* @param world The world.
	* @param action The function to execute.
	* @param ctx Userdata to pass to the function */
	atfini :: proc(world: ^World, action: Fini_Action, ctx: rawptr) ---
}

/** Type returned by ecs_get_entities(). */
Entities :: struct {
	ids:         ^Entity, /**< Array with all entity ids in the world. */
	count:       i32,     /**< Total number of entity ids. */
	alive_count: i32,     /**< Number of alive entity ids. */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Return entity identifiers in world.
	* This operation returns an array with all entity ids that exist in the world.
	* Note that the returned array will change and may get invalidated as a result
	* of entity creation & deletion.
	*
	* To iterate all alive entity ids, do:
	* @code
	* ecs_entities_t entities = ecs_get_entities(world);
	* for (int i = 0; i < entities.alive_count; i ++) {
	*   ecs_entity_t id = entities.ids[i];
	* }
	* @endcode
	*
	* To iterate not-alive ids, do:
	* @code
	* for (int i = entities.alive_count + 1; i < entities.count; i ++) {
	*   ecs_entity_t id = entities.ids[i];
	* }
	* @endcode
	*
	* The returned array does not need to be freed. Mutating the returned array
	* will return in undefined behavior (and likely crashes).
	*
	* @param world The world.
	* @return Struct with entity id array.
	*/
	get_entities :: proc(world: ^World) -> Entities ---

	/** Get flags set on the world.
	* This operation returns the internal flags (see api_flags.h) that are
	* set on the world.
	*
	* @param world The world.
	* @return Flags set on the world.
	*/
	world_get_flags :: proc(world: ^World) -> Flags32 ---

	/** Begin frame.
	* When an application does not use ecs_progress() to control the main loop, it
	* can still use Flecs features such as FPS limiting and time measurements. This
	* operation needs to be invoked whenever a new frame is about to get processed.
	*
	* Calls to ecs_frame_begin() must always be followed by ecs_frame_end().
	*
	* The function accepts a delta_time parameter, which will get passed to
	* systems. This value is also used to compute the amount of time the function
	* needs to sleep to ensure it does not exceed the target_fps, when it is set.
	* When 0 is provided for delta_time, the time will be measured.
	*
	* This function should only be ran from the main thread.
	*
	* @param world The world.
	* @param delta_time Time elapsed since the last frame.
	* @return The provided delta_time, or measured time if 0 was provided.
	*/
	frame_begin :: proc(world: ^World, delta_time: f32) -> f32 ---

	/** End frame.
	* This operation must be called at the end of the frame, and always after
	* ecs_frame_begin().
	*
	* @param world The world.
	*/
	frame_end :: proc(world: ^World) ---

	/** Register action to be executed once after frame.
	* Post frame actions are typically used for calling operations that cannot be
	* invoked during iteration, such as changing the number of threads.
	*
	* @param world The world.
	* @param action The function to execute.
	* @param ctx Userdata to pass to the function */
	run_post_frame :: proc(world: ^World, action: Fini_Action, ctx: rawptr) ---

	/** Signal exit
	* This operation signals that the application should quit. It will cause
	* ecs_progress() to return false.
	*
	* @param world The world to quit.
	*/
	quit :: proc(world: ^World) ---

	/** Return whether a quit has been requested.
	*
	* @param world The world.
	* @return Whether a quit has been requested.
	* @see ecs_quit()
	*/
	should_quit :: proc(world: ^World) -> bool ---

	/** Measure frame time.
	* Frame time measurements measure the total time passed in a single frame, and
	* how much of that time was spent on systems and on merging.
	*
	* Frame time measurements add a small constant-time overhead to an application.
	* When an application sets a target FPS, frame time measurements are enabled by
	* default.
	*
	* @param world The world.
	* @param enable Whether to enable or disable frame time measuring.
	*/
	measure_frame_time :: proc(world: ^World, enable: bool) ---

	/** Measure system time.
	* System time measurements measure the time spent in each system.
	*
	* System time measurements add overhead to every system invocation and
	* therefore have a small but measurable impact on application performance.
	* System time measurements must be enabled before obtaining system statistics.
	*
	* @param world The world.
	* @param enable Whether to enable or disable system time measuring.
	*/
	measure_system_time :: proc(world: ^World, enable: bool) ---

	/** Set target frames per second (FPS) for application.
	* Setting the target FPS ensures that ecs_progress() is not invoked faster than
	* the specified FPS. When enabled, ecs_progress() tracks the time passed since
	* the last invocation, and sleeps the remaining time of the frame (if any).
	*
	* This feature ensures systems are ran at a consistent interval, as well as
	* conserving CPU time by not running systems more often than required.
	*
	* Note that ecs_progress() only sleeps if there is time left in the frame. Both
	* time spent in flecs as time spent outside of flecs are taken into
	* account.
	*
	* @param world The world.
	* @param fps The target FPS.
	*/
	set_target_fps :: proc(world: ^World, fps: f32) ---

	/** Set default query flags.
	* Set a default value for the ecs_filter_desc_t::flags field. Default flags
	* are applied in addition to the flags provided in the descriptor. For a
	* list of available flags, see include/flecs/private/api_flags.h. Typical flags
	* to use are:
	*
	*  - `EcsQueryMatchEmptyTables`
	*  - `EcsQueryMatchDisabled`
	*  - `EcsQueryMatchPrefab`
	*
	* @param world The world.
	* @param flags The query flags.
	*/
	set_default_query_flags :: proc(world: ^World, flags: Flags32) ---

	/** Begin readonly mode.
	* This operation puts the world in readonly mode, which disallows mutations on
	* the world. Readonly mode exists so that internal mechanisms can implement
	* optimizations that certain aspects of the world to not change, while also
	* providing a mechanism for applications to prevent accidental mutations in,
	* for example, multithreaded applications.
	*
	* Readonly mode is a stronger version of deferred mode. In deferred mode
	* ECS operations such as add/remove/set/delete etc. are added to a command
	* queue to be executed later. In readonly mode, operations that could break
	* scheduler logic (such as creating systems, queries) are also disallowed.
	*
	* Readonly mode itself has a single threaded and a multi threaded mode. In
	* single threaded mode certain mutations on the world are still allowed, for
	* example:
	* - Entity liveliness operations (such as new, make_alive), so that systems are
	*   able to create new entities.
	* - Implicit component registration, so that this works from systems
	* - Mutations to supporting data structures for the evaluation of uncached
	*   queries (filters), so that these can be created on the fly.
	*
	* These mutations are safe in a single threaded applications, but for
	* multithreaded applications the world needs to be entirely immutable. For this
	* purpose multi threaded readonly mode exists, which disallows all mutations on
	* the world. This means that in multi threaded applications, entity liveliness
	* operations, implicit component registration, and on-the-fly query creation
	* are not guaranteed to work.
	*
	* While in readonly mode, applications can still enqueue ECS operations on a
	* stage. Stages are managed automatically when using the pipeline addon and
	* ecs_progress(), but they can also be configured manually as shown here:
	*
	* @code
	* // Number of stages typically corresponds with number of threads
	* ecs_set_stage_count(world, 2);
	* ecs_stage_t *stage = ecs_get_stage(world, 1);
	*
	* ecs_readonly_begin(world);
	* ecs_add(world, e, Tag); // readonly assert
	* ecs_add(stage, e, Tag); // OK
	* @endcode
	*
	* When an attempt is made to perform an operation on a world in readonly mode,
	* the code will throw an assert saying that the world is in readonly mode.
	*
	* A call to ecs_readonly_begin() must be followed up with ecs_readonly_end().
	* When ecs_readonly_end() is called, all enqueued commands from configured
	* stages are merged back into the world. Calls to ecs_readonly_begin() and
	* ecs_readonly_end() should always happen from a context where the code has
	* exclusive access to the world. The functions themselves are not thread safe.
	*
	* In a typical application, a (non-exhaustive) call stack that uses
	* ecs_readonly_begin() and ecs_readonly_end() will look like this:
	*
	* @code
	* ecs_progress()
	*   ecs_readonly_begin()
	*     ecs_defer_begin()
	*
	*       // user code
	*
	*   ecs_readonly_end()
	*     ecs_defer_end()
	*@endcode
	*
	* @param world The world
	* @param multi_threaded Whether to enable readonly/multi threaded mode.
	* @return Whether world is in readonly mode.
	*/
	readonly_begin :: proc(world: ^World, multi_threaded: bool) -> bool ---

	/** End readonly mode.
	* This operation ends readonly mode, and must be called after
	* ecs_readonly_begin(). Operations that were deferred while the world was in
	* readonly mode will be flushed.
	*
	* @param world The world
	*/
	readonly_end :: proc(world: ^World) ---

	/** Merge stage.
	* This will merge all commands enqueued for a stage.
	*
	* @param stage The stage.
	*/
	merge :: proc(stage: ^World) ---

	/** Defer operations until end of frame.
	* When this operation is invoked while iterating, operations inbetween the
	* ecs_defer_begin() and ecs_defer_end() operations are executed at the end
	* of the frame.
	*
	* This operation is thread safe.
	*
	* @param world The world.
	* @return true if world changed from non-deferred mode to deferred mode.
	*
	* @see ecs_defer_end()
	* @see ecs_is_deferred()
	* @see ecs_defer_resume()
	* @see ecs_defer_suspend()
	* @see ecs_is_defer_suspended()
	*/
	defer_begin :: proc(world: ^World) -> bool ---

	/** End block of operations to defer.
	* See ecs_defer_begin().
	*
	* This operation is thread safe.
	*
	* @param world The world.
	* @return true if world changed from deferred mode to non-deferred mode.
	*
	* @see ecs_defer_begin()
	* @see ecs_defer_is_deferred()
	* @see ecs_defer_resume()
	* @see ecs_defer_suspend()
	*/
	defer_end :: proc(world: ^World) -> bool ---

	/** Suspend deferring but do not flush queue.
	* This operation can be used to do an undeferred operation while not flushing
	* the operations in the queue.
	*
	* An application should invoke ecs_defer_resume() before ecs_defer_end() is called.
	* The operation may only be called when deferring is enabled.
	*
	* @param world The world.
	*
	* @see ecs_defer_begin()
	* @see ecs_defer_end()
	* @see ecs_defer_is_deferred()
	* @see ecs_defer_resume()
	*/
	defer_suspend :: proc(world: ^World) ---

	/** Resume deferring.
	* See ecs_defer_suspend().
	*
	* @param world The world.
	*
	* @see ecs_defer_begin()
	* @see ecs_defer_end()
	* @see ecs_defer_is_deferred()
	* @see ecs_defer_suspend()
	*/
	defer_resume :: proc(world: ^World) ---

	/** Test if deferring is enabled for current stage.
	*
	* @param world The world.
	* @return True if deferred, false if not.
	*
	* @see ecs_defer_begin()
	* @see ecs_defer_end()
	* @see ecs_defer_resume()
	* @see ecs_defer_suspend()
	* @see ecs_is_defer_suspended()
	*/
	is_deferred :: proc(world: ^World) -> bool ---

	/** Test if deferring is suspended for current stage.
	*
	* @param world The world.
	* @return True if suspended, false if not.
	*
	* @see ecs_defer_begin()
	* @see ecs_defer_end()
	* @see ecs_is_deferred()
	* @see ecs_defer_resume()
	* @see ecs_defer_suspend()
	*/
	is_defer_suspended :: proc(world: ^World) -> bool ---

	/** Configure world to have N stages.
	* This initializes N stages, which allows applications to defer operations to
	* multiple isolated defer queues. This is typically used for applications with
	* multiple threads, where each thread gets its own queue, and commands are
	* merged when threads are synchronized.
	*
	* Note that the ecs_set_threads() function already creates the appropriate
	* number of stages. The ecs_set_stage_count() operation is useful for applications
	* that want to manage their own stages and/or threads.
	*
	* @param world The world.
	* @param stages The number of stages.
	*/
	set_stage_count :: proc(world: ^World, stages: i32) ---

	/** Get number of configured stages.
	* Return number of stages set by ecs_set_stage_count().
	*
	* @param world The world.
	* @return The number of stages used for threading.
	*/
	get_stage_count :: proc(world: ^World) -> i32 ---

	/** Get stage-specific world pointer.
	* Flecs threads can safely invoke the API as long as they have a private
	* context to write to, also referred to as the stage. This function returns a
	* pointer to a stage, disguised as a world pointer.
	*
	* Note that this function does not(!) create a new world. It simply wraps the
	* existing world in a thread-specific context, which the API knows how to
	* unwrap. The reason the stage is returned as an ecs_world_t is so that it
	* can be passed transparently to the existing API functions, vs. having to
	* create a dedicated API for threading.
	*
	* @param world The world.
	* @param stage_id The index of the stage to retrieve.
	* @return A thread-specific pointer to the world.
	*/
	get_stage :: proc(world: ^World, stage_id: i32) -> ^World ---

	/** Test whether the current world is readonly.
	* This function allows the code to test whether the currently used world
	* is readonly or whether it allows for writing.
	*
	* @param world A pointer to a stage or the world.
	* @return True if the world or stage is readonly.
	*/
	stage_is_readonly :: proc(world: ^World) -> bool ---

	/** Create unmanaged stage.
	* Create a stage whose lifecycle is not managed by the world. Must be freed
	* with ecs_stage_free().
	*
	* @param world The world.
	* @return The stage.
	*/
	stage_new :: proc(world: ^World) -> ^World ---

	/** Free unmanaged stage.
	*
	* @param stage The stage to free.
	*/
	stage_free :: proc(stage: ^World) ---

	/** Get stage id.
	* The stage id can be used by an application to learn about which stage it is
	* using, which typically corresponds with the worker thread id.
	*
	* @param world The world.
	* @return The stage id.
	*/
	stage_get_id :: proc(world: ^World) -> i32 ---

	/** Set a world context.
	* This operation allows an application to register custom data with a world
	* that can be accessed anywhere where the application has the world.
	*
	* @param world The world.
	* @param ctx A pointer to a user defined structure.
	* @param ctx_free A function that is invoked with ctx when the world is freed.
	*/
	set_ctx :: proc(world: ^World, ctx: rawptr, ctx_free: Ctx_Free) ---

	/** Set a world binding context.
	* Same as ecs_set_ctx() but for binding context. A binding context is intended
	* specifically for language bindings to store binding specific data.
	*
	* @param world The world.
	* @param ctx A pointer to a user defined structure.
	* @param ctx_free A function that is invoked with ctx when the world is freed.
	*/
	set_binding_ctx :: proc(world: ^World, ctx: rawptr, ctx_free: Ctx_Free) ---

	/** Get the world context.
	* This operation retrieves a previously set world context.
	*
	* @param world The world.
	* @return The context set with ecs_set_ctx(). If no context was set, the
	*         function returns NULL.
	*/
	get_ctx :: proc(world: ^World) -> rawptr ---

	/** Get the world binding context.
	* This operation retrieves a previously set world binding context.
	*
	* @param world The world.
	* @return The context set with ecs_set_binding_ctx(). If no context was set, the
	*         function returns NULL.
	*/
	get_binding_ctx :: proc(world: ^World) -> rawptr ---

	/** Get build info.
	*  Returns information about the current Flecs build.
	*
	* @return A struct with information about the current Flecs build.
	*/
	get_build_info :: proc() -> ^Build_Info ---

	/** Get world info.
	*
	* @param world The world.
	* @return Pointer to the world info. Valid for as long as the world exists.
	*/
	get_world_info :: proc(world: ^World) -> ^World_Info ---

	/** Dimension the world for a specified number of entities.
	* This operation will preallocate memory in the world for the specified number
	* of entities. Specifying a number lower than the current number of entities in
	* the world will have no effect.
	*
	* @param world The world.
	* @param entity_count The number of entities to preallocate.
	*/
	dim :: proc(world: ^World, entity_count: i32) ---

	/** Free unused memory.
	* This operation frees allocated memory that is no longer in use by the world.
	* Examples of allocations that get cleaned up are:
	* - Unused pages in the entity index
	* - Component columns
	* - Empty tables
	*
	* Flecs uses allocators internally for speeding up allocations. Allocators are
	* not evaluated by this function, which means that the memory reported by the
	* OS may not go down. For this reason, this function is most effective when
	* combined with FLECS_USE_OS_ALLOC, which disables internal allocators.
	*
	* @param world The world.
	*/
	shrink :: proc(world: ^World) ---

	/** Set a range for issuing new entity ids.
	* This function constrains the entity identifiers returned by ecs_new_w() to the
	* specified range. This operation can be used to ensure that multiple processes
	* can run in the same simulation without requiring a central service that
	* coordinates issuing identifiers.
	*
	* If `id_end` is set to 0, the range is infinite. If `id_end` is set to a non-zero
	* value, it has to be larger than `id_start`. If `id_end` is set and ecs_new() is
	* invoked after an id is issued that is equal to `id_end`, the application will
	* abort.
	*
	* @param world The world.
	* @param id_start The start of the range.
	* @param id_end The end of the range.
	*/
	set_entity_range :: proc(world: ^World, id_start: Entity, id_end: Entity) ---

	/** Enable/disable range limits.
	* When an application is both a receiver of range-limited entities and a
	* producer of range-limited entities, range checking needs to be temporarily
	* disabled when inserting received entities. Range checking is disabled on a
	* stage, so setting this value is thread safe.
	*
	* @param world The world.
	* @param enable True if range checking should be enabled, false to disable.
	* @return The previous value.
	*/
	enable_range_check :: proc(world: ^World, enable: bool) -> bool ---

	/** Get the largest issued entity id (not counting generation).
	*
	* @param world The world.
	* @return The largest issued entity id.
	*/
	get_max_id :: proc(world: ^World) -> Entity ---

	/** Force aperiodic actions.
	* The world may delay certain operations until they are necessary for the
	* application to function correctly. This may cause observable side effects
	* such as delayed triggering of events, which can be inconvenient when for
	* example running a test suite.
	*
	* The flags parameter specifies which aperiodic actions to run. Specify 0 to
	* run all actions. Supported flags start with 'EcsAperiodic'. Flags identify
	* internal mechanisms and may change unannounced.
	*
	* @param world The world.
	* @param flags The flags specifying which actions to run.
	*/
	run_aperiodic :: proc(world: ^World, flags: Flags32) ---
}

/** Used with ecs_delete_empty_tables(). */
Delete_Empty_Tables_Desc :: struct {
	/** Free table data when generation > clear_generation. */
	clear_generation: u16,

	/** Delete table when generation > delete_generation. */
	delete_generation: u16,

	/** Amount of time operation is allowed to spend. */
	time_budget_seconds: f64,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Cleanup empty tables.
	* This operation cleans up empty tables that meet certain conditions. Having
	* large amounts of empty tables does not negatively impact performance of the
	* ECS, but can take up considerable amounts of memory, especially in
	* applications with many components, and many components per entity.
	*
	* The generation specifies the minimum number of times this operation has
	* to be called before an empty table is cleaned up. If a table becomes non
	* empty, the generation is reset.
	*
	* The operation allows for both a "clear" generation and a "delete"
	* generation. When the clear generation is reached, the table's
	* resources are freed (like component arrays) but the table itself is not
	* deleted. When the delete generation is reached, the empty table is deleted.
	*
	* By specifying a non-zero id the cleanup logic can be limited to tables with
	* a specific (component) id. The operation will only increase the generation
	* count of matching tables.
	*
	* The min_id_count specifies a lower bound for the number of components a table
	* should have. Often the more components a table has, the more specific it is
	* and therefore less likely to be reused.
	*
	* The time budget specifies how long the operation should take at most.
	*
	* @param world The world.
	* @param desc Configuration parameters.
	* @return Number of deleted tables.
	*/
	delete_empty_tables :: proc(world: ^World, desc: ^Delete_Empty_Tables_Desc) -> i32 ---

	/** Get world from poly.
	*
	* @param poly A pointer to a poly object.
	* @return The world.
	*/
	get_world :: proc(poly: ^Poly) -> ^World ---

	/** Get entity from poly.
	*
	* @param poly A pointer to a poly object.
	* @return Entity associated with the poly object.
	*/
	get_entity :: proc(poly: ^Poly) -> Entity ---

	/** Test if pointer is of specified type.
	* Usage:
	*
	* @code
	* flecs_poly_is(ptr, ecs_world_t)
	* @endcode
	*
	* This operation only works for poly types.
	*
	* @param object The object to test.
	* @param type The id of the type.
	* @return True if the pointer is of the specified type.
	*/
	flecs_poly_is_ :: proc(object: ^Poly, type: i32) -> bool ---

	/** Make a pair id.
	* This function is equivalent to using the ecs_pair() macro, and is added for
	* convenience to make it easier for non C/C++ bindings to work with pairs.
	*
	* @param first The first element of the pair of the pair.
	* @param second The target of the pair.
	* @return A pair id.
	*/
	make_pair :: proc(first: Entity, second: Entity) -> Id ---

	/** Begin exclusive thread access.
	* This operation ensures that only the thread from which this operation is
	* called can access the world. Attempts to access the world from other threads
	* will panic.
	*
	* ecs_exclusive_access_begin() must be called in pairs with
	* ecs_exclusive_access_end(). Calling ecs_exclusive_access_begin() from another
	* thread without first calling ecs_exclusive_access_end() will panic.
	*
	* A thread name can be provided to the function to improve debug messages. The
	* function does not(!) copy the thread name, which means the memory for the
	* name must remain alive for as long as the thread has exclusive access.
	*
	* This operation should only be called once per thread. Calling it multiple
	* times for the same thread will cause a panic.
	*
	* Note that this feature only works in builds where asserts are enabled. The
	* feature requires the OS API thread_self_ callback to be set.
	*
	* @param world The world.
	* @param thread_name Name of the thread obtaining exclusive access.
	*/
	exclusive_access_begin :: proc(world: ^World, thread_name: cstring) ---

	/** End exclusive thread access.
	* This operation should be called after ecs_exclusive_access_begin(). After
	* calling this operation other threads are no longer prevented from mutating
	* the world.
	*
	* When "lock_world" is set to true, no thread will be able to mutate the world
	* until ecs_exclusive_access_begin is called again. While the world is locked
	* only readonly operations are allowed. For example, ecs_get_id() is allowed,
	* but ecs_get_mut_id() is not allowed.
	*
	* A locked world can be unlocked by calling ecs_exclusive_access_end again with
	* lock_world set to false. Note that this only works for locked worlds, if\
	* ecs_exclusive_access_end() is called on a world that has exclusive thread
	* access from a different thread, a panic will happen.
	*
	* This operation must be called from the same thread that called
	* ecs_exclusive_access_begin(). Calling it from a different thread will cause
	* a panic.
	*
	* @param world The world.
	* @param lock_world When true, any mutations on the world will be blocked.
	*/
	exclusive_access_end :: proc(world: ^World, lock_world: bool) ---

	/** Create new entity id.
	* This operation returns an unused entity id. This operation is guaranteed to
	* return an empty entity as it does not use values set by ecs_set_scope() or
	* ecs_set_with().
	*
	* @param world The world.
	* @return The new entity id.
	*/
	new :: proc(world: ^World) -> Entity ---

	/** Create new low id.
	* This operation returns a new low id. Entity ids start after the
	* FLECS_HI_COMPONENT_ID constant. This reserves a range of low ids for things
	* like components, and allows parts of the code to optimize operations.
	*
	* Note that FLECS_HI_COMPONENT_ID does not represent the maximum number of
	* components that can be created, only the maximum number of components that
	* can take advantage of these optimizations.
	*
	* This operation is guaranteed to return an empty entity as it does not use
	* values set by ecs_set_scope() or ecs_set_with().
	*
	* This operation does not recycle ids.
	*
	* @param world The world.
	* @return The new component id.
	*/
	new_low_id :: proc(world: ^World) -> Entity ---

	/** Create new entity with (component) id.
	* This operation creates a new entity with an optional (component) id. When 0
	* is passed to the id parameter, no component is added to the new entity.
	*
	* @param world The world.
	* @param component The component to create the new entity with.
	* @return The new entity.
	*/
	new_w_id :: proc(world: ^World, component: Id) -> Entity ---

	/** Create new entity in table.
	* This operation creates a new entity in the specified table.
	*
	* @param world The world.
	* @param table The table to which to add the new entity.
	* @return The new entity.
	*/
	new_w_table :: proc(world: ^World, table: ^Table) -> Entity ---

	/** Find or create an entity.
	* This operation creates a new entity, or modifies an existing one. When a name
	* is set in the ecs_entity_desc_t::name field and ecs_entity_desc_t::entity is
	* not set, the operation will first attempt to find an existing entity by that
	* name. If no entity with that name can be found, it will be created.
	*
	* If both a name and entity handle are provided, the operation will check if
	* the entity name matches with the provided name. If the names do not match,
	* the function will fail and return 0.
	*
	* If an id to a non-existing entity is provided, that entity id become alive.
	*
	* See the documentation of ecs_entity_desc_t for more details.
	*
	* @param world The world.
	* @param desc Entity init parameters.
	* @return A handle to the new or existing entity, or 0 if failed.
	*/
	entity_init :: proc(world: ^World, desc: ^Entity_Desc) -> Entity ---

	/** Bulk create/populate new entities.
	* This operation bulk inserts a list of new or predefined entities into a
	* single table.
	*
	* The operation does not take ownership of component arrays provided by the
	* application. Components that are non-trivially copyable will be moved into
	* the storage.
	*
	* The operation will emit OnAdd events for each added id, and OnSet events for
	* each component that has been set.
	*
	* If no entity ids are provided by the application, the returned array of ids
	* points to an internal data structure which changes when new entities are
	* created/deleted.
	*
	* If as a result of the operation triggers are invoked that deletes
	* entities and no entity ids were provided by the application, the returned
	* array of identifiers may be incorrect. To avoid this problem, an application
	* can first call ecs_bulk_init() to create empty entities, copy the array to one
	* that is owned by the application, and then use this array to populate the
	* entities.
	*
	* @param world The world.
	* @param desc Bulk creation parameters.
	* @return Array with the list of entity ids created/populated.
	*/
	bulk_init :: proc(world: ^World, desc: ^Bulk_Desc) -> ^Entity ---

	/** Create N new entities.
	* This operation is the same as ecs_new_w_id(), but creates N entities
	* instead of one.
	*
	* @param world The world.
	* @param component The component to create the entities with.
	* @param count The number of entities to create.
	* @return The first entity id of the newly created entities.
	*/
	bulk_new_w_id :: proc(world: ^World, component: Id, count: i32) -> ^Entity ---

	/** Clone an entity
	* This operation clones the components of one entity into another entity. If
	* no destination entity is provided, a new entity will be created. Component
	* values are not copied unless copy_value is true.
	*
	* If the source entity has a name, it will not be copied to the destination
	* entity. This is to prevent having two entities with the same name under the
	* same parent, which is not allowed.
	*
	* @param world The world.
	* @param dst The entity to copy the components to.
	* @param src The entity to copy the components from.
	* @param copy_value If true, the value of components will be copied to dst.
	* @return The destination entity.
	*/
	clone :: proc(world: ^World, dst: Entity, src: Entity, copy_value: bool) -> Entity ---

	/** Delete an entity.
	* This operation will delete an entity and all of its components. The entity id
	* will be made available for recycling. If the entity passed to ecs_delete() is
	* not alive, the operation will have no side effects.
	*
	* @param world The world.
	* @param entity The entity.
	*/
	delete :: proc(world: ^World, entity: Entity) ---

	/** Delete all entities with the specified component.
	* This will delete all entities (tables) that have the specified id. The
	* component may be a wildcard and/or a pair.
	*
	* @param world The world.
	* @param component The component.
	*/
	delete_with :: proc(world: ^World, component: Id) ---

	/** Set child order for parent with OrderedChildren.
	* If the parent has the OrderedChildren trait, the order of the children
	* will be updated to the order in the specified children array. The operation
	* will fail if the parent does not have the OrderedChildren trait.
	*
	* This operation always takes place immediately, and is not deferred. When the
	* operation is called from a multithreaded system it will fail.
	*
	* The reason for not deferring this operation is that by the time the deferred
	* command would be executed, the children of the parent could have been changed
	* which would cause the operation to fail.
	*
	* @param world The world.
	* @param parent The parent.
	* @param children An array with children.
	* @param child_count The number of children in the provided array.
	*/
	set_child_order :: proc(world: ^World, parent: Entity, children: ^Entity, child_count: i32) ---

	/** Get ordered children.
	* If a parent has the OrderedChildren trait, this operation can be used to
	* obtain the array with child entities. If this operation is used on a parent
	* that does not have the OrderedChildren trait, it will fail.asm
	*
	* @param world The world.
	* @param parent The parent.
	* @return The array with child entities.
	*/
	get_ordered_children :: proc(world: ^World, parent: Entity) -> Entities ---

	/** Add a (component) id to an entity.
	* This operation adds a single (component) id to an entity. If the entity
	* already has the id, this operation will have no side effects.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component id to add.
	*/
	add_id :: proc(world: ^World, entity: Entity, component: Id) ---

	/** Remove a component from an entity.
	* This operation removes a single component from an entity. If the entity
	* does not have the component, this operation will have no side effects.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to remove.
	*/
	remove_id :: proc(world: ^World, entity: Entity, component: Id) ---

	/** Add auto override for component.
	* An auto override is a component that is automatically added to an entity when
	* it is instantiated from a prefab. Auto overrides are added to the entity that
	* is inherited from (usually a prefab). For example:
	*
	* @code
	* ecs_entity_t prefab = ecs_insert(world,
	*   ecs_value(Position, {10, 20}),
	*   ecs_value(Mass, {100}));
	*
	* ecs_auto_override(world, prefab, Position);
	*
	* ecs_entity_t inst = ecs_new_w_pair(world, EcsIsA, prefab);
	* assert(ecs_owns(world, inst, Position)); // true
	* assert(ecs_owns(world, inst, Mass)); // false
	* @endcode
	*
	* An auto override is equivalent to a manual override:
	*
	* @code
	* ecs_entity_t prefab = ecs_insert(world,
	*   ecs_value(Position, {10, 20}),
	*   ecs_value(Mass, {100}));
	*
	* ecs_entity_t inst = ecs_new_w_pair(world, EcsIsA, prefab);
	* assert(ecs_owns(world, inst, Position)); // false
	* ecs_add(world, inst, Position); // manual override
	* assert(ecs_owns(world, inst, Position)); // true
	* assert(ecs_owns(world, inst, Mass)); // false
	* @endcode
	*
	* This operation is equivalent to manually adding the id with the AUTO_OVERRIDE
	* bit applied:
	*
	* @code
	* ecs_add_id(world, entity, ECS_AUTO_OVERRIDE | id);
	* @endcode
	*
	* When a component is overridden and inherited from a prefab, the value from
	* the prefab component is copied to the instance. When the component is not
	* inherited from a prefab, it is added to the instance as if using ecs_add_id().
	*
	* Overriding is the default behavior on prefab instantiation. Auto overriding
	* is only useful for components with the `(OnInstantiate, Inherit)` trait.
	* When a component has the `(OnInstantiate, DontInherit)` trait and is overridden
	* the component is added, but the value from the prefab will not be copied.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to auto override.
	*/
	auto_override_id :: proc(world: ^World, entity: Entity, component: Id) ---

	/** Clear all components.
	* This operation will remove all components from an entity.
	*
	* @param world The world.
	* @param entity The entity.
	*/
	clear :: proc(world: ^World, entity: Entity) ---

	/** Remove all instances of the specified component.
	* This will remove the specified id from all entities (tables). The id may be
	* a wildcard and/or a pair.
	*
	* @param world The world.
	* @param component The component.
	*/
	remove_all :: proc(world: ^World, component: Id) ---

	/** Create new entities with specified component.
	* Entities created with ecs_entity_init() will be created with the specified
	* component. This does not apply to entities created with ecs_new().
	*
	* Only one component can be specified at a time. If this operation is called
	* while a component is already configured, the new component will override the
	* old component.
	*
	* @param world The world.
	* @param component The component.
	* @return The previously set component.
	* @see ecs_entity_init()
	* @see ecs_set_with()
	*/
	set_with :: proc(world: ^World, component: Id) -> Entity ---

	/** Get component set with ecs_set_with().
	* Get the component set with ecs_set_with().
	*
	* @param world The world.
	* @return The last component provided to ecs_set_with().
	* @see ecs_set_with()
	*/
	get_with :: proc(world: ^World) -> Id ---

	/** Enable or disable entity.
	* This operation enables or disables an entity by adding or removing the
	* #EcsDisabled tag. A disabled entity will not be matched with any systems,
	* unless the system explicitly specifies the #EcsDisabled tag.
	*
	* @param world The world.
	* @param entity The entity to enable or disable.
	* @param enabled true to enable the entity, false to disable.
	*/
	enable :: proc(world: ^World, entity: Entity, enabled: bool) ---

	/** Enable or disable component.
	* Enabling or disabling a component does not add or remove a component from an
	* entity, but prevents it from being matched with queries. This operation can
	* be useful when a component must be temporarily disabled without destroying
	* its value. It is also a more performant operation for when an application
	* needs to add/remove components at high frequency, as enabling/disabling is
	* cheaper than a regular add or remove.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to enable/disable.
	* @param enable True to enable the component, false to disable.
	*/
	enable_id :: proc(world: ^World, entity: Entity, component: Id, enable: bool) ---

	/** Test if component is enabled.
	* Test whether a component is currently enabled or disabled. This operation
	* will return true when the entity has the component and if it has not been
	* disabled by ecs_enable_component().
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component.
	* @return True if the component is enabled, otherwise false.
	*/
	is_enabled_id :: proc(world: ^World, entity: Entity, component: Id) -> bool ---

	/** Get an immutable pointer to a component.
	* This operation obtains a const pointer to the requested component. The
	* operation accepts the component entity id.
	*
	* This operation can return inherited components reachable through an `IsA`
	* relationship.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to get.
	* @return The component pointer, NULL if the entity does not have the component.
	*
	* @see ecs_get_mut_id()
	*/
	get_id :: proc(world: ^World, entity: Entity, component: Id) -> rawptr ---

	/** Get a mutable pointer to a component.
	* This operation obtains a mutable pointer to the requested component. The
	* operation accepts the component entity id.
	*
	* Unlike ecs_get_id(), this operation does not return inherited components.
	* This is to prevent errors where an application accidentally resolves an
	* inherited component shared with many entities and modifies it, while thinking
	* it is modifying an owned component.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to get.
	* @return The component pointer, NULL if the entity does not have the component.
	*/
	get_mut_id :: proc(world: ^World, entity: Entity, component: Id) -> rawptr ---

	/** Ensure entity has component, return pointer.
	* This operation returns a mutable pointer to a component. If the entity did
	* not yet have the component, it will be added.
	*
	* If ensure is called when the world is in deferred/readonly mode, the
	* function will:
	* - return a pointer to a temp storage if the component does not yet exist, or
	* - return a pointer to the existing component if it exists
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to get/add.
	* @return The component pointer.
	*
	* @see ecs_emplace_id()
	*/
	ensure_id :: proc(world: ^World, entity: Entity, component: Id, size: c.size_t) -> rawptr ---

	/** Create a component ref.
	* A ref is a handle to an entity + component which caches a small amount of
	* data to reduce overhead of repeatedly accessing the component. Use
	* ecs_ref_get() to get the component data.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to create a ref for.
	* @return The reference.
	*/
	ref_init_id :: proc(world: ^World, entity: Entity, component: Id) -> Ref ---

	/** Get component from ref.
	* Get component pointer from ref. The ref must be created with ecs_ref_init().
	* The specified component must match the component with which the ref was
	* created.
	*
	* @param world The world.
	* @param ref The ref.
	* @param component The component to get.
	* @return The component pointer, NULL if the entity does not have the component.
	*/
	ref_get_id :: proc(world: ^World, ref: ^Ref, component: Id) -> rawptr ---

	/** Update ref.
	* Ensures contents of ref are up to date. Same as ecs_ref_get_id(), but does not
	* return pointer to component id.
	*
	* @param world The world.
	* @param ref The ref.
	*/
	ref_update :: proc(world: ^World, ref: ^Ref) ---

	/** Emplace a component.
	* Emplace is similar to ecs_ensure_id() except that the component constructor
	* is not invoked for the returned pointer, allowing the component to be
	* constructed directly in the storage.
	*
	* When the `is_new` parameter is not provided, the operation will assert when the
	* component already exists. When the `is_new` parameter is provided, it will
	* indicate whether the returned storage has been constructed.
	*
	* When `is_new` indicates that the storage has not yet been constructed, it must
	* be constructed by the code invoking this operation. Not constructing the
	* component will result in undefined behavior.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to get/add.
	* @param size The component size.
	* @param is_new Whether this is an existing or new component.
	* @return The (uninitialized) component pointer.
	*/
	emplace_id :: proc(world: ^World, entity: Entity, component: Id, size: c.size_t, is_new: ^bool) -> rawptr ---

	/** Signal that a component has been modified.
	* This operation is usually used after modifying a component value obtained by
	* ecs_ensure_id(). The operation will mark the component as dirty, and invoke
	* OnSet observers and hooks.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component that was modified.
	*/
	modified_id :: proc(world: ^World, entity: Entity, component: Id) ---

	/** Set the value of a component.
	* This operation allows an application to set the value of a component. The
	* operation is equivalent to calling ecs_ensure_id() followed by
	* ecs_modified_id(). The operation will not modify the value of the passed in
	* component. If the component has a copy hook registered, it will be used to
	* copy in the component.
	*
	* If the provided entity is 0, a new entity will be created.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to set.
	* @param size The size of the pointed-to value.
	* @param ptr The pointer to the value.
	*/
	set_id :: proc(world: ^World, entity: Entity, component: Id, size: c.size_t, ptr: rawptr) ---

	/** Test whether an entity is valid.
	* This operation tests whether the entity id:
	* - is not 0
	* - has a valid bit pattern
	* - is alive (see ecs_is_alive())
	*
	* If this operation returns true, it is safe to use the entity with other
	* other operations.
	*
	* This operation should only be used if an application cannot be sure that an
	* entity is initialized with a valid value. In all other cases where an entity
	* was initialized with a valid value, but the application wants to check if the
	* entity is (still) alive, use ecs_is_alive.
	*
	* @param world The world.
	* @param e The entity.
	* @return True if the entity is valid, false if the entity is not valid.
	* @see ecs_is_alive()
	*/
	is_valid :: proc(world: ^World, e: Entity) -> bool ---

	/** Test whether an entity is alive.
	* Entities are alive after they are created, and become not alive when they are
	* deleted. Operations that return alive ids are (amongst others) ecs_new(),
	* ecs_new_low_id() and ecs_entity_init(). Ids can be made alive with the
	* ecs_make_alive() * function.
	*
	* After an id is deleted it can be recycled. Recycled ids are different from
	* the original id in that they have a different generation count. This makes it
	* possible for the API to distinguish between the two. An example:
	*
	* @code
	* ecs_entity_t e1 = ecs_new(world);
	* ecs_is_alive(world, e1);             // true
	* ecs_delete(world, e1);
	* ecs_is_alive(world, e1);             // false
	*
	* ecs_entity_t e2 = ecs_new(world);    // recycles e1
	* ecs_is_alive(world, e2);             // true
	* ecs_is_alive(world, e1);             // false
	* @endcode
	*
	* Other than ecs_is_valid(), this operation will panic if the passed in entity
	* id is 0 or has an invalid bit pattern.
	*
	* @param world The world.
	* @param e The entity.
	* @return True if the entity is alive, false if the entity is not alive.
	* @see ecs_is_valid()
	*/
	is_alive :: proc(world: ^World, e: Entity) -> bool ---

	/** Remove generation from entity id.
	*
	* @param e The entity id.
	* @return The entity id without the generation count.
	*/
	strip_generation :: proc(e: Entity) -> Id ---

	/** Get alive identifier.
	* In some cases an application may need to work with identifiers from which
	* the generation has been stripped. A typical scenario in which this happens is
	* when iterating relationships in an entity type.
	*
	* For example, when obtaining the parent id from a `ChildOf` relationship, the parent
	* (second element of the pair) will have been stored in a 32 bit value, which
	* cannot store the entity generation. This function can retrieve the identifier
	* with the current generation for that id.
	*
	* If the provided identifier is not alive, the function will return 0.
	*
	* @param world The world.
	* @param e The for which to obtain the current alive entity id.
	* @return The alive entity id if there is one, or 0 if the id is not alive.
	*/
	get_alive :: proc(world: ^World, e: Entity) -> Entity ---

	/** Ensure id is alive.
	* This operation ensures that the provided id is alive. This is useful in
	* scenarios where an application has an existing id that has not been created
	* with ecs_new_w() (such as a global constant or an id from a remote application).
	*
	* When this operation is successful it guarantees that the provided id exists,
	* is valid and is alive.
	*
	* Before this operation the id must either not be alive or have a generation
	* that is equal to the passed in entity.
	*
	* If the provided id has a non-zero generation count and the id does not exist
	* in the world, the id will be created with the specified generation.
	*
	* If the provided id is alive and has a generation count that does not match
	* the provided id, the operation will fail.
	*
	* @param world The world.
	* @param entity The entity id to make alive.
	*
	* @see ecs_make_alive_id()
	*/
	make_alive :: proc(world: ^World, entity: Entity) ---

	/** Same as ecs_make_alive(), but for components.
	* An id can be an entity or pair, and can contain id flags. This operation
	* ensures that the entity (or entities, for a pair) are alive.
	*
	* When this operation is successful it guarantees that the provided id can be
	* used in operations that accept an id.
	*
	* Since entities in a pair do not encode their generation ids, this operation
	* will not fail when an entity with non-zero generation count already exists in
	* the world.
	*
	* This is different from ecs_make_alive(), which will fail if attempted with an id
	* that has generation 0 and an entity with a non-zero generation is currently
	* alive.
	*
	* @param world The world.
	* @param component The component to make alive.
	*/
	make_alive_id :: proc(world: ^World, component: Id) ---

	/** Test whether an entity exists.
	* Similar as ecs_is_alive(), but ignores entity generation count.
	*
	* @param world The world.
	* @param entity The entity.
	* @return True if the entity exists, false if the entity does not exist.
	*/
	exists :: proc(world: ^World, entity: Entity) -> bool ---

	/** Override the generation of an entity.
	* The generation count of an entity is increased each time an entity is deleted
	* and is used to test whether an entity id is alive.
	*
	* This operation overrides the current generation of an entity with the
	* specified generation, which can be useful if an entity is externally managed,
	* like for external pools, savefiles or netcode.
	*
	* This operation is similar to ecs_make_alive(), except that it will also
	* override the generation of an alive entity.
	*
	* @param world The world.
	* @param entity Entity for which to set the generation with the new generation.
	*/
	set_version :: proc(world: ^World, entity: Entity) ---

	/** Get generation of an entity.
	*
	* @param entity Entity for which to get the generation of.
	* @return The generation of the entity.
	*/
	get_version :: proc(entity: Entity) -> u32 ---

	/** Get the type of an entity.
	*
	* @param world The world.
	* @param entity The entity.
	* @return The type of the entity, NULL if the entity has no components.
	*/
	get_type :: proc(world: ^World, entity: Entity) -> ^Type ---

	/** Get the table of an entity.
	*
	* @param world The world.
	* @param entity The entity.
	* @return The table of the entity, NULL if the entity has no components/tags.
	*/
	get_table :: proc(world: ^World, entity: Entity) -> ^Table ---

	/** Convert type to string.
	* The result of this operation must be freed with ecs_os_free().
	*
	* @param world The world.
	* @param type The type.
	* @return The stringified type.
	*/
	type_str :: proc(world: ^World, type: ^Type) -> cstring ---

	/** Convert table to string.
	* Same as `ecs_type_str(world, ecs_table_get_type(table))`. The result of this
	* operation must be freed with ecs_os_free().
	*
	* @param world The world.
	* @param table The table.
	* @return The stringified table type.
	*
	* @see ecs_table_get_type()
	* @see ecs_type_str()
	*/
	table_str :: proc(world: ^World, table: ^Table) -> cstring ---

	/** Convert entity to string.
	* Same as combining:
	* - ecs_get_path(world, entity)
	* - ecs_type_str(world, ecs_get_type(world, entity))
	*
	* The result of this operation must be freed with ecs_os_free().
	*
	* @param world The world.
	* @param entity The entity.
	* @return The entity path with stringified type.
	*
	* @see ecs_get_path()
	* @see ecs_type_str()
	*/
	entity_str :: proc(world: ^World, entity: Entity) -> cstring ---

	/** Test if an entity has a component.
	* This operation returns true if the entity has or inherits the component.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to test for.
	* @return True if the entity has the component, false if not.
	*
	* @see ecs_owns_id()
	*/
	has_id :: proc(world: ^World, entity: Entity, component: Id) -> bool ---

	/** Test if an entity owns a component.
	* This operation returns true if the entity has the component. The operation
	* behaves the same as ecs_has_id(), except that it will return false for
	* components that are inherited through an `IsA` relationship.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to test for.
	* @return True if the entity has the component, false if not.
	*/
	owns_id :: proc(world: ^World, entity: Entity, component: Id) -> bool ---

	/** Get the target of a relationship.
	* This will return a target (second element of a pair) of the entity for the
	* specified relationship. The index allows for iterating through the targets,
	* if a single entity has multiple targets for the same relationship.
	*
	* If the index is larger than the total number of instances the entity has for
	* the relationship, the operation will return 0.
	*
	* @param world The world.
	* @param entity The entity.
	* @param rel The relationship between the entity and the target.
	* @param index The index of the relationship instance.
	* @return The target for the relationship at the specified index.
	*/
	get_target :: proc(world: ^World, entity: Entity, rel: Entity, index: i32) -> Entity ---

	/** Get parent (target of `ChildOf` relationship) for entity.
	* This operation is the same as calling:
	*
	* @code
	* ecs_get_target(world, entity, EcsChildOf, 0);
	* @endcode
	*
	* @param world The world.
	* @param entity The entity.
	* @return The parent of the entity, 0 if the entity has no parent.
	*
	* @see ecs_get_target()
	*/
	get_parent :: proc(world: ^World, entity: Entity) -> Entity ---

	/** Create child with Parent component.
	* This creates or returns an existing child for the specified parent. If a new
	* child is created, the Parent component is used to create the parent
	* relationship.
	*
	* If a child entity already exists with the specified name, it will be
	* returned.
	*
	* @param world The world.
	* @param parent The parent for which to create the child.
	* @param name The name with which to create the entity (may be NULL).
	* @return A new or existing child entity.
	*/
	new_w_parent :: proc(world: ^World, parent: Entity, name: cstring) -> Entity ---

	/** Get the target of a relationship for a given component.
	* This operation returns the first entity that has the provided component by
	* following the relationship. If the entity itself has the component then it
	* will be returned. If the component cannot be found on the entity or by
	* following the relationship, the operation will return 0.
	*
	* This operation can be used to lookup, for example, which prefab is providing
	* a component by specifying the `IsA` relationship:
	*
	* @code
	* // Is Position provided by the entity or one of its base entities?
	* ecs_get_target_for_id(world, entity, EcsIsA, ecs_id(Position))
	* @endcode
	*
	* @param world The world.
	* @param entity The entity.
	* @param rel The relationship to follow.
	* @param component The component to lookup.
	* @return The entity for which the target has been found.
	*/
	get_target_for_id :: proc(world: ^World, entity: Entity, rel: Entity, component: Id) -> Entity ---

	/** Return depth for entity in tree for the specified relationship.
	* Depth is determined by counting the number of targets encountered while
	* traversing up the relationship tree for rel. Only acyclic relationships are
	* supported.
	*
	* @param world The world.
	* @param entity The entity.
	* @param rel The relationship.
	* @return The depth of the entity in the tree.
	*/
	get_depth :: proc(world: ^World, entity: Entity, rel: Entity) -> i32 ---

	/** Count entities that have the specified id.
	* Returns the number of entities that have the specified id.
	*
	* @param world The world.
	* @param entity The id to search for.
	* @return The number of entities that have the id.
	*/
	count_id :: proc(world: ^World, entity: Id) -> i32 ---

	/** Get the name of an entity.
	* This will return the name stored in `(EcsIdentifier, EcsName)`.
	*
	* @param world The world.
	* @param entity The entity.
	* @return The type of the entity, NULL if the entity has no name.
	*
	* @see ecs_set_name()
	*/
	get_name :: proc(world: ^World, entity: Entity) -> cstring ---

	/** Get the symbol of an entity.
	* This will return the symbol stored in `(EcsIdentifier, EcsSymbol)`.
	*
	* @param world The world.
	* @param entity The entity.
	* @return The type of the entity, NULL if the entity has no name.
	*
	* @see ecs_set_symbol()
	*/
	get_symbol :: proc(world: ^World, entity: Entity) -> cstring ---

	/** Set the name of an entity.
	* This will set or overwrite the name of an entity. If no entity is provided,
	* a new entity will be created.
	*
	* The name is stored in `(EcsIdentifier, EcsName)`.
	*
	* @param world The world.
	* @param entity The entity.
	* @param name The name.
	* @return The provided entity, or a new entity if 0 was provided.
	*
	* @see ecs_get_name()
	*/
	set_name :: proc(world: ^World, entity: Entity, name: cstring) -> Entity ---

	/** Set the symbol of an entity.
	* This will set or overwrite the symbol of an entity. If no entity is provided,
	* a new entity will be created.
	*
	* The symbol is stored in (EcsIdentifier, EcsSymbol).
	*
	* @param world The world.
	* @param entity The entity.
	* @param symbol The symbol.
	* @return The provided entity, or a new entity if 0 was provided.
	*
	* @see ecs_get_symbol()
	*/
	set_symbol :: proc(world: ^World, entity: Entity, symbol: cstring) -> Entity ---

	/** Set alias for entity.
	* An entity can be looked up using its alias from the root scope without
	* providing the fully qualified name if its parent. An entity can only have
	* a single alias.
	*
	* The symbol is stored in `(EcsIdentifier, EcsAlias)`.
	*
	* @param world The world.
	* @param entity The entity.
	* @param alias The alias.
	*/
	set_alias :: proc(world: ^World, entity: Entity, alias: cstring) ---

	/** Lookup an entity by it's path.
	* This operation is equivalent to calling:
	*
	* @code
	* ecs_lookup_path_w_sep(world, 0, path, ".", NULL, true);
	* @endcode
	*
	* @param world The world.
	* @param path The entity path.
	* @return The entity with the specified path, or 0 if no entity was found.
	*
	* @see ecs_lookup_child()
	* @see ecs_lookup_path_w_sep()
	* @see ecs_lookup_symbol()
	*/
	lookup :: proc(world: ^World, path: cstring) -> Entity ---

	/** Lookup a child entity by name.
	* Returns an entity that matches the specified name. Only looks for entities in
	* the provided parent. If no parent is provided, look in the current scope (
	* root if no scope is provided).
	*
	* @param world The world.
	* @param parent The parent for which to lookup the child.
	* @param name The entity name.
	* @return The entity with the specified name, or 0 if no entity was found.
	*
	* @see ecs_lookup()
	* @see ecs_lookup_path_w_sep()
	* @see ecs_lookup_symbol()
	*/
	lookup_child :: proc(world: ^World, parent: Entity, name: cstring) -> Entity ---

	/** Lookup an entity from a path.
	* Lookup an entity from a provided path, relative to the provided parent. The
	* operation will use the provided separator to tokenize the path expression. If
	* the provided path contains the prefix, the search will start from the root.
	*
	* If the entity is not found in the provided parent, the operation will
	* continue to search in the parent of the parent, until the root is reached. If
	* the entity is still not found, the lookup will search in the flecs.core
	* scope. If the entity is not found there either, the function returns 0.
	*
	* @param world The world.
	* @param parent The entity from which to resolve the path.
	* @param path The path to resolve.
	* @param sep The path separator.
	* @param prefix The path prefix.
	* @param recursive Recursively traverse up the tree until entity is found.
	* @return The entity if found, else 0.
	*
	* @see ecs_lookup()
	* @see ecs_lookup_child()
	* @see ecs_lookup_symbol()
	*/
	lookup_path_w_sep :: proc(world: ^World, parent: Entity, path: cstring, sep: cstring, prefix: cstring, recursive: bool) -> Entity ---

	/** Lookup an entity by its symbol name.
	* This looks up an entity by symbol stored in `(EcsIdentifier, EcsSymbol)`. The
	* operation does not take into account hierarchies.
	*
	* This operation can be useful to resolve, for example, a type by its C
	* identifier, which does not include the Flecs namespacing.
	*
	* @param world The world.
	* @param symbol The symbol.
	* @param lookup_as_path If not found as a symbol, lookup as path.
	* @param recursive If looking up as path, recursively traverse up the tree.
	* @return The entity if found, else 0.
	*
	* @see ecs_lookup()
	* @see ecs_lookup_child()
	* @see ecs_lookup_path_w_sep()
	*/
	lookup_symbol :: proc(world: ^World, symbol: cstring, lookup_as_path: bool, recursive: bool) -> Entity ---

	/** Get a path identifier for an entity.
	* This operation creates a path that contains the names of the entities from
	* the specified parent to the provided entity, separated by the provided
	* separator. If no parent is provided the path will be relative to the root. If
	* a prefix is provided, the path will be prefixed by the prefix.
	*
	* If the parent is equal to the provided child, the operation will return an
	* empty string. If a nonzero component is provided, the path will be created by
	* looking for parents with that component.
	*
	* The returned path should be freed by the application.
	*
	* @param world The world.
	* @param parent The entity from which to create the path.
	* @param child The entity to which to create the path.
	* @param sep The separator to use between path elements.
	* @param prefix The initial character to use for root elements.
	* @return The relative entity path.
	*
	* @see ecs_get_path_w_sep_buf()
	*/
	get_path_w_sep :: proc(world: ^World, parent: Entity, child: Entity, sep: cstring, prefix: cstring) -> cstring ---

	/** Write path identifier to buffer.
	* Same as ecs_get_path_w_sep(), but writes result to an ecs_strbuf_t.
	*
	* @param world The world.
	* @param parent The entity from which to create the path.
	* @param child The entity to which to create the path.
	* @param sep The separator to use between path elements.
	* @param prefix The initial character to use for root elements.
	* @param buf The buffer to write to.
	*
	* @see ecs_get_path_w_sep()
	*/
	get_path_w_sep_buf :: proc(world: ^World, parent: Entity, child: Entity, sep: cstring, prefix: cstring, buf: ^Strbuf, escape: bool) ---

	/** Find or create entity from path.
	* This operation will find or create an entity from a path, and will create any
	* intermediate entities if required. If the entity already exists, no entities
	* will be created.
	*
	* If the path starts with the prefix, then the entity will be created from the
	* root scope.
	*
	* @param world The world.
	* @param parent The entity relative to which the entity should be created.
	* @param path The path to create the entity for.
	* @param sep The separator used in the path.
	* @param prefix The prefix used in the path.
	* @return The entity.
	*/
	new_from_path_w_sep :: proc(world: ^World, parent: Entity, path: cstring, sep: cstring, prefix: cstring) -> Entity ---

	/** Add specified path to entity.
	* This operation is similar to ecs_new_from_path(), but will instead add the path
	* to an existing entity.
	*
	* If an entity already exists for the path, it will be returned instead.
	*
	* @param world The world.
	* @param entity The entity to which to add the path.
	* @param parent The entity relative to which the entity should be created.
	* @param path The path to create the entity for.
	* @param sep The separator used in the path.
	* @param prefix The prefix used in the path.
	* @return The entity.
	*/
	add_path_w_sep :: proc(world: ^World, entity: Entity, parent: Entity, path: cstring, sep: cstring, prefix: cstring) -> Entity ---

	/** Set the current scope.
	* This operation sets the scope of the current stage to the provided entity.
	* As a result new entities will be created in this scope, and lookups will be
	* relative to the provided scope.
	*
	* It is considered good practice to restore the scope to the old value.
	*
	* @param world The world.
	* @param scope The entity to use as scope.
	* @return The previous scope.
	*
	* @see ecs_get_scope()
	*/
	set_scope :: proc(world: ^World, scope: Entity) -> Entity ---

	/** Get the current scope.
	* Get the scope set by ecs_set_scope(). If no scope is set, this operation will
	* return 0.
	*
	* @param world The world.
	* @return The current scope.
	*/
	get_scope :: proc(world: ^World) -> Entity ---

	/** Set a name prefix for newly created entities.
	* This is a utility that lets C modules use prefixed names for C types and
	* C functions, while using names for the entity names that do not have the
	* prefix. The name prefix is currently only used by ECS_COMPONENT.
	*
	* @param world The world.
	* @param prefix The name prefix to use.
	* @return The previous prefix.
	*/
	set_name_prefix :: proc(world: ^World, prefix: cstring) -> cstring ---

	/** Set search path for lookup operations.
	* This operation accepts an array of entity ids that will be used as search
	* scopes by lookup operations. The operation returns the current search path.
	* It is good practice to restore the old search path.
	*
	* The search path will be evaluated starting from the last element.
	*
	* The default search path includes flecs.core. When a custom search path is
	* provided it overwrites the existing search path. Operations that rely on
	* looking up names from flecs.core without providing the namespace may fail if
	* the custom search path does not include flecs.core (EcsFlecsCore).
	*
	* The search path array is not copied into managed memory. The application must
	* ensure that the provided array is valid for as long as it is used as the
	* search path.
	*
	* The provided array must be terminated with a 0 element. This enables an
	* application to push/pop elements to an existing array without invoking the
	* ecs_set_lookup_path() operation again.
	*
	* @param world The world.
	* @param lookup_path 0-terminated array with entity ids for the lookup path.
	* @return Current lookup path array.
	*
	* @see ecs_get_lookup_path()
	*/
	set_lookup_path :: proc(world: ^World, lookup_path: ^Entity) -> ^Entity ---

	/** Get current lookup path.
	* Returns value set by ecs_set_lookup_path().
	*
	* @param world The world.
	* @return The current lookup path.
	*/
	get_lookup_path :: proc(world: ^World) -> ^Entity ---

	/** Find or create a component.
	* This operation creates a new component, or finds an existing one. The find or
	* create behavior is the same as ecs_entity_init().
	*
	* When an existing component is found, the size and alignment are verified with
	* the provided values. If the values do not match, the operation will fail.
	*
	* See the documentation of ecs_component_desc_t for more details.
	*
	* @param world The world.
	* @param desc Component init parameters.
	* @return A handle to the new or existing component, or 0 if failed.
	*/
	component_init :: proc(world: ^World, desc: ^Component_Desc) -> Entity ---

	/** Get the type info for an component.
	* This function returns the type information for a component. The component can
	* be a regular component or pair. For the rules on how type information is
	* determined based on a component id, see ecs_get_typeid().
	*
	* @param world The world.
	* @param component The component.
	* @return The type information of the id.
	*/
	get_type_info :: proc(world: ^World, component: Id) -> ^Type_Info ---

	/** Register hooks for component.
	* Hooks allow for the execution of user code when components are constructed,
	* copied, moved, destructed, added, removed or set. Hooks can be assigned as
	* as long as a component has not yet been used (added to an entity).
	*
	* The hooks that are currently set can be accessed with ecs_get_type_info().
	*
	* @param world The world.
	* @param component The component for which to register the actions
	* @param hooks Type that contains the component actions.
	*/
	set_hooks_id :: proc(world: ^World, component: Entity, hooks: ^Type_Hooks) ---

	/** Get hooks for component.
	*
	* @param world The world.
	* @param component The component for which to retrieve the hooks.
	* @return The hooks for the component, or NULL if not registered.
	*/
	get_hooks_id :: proc(world: ^World, component: Entity) -> ^Type_Hooks ---

	/** Returns whether specified component is a tag.
	* This operation returns whether the specified component is a tag (a component
	* without data/size).
	*
	* An id is a tag when:
	* - it is an entity without the EcsComponent component
	* - it has an EcsComponent with size member set to 0
	* - it is a pair where both elements are a tag
	* - it is a pair where the first element has the #EcsPairIsTag tag
	*
	* @param world The world.
	* @param component The component.
	* @return Whether the provided id is a tag.
	*/
	id_is_tag :: proc(world: ^World, component: Id) -> bool ---

	/** Returns whether specified component is in use.
	* This operation returns whether a component is in use in the world. A
	* component is in use if it has been added to one or more tables.
	*
	* @param world The world.
	* @param component The component.
	* @return Whether the component is in use.
	*/
	id_in_use :: proc(world: ^World, component: Id) -> bool ---

	/** Get the type for a component.
	* This operation returns the type for a component id, if the id is associated
	* with a type. For a regular component with a non-zero size (an entity with the
	* EcsComponent component) the operation will return the component id itself.
	*
	* For an entity that does not have the EcsComponent component, or with an
	* EcsComponent value with size 0, the operation will return 0.
	*
	* For a pair id the operation will return the type associated with the pair, by
	* applying the following queries in order:
	* - The first pair element is returned if it is a component
	* - 0 is returned if the relationship entity has the Tag property
	* - The second pair element is returned if it is a component
	* - 0 is returned.
	*
	* @param world The world.
	* @param component The component.
	* @return The type of the component.
	*/
	get_typeid :: proc(world: ^World, component: Id) -> Entity ---

	/** Utility to match a component with a pattern.
	* This operation returns true if the provided pattern matches the provided
	* component. The pattern may contain a wildcard (or wildcards, when a pair).
	*
	* @param component The component.
	* @param pattern The pattern to compare with.
	* @return Whether the id matches the pattern.
	*/
	id_match :: proc(component: Id, pattern: Id) -> bool ---

	/** Utility to check if component is a pair.
	*
	* @param component The component.
	* @return True if component is a pair.
	*/
	id_is_pair :: proc(component: Id) -> bool ---

	/** Utility to check if component is a wildcard.
	*
	* @param component The component.
	* @return True if component is a wildcard or a pair containing a wildcard.
	*/
	id_is_wildcard :: proc(component: Id) -> bool ---

	/** Utility to check if component is an any wildcard.
	*
	* @param component The component.
	* @return True if component is an any wildcard or a pair containing an any wildcard.
	*/
	id_is_any :: proc(component: Id) -> bool ---

	/** Utility to check if id is valid.
	* A valid id is an id that can be added to an entity. Invalid ids are:
	* - ids that contain wildcards
	* - ids that contain invalid entities
	* - ids that are 0 or contain 0 entities
	*
	* Note that the same rules apply to removing from an entity, with the exception
	* of wildcards.
	*
	* @param world The world.
	* @param component The component.
	* @return True if the id is valid.
	*/
	id_is_valid :: proc(world: ^World, component: Id) -> bool ---

	/** Get flags associated with id.
	* This operation returns the internal flags (see api_flags.h) that are
	* associated with the provided id.
	*
	* @param world The world.
	* @param component The component.
	* @return Flags associated with the id, or 0 if the id is not in use.
	*/
	id_get_flags :: proc(world: ^World, component: Id) -> Flags32 ---

	/** Convert component flag to string.
	* This operation converts a component flag to a string. Possible outputs are:
	*
	* - PAIR
	* - TOGGLE
	* - AUTO_OVERRIDE
	*
	* @param component_flags The component flag.
	* @return The id flag string, or NULL if no valid id is provided.
	*/
	id_flag_str :: proc(component_flags: u64) -> cstring ---

	/** Convert component id to string.
	* This operation converts the provided component id to a string. It can output
	* strings of the following formats:
	*
	* - "ComponentName"
	* - "FLAG|ComponentName"
	* - "(Relationship, Target)"
	* - "FLAG|(Relationship, Target)"
	*
	* The PAIR flag never added to the string.
	*
	* @param world The world.
	* @param component The component to convert to a string.
	* @return The component converted to a string.
	*/
	id_str :: proc(world: ^World, component: Id) -> cstring ---

	/** Write component string to buffer.
	* Same as ecs_id_str() but writes result to ecs_strbuf_t.
	*
	* @param world The world.
	* @param component The component to convert to a string.
	* @param buf The buffer to write to.
	*/
	id_str_buf :: proc(world: ^World, component: Id, buf: ^Strbuf) ---

	/** Convert string to a component.
	* This operation is the reverse of ecs_id_str(). The FLECS_SCRIPT addon
	* is required for this operation to work.
	*
	* @param world The world.
	* @param expr The string to convert to an id.
	*/
	id_from_str :: proc(world: ^World, expr: cstring) -> Id ---

	/** Test whether term ref is set.
	* A term ref is a reference to an entity, component or variable for one of the
	* three parts of a term (src, first, second).
	*
	* @param ref The term ref.
	* @return True when set, false when not set.
	*/
	term_ref_is_set :: proc(ref: ^Term_Ref) -> bool ---

	/** Test whether a term is set.
	* This operation can be used to test whether a term has been initialized with
	* values or whether it is empty.
	*
	* An application generally does not need to invoke this operation. It is useful
	* when initializing a 0-initialized array of terms (like in ecs_term_desc_t) as
	* this operation can be used to find the last initialized element.
	*
	* @param term The term.
	* @return True when set, false when not set.
	*/
	term_is_initialized :: proc(term: ^Term) -> bool ---

	/** Is term matched on $this variable.
	* This operation checks whether a term is matched on the $this variable, which
	* is the default source for queries.
	*
	* A term has a $this source when:
	* - ecs_term_t::src::id is EcsThis
	* - ecs_term_t::src::flags is EcsIsVariable
	*
	* If ecs_term_t::src is not populated, it will be automatically initialized to
	* the $this source for the created query.
	*
	* @param term The term.
	* @return True if term matches $this, false if not.
	*/
	term_match_this :: proc(term: ^Term) -> bool ---

	/** Is term matched on 0 source.
	* This operation checks whether a term is matched on a 0 source. A 0 source is
	* a term that isn't matched against anything, and can be used just to pass
	* (component) ids to a query iterator.
	*
	* A term has a 0 source when:
	* - ecs_term_t::src::id is 0
	* - ecs_term_t::src::flags has EcsIsEntity set
	*
	* @param term The term.
	* @return True if term has 0 source, false if not.
	*/
	term_match_0 :: proc(term: ^Term) -> bool ---

	/** Convert term to string expression.
	* Convert term to a string expression. The resulting expression is equivalent
	* to the same term, with the exception of And & Or operators.
	*
	* @param world The world.
	* @param term The term.
	* @return The term converted to a string.
	*/
	term_str :: proc(world: ^World, term: ^Term) -> cstring ---

	/** Convert query to string expression.
	* Convert query to a string expression. The resulting expression can be
	* parsed to create the same query.
	*
	* @param query The query.
	* @return The query converted to a string.
	*/
	query_str :: proc(query: ^Query) -> cstring ---

	/** Iterate all entities with specified (component id).
	* This returns an iterator that yields all entities with a single specified
	* component. This is a much lighter weight operation than creating and
	* iterating a query.
	*
	* Usage:
	* @code
	* ecs_iter_t it = ecs_each(world, Player);
	* while (ecs_each_next(&it)) {
	*   for (int i = 0; i < it.count; i ++) {
	*     // Iterate as usual.
	*   }
	* }
	* @endcode
	*
	* If the specified id is a component, it is possible to access the component
	* pointer with ecs_field just like with regular queries:
	*
	* @code
	* ecs_iter_t it = ecs_each(world, Position);
	* while (ecs_each_next(&it)) {
	*   Position *p = ecs_field(&it, Position, 0);
	*   for (int i = 0; i < it.count; i ++) {
	*     // Iterate as usual.
	*   }
	* }
	* @endcode
	*
	* @param world The world.
	* @param component The component to iterate.
	* @return An iterator that iterates all entities with the (component) id.
	*/
	each_id :: proc(world: ^World, component: Id) -> Iter ---

	/** Progress an iterator created with ecs_each_id().
	*
	* @param it The iterator.
	* @return True if the iterator has more results, false if not.
	*/
	each_next :: proc(it: ^Iter) -> bool ---

	/** Iterate children of parent.
	* This operation is usually equivalent to doing:
	* @code
	* ecs_iter_t it = ecs_each_id(world, ecs_pair(EcsChildOf, parent));
	* @endcode
	*
	* The only exception is when the parent has the EcsOrderedChildren trait, in
	* which case this operation will return a single result with the ordered
	* child entity ids.
	*
	* This operation is equivalent to doing:
	*
	* @code
	* ecs_children_w_rel(world, EcsChildOf, parent);
	* @endcode
	*
	* @param world The world.
	* @param parent The parent.
	* @return An iterator that iterates all children of the parent.
	*
	* @see ecs_each_id()
	*/
	children :: proc(world: ^World, parent: Entity) -> Iter ---

	/** Same as ecs_children() but with custom relationship argument.
	*
	* @param world The world.
	* @param relationship The relationship.
	* @param parent The parent.
	* @return An iterator that iterates all children of the parent.
	*/
	children_w_rel :: proc(world: ^World, relationship: Entity, parent: Entity) -> Iter ---

	/** Progress an iterator created with ecs_children().
	*
	* @param it The iterator.
	* @return True if the iterator has more results, false if not.
	*/
	children_next :: proc(it: ^Iter) -> bool ---

	/** Create a query.
	*
	* @param world The world.
	* @param desc The descriptor (see ecs_query_desc_t)
	* @return The query.
	*/
	query_init :: proc(world: ^World, desc: ^Query_Desc) -> ^Query ---

	/** Delete a query.
	*
	* @param query The query.
	*/
	query_fini :: proc(query: ^Query) ---

	/** Find variable index.
	* This operation looks up the index of a variable in the query. This index can
	* be used in operations like ecs_iter_set_var() and ecs_iter_get_var().
	*
	* @param query The query.
	* @param name The variable name.
	* @return The variable index.
	*/
	query_find_var :: proc(query: ^Query, name: cstring) -> i32 ---

	/** Get variable name.
	* This operation returns the variable name for an index.
	*
	* @param query The query.
	* @param var_id The variable index.
	* @return The variable name.
	*/
	query_var_name :: proc(query: ^Query, var_id: i32) -> cstring ---

	/** Test if variable is an entity.
	* Internally the query engine has entity variables and table variables. When
	* iterating through query variables (by using ecs_query_variable_count()) only
	* the values for entity variables are accessible. This operation enables an
	* application to check if a variable is an entity variable.
	*
	* @param query The query.
	* @param var_id The variable id.
	* @return Whether the variable is an entity variable.
	*/
	query_var_is_entity :: proc(query: ^Query, var_id: i32) -> bool ---

	/** Create a query iterator.
	* Use an iterator to iterate through the entities that match an entity. Queries
	* can return multiple results, and have to be iterated by repeatedly calling
	* ecs_query_next() until the operation returns false.
	*
	* Depending on the query, a single result can contain an entire table, a range
	* of entities in a table, or a single entity. Iteration code has an inner and
	* an outer loop. The outer loop loops through the query results, and typically
	* corresponds with a table. The inner loop loops entities in the result.
	*
	* Example:
	* @code
	* ecs_iter_t it = ecs_query_iter(world, q);
	*
	* while (ecs_query_next(&it)) {
	*   Position *p = ecs_field(&it, Position, 0);
	*   Velocity *v = ecs_field(&it, Velocity, 1);
	*
	*   for (int i = 0; i < it.count; i ++) {
	*     p[i].x += v[i].x;
	*     p[i].y += v[i].y;
	*   }
	* }
	* @endcode
	*
	* The world passed into the operation must be either the actual world or the
	* current stage, when iterating from a system. The stage is accessible through
	* the it.world member.
	*
	* Example:
	* @code
	* void MySystem(ecs_iter_t *it) {
	*   ecs_query_t *q = it->ctx; // Query passed as system context
	*
	*   // Create query iterator from system stage
	*   ecs_iter_t qit = ecs_query_iter(it->world, q);
	*   while (ecs_query_next(&qit)) {
	*     // Iterate as usual
	*   }
	* }
	* @endcode
	*
	* If query iteration is stopped without the last call to ecs_query_next()
	* returning false, iterator resources need to be cleaned up explicitly
	* with ecs_iter_fini().
	*
	* Example:
	* @code
	* ecs_iter_t it = ecs_query_iter(world, q);
	*
	* while (ecs_query_next(&it)) {
	*   if (!ecs_field_is_set(&it, 0)) {
	*     ecs_iter_fini(&it); // Free iterator resources
	*     break;
	*   }
	*
	*   for (int i = 0; i < it.count; i ++) {
	*     // ...
	*   }
	* }
	* @endcode
	*
	* @param world The world.
	* @param query The query.
	* @return An iterator.
	*
	* @see ecs_query_next()
	*/
	query_iter :: proc(world: ^World, query: ^Query) -> Iter ---

	/** Progress query iterator.
	*
	* @param it The iterator.
	* @return True if the iterator has more results, false if not.
	*
	* @see ecs_query_iter()
	*/
	query_next :: proc(it: ^Iter) -> bool ---

	/** Match entity with query.
	* This operation matches an entity with a query and returns the result of the
	* match in the "it" out parameter. An application should free the iterator
	* resources with ecs_iter_fini() if this function returns true.
	*
	* Usage:
	* @code
	* ecs_iter_t it;
	* if (ecs_query_has(q, e, &it)) {
	*   ecs_iter_fini(&it);
	* }
	* @endcode
	*
	* @param query The query.
	* @param entity The entity to match
	* @param it The iterator with matched data.
	* @return True if entity matches the query, false if not.
	*/
	query_has :: proc(query: ^Query, entity: Entity, it: ^Iter) -> bool ---

	/** Match table with query.
	* This operation matches a table with a query and returns the result of the
	* match in the "it" out parameter. An application should free the iterator
	* resources with ecs_iter_fini() if this function returns true.
	*
	* Usage:
	* @code
	* ecs_iter_t it;
	* if (ecs_query_has_table(q, t, &it)) {
	*   ecs_iter_fini(&it);
	* }
	* @endcode
	*
	* @param query The query.
	* @param table The table to match
	* @param it The iterator with matched data.
	* @return True if table matches the query, false if not.
	*/
	query_has_table :: proc(query: ^Query, table: ^Table, it: ^Iter) -> bool ---

	/** Match range with query.
	* This operation matches a range with a query and returns the result of the
	* match in the "it" out parameter. An application should free the iterator
	* resources with ecs_iter_fini() if this function returns true.
	*
	* The entire range must match the query for the operation to return true.
	*
	* Usage:
	* @code
	* ecs_table_range_t range = {
	*   .table = table,
	*   .offset = 1,
	*   .count = 2
	* };
	*
	* ecs_iter_t it;
	* if (ecs_query_has_range(q, &range, &it)) {
	*   ecs_iter_fini(&it);
	* }
	* @endcode
	*
	* @param query The query.
	* @param range The range to match
	* @param it The iterator with matched data.
	* @return True if range matches the query, false if not.
	*/
	query_has_range :: proc(query: ^Query, range: ^Table_Range, it: ^Iter) -> bool ---

	/** Returns how often a match event happened for a cached query.
	* This operation can be used to determine whether the query cache has been
	* updated with new tables.
	*
	* @param query The query.
	* @return The number of match events happened.
	*/
	query_match_count :: proc(query: ^Query) -> i32 ---

	/** Convert query to a string.
	* This will convert the query program to a string which can aid in debugging
	* the behavior of a query.
	*
	* The returned string must be freed with ecs_os_free().
	*
	* @param query The query.
	* @return The query plan.
	*/
	query_plan :: proc(query: ^Query) -> cstring ---

	/** Convert query to string with profile.
	* To use this you must set the EcsIterProfile flag on an iterator before
	* starting iteration:
	*
	* @code
	*   it.flags |= EcsIterProfile
	* @endcode
	*
	* The returned string must be freed with ecs_os_free().
	*
	* @param query The query.
	* @param it The iterator with profile data.
	* @return The query plan with profile data.
	*/
	query_plan_w_profile :: proc(query: ^Query, it: ^Iter) -> cstring ---

	/** Same as ecs_query_plan(), but includes plan for populating cache (if any).
	*
	* @param query The query.
	* @return The query plan.
	*/
	query_plans :: proc(query: ^Query) -> cstring ---

	/** Populate variables from key-value string.
	* Convenience function to set query variables from a key-value string separated
	* by comma's. The string must have the following format:
	*
	* @code
	*   var_a: value, var_b: value
	* @endcode
	*
	* The key-value list may optionally be enclosed in parenthesis.
	*
	* This function uses the script addon.
	*
	* @param query The query.
	* @param it The iterator for which to set the variables.
	* @param expr The key-value expression.
	* @return Pointer to the next character after the last parsed one.
	*/
	query_args_parse :: proc(query: ^Query, it: ^Iter, expr: cstring) -> cstring ---

	/** Returns whether the query data changed since the last iteration.
	* The operation will return true after:
	* - new entities have been matched with
	* - new tables have been matched/unmatched with
	* - matched entities were deleted
	* - matched components were changed
	*
	* The operation will not return true after a write-only (EcsOut) or filter
	* (EcsInOutNone) term has changed, when a term is not matched with the
	* current table (This subject) or for tag terms.
	*
	* The changed state of a table is reset after it is iterated. If an iterator was
	* not iterated until completion, tables may still be marked as changed.
	*
	* If no iterator is provided the operation will return the changed state of the
	* all matched tables of the query.
	*
	* If an iterator is provided, the operation will return the changed state of
	* the currently returned iterator result. The following preconditions must be
	* met before using an iterator with change detection:
	*
	* - The iterator is a query iterator (created with ecs_query_iter())
	* - The iterator must be valid (ecs_query_next() must have returned true)
	*
	* @param query The query (optional if 'it' is provided).
	* @return true if entities changed, otherwise false.
	*/
	query_changed :: proc(query: ^Query) -> bool ---

	/** Get query object.
	* Returns the query object. Can be used to access various information about
	* the query.
	*
	* @param world The world.
	* @param query The query.
	* @return The query object.
	*/
	query_get :: proc(world: ^World, query: Entity) -> ^Query ---

	/** Skip a table while iterating.
	* This operation lets the query iterator know that a table was skipped while
	* iterating. A skipped table will not reset its changed state, and the query
	* will not update the dirty flags of the table for its out columns.
	*
	* Only valid iterators must be provided (next has to be called at least once &
	* return true) and the iterator must be a query iterator.
	*
	* @param it The iterator result to skip.
	*/
	iter_skip :: proc(it: ^Iter) ---

	/** Set group to iterate for query iterator.
	* This operation limits the results returned by the query to only the selected
	* group id. The query must have a group_by function, and the iterator must
	* be a query iterator.
	*
	* Groups are sets of tables that are stored together in the query cache based
	* on a group id, which is calculated per table by the group_by function. To
	* iterate a group, an iterator only needs to know the first and last cache node
	* for that group, which can both be found in a fast O(1) operation.
	*
	* As a result, group iteration is one of the most efficient mechanisms to
	* filter out large numbers of entities, even if those entities are distributed
	* across many tables. This makes it a good fit for things like dividing up
	* a world into cells, and only iterating cells close to a player.
	*
	* The group to iterate must be set before the first call to ecs_query_next(). No
	* operations that can add/remove components should be invoked between calling
	* ecs_iter_set_group() and ecs_query_next().
	*
	* @param it The query iterator.
	* @param group_id The group to iterate.
	*/
	iter_set_group :: proc(it: ^Iter, group_id: u64) ---

	/** Return map with query groups.
	* This map can be used to iterate the active group identifiers of a query. The
	* payload of the map is opaque. The map can be used as follows:
	*
	* @code
	* const ecs_map_t *keys = ecs_query_get_groups(q);
	* ecs_map_iter_t kit = ecs_map_iter(keys);
	* while (ecs_map_next(&kit)) {
	*   uint64_t group_id = ecs_map_key(&kit);
	*
	*   // Iterate query for group
	*   ecs_iter_t it = ecs_query_iter(world, q);
	*   ecs_iter_set_group(&it, group_id);
	*   while (ecs_query_next(&it)) {
	*     // Iterate as usual
	*   }
	* }
	* @endcode
	*
	* This operation is not valid for queries that do not use group_by. The
	* returned map pointer will remain valid for as long as the query exists.
	*
	* @param query The query.
	* @return The map with query groups.
	*/
	query_get_groups :: proc(query: ^Query) -> ^Map ---

	/** Get context of query group.
	* This operation returns the context of a query group as returned by the
	* on_group_create callback.
	*
	* @param query The query.
	* @param group_id The group for which to obtain the context.
	* @return The group context, NULL if the group doesn't exist.
	*/
	query_get_group_ctx :: proc(query: ^Query, group_id: u64) -> rawptr ---

	/** Get information about query group.
	* This operation returns information about a query group, including the group
	* context returned by the on_group_create callback.
	*
	* @param query The query.
	* @param group_id The group for which to obtain the group info.
	* @return The group info, NULL if the group doesn't exist.
	*/
	query_get_group_info :: proc(query: ^Query, group_id: u64) -> ^Query_Group_Info ---
}

/** Struct returned by ecs_query_count(). */
Query_Count :: struct {
	results:  i32, /**< Number of results returned by query. */
	entities: i32, /**< Number of entities returned by query. */
	tables:   i32, /**< Number of tables returned by query. Only set for
                             * queries for which the table count can be reliably
                             * determined. */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Returns number of entities and results the query matches with.
	* Only entities matching the $this variable as source are counted.
	*
	* @param query The query.
	* @return The number of matched entities.
	*/
	query_count :: proc(query: ^Query) -> Query_Count ---

	/** Does query return one or more results.
	*
	* @param query The query.
	* @return True if query matches anything, false if not.
	*/
	query_is_true :: proc(query: ^Query) -> bool ---

	/** Get query used to populate cache.
	* This operation returns the query that is used to populate the query cache.
	* For queries that are can be entirely cached, the returned query will be
	* equivalent to the query passed to ecs_query_get_cache_query().
	*
	* @param query The query.
	* @return The query used to populate the cache, NULL if query is not cached.
	*/
	query_get_cache_query :: proc(query: ^Query) -> ^Query ---

	/** Send event.
	* This sends an event to matching triggers & is the mechanism used by flecs
	* itself to send `OnAdd`, `OnRemove`, etc events.
	*
	* Applications can use this function to send custom events, where a custom
	* event can be any regular entity.
	*
	* Applications should not send builtin flecs events, as this may violate
	* assumptions the code makes about the conditions under which those events are
	* sent.
	*
	* Triggers are invoked synchronously. It is therefore safe to use stack-based
	* data as event context, which can be set in the "param" member.
	*
	* @param world The world.
	* @param desc Event parameters.
	*
	* @see ecs_enqueue()
	*/
	emit :: proc(world: ^World, desc: ^Event_Desc) ---

	/** Enqueue event.
	* Same as ecs_emit(), but enqueues an event in the command queue instead. The
	* event will be emitted when ecs_defer_end() is called.
	*
	* If this operation is called when the provided world is not in deferred mode
	* it behaves just like ecs_emit().
	*
	* @param world The world.
	* @param desc Event parameters.
	*/
	enqueue :: proc(world: ^World, desc: ^Event_Desc) ---

	/** Create observer.
	* Observers are like triggers, but can subscribe for multiple terms. An
	* observer only triggers when the source of the event meets all terms.
	*
	* See the documentation for ecs_observer_desc_t for more details.
	*
	* @param world The world.
	* @param desc The observer creation parameters.
	* @return The observer, or 0 if the operation failed.
	*/
	observer_init :: proc(world: ^World, desc: ^Observer_Desc) -> Entity ---

	/** Get observer object.
	* Returns the observer object. Can be used to access various information about
	* the observer, like the query and context.
	*
	* @param world The world.
	* @param observer The observer.
	* @return The observer object.
	*/
	observer_get :: proc(world: ^World, observer: Entity) -> ^Observer ---

	/** Progress any iterator.
	* This operation is useful in combination with iterators for which it is not
	* known what created them. Example use cases are functions that should accept
	* any kind of iterator (such as serializers) or iterators created from poly
	* objects.
	*
	* This operation is slightly slower than using a type-specific iterator (e.g.
	* ecs_query_next, ecs_query_next) as it has to call a function pointer which
	* introduces a level of indirection.
	*
	* @param it The iterator.
	* @return True if iterator has more results, false if not.
	*/
	iter_next :: proc(it: ^Iter) -> bool ---

	/** Cleanup iterator resources.
	* This operation cleans up any resources associated with the iterator.
	*
	* This operation should only be used when an iterator is not iterated until
	* completion (next has not yet returned false). When an iterator is iterated
	* until completion, resources are automatically freed.
	*
	* @param it The iterator.
	*/
	iter_fini :: proc(it: ^Iter) ---

	/** Count number of matched entities in query.
	* This operation returns the number of matched entities. If a query contains no
	* matched entities but still yields results (e.g. it has no terms with This
	* sources) the operation will return 0.
	*
	* To determine the number of matched entities, the operation iterates the
	* iterator until it yields no more results.
	*
	* @param it The iterator.
	* @return True if iterator has more results, false if not.
	*/
	iter_count :: proc(it: ^Iter) -> i32 ---

	/** Test if iterator is true.
	* This operation will return true if the iterator returns at least one result.
	* This is especially useful in combination with fact-checking queries (see the
	* queries addon).
	*
	* The operation requires a valid iterator. After the operation is invoked, the
	* application should no longer invoke next on the iterator and should treat it
	* as if the iterator is iterated until completion.
	*
	* @param it The iterator.
	* @return true if the iterator returns at least one result.
	*/
	iter_is_true :: proc(it: ^Iter) -> bool ---

	/** Get first matching entity from iterator.
	* After this operation the application should treat the iterator as if it has
	* been iterated until completion.
	*
	* @param it The iterator.
	* @return The first matching entity, or 0 if no entities were matched.
	*/
	iter_first :: proc(it: ^Iter) -> Entity ---

	/** Set value for iterator variable.
	* This constrains the iterator to return only results for which the variable
	* equals the specified value. The default value for all variables is
	* EcsWildcard, which means the variable can assume any value.
	*
	* Example:
	*
	* @code
	* // Query that matches (Eats, *)
	* ecs_query_t *q = ecs_query(world, {
	*   .terms = {
	*     { .first.id = Eats, .second.name = "$food" }
	*   }
	* });
	*
	* int food_var = ecs_query_find_var(r, "food");
	*
	* // Set Food to Apples, so we're only matching (Eats, Apples)
	* ecs_iter_t it = ecs_query_iter(world, q);
	* ecs_iter_set_var(&it, food_var, Apples);
	*
	* while (ecs_query_next(&it)) {
	*   for (int i = 0; i < it.count; i ++) {
	*     // iterate as usual
	*   }
	* }
	* @endcode
	*
	* The variable must be initialized after creating the iterator and before the
	* first call to next.
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @param entity The entity variable value.
	*
	* @see ecs_iter_set_var_as_range()
	* @see ecs_iter_set_var_as_table()
	*/
	iter_set_var :: proc(it: ^Iter, var_id: i32, entity: Entity) ---

	/** Same as ecs_iter_set_var(), but for a table.
	* This constrains the variable to all entities in a table.
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @param table The table variable value.
	*
	* @see ecs_iter_set_var()
	* @see ecs_iter_set_var_as_range()
	*/
	iter_set_var_as_table :: proc(it: ^Iter, var_id: i32, table: ^Table) ---

	/** Same as ecs_iter_set_var(), but for a range of entities
	* This constrains the variable to a range of entities in a table.
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @param range The range variable value.
	*
	* @see ecs_iter_set_var()
	* @see ecs_iter_set_var_as_table()
	*/
	iter_set_var_as_range :: proc(it: ^Iter, var_id: i32, range: ^Table_Range) ---

	/** Get value of iterator variable as entity.
	* A variable can be interpreted as entity if it is set to an entity, or if it
	* is set to a table range with count 1.
	*
	* This operation can only be invoked on valid iterators. The variable index
	* must be smaller than the total number of variables provided by the iterator
	* (as set in ecs_iter_t::variable_count).
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @return The variable value.
	*/
	iter_get_var :: proc(it: ^Iter, var_id: i32) -> Entity ---

	/** Get variable name.
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @return The variable name.
	*/
	iter_get_var_name :: proc(it: ^Iter, var_id: i32) -> cstring ---

	/** Get number of variables.
	*
	* @param it The iterator.
	* @return The number of variables.
	*/
	iter_get_var_count :: proc(it: ^Iter) -> i32 ---

	/** Get variable array.
	*
	* @param it The iterator.
	* @return The variable array (if any).
	*/
	iter_get_vars :: proc(it: ^Iter) -> ^Var ---

	/** Get value of iterator variable as table.
	* A variable can be interpreted as table if it is set as table range with
	* both offset and count set to 0, or if offset is 0 and count matches the
	* number of elements in the table.
	*
	* This operation can only be invoked on valid iterators. The variable index
	* must be smaller than the total number of variables provided by the iterator
	* (as set in ecs_iter_t::variable_count).
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @return The variable value.
	*/
	iter_get_var_as_table :: proc(it: ^Iter, var_id: i32) -> ^Table ---

	/** Get value of iterator variable as table range.
	* A value can be interpreted as table range if it is set as table range, or if
	* it is set to an entity with a non-empty type (the entity must have at least
	* one component, tag or relationship in its type).
	*
	* This operation can only be invoked on valid iterators. The variable index
	* must be smaller than the total number of variables provided by the iterator
	* (as set in ecs_iter_t::variable_count).
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @return The variable value.
	*/
	iter_get_var_as_range :: proc(it: ^Iter, var_id: i32) -> Table_Range ---

	/** Returns whether variable is constrained.
	* This operation returns true for variables set by one of the ecs_iter_set_var*
	* operations.
	*
	* A constrained variable is guaranteed not to change values while results are
	* being iterated.
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @return Whether the variable is constrained to a specified value.
	*/
	iter_var_is_constrained :: proc(it: ^Iter, var_id: i32) -> bool ---

	/** Return the group id for the currently iterated result.
	* This operation returns the group id for queries that use group_by. If this
	* operation is called on an iterator that is not iterating a query that uses
	* group_by it will fail.
	*
	* For queries that use cascade, this operation will return the hierarchy depth
	* of the currently iterated result.
	*
	* @param it The iterator.
	* @return The group id of the currently iterated result.
	*/
	iter_get_group :: proc(it: ^Iter) -> u64 ---

	/** Returns whether current iterator result has changed.
	* This operation must be used in combination with a query that supports change
	* detection (e.g. is cached). The operation returns whether the currently
	* iterated result has changed since the last time it was iterated by the query.
	*
	* Change detection works on a per-table basis. Changes to individual entities
	* cannot be detected this way.
	*
	* @param it The iterator.
	* @return True if the result changed, false if it didn't.
	*/
	iter_changed :: proc(it: ^Iter) -> bool ---

	/** Convert iterator to string.
	* Prints the contents of an iterator to a string. Useful for debugging and/or
	* testing the output of an iterator.
	*
	* The function only converts the currently iterated data to a string. To
	* convert all data, the application has to manually call the next function and
	* call ecs_iter_str() on each result.
	*
	* @param it The iterator.
	* @return A string representing the contents of the iterator.
	*/
	iter_str :: proc(it: ^Iter) -> cstring ---

	/** Create a paged iterator.
	* Paged iterators limit the results to those starting from 'offset', and will
	* return at most 'limit' results.
	*
	* The iterator must be iterated with ecs_page_next().
	*
	* A paged iterator acts as a passthrough for data exposed by the parent
	* iterator, so that any data provided by the parent will also be provided by
	* the paged iterator.
	*
	* @param it The source iterator.
	* @param offset The number of entities to skip.
	* @param limit The maximum number of entities to iterate.
	* @return A page iterator.
	*/
	page_iter :: proc(it: ^Iter, offset: i32, limit: i32) -> Iter ---

	/** Progress a paged iterator.
	* Progresses an iterator created by ecs_page_iter().
	*
	* @param it The iterator.
	* @return true if iterator has more results, false if not.
	*/
	page_next :: proc(it: ^Iter) -> bool ---

	/** Create a worker iterator.
	* Worker iterators can be used to equally divide the number of matched entities
	* across N resources (usually threads). Each resource will process the total
	* number of matched entities divided by 'count'.
	*
	* Entities are distributed across resources such that the distribution is
	* stable between queries. Two queries that match the same table are guaranteed
	* to match the same entities in that table.
	*
	* The iterator must be iterated with ecs_worker_next().
	*
	* A worker iterator acts as a passthrough for data exposed by the parent
	* iterator, so that any data provided by the parent will also be provided by
	* the worker iterator.
	*
	* @param it The source iterator.
	* @param index The index of the current resource.
	* @param count The total number of resources to divide entities between.
	* @return A worker iterator.
	*/
	worker_iter :: proc(it: ^Iter, index: i32, count: i32) -> Iter ---

	/** Progress a worker iterator.
	* Progresses an iterator created by ecs_worker_iter().
	*
	* @param it The iterator.
	* @return true if iterator has more results, false if not.
	*/
	worker_next :: proc(it: ^Iter) -> bool ---

	/** Get data for field.
	* This operation retrieves a pointer to an array of data that belongs to the
	* term in the query. The index refers to the location of the term in the query,
	* and starts counting from zero.
	*
	* For example, the query `"Position, Velocity"` will return the `Position` array
	* for index 0, and the `Velocity` array for index 1.
	*
	* When the specified field is not owned by the entity this function returns a
	* pointer instead of an array. This happens when the source of a field is not
	* the entity being iterated, such as a shared component (from a prefab), a
	* component from a parent, or another entity. The ecs_field_is_self() operation
	* can be used to test dynamically if a field is owned.
	*
	* When a field contains a sparse component, use the ecs_field_at function. When
	* a field is guaranteed to be set and owned, the ecs_field_self() function can be
	* used. ecs_field_self() has slightly better performance, and provides stricter
	* validity checking.
	*
	* The provided size must be either 0 or must match the size of the type
	* of the returned array. If the size does not match, the operation may assert.
	* The size can be dynamically obtained with ecs_field_size().
	*
	* An example:
	*
	* @code
	* while (ecs_query_next(&it)) {
	*   Position *p = ecs_field(&it, Position, 0);
	*   Velocity *v = ecs_field(&it, Velocity, 1);
	*   for (int32_t i = 0; i < it->count; i ++) {
	*     p[i].x += v[i].x;
	*     p[i].y += v[i].y;
	*   }
	* }
	* @endcode
	*
	* @param it The iterator.
	* @param size The size of the field type.
	* @param index The index of the field.
	* @return A pointer to the data of the field.
	*/
	field_w_size :: proc(it: ^Iter, size: c.size_t, index: i8) -> rawptr ---

	/** Get data for field at specified row.
	* This operation should be used instead of ecs_field_w_size for sparse
	* component fields. This operation should be called for each returned row in a
	* result. In the following example the Velocity component is sparse:
	*
	* @code
	* while (ecs_query_next(&it)) {
	*   Position *p = ecs_field(&it, Position, 0);
	*   for (int32_t i = 0; i < it->count; i ++) {
	*     Velocity *v = ecs_field_at(&it, Velocity, 1);
	*     p[i].x += v->x;
	*     p[i].y += v->y;
	*   }
	* }
	* @endcode
	*
	* @param it the iterator.
	* @param size The size of the field type.
	* @param index The index of the field.
	* @return A pointer to the data of the field.
	*/
	field_at_w_size :: proc(it: ^Iter, size: c.size_t, index: i8, row: i32) -> rawptr ---

	/** Test whether the field is readonly.
	* This operation returns whether the field is readonly. Readonly fields are
	* annotated with [in], or are added as a const type in the C++ API.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return Whether the field is readonly.
	*/
	field_is_readonly :: proc(it: ^Iter, index: i8) -> bool ---

	/** Test whether the field is writeonly.
	* This operation returns whether this is a writeonly field. Writeonly terms are
	* annotated with [out].
	*
	* Serializers are not required to serialize the values of a writeonly field.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return Whether the field is writeonly.
	*/
	field_is_writeonly :: proc(it: ^Iter, index: i8) -> bool ---

	/** Test whether field is set.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return Whether the field is set.
	*/
	field_is_set :: proc(it: ^Iter, index: i8) -> bool ---

	/** Return id matched for field.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return The id matched for the field.
	*/
	field_id :: proc(it: ^Iter, index: i8) -> Id ---

	/** Return index of matched table column.
	* This function only returns column indices for fields that have been matched
	* on the $this variable. Fields matched on other tables will return -1.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return The index of the matched column, -1 if not matched.
	*/
	field_column :: proc(it: ^Iter, index: i8) -> i32 ---

	/** Return field source.
	* The field source is the entity on which the field was matched.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return The source for the field.
	*/
	field_src :: proc(it: ^Iter, index: i8) -> Entity ---

	/** Return field type size.
	* Return type size of the field. Returns 0 if the field has no data.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return The type size for the field.
	*/
	field_size :: proc(it: ^Iter, index: i8) -> c.size_t ---

	/** Test whether the field is matched on self.
	* This operation returns whether the field is matched on the currently iterated
	* entity. This function will return false when the field is owned by another
	* entity, such as a parent or a prefab.
	*
	* When this operation returns false, the field must be accessed as a single
	* value instead of an array. Fields for which this operation returns true
	* return arrays with it->count values.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return Whether the field is matched on self.
	*/
	field_is_self :: proc(it: ^Iter, index: i8) -> bool ---

	/** Get type for table.
	* The table type is a vector that contains all component, tag and pair ids.
	*
	* @param table The table.
	* @return The type of the table.
	*/
	table_get_type :: proc(table: ^Table) -> ^Type ---

	/** Get type index for component.
	* This operation returns the index for a component in the table's type.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component.
	* @return The index of the component in the table type, or -1 if not found.
	*
	* @see ecs_table_has_id()
	*/
	table_get_type_index :: proc(world: ^World, table: ^Table, component: Id) -> i32 ---

	/** Get column index for component.
	* This operation returns the column index for a component in the table's type.
	* If the component doesn't have data (it is a tag), the function will return -1.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component.
	* @return The column index of the id, or -1 if not found/not a component.
	*/
	table_get_column_index :: proc(world: ^World, table: ^Table, component: Id) -> i32 ---

	/** Return number of columns in table.
	* Similar to `ecs_table_get_type(table)->count`, except that the column count
	* only counts the number of components in a table.
	*
	* @param table The table.
	* @return The number of columns in the table.
	*/
	table_column_count :: proc(table: ^Table) -> i32 ---

	/** Convert type index to column index.
	* Tables have an array of columns for each component in the table. This array
	* does not include elements for tags, which means that the index for a
	* component in the table type is not necessarily the same as the index in the
	* column array. This operation converts from an index in the table type to an
	* index in the column array.
	*
	* @param table The table.
	* @param index The index in the table type.
	* @return The index in the table column array.
	*
	* @see ecs_table_column_to_type_index()
	*/
	table_type_to_column_index :: proc(table: ^Table, index: i32) -> i32 ---

	/** Convert column index to type index.
	* Same as ecs_table_type_to_column_index(), but converts from an index in the
	* column array to an index in the table type.
	*
	* @param table The table.
	* @param index The column index.
	* @return The index in the table type.
	*/
	table_column_to_type_index :: proc(table: ^Table, index: i32) -> i32 ---

	/** Get column from table by column index.
	* This operation returns the component array for the provided index.
	*
	* @param table The table.
	* @param index The column index.
	* @param offset The index of the first row to return (0 for entire column).
	* @return The component array, or NULL if the index is not a component.
	*/
	table_get_column :: proc(table: ^Table, index: i32, offset: i32) -> rawptr ---

	/** Get column from table by component.
	* This operation returns the component array for the provided component.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component for the column.
	* @param offset The index of the first row to return (0 for entire column).
	* @return The component array, or NULL if the index is not a component.
	*/
	table_get_id :: proc(world: ^World, table: ^Table, component: Id, offset: i32) -> rawptr ---

	/** Get column size from table.
	* This operation returns the component size for the provided index.
	*
	* @param table The table.
	* @param index The column index.
	* @return The component size, or 0 if the index is not a component.
	*/
	table_get_column_size :: proc(table: ^Table, index: i32) -> c.size_t ---

	/** Returns the number of entities in the table.
	* This operation returns the number of entities in the table.
	*
	* @param table The table.
	* @return The number of entities in the table.
	*/
	table_count :: proc(table: ^Table) -> i32 ---

	/** Returns allocated size of table.
	* This operation returns the number of elements allocated in the table
	* per column.
	*
	* @param table The table.
	* @return The number of allocated elements in the table.
	*/
	table_size :: proc(table: ^Table) -> i32 ---

	/** Returns array with entity ids for table.
	* The size of the returned array is the result of ecs_table_count().
	*
	* @param table The table.
	* @return Array with entity ids for table.
	*/
	table_entities :: proc(table: ^Table) -> ^Entity ---

	/** Test if table has component.
	* Same as `ecs_table_get_type_index(world, table, component) != -1`.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component.
	* @return True if the table has the id, false if the table doesn't.
	*
	* @see ecs_table_get_type_index()
	*/
	table_has_id :: proc(world: ^World, table: ^Table, component: Id) -> bool ---

	/** Get relationship target for table.
	*
	* @param world The world.
	* @param table The table.
	* @param relationship The relationship for which to obtain the target.
	* @param index The index, in case the table has multiple instances of the relationship.
	* @return The requested relationship target.
	*
	* @see ecs_get_target()
	*/
	table_get_target :: proc(world: ^World, table: ^Table, relationship: Entity, index: i32) -> Entity ---

	/** Return depth for table in tree for relationship rel.
	* Depth is determined by counting the number of targets encountered while
	* traversing up the relationship tree for rel. Only acyclic relationships are
	* supported.
	*
	* @param world The world.
	* @param table The table.
	* @param rel The relationship.
	* @return The depth of the table in the tree.
	*/
	table_get_depth :: proc(world: ^World, table: ^Table, rel: Entity) -> i32 ---

	/** Get table that has all components of current table plus the specified id.
	* If the provided table already has the provided id, the operation will return
	* the provided table.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component to add.
	* @result The resulting table.
	*/
	table_add_id :: proc(world: ^World, table: ^Table, component: Id) -> ^Table ---

	/** Find table from id array.
	* This operation finds or creates a table with the specified array of
	* (component) ids. The ids in the array must be sorted, and it may not contain
	* duplicate elements.
	*
	* @param world The world.
	* @param ids The id array.
	* @param id_count The number of elements in the id array.
	* @return The table with the specified (component) ids.
	*/
	table_find :: proc(world: ^World, ids: ^Id, id_count: i32) -> ^Table ---

	/** Get table that has all components of current table minus the specified component.
	* If the provided table doesn't have the provided component, the operation will
	* return the provided table.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component to remove.
	* @result The resulting table.
	*/
	table_remove_id :: proc(world: ^World, table: ^Table, component: Id) -> ^Table ---

	/** Lock a table.
	* When a table is locked, modifications to it will throw an assert. When the
	* table is locked recursively, it will take an equal amount of unlock
	* operations to actually unlock the table.
	*
	* Table locks can be used to build safe iterators where it is guaranteed that
	* the contents of a table are not modified while it is being iterated.
	*
	* The operation only works when called on the world, and has no side effects
	* when called on a stage. The assumption is that when called on a stage,
	* operations are deferred already.
	*
	* @param world The world.
	* @param table The table to lock.
	*/
	table_lock :: proc(world: ^World, table: ^Table) ---

	/** Unlock a table.
	* Must be called after calling ecs_table_lock().
	*
	* @param world The world.
	* @param table The table to unlock.
	*/
	table_unlock :: proc(world: ^World, table: ^Table) ---

	/** Test table for flags.
	* Test if table has all of the provided flags. See
	* include/flecs/private/api_flags.h for a list of table flags that can be used
	* with this function.
	*
	* @param table The table.
	* @param flags The flags to test for.
	* @return Whether the specified flags are set for the table.
	*/
	table_has_flags :: proc(table: ^Table, flags: Flags32) -> bool ---

	/** Check if table has traversable entities.
	* Traversable entities are entities that are used as target in a pair with a
	* relationship that has the Traversable trait.
	*
	* @param table The table.
	* @return Whether the table has traversable entities.
	*/
	table_has_traversable :: proc(table: ^Table) -> bool ---

	/** Swaps two elements inside the table. This is useful for implementing custom
	* table sorting algorithms.
	* @param world The world
	* @param table The table to swap elements in
	* @param row_1 Table element to swap with row_2
	* @param row_2 Table element to swap with row_1
	*/
	table_swap_rows :: proc(world: ^World, table: ^Table, row_1: i32, row_2: i32) ---

	/** Commit (move) entity to a table.
	* This operation moves an entity from its current table to the specified
	* table. This may cause the following actions:
	* - Ctor for each component in the target table
	* - Move for each overlapping component
	* - Dtor for each component in the source table.
	* - `OnAdd` triggers for non-overlapping components in the target table
	* - `OnRemove` triggers for non-overlapping components in the source table.
	*
	* This operation is a faster than adding/removing components individually.
	*
	* The application must explicitly provide the difference in components between
	* tables as the added/removed parameters. This can usually be derived directly
	* from the result of ecs_table_add_id() and ecs_table_remove_id(). These arrays are
	* required to properly execute `OnAdd`/`OnRemove` triggers.
	*
	* @param world The world.
	* @param entity The entity to commit.
	* @param record The entity's record (optional, providing it saves a lookup).
	* @param table The table to commit the entity to.
	* @return True if the entity got moved, false otherwise.
	*/
	commit :: proc(world: ^World, entity: Entity, record: ^Record, table: ^Table, added: ^Type, removed: ^Type) -> bool ---

	/** Search for component in table type.
	* This operation returns the index of first occurrence of the component in the
	* table type. The component may be a pair or wildcard.
	*
	* When component_out is provided, the function will assign it with the found
	* component. The found component may be different from the provided component
	* if it is a wildcard.
	*
	* This is a constant time operation.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component to search for.
	* @param component_out If provided, it will be set to the found component (optional).
	* @return The index of the id in the table type.
	*
	* @see ecs_search_offset()
	* @see ecs_search_relation()
	*/
	search :: proc(world: ^World, table: ^Table, component: Id, component_out: ^Id) -> i32 ---

	/** Search for component in table type starting from an offset.
	* This operation is the same as ecs_search(), but starts searching from an offset
	* in the table type.
	*
	* This operation is typically called in a loop where the resulting index is
	* used in the next iteration as offset:
	*
	* @code
	* int32_t index = -1;
	* while ((index = ecs_search_offset(world, table, offset, id, NULL))) {
	*   // do stuff
	* }
	* @endcode
	*
	* Depending on how the operation is used it is either linear or constant time.
	* When the id has the form `(id)` or `(rel, *)` and the operation is invoked as
	* in the above example, it is guaranteed to be constant time.
	*
	* If the provided component has the form `(*, tgt)` the operation takes linear
	* time. The reason for this is that ids for an target are not packed together,
	* as they are sorted relationship first.
	*
	* If the component at the offset does not match the provided id, the operation
	* will do a linear search to find a matching id.
	*
	* @param world The world.
	* @param table The table.
	* @param offset Offset from where to start searching.
	* @param component The component to search for.
	* @param component_out If provided, it will be set to the found component (optional).
	* @return The index of the id in the table type.
	*
	* @see ecs_search()
	* @see ecs_search_relation()
	*/
	search_offset :: proc(world: ^World, table: ^Table, offset: i32, component: Id, component_out: ^Id) -> i32 ---

	/** Search for component/relationship id in table type starting from an offset.
	* This operation is the same as ecs_search_offset(), but has the additional
	* capability of traversing relationships to find a component. For example, if
	* an application wants to find a component for either the provided table or a
	* prefab (using the `IsA` relationship) of that table, it could use the operation
	* like this:
	*
	* @code
	* int32_t index = ecs_search_relation(
	*   world,            // the world
	*   table,            // the table
	*   0,                // offset 0
	*   ecs_id(Position), // the component id
	*   EcsIsA,           // the relationship to traverse
	*   0,                // start at depth 0 (the table itself)
	*   0,                // no depth limit
	*   NULL,             // (optional) entity on which component was found
	*   NULL,             // see above
	*   NULL);            // internal type with information about matched id
	* @endcode
	*
	* The operation searches depth first. If a table type has 2 `IsA` relationships, the
	* operation will first search the `IsA` tree of the first relationship.
	*
	* When choosing between ecs_search(), ecs_search_offset() and ecs_search_relation(),
	* the simpler the function the better its performance.
	*
	* @param world The world.
	* @param table The table.
	* @param offset Offset from where to start searching.
	* @param component The component to search for.
	* @param rel The relationship to traverse (optional).
	* @param flags Whether to search EcsSelf and/or EcsUp.
	* @param tgt_out If provided, it will be set to the matched entity.
	* @param component_out If provided, it will be set to the found component (optional).
	* @param tr_out Internal datatype.
	* @return The index of the component in the table type.
	*
	* @see ecs_search()
	* @see ecs_search_offset()
	*/
	search_relation :: proc(world: ^World, table: ^Table, offset: i32, component: Id, rel: Entity, flags: Flags64, tgt_out: ^Entity, component_out: ^Id, tr_out: ^^Table_Record) -> i32 ---

	/* Up traversal from entity */
	search_relation_for_entity :: proc(world: ^World, entity: Entity, id: Id, rel: Entity, self: bool, cr: ^Component_Record, tgt_out: ^Entity, id_out: ^Id, tr_out: ^^Table_Record) -> i32 ---

	/** Remove all entities in a table. Does not deallocate table memory.
	* Retaining table memory can be efficient when planning
	* to refill the table with operations like ecs_bulk_init
	*
	* @param world The world.
	* @param table The table to clear.
	*/
	table_clear_entities :: proc(world: ^World, table: ^Table) ---

	/** Construct a value in existing storage
	*
	* @param world The world.
	* @param type The type of the value to create.
	* @param ptr Pointer to a value of type 'type'
	* @return Zero if success, nonzero if failed.
	*/
	value_init :: proc(world: ^World, type: Entity, ptr: rawptr) -> i32 ---

	/** Construct a value in existing storage
	*
	* @param world The world.
	* @param ti The type info of the type to create.
	* @param ptr Pointer to a value of type 'type'
	* @return Zero if success, nonzero if failed.
	*/
	value_init_w_type_info :: proc(world: ^World, ti: ^Type_Info, ptr: rawptr) -> i32 ---

	/** Construct a value in new storage
	*
	* @param world The world.
	* @param type The type of the value to create.
	* @return Pointer to type if success, NULL if failed.
	*/
	value_new :: proc(world: ^World, type: Entity) -> rawptr ---

	/** Construct a value in new storage
	*
	* @param world The world.
	* @param ti The type info of the type to create.
	* @return Pointer to type if success, NULL if failed.
	*/
	value_new_w_type_info :: proc(world: ^World, ti: ^Type_Info) -> rawptr ---

	/** Destruct a value
	*
	* @param world The world.
	* @param ti Type info of the value to destruct.
	* @param ptr Pointer to constructed value of type 'type'.
	* @return Zero if success, nonzero if failed.
	*/
	value_fini_w_type_info :: proc(world: ^World, ti: ^Type_Info, ptr: rawptr) -> i32 ---

	/** Destruct a value
	*
	* @param world The world.
	* @param type The type of the value to destruct.
	* @param ptr Pointer to constructed value of type 'type'.
	* @return Zero if success, nonzero if failed.
	*/
	value_fini :: proc(world: ^World, type: Entity, ptr: rawptr) -> i32 ---

	/** Destruct a value, free storage
	*
	* @param world The world.
	* @param type The type of the value to destruct.
	* @param ptr A pointer to the value.
	* @return Zero if success, nonzero if failed.
	*/
	value_free :: proc(world: ^World, type: Entity, ptr: rawptr) -> i32 ---

	/** Copy value.
	*
	* @param world The world.
	* @param ti Type info of the value to copy.
	* @param dst Pointer to the storage to copy to.
	* @param src Pointer to the value to copy.
	* @return Zero if success, nonzero if failed.
	*/
	value_copy_w_type_info :: proc(world: ^World, ti: ^Type_Info, dst: rawptr, src: rawptr) -> i32 ---

	/** Copy value.
	*
	* @param world The world.
	* @param type The type of the value to copy.
	* @param dst Pointer to the storage to copy to.
	* @param src Pointer to the value to copy.
	* @return Zero if success, nonzero if failed.
	*/
	value_copy :: proc(world: ^World, type: Entity, dst: rawptr, src: rawptr) -> i32 ---

	/** Move value.
	*
	* @param world The world.
	* @param ti Type info of the value to move.
	* @param dst Pointer to the storage to move to.
	* @param src Pointer to the value to move.
	* @return Zero if success, nonzero if failed.
	*/
	value_move_w_type_info :: proc(world: ^World, ti: ^Type_Info, dst: rawptr, src: rawptr) -> i32 ---

	/** Move value.
	*
	* @param world The world.
	* @param type The type of the value to move.
	* @param dst Pointer to the storage to move to.
	* @param src Pointer to the value to move.
	* @return Zero if success, nonzero if failed.
	*/
	value_move :: proc(world: ^World, type: Entity, dst: rawptr, src: rawptr) -> i32 ---

	/** Move construct value.
	*
	* @param world The world.
	* @param ti Type info of the value to move.
	* @param dst Pointer to the storage to move to.
	* @param src Pointer to the value to move.
	* @return Zero if success, nonzero if failed.
	*/
	value_move_ctor_w_type_info :: proc(world: ^World, ti: ^Type_Info, dst: rawptr, src: rawptr) -> i32 ---

	/** Move construct value.
	*
	* @param world The world.
	* @param type The type of the value to move.
	* @param dst Pointer to the storage to move to.
	* @param src Pointer to the value to move.
	* @return Zero if success, nonzero if failed.
	*/
	value_move_ctor :: proc(world: ^World, type: Entity, dst: rawptr, src: rawptr) -> i32 ---

	/** Log message indicating an operation is deprecated. */
	deprecated_ :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Increase log stack.
	* This operation increases the indent_ value of the OS API and can be useful to
	* make nested behavior more visible.
	*
	* @param level The log level.
	*/
	log_push_ :: proc(level: i32) ---

	/** Decrease log stack.
	* This operation decreases the indent_ value of the OS API and can be useful to
	* make nested behavior more visible.
	*
	* @param level The log level.
	*/
	log_pop_ :: proc(level: i32) ---

	/** Should current level be logged.
	* This operation returns true when the specified log level should be logged
	* with the current log level.
	*
	* @param level The log level to check for.
	* @return Whether logging is enabled for the current level.
	*/
	should_log :: proc(level: i32) -> bool ---

	/** Get description for error code */
	strerror :: proc(error_code: i32) -> cstring ---

	////////////////////////////////////////////////////////////////////////////////
	//// Logging functions (do nothing when logging is enabled)
	////////////////////////////////////////////////////////////////////////////////
	print_           :: proc(level: i32, file: cstring, line: i32, fmt: cstring, #c_vararg _: ..any) ---
	printv_          :: proc(level: i32, file: cstring, line: i32, fmt: cstring, args: c.va_list) ---
	log_             :: proc(level: i32, file: cstring, line: i32, fmt: cstring, #c_vararg _: ..any) ---
	logv_            :: proc(level: i32, file: cstring, line: i32, fmt: cstring, args: c.va_list) ---
	abort_           :: proc(error_code: i32, file: cstring, line: i32, fmt: cstring, #c_vararg _: ..any) ---
	assert_log_      :: proc(error_code: i32, condition_str: cstring, file: cstring, line: i32, fmt: cstring, #c_vararg _: ..any) ---
	parser_error_    :: proc(name: cstring, expr: cstring, column: i64, fmt: cstring, #c_vararg _: ..any) ---
	parser_errorv_   :: proc(name: cstring, expr: cstring, column: i64, fmt: cstring, args: c.va_list) ---
	parser_warning_  :: proc(name: cstring, expr: cstring, column: i64, fmt: cstring, #c_vararg _: ..any) ---
	parser_warningv_ :: proc(name: cstring, expr: cstring, column: i64, fmt: cstring, args: c.va_list) ---

	/** Enable or disable log.
	* This will enable builtin log. For log to work, it will have to be
	* compiled in which requires defining one of the following macros:
	*
	* FLECS_LOG_0 - All log is disabled
	* FLECS_LOG_1 - Enable log level 1
	* FLECS_LOG_2 - Enable log level 2 and below
	* FLECS_LOG_3 - Enable log level 3 and below
	*
	* If no log level is defined and this is a debug build, FLECS_LOG_3 will
	* have been automatically defined.
	*
	* The provided level corresponds with the log level. If -1 is provided as
	* value, warnings are disabled. If -2 is provided, errors are disabled as well.
	*
	* @param level Desired tracing level.
	* @return Previous log level.
	*/
	log_set_level :: proc(level: i32) -> i32 ---

	/** Get current log level.
	*
	* @return Previous log level.
	*/
	log_get_level :: proc() -> i32 ---

	/** Enable/disable tracing with colors.
	* By default colors are enabled.
	*
	* @param enabled Whether to enable tracing with colors.
	* @return Previous color setting.
	*/
	log_enable_colors :: proc(enabled: bool) -> bool ---

	/** Enable/disable logging timestamp.
	* By default timestamps are disabled. Note that enabling timestamps introduces
	* overhead as the logging code will need to obtain the current time.
	*
	* @param enabled Whether to enable tracing with timestamps.
	* @return Previous timestamp setting.
	*/
	log_enable_timestamp :: proc(enabled: bool) -> bool ---

	/** Enable/disable logging time since last log.
	* By default deltatime is disabled. Note that enabling timestamps introduces
	* overhead as the logging code will need to obtain the current time.
	*
	* When enabled, this logs the amount of time in seconds passed since the last
	* log, when this amount is non-zero. The format is a '+' character followed by
	* the number of seconds:
	*
	*     +1 trace: log message
	*
	* @param enabled Whether to enable tracing with timestamps.
	* @return Previous timestamp setting.
	*/
	log_enable_timedelta :: proc(enabled: bool) -> bool ---

	/** Get last logged error code.
	* Calling this operation resets the error code.
	*
	* @return Last error, 0 if none was logged since last call to last_error.
	*/
	log_last_error    :: proc() -> i32 ---
	log_start_capture :: proc(capture_try: bool) ---
	log_stop_capture  :: proc() -> cstring ---
}

////////////////////////////////////////////////////////////////////////////////
//// Error codes
////////////////////////////////////////////////////////////////////////////////
INVALID_OPERATION             :: (1)
INVALID_PARAMETER             :: (2)
CONSTRAINT_VIOLATED           :: (3)
OUT_OF_MEMORY                 :: (4)
OUT_OF_RANGE                  :: (5)
UNSUPPORTED                   :: (6)
INTERNAL_ERROR                :: (7)
ALREADY_DEFINED               :: (8)
MISSING_OS_API                :: (9)
OPERATION_FAILED              :: (10)
INVALID_CONVERSION            :: (11)
CYCLE_DETECTED                :: (13)
LEAK_DETECTED                 :: (14)
DOUBLE_FREE                   :: (15)
INCONSISTENT_NAME             :: (20)
NAME_IN_USE                   :: (21)
INVALID_COMPONENT_SIZE        :: (23)
INVALID_COMPONENT_ALIGNMENT   :: (24)
COMPONENT_NOT_REGISTERED      :: (25)
INCONSISTENT_COMPONENT_ID     :: (26)
INCONSISTENT_COMPONENT_ACTION :: (27)
MODULE_UNDEFINED              :: (28)
MISSING_SYMBOL                :: (29)
ALREADY_IN_USE                :: (30)
ACCESS_VIOLATION              :: (40)
COLUMN_INDEX_OUT_OF_RANGE     :: (41)
COLUMN_IS_NOT_SHARED          :: (42)
COLUMN_IS_SHARED              :: (43)
COLUMN_TYPE_MISMATCH          :: (45)
INVALID_WHILE_READONLY        :: (70)
LOCKED_STORAGE                :: (71)
INVALID_FROM_WORKER           :: (72)

////////////////////////////////////////////////////////////////////////////////
//// Used when logging with colors is enabled
////////////////////////////////////////////////////////////////////////////////
BLACK   :: "\033[1;30m"
RED     :: "\033[0;31m"
GREEN   :: "\033[0;32m"
YELLOW  :: "\033[0;33m"
BLUE    :: "\033[0;34m"
MAGENTA :: "\033[0;35m"
CYAN    :: "\033[0;36m"
WHITE   :: "\033[1;37m"
GREY    :: "\033[0;37m"
NORMAL  :: "\033[0;49m"
BOLD    :: "\033[1;49m"

/** Callback type for init action. */
App_Init_Action :: proc "c" (world: ^World) -> i32

/** Used with ecs_app_run(). */
App_Desc :: struct {
	target_fps:   f32,             /**< Target FPS. */
	delta_time:   f32,             /**< Frame time increment (0 for measured values) */
	threads:      i32,             /**< Number of threads. */
	frames:       i32,             /**< Number of frames to run (0 for infinite) */
	enable_rest:  bool,            /**< Enables ECS access over HTTP, necessary for explorer */
	enable_stats: bool,            /**< Periodically collect statistics */
	port:         u16,             /**< HTTP port used by REST API */
	init:         App_Init_Action, /**< If set, function is ran before starting the
                                 * main loop. */
	ctx:          rawptr,          /**< Reserved for custom run/frame actions */
}

/** Callback type for run action. */
App_Run_Action :: proc "c" (world: ^World, desc: ^App_Desc) -> i32

/** Callback type for frame action. */
App_Frame_Action :: proc "c" (world: ^World, desc: ^App_Desc) -> i32

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Run application.
	* This will run the application with the parameters specified in desc. After
	* the application quits (ecs_quit() is called) the world will be cleaned up.
	*
	* If a custom run action is set, it will be invoked by this operation. The
	* default run action calls the frame action in a loop until it returns a
	* non-zero value.
	*
	* @param world The world.
	* @param desc Application parameters.
	*/
	app_run :: proc(world: ^World, desc: ^App_Desc) -> i32 ---

	/** Default frame callback.
	* This operation will run a single frame. By default this operation will invoke
	* ecs_progress() directly, unless a custom frame action is set.
	*
	* @param world The world.
	* @param desc The desc struct passed to ecs_app_run().
	* @return value returned by ecs_progress()
	*/
	app_run_frame :: proc(world: ^World, desc: ^App_Desc) -> i32 ---

	/** Set custom run action.
	* See ecs_app_run().
	*
	* @param callback The run action.
	*/
	app_set_run_action :: proc(callback: App_Run_Action) -> i32 ---

	/** Set custom frame action.
	* See ecs_app_run_frame().
	*
	* @param callback The frame action.
	*/
	app_set_frame_action :: proc(callback: App_Frame_Action) -> i32 ---
}

/** Maximum number of headers in request. */
HTTP_HEADER_COUNT_MAX :: (32)

/** Maximum number of query parameters in request. */
HTTP_QUERY_PARAM_COUNT_MAX :: (32)

Http_Server :: struct {}

/** A connection manages communication with the remote host. */
Http_Connection :: struct {
	id:     u64,
	server: ^Http_Server,
	host:   [128]i8,
	port:   [16]i8,
}

/** Helper type used for headers & URL query parameters. */
Http_Key_Value :: struct {
	key:   cstring,
	value: cstring,
}

/** Supported request methods. */
Http_Method :: enum u32 {
	EcsHttpGet               = 0,
	EcsHttpPost              = 1,
	EcsHttpPut               = 2,
	EcsHttpDelete            = 3,
	EcsHttpOptions           = 4,
	EcsHttpMethodUnsupported = 5,
}

/** An HTTP request. */
Http_Request :: struct {
	id:           u64,
	method:       Http_Method,
	path:         cstring,
	body:         cstring,
	headers:      [32]Http_Key_Value,
	params:       [32]Http_Key_Value,
	header_count: i32,
	param_count:  i32,
	conn:         ^Http_Connection,
}

/** An HTTP reply. */
Http_Reply :: struct {
	code:         i32,     /**< default = 200 */
	body:         Strbuf,  /**< default = "" */
	status:       cstring, /**< default = OK */
	content_type: cstring, /**< default = application/json */
	headers:      Strbuf,  /**< default = "" */
}

HTTP_REPLY_INIT :: (Http_Reply){200, STRBUF_INIT, "OK", "application/json", STRBUF_INIT}

foreign lib {
	/**< Total number of HTTP requests received. */
	ecs_http_request_received_count : i64 /**< Total number of HTTP requests received. */

	/**< Total number of invalid HTTP requests. */
	ecs_http_request_invalid_count : i64 /**< Total number of invalid HTTP requests. */

	/**< Total number of successful HTTP requests. */
	ecs_http_request_handled_ok_count : i64 /**< Total number of successful HTTP requests. */

	/**< Total number of HTTP requests with errors. */
	ecs_http_request_handled_error_count : i64 /**< Total number of HTTP requests with errors. */

	/**< Total number of HTTP requests with an unknown endpoint. */
	ecs_http_request_not_handled_count : i64 /**< Total number of HTTP requests with an unknown endpoint. */

	/**< Total number of preflight HTTP requests received. */
	ecs_http_request_preflight_count : i64 /**< Total number of preflight HTTP requests received. */

	/**< Total number of HTTP replies successfully sent. */
	ecs_http_send_ok_count : i64 /**< Total number of HTTP replies successfully sent. */

	/**< Total number of HTTP replies that failed to send. */
	ecs_http_send_error_count : i64 /**< Total number of HTTP replies that failed to send. */

	/**< Total number of HTTP busy replies. */
	ecs_http_busy_count : i64 /**< Total number of HTTP busy replies. */
}

/** Request callback.
* Invoked for each valid request. The function should populate the reply and
* return true. When the function returns false, the server will reply with a
* 404 (Not found) code. */
Http_Reply_Action :: proc "c" (request: ^Http_Request, reply: ^Http_Reply, ctx: rawptr) -> bool

/** Used with ecs_http_server_init(). */
Http_Server_Desc :: struct {
	callback:            Http_Reply_Action, /**< Function called for each request  */
	ctx:                 rawptr,            /**< Passed to callback (optional) */
	port:                u16,               /**< HTTP port */
	ipaddr:              cstring,           /**< Interface to listen on (optional) */
	send_queue_wait_ms:  i32,               /**< Send queue wait time when empty */
	cache_timeout:       f64,               /**< Cache invalidation timeout (0 disables caching) */
	cache_purge_timeout: f64,               /**< Cache purge timeout (for purging cache entries) */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create server.
	* Use ecs_http_server_start() to start receiving requests.
	*
	* @param desc Server configuration parameters.
	* @return The new server, or NULL if creation failed.
	*/
	http_server_init :: proc(desc: ^Http_Server_Desc) -> ^Http_Server ---

	/** Destroy server.
	* This operation will stop the server if it was still running.
	*
	* @param server The server to destroy.
	*/
	http_server_fini :: proc(server: ^Http_Server) ---

	/** Start server.
	* After this operation the server will be able to accept requests.
	*
	* @param server The server to start.
	* @return Zero if successful, non-zero if failed.
	*/
	http_server_start :: proc(server: ^Http_Server) -> i32 ---

	/** Process server requests.
	* This operation invokes the reply callback for each received request. No new
	* requests will be enqueued while processing requests.
	*
	* @param server The server for which to process requests.
	*/
	http_server_dequeue :: proc(server: ^Http_Server, delta_time: f32) ---

	/** Stop server.
	* After this operation no new requests can be received.
	*
	* @param server The server.
	*/
	http_server_stop :: proc(server: ^Http_Server) ---

	/** Emulate a request.
	* The request string must be a valid HTTP request. A minimal example:
	*
	*     GET /entity/flecs/core/World?label=true HTTP/1.1
	*
	* @param srv The server.
	* @param req The request.
	* @param len The length of the request (optional).
	* @return The reply.
	*/
	http_server_http_request :: proc(srv: ^Http_Server, req: cstring, len: Size, reply_out: ^Http_Reply) -> i32 ---

	/** Convenience wrapper around ecs_http_server_http_request(). */
	http_server_request :: proc(srv: ^Http_Server, method: cstring, req: cstring, body: cstring, reply_out: ^Http_Reply) -> i32 ---

	/** Get context provided in ecs_http_server_desc_t */
	http_server_ctx :: proc(srv: ^Http_Server) -> rawptr ---

	/** Find header in request.
	*
	* @param req The request.
	* @param name name of the header to find
	* @return The header value, or NULL if not found.
	*/
	http_get_header :: proc(req: ^Http_Request, name: cstring) -> cstring ---

	/** Find query parameter in request.
	*
	* @param req The request.
	* @param name The parameter name.
	* @return The decoded parameter value, or NULL if not found.
	*/
	http_get_param :: proc(req: ^Http_Request, name: cstring) -> cstring ---
}

REST_DEFAULT_PORT :: (27750)

foreign lib {
	FLECS_IDEcsRestID_ : Entity
}

/** Private REST data. */
Rest_Ctx :: struct {
	world:        ^World,
	srv:          ^Http_Server,
	rc:           i32,
	cmd_captures: Map,
	last_time:    f64,
}

/** Component that creates a REST API server when instantiated. */
Ecs_Rest :: struct {
	port:   u16,     /**< Port of server (optional, default = 27750) */
	ipaddr: cstring, /**< Interface address (optional, default = 0.0.0.0) */
	impl:   ^Rest_Ctx,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create HTTP server for REST API.
	* This allows for the creation of a REST server that can be managed by the
	* application without using Flecs systems.
	*
	* @param world The world.
	* @param desc The HTTP server descriptor.
	* @return The HTTP server, or NULL if failed.
	*/
	rest_server_init :: proc(world: ^World, desc: ^Http_Server_Desc) -> ^Http_Server ---

	/** Cleanup REST HTTP server.
	* The server must have been created with ecs_rest_server_init().
	*/
	rest_server_fini :: proc(srv: ^Http_Server) ---
}

@(default_calling_convention="c")
foreign lib {
	/** Rest module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsRest)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsRestImport :: proc(world: ^World) ---
}

/** Component used for one shot/interval timer functionality */
Ecs_Timer :: struct {
	timeout:     f32,  /**< Timer timeout period */
	time:        f32,  /**< Incrementing time value */
	overshoot:   f32,  /**< Used to correct returned interval time */
	fired_count: i32,  /**< Number of times ticked */
	active:      bool, /**< Is the timer active or not */
	single_shot: bool, /**< Is this a single shot timer */
}

/** Apply a rate filter to a tick source */
Ecs_Rate_Filter :: struct {
	src:          Entity, /**< Source of the rate filter */
	rate:         i32,    /**< Rate of the rate filter */
	tick_count:   i32,    /**< Number of times the rate filter ticked */
	time_elapsed: f32,    /**< Time elapsed since last tick */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Set timer timeout.
	* This operation executes any systems associated with the timer after the
	* specified timeout value. If the entity contains an existing timer, the
	* timeout value will be reset. The timer can be started and stopped with
	* ecs_start_timer() and ecs_stop_timer().
	*
	* The timer is synchronous, and is incremented each frame by delta_time.
	*
	* The tick_source entity will be a tick source after this operation. Tick
	* sources can be read by getting the EcsTickSource component. If the tick
	* source ticked this frame, the 'tick' member will be true. When the tick
	* source is a system, the system will tick when the timer ticks.
	*
	* @param world The world.
	* @param tick_source The timer for which to set the timeout (0 to create one).
	* @param timeout The timeout value.
	* @return The timer entity.
	*/
	set_timeout :: proc(world: ^World, tick_source: Entity, timeout: f32) -> Entity ---

	/** Get current timeout value for the specified timer.
	* This operation returns the value set by ecs_set_timeout(). If no timer is
	* active for this entity, the operation returns 0.
	*
	* After the timeout expires the EcsTimer component is removed from the entity.
	* This means that if ecs_get_timeout() is invoked after the timer is expired, the
	* operation will return 0.
	*
	* The timer is synchronous, and is incremented each frame by delta_time.
	*
	* The tick_source entity will be a tick source after this operation. Tick
	* sources can be read by getting the EcsTickSource component. If the tick
	* source ticked this frame, the 'tick' member will be true. When the tick
	* source is a system, the system will tick when the timer ticks.
	*
	* @param world The world.
	* @param tick_source The timer.
	* @return The current timeout value, or 0 if no timer is active.
	*/
	get_timeout :: proc(world: ^World, tick_source: Entity) -> f32 ---

	/** Set timer interval.
	* This operation will continuously invoke systems associated with the timer
	* after the interval period expires. If the entity contains an existing timer,
	* the interval value will be reset.
	*
	* The timer is synchronous, and is incremented each frame by delta_time.
	*
	* The tick_source entity will be a tick source after this operation. Tick
	* sources can be read by getting the EcsTickSource component. If the tick
	* source ticked this frame, the 'tick' member will be true. When the tick
	* source is a system, the system will tick when the timer ticks.
	*
	* @param world The world.
	* @param tick_source The timer for which to set the interval (0 to create one).
	* @param interval The interval value.
	* @return The timer entity.
	*/
	set_interval :: proc(world: ^World, tick_source: Entity, interval: f32) -> Entity ---

	/** Get current interval value for the specified timer.
	* This operation returns the value set by ecs_set_interval(). If the entity is
	* not a timer, the operation will return 0.
	*
	* @param world The world.
	* @param tick_source The timer for which to set the interval.
	* @return The current interval value, or 0 if no timer is active.
	*/
	get_interval :: proc(world: ^World, tick_source: Entity) -> f32 ---

	/** Start timer.
	* This operation resets the timer and starts it with the specified timeout.
	*
	* @param world The world.
	* @param tick_source The timer to start.
	*/
	start_timer :: proc(world: ^World, tick_source: Entity) ---

	/** Stop timer
	* This operation stops a timer from triggering.
	*
	* @param world The world.
	* @param tick_source The timer to stop.
	*/
	stop_timer :: proc(world: ^World, tick_source: Entity) ---

	/** Reset time value of timer to 0.
	* This operation resets the timer value to 0.
	*
	* @param world The world.
	* @param tick_source The timer to reset.
	*/
	reset_timer :: proc(world: ^World, tick_source: Entity) ---

	/** Enable randomizing initial time value of timers.
	* Initializes timers with a random time value, which can improve scheduling as
	* systems/timers for the same interval don't all happen on the same tick.
	*
	* @param world The world.
	*/
	randomize_timers :: proc(world: ^World) ---

	/** Set rate filter.
	* This operation initializes a rate filter. Rate filters sample tick sources
	* and tick at a configurable multiple. A rate filter is a tick source itself,
	* which means that rate filters can be chained.
	*
	* Rate filters enable deterministic system execution which cannot be achieved
	* with interval timers alone. For example, if timer A has interval 2.0 and
	* timer B has interval 4.0, it is not guaranteed that B will tick at exactly
	* twice the multiple of A. This is partly due to the indeterministic nature of
	* timers, and partly due to floating point rounding errors.
	*
	* Rate filters can be combined with timers (or other rate filters) to ensure
	* that a system ticks at an exact multiple of a tick source (which can be
	* another system). If a rate filter is created with a rate of 1 it will tick
	* at the exact same time as its source.
	*
	* If no tick source is provided, the rate filter will use the frame tick as
	* source, which corresponds with the number of times ecs_progress() is called.
	*
	* The tick_source entity will be a tick source after this operation. Tick
	* sources can be read by getting the EcsTickSource component. If the tick
	* source ticked this frame, the 'tick' member will be true. When the tick
	* source is a system, the system will tick when the timer ticks.
	*
	* @param world The world.
	* @param tick_source The rate filter entity (0 to create one).
	* @param rate The rate to apply.
	* @param source The tick source (0 to use frames)
	* @return The filter entity.
	*/
	set_rate :: proc(world: ^World, tick_source: Entity, rate: i32, source: Entity) -> Entity ---

	/** Assign tick source to system.
	* Systems can be their own tick source, which can be any of the tick sources
	* (one shot timers, interval times and rate filters). However, in some cases it
	* is must be guaranteed that different systems tick on the exact same frame.
	*
	* This cannot be guaranteed by giving two systems the same interval/rate filter
	* as it is possible that one system is (for example) disabled, which would
	* cause the systems to go out of sync. To provide these guarantees, systems
	* must use the same tick source, which is what this operation enables.
	*
	* When two systems share the same tick source, it is guaranteed that they tick
	* in the same frame. The provided tick source can be any entity that is a tick
	* source, including another system. If the provided entity is not a tick source
	* the system will not be ran.
	*
	* To disassociate a tick source from a system, use 0 for the tick_source
	* parameter.
	*
	* @param world The world.
	* @param system The system to associate with the timer.
	* @param tick_source The tick source to associate with the system.
	*/
	set_tick_source :: proc(world: ^World, system: Entity, tick_source: Entity) ---

	/** Timer module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsTimer)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsTimerImport :: proc(world: ^World) ---
}

/** Pipeline descriptor, used with ecs_pipeline_init(). */
Pipeline_Desc :: struct {
	/** Existing entity to associate with pipeline (optional). */
	entity: Entity,

	/** The pipeline query.
	* Pipelines are queries that are matched with system entities. Pipeline
	* queries are the same as regular queries, which means the same query rules
	* apply. A common mistake is to try a pipeline that matches systems in a
	* list of phases by specifying all the phases, like:
	*   OnUpdate, OnPhysics, OnRender
	*
	* That however creates a query that matches entities with OnUpdate _and_
	* OnPhysics _and_ OnRender tags, which is likely undesired. Instead, a
	* query could use the or operator match a system that has one of the
	* specified phases:
	*   OnUpdate || OnPhysics || OnRender
	*
	* This will return the correct set of systems, but they likely won't be in
	* the correct order. To make sure systems are returned in the correct order
	* two query ordering features can be used:
	* - group_by
	* - order_by
	*
	* Take a look at the system manual for a more detailed explanation of
	* how query features can be applied to pipelines, and how the builtin
	* pipeline query works.
	*/
	query: Query_Desc,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a custom pipeline.
	*
	* @param world The world.
	* @param desc The pipeline descriptor.
	* @return The pipeline, 0 if failed.
	*/
	pipeline_init :: proc(world: ^World, desc: ^Pipeline_Desc) -> Entity ---

	/** Set a custom pipeline.
	* This operation sets the pipeline to run when ecs_progress() is invoked.
	*
	* @param world The world.
	* @param pipeline The pipeline to set.
	*/
	set_pipeline :: proc(world: ^World, pipeline: Entity) ---

	/** Get the current pipeline.
	* This operation gets the current pipeline.
	*
	* @param world The world.
	* @return The current pipeline.
	*/
	get_pipeline :: proc(world: ^World) -> Entity ---

	/** Progress a world.
	* This operation progresses the world by running all systems that are both
	* enabled and periodic on their matching entities.
	*
	* An application can pass a delta_time into the function, which is the time
	* passed since the last frame. This value is passed to systems so they can
	* update entity values proportional to the elapsed time since their last
	* invocation.
	*
	* When an application passes 0 to delta_time, ecs_progress() will automatically
	* measure the time passed since the last frame. If an application does not uses
	* time management, it should pass a non-zero value for delta_time (1.0 is
	* recommended). That way, no time will be wasted measuring the time.
	*
	* @param world The world to progress.
	* @param delta_time The time passed since the last frame.
	* @return false if ecs_quit() has been called, true otherwise.
	*/
	progress :: proc(world: ^World, delta_time: f32) -> bool ---

	/** Set time scale.
	* Increase or decrease simulation speed by the provided multiplier.
	*
	* @param world The world.
	* @param scale The scale to apply (default = 1).
	*/
	set_time_scale :: proc(world: ^World, scale: f32) ---

	/** Reset world clock.
	* Reset the clock that keeps track of the total time passed in the simulation.
	*
	* @param world The world.
	*/
	reset_clock :: proc(world: ^World) ---

	/** Run pipeline.
	* This will run all systems in the provided pipeline. This operation may be
	* invoked from multiple threads, and only when staging is disabled, as the
	* pipeline manages staging and, if necessary, synchronization between threads.
	*
	* If 0 is provided for the pipeline id, the default pipeline will be ran (this
	* is either the builtin pipeline or the pipeline set with set_pipeline()).
	*
	* When using progress() this operation will be invoked automatically for the
	* default pipeline (either the builtin pipeline or the pipeline set with
	* set_pipeline()). An application may run additional pipelines.
	*
	* @param world The world.
	* @param pipeline The pipeline to run.
	* @param delta_time The delta_time to pass to systems.
	*/
	run_pipeline :: proc(world: ^World, pipeline: Entity, delta_time: f32) ---

	/** Set number of worker threads.
	* Setting this value to a value higher than 1 will start as many threads and
	* will cause systems to evenly distribute matched entities across threads. The
	* operation may be called multiple times to reconfigure the number of threads
	* used, but never while running a system / pipeline.
	* Calling ecs_set_threads() will also end the use of task threads setup with
	* ecs_set_task_threads() and vice-versa.
	*
	* @param world The world.
	* @param threads The number of threads to create.
	*/
	set_threads :: proc(world: ^World, threads: i32) ---

	/** Set number of worker task threads.
	* ecs_set_task_threads() is similar to ecs_set_threads(), except threads are treated
	* as short-lived tasks and will be created and joined around each update of the world.
	* Creation and joining of these tasks will use the os_api_t tasks APIs rather than the
	* the standard thread API functions, although they may be the same if desired.
	* This function is useful for multithreading world updates using an external
	* asynchronous job system rather than long running threads by providing the APIs
	* to create tasks for your job system and then wait on their conclusion.
	* The operation may be called multiple times to reconfigure the number of task threads
	* used, but never while running a system / pipeline.
	* Calling ecs_set_task_threads() will also end the use of threads setup with
	* ecs_set_threads() and vice-versa
	*
	* @param world The world.
	* @param task_threads The number of task threads to create.
	*/
	set_task_threads :: proc(world: ^World, task_threads: i32) ---

	/** Returns true if task thread use have been requested.
	*
	* @param world The world.
	* @result Whether the world is using task threads.
	*/
	using_task_threads :: proc(world: ^World) -> bool ---

	/** Pipeline module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsPipeline)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsPipelineImport :: proc(world: ^World) ---
}

/** Component used to provide a tick source to systems */
Ecs_Tick_Source :: struct {
	tick:         bool, /**< True if providing tick */
	time_elapsed: f32,  /**< Time elapsed since last tick */
}

/** Use with ecs_system_init() to create or update a system. */
System_Desc :: struct {
	_canary: i32,

	/** Existing entity to associate with system (optional) */
	entity: Entity,

	/** System query parameters */
	query: Query_Desc,

	/** Optional pipeline phase for the system to run in. When set, it will be
	* added to the system both as a tag and as a (DependsOn, phase) pair. */
	phase: Entity,

	/** Callback that is ran for each result returned by the system's query. This
	* means that this callback can be invoked multiple times per system per
	* frame, typically once for each matching table. */
	callback: Iter_Action,

	/** Callback that is invoked when a system is ran.
	* When left to NULL, the default system runner is used, which calls the
	* "callback" action for each result returned from the system's query.
	*
	* It should not be assumed that the input iterator can always be iterated
	* with ecs_query_next(). When a system is multithreaded and/or paged, the
	* iterator can be either a worker or paged iterator. The correct function
	* to use for iteration is ecs_iter_next().
	*
	* An implementation can test whether the iterator is a query iterator by
	* testing whether the it->next value is equal to ecs_query_next(). */
	run: Run_Action,

	/** Context to be passed to callback (as ecs_iter_t::param) */
	ctx: rawptr,

	/** Callback to free ctx. */
	ctx_free: Ctx_Free,

	/** Context associated with callback (for language bindings). */
	callback_ctx: rawptr,

	/** Callback to free callback ctx. */
	callback_ctx_free: Ctx_Free,

	/** Context associated with run (for language bindings). */
	run_ctx: rawptr,

	/** Callback to free run ctx. */
	run_ctx_free: Ctx_Free,

	/** Interval in seconds at which the system should run */
	interval: f32,

	/** Rate at which the system should run */
	rate: i32,

	/** External tick source that determines when system ticks */
	tick_source: Entity,

	/** If true, system will be ran on multiple threads */
	multi_threaded: bool,

	/** If true, system will have access to the actual world. Cannot be true at the
	* same time as multi_threaded. */
	immediate: bool,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a system */
	system_init :: proc(world: ^World, desc: ^System_Desc) -> Entity ---
}

/** System type, get with ecs_system_get() */
System :: struct {
	hdr: Header,

	/** See ecs_system_desc_t */
	run: Run_Action,

	/** See ecs_system_desc_t */
	action: Iter_Action,

	/** System query */
	query: ^Query,

	/** Tick source associated with system */
	tick_source: Entity,

	/** Is system multithreaded */
	multi_threaded: bool,

	/** Is system ran in immediate mode */
	immediate: bool,

	/** Cached system name (for perf tracing) */
	name: cstring,

	/** Userdata for system */
	ctx: rawptr,

	/** Callback language binding context */
	callback_ctx: rawptr,

	/** Run language binding context */
	run_ctx: rawptr,

	/** Callback to free ctx. */
	ctx_free: Ctx_Free,

	/** Callback to free callback ctx. */
	callback_ctx_free: Ctx_Free,

	/** Callback to free run ctx. */
	run_ctx_free: Ctx_Free,

	/** Time spent on running system */
	time_spent: f32,

	/** Time passed since last invocation */
	time_passed: f32,

	/** Last frame for which the system was considered */
	last_frame: i64,

	/* Mixins */
	dtor: Flecs_Poly_Dtor,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Get system object.
	* Returns the system object. Can be used to access various information about
	* the system, like the query and context.
	*
	* @param world The world.
	* @param system The system.
	* @return The system object.
	*/
	system_get :: proc(world: ^World, system: Entity) -> ^System ---

	/** Run a specific system manually.
	* This operation runs a single system manually. It is an efficient way to
	* invoke logic on a set of entities, as manual systems are only matched to
	* tables at creation time or after creation time, when a new table is created.
	*
	* Manual systems are useful to evaluate lists of pre-matched entities at
	* application defined times. Because none of the matching logic is evaluated
	* before the system is invoked, manual systems are much more efficient than
	* manually obtaining a list of entities and retrieving their components.
	*
	* An application may pass custom data to a system through the param parameter.
	* This data can be accessed by the system through the param member in the
	* ecs_iter_t value that is passed to the system callback.
	*
	* Any system may interrupt execution by setting the interrupted_by member in
	* the ecs_iter_t value. This is particularly useful for manual systems, where
	* the value of interrupted_by is returned by this operation. This, in
	* combination with the param argument lets applications use manual systems
	* to lookup entities: once the entity has been found its handle is passed to
	* interrupted_by, which is then subsequently returned.
	*
	* @param world The world.
	* @param system The system to run.
	* @param delta_time The time passed since the last system invocation.
	* @param param A user-defined parameter to pass to the system.
	* @return handle to last evaluated entity if system was interrupted.
	*/
	run :: proc(world: ^World, system: Entity, delta_time: f32, param: rawptr) -> Entity ---

	/** Same as ecs_run(), but subdivides entities across number of provided stages.
	*
	* @param world The world.
	* @param system The system to run.
	* @param stage_current The id of the current stage.
	* @param stage_count The total number of stages.
	* @param delta_time The time passed since the last system invocation.
	* @param param A user-defined parameter to pass to the system.
	* @return handle to last evaluated entity if system was interrupted.
	*/
	run_worker :: proc(world: ^World, system: Entity, stage_current: i32, stage_count: i32, delta_time: f32, param: rawptr) -> Entity ---

	/** System module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsSystem)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsSystemImport :: proc(world: ^World) ---
}

STAT_WINDOW :: (60)

/** Simple value that indicates current state */
Gauge :: struct {
	avg: [60]f32,
	min: [60]f32,
	max: [60]f32,
}

/** Monotonically increasing counter */
Counter :: struct {
	rate:  Gauge, /**< Keep track of deltas too */
	value: [60]f64,
}

/** Make all metrics the same size, so we can iterate over fields */
Metric :: struct #raw_union {
	gauge:   Gauge,
	counter: Counter,
}

World_Stats :: struct {
	first_: i64,

	entities: struct {
		count:           Metric, /**< Number of entities */
		not_alive_count: Metric, /**< Number of not alive (recyclable) entity ids */
	},

	components: struct {
		tag_count:       Metric, /**< Number of tag ids (ids without data) */
		component_count: Metric, /**< Number of components ids (ids with data) */
		pair_count:      Metric, /**< Number of pair ids */
		type_count:      Metric, /**< Number of registered types */
		create_count:    Metric, /**< Number of times id has been created */
		delete_count:    Metric, /**< Number of times id has been deleted */
	},

	tables: struct {
		count:        Metric, /**< Number of tables */
		empty_count:  Metric, /**< Number of empty tables */
		create_count: Metric, /**< Number of times table has been created */
		delete_count: Metric, /**< Number of times table has been deleted */
	},

	queries: struct {
		query_count:    Metric, /**< Number of queries */
		observer_count: Metric, /**< Number of observers */
		system_count:   Metric, /**< Number of systems */
	},

	commands: struct {
		add_count:            Metric,
		remove_count:         Metric,
		delete_count:         Metric,
		clear_count:          Metric,
		set_count:            Metric,
		ensure_count:         Metric,
		modified_count:       Metric,
		other_count:          Metric,
		discard_count:        Metric,
		batched_entity_count: Metric,
		batched_count:        Metric,
	},

	frame: struct {
		frame_count:          Metric, /**< Number of frames processed. */
		merge_count:          Metric, /**< Number of merges executed. */
		rematch_count:        Metric, /**< Number of query rematches */
		pipeline_build_count: Metric, /**< Number of system pipeline rebuilds (occurs when an inactive system becomes active). */
		systems_ran:          Metric, /**< Number of systems ran. */
		observers_ran:        Metric, /**< Number of times an observer was invoked. */
		event_emit_count:     Metric, /**< Number of events emitted */
	},

	performance: struct {
		world_time_raw: Metric, /**< Actual time passed since simulation start (first time progress() is called) */
		world_time:     Metric, /**< Simulation time passed since simulation start. Takes into account time scaling */
		frame_time:     Metric, /**< Time spent processing a frame. Smaller than world_time_total when load is not 100% */
		system_time:    Metric, /**< Time spent on running systems. */
		emit_time:      Metric, /**< Time spent on notifying observers. */
		merge_time:     Metric, /**< Time spent on merging commands. */
		rematch_time:   Metric, /**< Time spent on rematching. */
		fps:            Metric, /**< Frames per second. */
		delta_time:     Metric, /**< Delta_time. */
	},

	memory: struct {
		/* Memory allocation data */
		alloc_count:             Metric, /**< Allocs per frame */
		realloc_count:           Metric, /**< Reallocs per frame */
		free_count:              Metric, /**< Frees per frame */
		outstanding_alloc_count: Metric, /**< Difference between allocs & frees */

		/* Memory allocator data */
		block_alloc_count:             Metric, /**< Block allocations per frame */
		block_free_count:              Metric, /**< Block frees per frame */
		block_outstanding_alloc_count: Metric, /**< Difference between allocs & frees */
		stack_alloc_count:             Metric, /**< Page allocations per frame */
		stack_free_count:              Metric, /**< Page frees per frame */
		stack_outstanding_alloc_count: Metric, /**< Difference between allocs & frees */
	},

	http: struct {
		request_received_count:      Metric,
		request_invalid_count:       Metric,
		request_handled_ok_count:    Metric,
		request_handled_error_count: Metric,
		request_not_handled_count:   Metric,
		request_preflight_count:     Metric,
		send_ok_count:               Metric,
		send_error_count:            Metric,
		busy_count:                  Metric,
	},

	last_: i64,

	/** Current position in ring buffer */
	t: i32,
}

/** Statistics for a single query (use ecs_query_cache_stats_get) */
Query_Stats :: struct {
	first_:               i64,
	result_count:         Metric, /**< Number of query results */
	matched_table_count:  Metric, /**< Number of matched tables */
	matched_entity_count: Metric, /**< Number of matched entities */
	last_:                i64,

	/** Current position in ringbuffer */
	t: i32,
}

/** Statistics for a single system (use ecs_system_stats_get()) */
System_Stats :: struct {
	first_:     i64,
	time_spent: Metric, /**< Time spent processing a system */
	last_:      i64,
	task:       bool,   /**< Is system a task */
	query:      Query_Stats,
}

/** Statistics for sync point */
Sync_Stats :: struct {
	first_:            i64,
	time_spent:        Metric,
	commands_enqueued: Metric,
	last_:             i64,
	system_count:      i32,
	multi_threaded:    bool,
	immediate:         bool,
}

/** Statistics for all systems in a pipeline. */
Pipeline_Stats :: struct {
	/* Allow for initializing struct with {0} */
	canary_: i8,

	/** Vector with system ids of all systems in the pipeline. The systems are
	* stored in the order they are executed. Merges are represented by a 0. */
	systems: Vec,

	/** Vector with sync point stats */
	sync_points: Vec,

	/** Current position in ring buffer */
	t:                   i32,
	system_count:        i32, /**< Number of systems in pipeline */
	active_system_count: i32, /**< Number of active systems in pipeline */
	rebuild_count:       i32, /**< Number of times pipeline has rebuilt */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Get world statistics.
	*
	* @param world The world.
	* @param stats Out parameter for statistics.
	*/
	world_stats_get :: proc(world: ^World, stats: ^World_Stats) ---

	/** Reduce source measurement window into single destination measurement. */
	world_stats_reduce :: proc(dst: ^World_Stats, src: ^World_Stats) ---

	/** Reduce last measurement into previous measurement, restore old value. */
	world_stats_reduce_last :: proc(stats: ^World_Stats, old: ^World_Stats, count: i32) ---

	/** Repeat last measurement. */
	world_stats_repeat_last :: proc(stats: ^World_Stats) ---

	/** Copy last measurement from source to destination. */
	world_stats_copy_last :: proc(dst: ^World_Stats, src: ^World_Stats) ---
	world_stats_log       :: proc(world: ^World, stats: ^World_Stats) ---

	/** Get query statistics.
	* Obtain statistics for the provided query.
	*
	* @param world The world.
	* @param query The query.
	* @param stats Out parameter for statistics.
	*/
	query_stats_get :: proc(world: ^World, query: ^Query, stats: ^Query_Stats) ---

	/** Reduce source measurement window into single destination measurement. */
	query_cache_stats_reduce :: proc(dst: ^Query_Stats, src: ^Query_Stats) ---

	/** Reduce last measurement into previous measurement, restore old value. */
	query_cache_stats_reduce_last :: proc(stats: ^Query_Stats, old: ^Query_Stats, count: i32) ---

	/** Repeat last measurement. */
	query_cache_stats_repeat_last :: proc(stats: ^Query_Stats) ---

	/** Copy last measurement from source to destination. */
	query_cache_stats_copy_last :: proc(dst: ^Query_Stats, src: ^Query_Stats) ---

	/** Get system statistics.
	* Obtain statistics for the provided system.
	*
	* @param world The world.
	* @param system The system.
	* @param stats Out parameter for statistics.
	* @return true if success, false if not a system.
	*/
	system_stats_get :: proc(world: ^World, system: Entity, stats: ^System_Stats) -> bool ---

	/** Reduce source measurement window into single destination measurement */
	system_stats_reduce :: proc(dst: ^System_Stats, src: ^System_Stats) ---

	/** Reduce last measurement into previous measurement, restore old value. */
	system_stats_reduce_last :: proc(stats: ^System_Stats, old: ^System_Stats, count: i32) ---

	/** Repeat last measurement. */
	system_stats_repeat_last :: proc(stats: ^System_Stats) ---

	/** Copy last measurement from source to destination. */
	system_stats_copy_last :: proc(dst: ^System_Stats, src: ^System_Stats) ---

	/** Get pipeline statistics.
	* Obtain statistics for the provided pipeline.
	*
	* @param world The world.
	* @param pipeline The pipeline.
	* @param stats Out parameter for statistics.
	* @return true if success, false if not a pipeline.
	*/
	pipeline_stats_get :: proc(world: ^World, pipeline: Entity, stats: ^Pipeline_Stats) -> bool ---

	/** Free pipeline stats.
	*
	* @param stats The stats to free.
	*/
	pipeline_stats_fini :: proc(stats: ^Pipeline_Stats) ---

	/** Reduce source measurement window into single destination measurement */
	pipeline_stats_reduce :: proc(dst: ^Pipeline_Stats, src: ^Pipeline_Stats) ---

	/** Reduce last measurement into previous measurement, restore old value. */
	pipeline_stats_reduce_last :: proc(stats: ^Pipeline_Stats, old: ^Pipeline_Stats, count: i32) ---

	/** Repeat last measurement. */
	pipeline_stats_repeat_last :: proc(stats: ^Pipeline_Stats) ---

	/** Copy last measurement to destination.
	* This operation copies the last measurement into the destination. It does not
	* modify the cursor.
	*
	* @param dst The metrics.
	* @param src The metrics to copy.
	*/
	pipeline_stats_copy_last :: proc(dst: ^Pipeline_Stats, src: ^Pipeline_Stats) ---

	/** Reduce all measurements from a window into a single measurement. */
	metric_reduce :: proc(dst: ^Metric, src: ^Metric, t_dst: i32, t_src: i32) ---

	/** Reduce last measurement into previous measurement */
	metric_reduce_last :: proc(m: ^Metric, t: i32, count: i32) ---

	/** Copy measurement */
	metric_copy :: proc(m: ^Metric, dst: i32, src: i32) ---
}

foreign lib {
	FLECS_IDFlecsStatsID_                   : Entity /**< Flecs stats module. */
	FLECS_IDEcsWorldStatsID_                : Entity /**< Component id for EcsWorldStats. */
	FLECS_IDEcsWorldSummaryID_              : Entity /**< Component id for EcsWorldSummary. */
	FLECS_IDEcsSystemStatsID_               : Entity /**< Component id for EcsSystemStats. */
	FLECS_IDEcsPipelineStatsID_             : Entity /**< Component id for EcsPipelineStats. */
	FLECS_IDecs_entities_memory_tID_        : Entity /**< Component id for ecs_entities_memory_t. */
	FLECS_IDecs_component_index_memory_tID_ : Entity /**< Component id for ecs_component_index_memory_t. */
	FLECS_IDecs_query_memory_tID_           : Entity /**< Component id for ecs_query_memory_t. */
	FLECS_IDecs_component_memory_tID_       : Entity /**< Component id for ecs_component_memory_t. */
	FLECS_IDecs_table_memory_tID_           : Entity /**< Component id for ecs_table_memory_t. */
	FLECS_IDecs_misc_memory_tID_            : Entity /**< Component id for ecs_misc_memory_t. */
	FLECS_IDecs_table_histogram_tID_        : Entity /**< Component id for ecs_table_histogram_t. */
	FLECS_IDecs_allocator_memory_tID_       : Entity /**< Component id for ecs_allocator_memory_t. */
	FLECS_IDEcsWorldMemoryID_               : Entity /**< Component id for EcsWorldMemory. */

	/**< Tag used for metrics collected in last second. */
	EcsPeriod1s : Entity /**< Tag used for metrics collected in last second. */

	/**< Tag used for metrics collected in last minute. */
	EcsPeriod1m : Entity /**< Tag used for metrics collected in last minute. */

	/**< Tag used for metrics collected in last hour. */
	EcsPeriod1h : Entity /**< Tag used for metrics collected in last hour. */

	/**< Tag used for metrics collected in last day. */
	EcsPeriod1d : Entity /**< Tag used for metrics collected in last day. */

	/**< Tag used for metrics collected in last week. */
	EcsPeriod1w : Entity /**< Tag used for metrics collected in last week. */
}

/** Common data for statistics. */
Ecs_Stats_Header :: struct {
	elapsed:      f32,
	reduce_count: i32,
}

/** Component that stores world statistics. */
Ecs_World_Stats :: struct {
	hdr:   Ecs_Stats_Header,
	stats: ^World_Stats,
}

/** Component that stores system statistics. */
Ecs_System_Stats :: struct {
	hdr:   Ecs_Stats_Header,
	stats: Map,
}

/** Component that stores pipeline statistics. */
Ecs_Pipeline_Stats :: struct {
	hdr:   Ecs_Stats_Header,
	stats: Map,
}

/** Component that stores a summary of world statistics. */
Ecs_World_Summary :: struct {
	/* Time */
	target_fps: f64, /**< Target FPS */
	time_scale: f64, /**< Simulation time scale */
	fps:        f64, /**< FPS */

	/* Totals */
	frame_time_total:    f64, /**< Total time spent processing a frame */
	system_time_total:   f64, /**< Total time spent in systems */
	merge_time_total:    f64, /**< Total time spent in merges */
	entity_count:        i64,
	table_count:         i64,
	frame_count:         i64, /**< Number of frames processed */
	command_count:       i64, /**< Number of commands processed */
	merge_count:         i64, /**< Number of merges executed */
	systems_ran_total:   i64,
	observers_ran_total: i64,
	queries_ran_total:   i64,
	tag_count:           i32, /**< Number of tag (no data) ids in the world */
	component_count:     i32, /**< Number of component (data) ids in the world */
	pair_count:          i32, /**< Number of pair ids in the world */

	/* Per frame */
	frame_time_frame:    f64, /**< Time spent processing a frame */
	system_time_frame:   f64, /**< Time spent in systems */
	merge_time_frame:    f64, /**< Time spent in merges */
	merge_count_frame:   i64,
	systems_ran_frame:   i64,
	observers_ran_frame: i64,
	queries_ran_frame:   i64,
	command_count_frame: i64, /**< Number of commands processed in last frame */
	simulation_time:     f64, /**< Time spent in simulation */
	uptime:              u32, /**< Time since world was created */

	/* Build info */
	build_info: Build_Info, /**< Build info */
}

/** Entity memory. */
Entities_Memory :: struct {
	alive_count:        i32,  /** Number of alive entities. */
	not_alive_count:    i32,  /** Number of not alive entities. */
	bytes_entity_index: Size, /** Bytes used by entity index. */
	bytes_names:        Size, /** Bytes used by names, symbols, aliases. */
	bytes_doc_strings:  Size, /** Bytes used by doc strings. */
}

/* Component memory. */
Component_Memory :: struct {
	instances:                     i32,  /** Total number of component instances. */
	bytes_table_components:        Size, /** Bytes used by table columns. */
	bytes_table_components_unused: Size, /** Unused bytes in table columns. */
	bytes_toggle_bitsets:          Size, /** Bytes used in bitsets (toggled components). */
	bytes_sparse_components:       Size, /** Bytes used in component sparse sets. */
}

/** Component index memory. */
Component_Index_Memory :: struct {
	count:                    i32,  /** Number of component records. */
	bytes_component_record:   Size, /** Bytes used by ecs_component_record_t struct. */
	bytes_table_cache:        Size, /** Bytes used by table cache. */
	bytes_name_index:         Size, /** Bytes used by name index. */
	bytes_ordered_children:   Size, /** Bytes used by ordered children vector. */
	bytes_children_table_map: Size, /** Bytes used by map for non-fragmenting ChildOf table lookups. */
	bytes_reachable_cache:    Size, /** Bytes used by reachable cache. */
}

/** Query memory. */
Query_Memory :: struct {
	count:          i32,  /** Number of queries. */
	cached_count:   i32,  /** Number of queries with caches. */
	bytes_query:    Size, /** Bytes used by ecs_query_impl_t struct. */
	bytes_cache:    Size, /** Bytes used by query cache. */
	bytes_group_by: Size, /** Bytes used by query cache groups (excludes cache elements). */
	bytes_order_by: Size, /** Bytes used by table_slices. */
	bytes_plan:     Size, /** Bytes used by query plan. */
	bytes_terms:    Size, /** Bytes used by terms array. */
	bytes_misc:     Size, /** Bytes used by remaining misc arrays. */
}

/** Table memory histogram constants */
TABLE_MEMORY_HISTOGRAM_BUCKET_COUNT :: 14
TABLE_MEMORY_HISTOGRAM_MAX_COUNT    :: (1<<TABLE_MEMORY_HISTOGRAM_BUCKET_COUNT)

/** Table memory */
Table_Memory :: struct {
	count:               i32,  /** Total number of tables. */
	empty_count:         i32,  /** Number of empty tables. */
	column_count:        i32,  /** Number of table columns. */
	bytes_table:         Size, /** Bytes used by ecs_table_t struct. */
	bytes_type:          Size, /** Bytes used by type, columns and table records. */
	bytes_entities:      Size, /** Bytes used by entity vectors. */
	bytes_overrides:     Size, /** Bytes used by table overrides. */
	bytes_column_map:    Size, /** Bytes used by column map. */
	bytes_component_map: Size, /** Bytes used by component map. */
	bytes_dirty_state:   Size, /** Bytes used by dirty state. */
	bytes_edges:         Size, /** Bytes used by table graph edges. */
}

/** Table size histogram */
Table_Histogram :: struct {
	entity_counts: [14]i32,
}

/** Misc memory */
Misc_Memory :: struct {
	bytes_world:                   Size, /** Memory used by world and stages */
	bytes_observers:               Size, /** Memory used by observers. */
	bytes_systems:                 Size, /** Memory used by systems (excluding system queries). */
	bytes_pipelines:               Size, /** Memory used by pipelines (excluding pipeline queries). */
	bytes_table_lookup:            Size, /** Bytes used for table lookup data structures. */
	bytes_component_record_lookup: Size, /** Bytes used for component record lookup data structures. */
	bytes_locked_components:       Size, /** Locked component map. */
	bytes_type_info:               Size, /** Bytes used for storing type information. */
	bytes_commands:                Size, /** Command queue */
	bytes_rematch_monitor:         Size, /** Memory used by monitor used to track rematches */
	bytes_component_ids:           Size, /** Memory used for mapping global to world-local component ids. */
	bytes_reflection:              Size, /** Memory used for component reflection not tracked elsewhere. */
	bytes_tree_spawner:            Size, /** Memory used for tree (prefab) spawners. */
	bytes_prefab_child_indices:    Size, /** Memory used by map that stores indices for ordered prefab children */
	bytes_stats:                   Size, /** Memory used for statistics tracking not tracked elsewhere. */
	bytes_rest:                    Size, /** Memory used by REST HTTP server */
}

/** Allocator memory.
* Returns memory that's allocated by allocators but not in use. */
Allocator_Memory :: struct {
	bytes_graph_edge:       Size, /** Graph edge allocator. */
	bytes_component_record: Size, /** Component record allocator. */
	bytes_pair_record:      Size, /** Pair record allocator. */
	bytes_table_diff:       Size, /** Table diff allocator. */
	bytes_sparse_chunk:     Size, /** Sparse chunk allocator. */
	bytes_allocator:        Size, /** Generic allocator. */
	bytes_stack_allocator:  Size, /** Stack allocator. */
	bytes_cmd_entry_chunk:  Size, /** Command batching entry chunk allocator. */
	bytes_query_impl:       Size, /** Query struct allocator. */
	bytes_query_cache:      Size, /** Query cache struct allocator. */
	bytes_misc:             Size, /** Miscalleneous allocators */
}

/** Component with memory statistics. */
Ecs_World_Memory :: struct {
	entities:        Entities_Memory,
	components:      Component_Memory,
	component_index: Component_Index_Memory,
	queries:         Query_Memory,
	tables:          Table_Memory,
	table_histogram: Table_Histogram,
	misc:            Misc_Memory,
	allocators:      Allocator_Memory,
	collection_time: f64, /** Time spent collecting statistics. */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Memory statistics getters. */
	/** Get memory usage statistics for the entity index.
	*
	* @param world The world.
	* @return Memory statistics for the entity index.
	*/
	entity_memory_get :: proc(world: ^World) -> Entities_Memory ---

	/** Get memory usage statistics for single component record.
	*
	* @param cr The component record.
	* @param result Memory statistics for component record (out).
	*/
	component_record_memory_get :: proc(cr: ^Component_Record, result: ^Component_Index_Memory) ---

	/** Get memory usage statistics for the component index.
	*
	* @param world The world.
	* @return Memory statistics for the component index.
	*/
	component_index_memory_get :: proc(world: ^World) -> Component_Index_Memory ---

	/** Get memory usage statistics for single query.
	*
	* @param query The query.
	* @param result Memory statistics for query (out).
	*/
	query_memory_get :: proc(query: ^Query, result: ^Query_Memory) ---

	/** Get memory usage statistics for queries.
	*
	* @param world The world.
	* @return Memory statistics for queries.
	*/
	queries_memory_get :: proc(world: ^World) -> Query_Memory ---

	/** Get component memory for table.
	*
	* @param table The table.
	* @param result The memory used by components stored in this table (out).
	*/
	table_component_memory_get :: proc(table: ^Table, result: ^Component_Memory) ---

	/** Get memory usage statistics for components.
	*
	* @param world The world.
	* @return Memory statistics for components.
	*/
	component_memory_get :: proc(world: ^World) -> Component_Memory ---

	/** Get memory usage statistics for single table.
	*
	* @param table The table.
	* @param result Memory statistics for table (out).
	*/
	table_memory_get :: proc(table: ^Table, result: ^Table_Memory) ---

	/** Get memory usage statistics for tables.
	*
	* @param world The world.
	* @return Memory statistics for tables.
	*/
	tables_memory_get :: proc(world: ^World) -> Table_Memory ---

	/** Get number of tables by number of entities in the table.
	*
	* @param world The world.
	* @return Number of tables by number of entities in the table.
	*/
	table_histogram_get :: proc(world: ^World) -> Table_Histogram ---

	/** Get memory usage statistics for commands.
	*
	* @param world The world.
	* @return Memory statistics for commands.
	*/
	misc_memory_get :: proc(world: ^World) -> Misc_Memory ---

	/** Get memory usage statistics for allocators.
	*
	* @param world The world.
	* @return Memory statistics for allocators.
	*/
	allocator_memory_get :: proc(world: ^World) -> Allocator_Memory ---

	/** Get total memory used by world.
	*
	* @param world The world.
	*/
	memory_get :: proc(world: ^World) -> Size ---

	/** Stats module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsStats)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsStatsImport :: proc(world: ^World) ---
}

foreign lib {
	FLECS_IDFlecsMetricsID_        : Entity
	FLECS_IDEcsMetricID_           : Entity
	EcsMetric                      : Entity
	EcsCounter                     : Entity
	FLECS_IDEcsCounterID_          : Entity
	FLECS_IDEcsCounterIncrementID_ : Entity
	EcsCounterIncrement            : Entity
	FLECS_IDEcsCounterIdID_        : Entity
	EcsCounterId                   : Entity
	EcsGauge                       : Entity
	FLECS_IDEcsGaugeID_            : Entity
	FLECS_IDEcsMetricInstanceID_   : Entity
	EcsMetricInstance              : Entity
	FLECS_IDEcsMetricValueID_      : Entity
	FLECS_IDEcsMetricSourceID_     : Entity
}

/** Component that stores metric value. */
Ecs_Metric_Value :: struct {
	value: f64,
}

/** Component that stores metric source. */
Ecs_Metric_Source :: struct {
	entity: Entity,
}

/** Used with ecs_metric_init to create metric. */
Metric_Desc :: struct {
	_canary: i32,

	/** Entity associated with metric */
	entity: Entity,

	/** Entity associated with member that stores metric value. Must not be set
	* at the same time as id. Cannot be combined with EcsCounterId. */
	member: Entity,

	/* Member dot expression. Can be used instead of member and supports nested
	* members. Must be set together with id and should not be set at the same
	* time as member. */
	dotmember: cstring,

	/** Tracks whether entities have the specified component id. Must not be set
	* at the same time as member. */
	id: Id,

	/** If id is a (R, *) wildcard and relationship R has the OneOf property,
	* setting this value to true will track individual targets.
	* If the kind is EcsCountId and the id is a (R, *) wildcard, this value
	* will create a metric per target. */
	targets: bool,

	/** Must be EcsGauge, EcsCounter, EcsCounterIncrement or EcsCounterId */
	kind: Entity,

	/** Description of metric. Will only be set if FLECS_DOC addon is enabled */
	brief: cstring,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new metric.
	* Metrics are entities that store values measured from a range of different
	* properties in the ECS storage. Metrics provide a single unified interface to
	* discovering and reading these values, which can be useful for monitoring
	* utilities, or for debugging.
	*
	* Examples of properties that can be measured by metrics are:
	*  - Component member values
	*  - How long an entity has had a specific component
	*  - How long an entity has had a specific target for a relationship
	*  - How many entities have a specific component
	*
	* Metrics can either be created as a "gauge" or "counter". A gauge is a metric
	* that represents the value of something at a specific point in time, for
	* example "velocity". A counter metric represents a value that is monotonically
	* increasing, for example "miles driven".
	*
	* There are three different kinds of counter metric kinds:
	* - EcsCounter
	*   When combined with a member, this will store the actual value of the member
	*   in the metric. This is useful for values that are already counters, such as
	*   a MilesDriven component.
	*   This kind creates a metric per entity that has the member/id.
	*
	* - EcsCounterIncrement
	*   When combined with a member, this will increment the value of the metric by
	*   the value of the member * delta_time. This is useful for values that are
	*   not counters, such as a Velocity component.
	*   This kind creates a metric per entity that has the member.
	*
	* - EcsCounterId
	*   This metric kind will count the number of entities with a specific
	*   (component) id. This kind creates a single metric instance for regular ids,
	*   and a metric instance per target for wildcard ids when targets is set.
	*
	* @param world The world.
	* @param desc Metric description.
	* @return The metric entity.
	*/
	metric_init :: proc(world: ^World, desc: ^Metric_Desc) -> Entity ---

	/** Metrics module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsMetrics)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsMetricsImport :: proc(world: ^World) ---
}

ALERT_MAX_SEVERITY_FILTERS :: (4)

foreign lib {
	FLECS_IDFlecsAlertsID_      : Entity
	FLECS_IDEcsAlertID_         : Entity /**< Component added to alert, and used as first element of alert severity pair. */
	FLECS_IDEcsAlertInstanceID_ : Entity /**< Component added to alert instance. */
	FLECS_IDEcsAlertsActiveID_  : Entity /**< Component added to alert source which tracks how many active alerts there are. */
	FLECS_IDEcsAlertTimeoutID_  : Entity /**< Component added to alert which tracks how long an alert has been inactive. */
	EcsAlertInfo                : Entity /**< Info alert severity. */
	FLECS_IDEcsAlertInfoID_     : Entity /**< Info alert severity. */
	FLECS_IDEcsAlertWarningID_  : Entity /**< Warning alert severity. */
	EcsAlertWarning             : Entity /**< Warning alert severity. */
	FLECS_IDEcsAlertErrorID_    : Entity /**< Error alert severity. */
	EcsAlertError               : Entity /**< Error alert severity. */
	EcsAlertCritical            : Entity /**< Critical alert severity. */
	FLECS_IDEcsAlertCriticalID_ : Entity /**< Critical alert severity. */
}

/** Component added to alert instance. */
Ecs_Alert_Instance :: struct {
	message: cstring, /**< Generated alert message */
}

/** Map with active alerts for entity. */
Ecs_Alerts_Active :: struct {
	info_count:    i32, /**< Number of alerts for source with info severity */
	warning_count: i32, /**< Number of alerts for source with warning severity */
	error_count:   i32, /**< Number of alerts for source with error severity */
	alerts:        Map,
}

/** Alert severity filter.
* A severity filter can adjust the severity of an alert based on whether an
* entity in the alert query has a specific component. For example, a filter
* could check if an entity has the "Production" tag, and increase the default
* severity of an alert from Warning to Error.
*/
Alert_Severity_Filter :: struct {
	severity:   Entity,  /* Severity kind */
	with:       Id,      /* Component to match */
	var:        cstring, /* Variable to match component on. Do not include the
                            * '$' character. Leave to NULL for $this. */
	_var_index: i32,     /* Index of variable in filter (do not set) */
}

/** Alert descriptor, used with ecs_alert_init(). */
Alert_Desc :: struct {
	_canary: i32,

	/** Entity associated with alert */
	entity: Entity,

	/** Alert query. An alert will be created for each entity that matches the
	* specified query. The query must have at least one term that uses the
	* $this variable (default). */
	query: Query_Desc,

	/** Template for alert message. This string is used to generate the alert
	* message and may refer to variables in the query result. The format for
	* the template expressions is as specified by ecs_script_string_interpolate().
	*
	* Examples:
	*
	*     "$this has Position but not Velocity"
	*     "$this has a parent entity $parent without Position"
	*/
	message: cstring,

	/** User friendly name. Will only be set if FLECS_DOC addon is enabled. */
	doc_name: cstring,

	/** Description of alert. Will only be set if FLECS_DOC addon is enabled */
	brief: cstring,

	/** Metric kind. Must be EcsAlertInfo, EcsAlertWarning, EcsAlertError or
	* EcsAlertCritical. Defaults to EcsAlertError. */
	severity: Entity,

	/** Severity filters can be used to assign different severities to the same
	* alert. This prevents having to create multiple alerts, and allows
	* entities to transition between severities without resetting the
	* alert duration (optional). */
	severity_filters: [4]Alert_Severity_Filter,

	/** The retain period specifies how long an alert must be inactive before it
	* is cleared. This makes it easier to track noisy alerts. While an alert is
	* inactive its duration won't increase.
	* When the retain period is 0, the alert will clear immediately after it no
	* longer matches the alert query. */
	retain_period: f32,

	/** Alert when member value is out of range. Uses the warning/error ranges
	* assigned to the member in the MemberRanges component (optional). */
	member: Entity,

	/** (Component) id of member to monitor. If left to 0 this will be set to
	* the parent entity of the member (optional). */
	id: Id,

	/** Variable from which to fetch the member (optional). When left to NULL
	* 'id' will be obtained from $this. */
	var: cstring,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new alert.
	* An alert is a query that is evaluated periodically and creates alert
	* instances for each entity that matches the query. Alerts can be used to
	* automate detection of errors in an application.
	*
	* Alerts are automatically cleared when a query is no longer true for an alert
	* instance. At most one alert instance will be created per matched entity.
	*
	* Alert instances have three components:
	* - AlertInstance: contains the alert message for the instance
	* - MetricSource: contains the entity that triggered the alert
	* - MetricValue: contains how long the alert has been active
	*
	* Alerts reuse components from the metrics addon so that alert instances can be
	* tracked and discovered as metrics. Just like metrics, alert instances are
	* created as children of the alert.
	*
	* When an entity has active alerts, it will have the EcsAlertsActive component
	* which contains a map with active alerts for the entity. This component
	* will be automatically removed once all alerts are cleared for the entity.
	*
	* @param world The world.
	* @param desc Alert description.
	* @return The alert entity.
	*/
	alert_init :: proc(world: ^World, desc: ^Alert_Desc) -> Entity ---

	/** Return number of active alerts for entity.
	* When a valid alert entity is specified for the alert parameter, the operation
	* will return whether the specified alert is active for the entity. When no
	* alert is specified, the operation will return the total number of active
	* alerts for the entity.
	*
	* @param world The world.
	* @param entity The entity.
	* @param alert The alert to test for (optional).
	* @return The number of active alerts for the entity.
	*/
	get_alert_count :: proc(world: ^World, entity: Entity, alert: Entity) -> i32 ---

	/** Return alert instance for specified alert.
	* This operation returns the alert instance for the specified alert. If the
	* alert is not active for the entity, the operation will return 0.
	*
	* @param world The world.
	* @param entity The entity.
	* @param alert The alert to test for.
	* @return The alert instance for the specified alert.
	*/
	get_alert :: proc(world: ^World, entity: Entity, alert: Entity) -> Entity ---

	/** Alert module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsAlerts)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsAlertsImport :: proc(world: ^World) ---
}

/** Used with ecs_ptr_from_json(), ecs_entity_from_json(). */
From_Json_Desc :: struct {
	name: cstring, /**< Name of expression (used for logging) */
	expr: cstring, /**< Full expression (used for logging) */

	/** Callback that allows for specifying a custom lookup function. The
	* default behavior uses ecs_lookup() */
	lookup_action: proc "c" (_: ^World, value: cstring, ctx: rawptr) -> Entity,
	lookup_ctx:    rawptr,

	/** Require components to be registered with reflection data. When not
	* in strict mode, values for components without reflection are ignored. */
	strict: bool,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Parse JSON string into value.
	* This operation parses a JSON expression into the provided pointer. The
	* memory pointed to must be large enough to contain a value of the used type.
	*
	* @param world The world.
	* @param type The type of the expression to parse.
	* @param ptr Pointer to the memory to write to.
	* @param json The JSON expression to parse.
	* @param desc Configuration parameters for deserializer.
	* @return Pointer to the character after the last one read, or NULL if failed.
	*/
	ptr_from_json :: proc(world: ^World, type: Entity, ptr: rawptr, json: cstring, desc: ^From_Json_Desc) -> cstring ---

	/** Parse JSON object with multiple component values into entity. The format
	* is the same as the one outputted by ecs_entity_to_json(), but at the moment
	* only supports the "ids" and "values" member.
	*
	* @param world The world.
	* @param entity The entity to serialize to.
	* @param json The JSON expression to parse (see entity in JSON format manual).
	* @param desc Configuration parameters for deserializer.
	* @return Pointer to the character after the last one read, or NULL if failed.
	*/
	entity_from_json :: proc(world: ^World, entity: Entity, json: cstring, desc: ^From_Json_Desc) -> cstring ---

	/** Parse JSON object with multiple entities into the world. The format is the
	* same as the one outputted by ecs_world_to_json().
	*
	* @param world The world.
	* @param json The JSON expression to parse (see iterator in JSON format manual).
	* @param desc Deserialization parameters.
	* @return Last deserialized character, NULL if failed.
	*/
	world_from_json :: proc(world: ^World, json: cstring, desc: ^From_Json_Desc) -> cstring ---

	/** Same as ecs_world_from_json(), but loads JSON from file.
	*
	* @param world The world.
	* @param filename The file from which to load the JSON.
	* @param desc Deserialization parameters.
	* @return Last deserialized character, NULL if failed.
	*/
	world_from_json_file :: proc(world: ^World, filename: cstring, desc: ^From_Json_Desc) -> cstring ---

	/** Serialize array into JSON string.
	* This operation serializes a value of the provided type to a JSON string. The
	* memory pointed to must be large enough to contain a value of the used type.
	*
	* If count is 0, the function will serialize a single value, not wrapped in
	* array brackets. If count is >= 1, the operation will serialize values to a
	* a comma-separated list inside of array brackets.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @param count The number of elements to serialize.
	* @return String with JSON expression, or NULL if failed.
	*/
	array_to_json :: proc(world: ^World, type: Entity, data: rawptr, count: i32) -> cstring ---

	/** Serialize array into JSON string buffer.
	* Same as ecs_array_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @param count The number of elements to serialize.
	* @param buf_out The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	array_to_json_buf :: proc(world: ^World, type: Entity, data: rawptr, count: i32, buf_out: ^Strbuf) -> i32 ---

	/** Serialize value into JSON string.
	* Same as ecs_array_to_json(), with count = 0.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @return String with JSON expression, or NULL if failed.
	*/
	ptr_to_json :: proc(world: ^World, type: Entity, data: rawptr) -> cstring ---

	/** Serialize value into JSON string buffer.
	* Same as ecs_ptr_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @param buf_out The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	ptr_to_json_buf :: proc(world: ^World, type: Entity, data: rawptr, buf_out: ^Strbuf) -> i32 ---

	/** Serialize type info to JSON.
	* This serializes type information to JSON, and can be used to store/transmit
	* the structure of a (component) value.
	*
	* If the provided type does not have reflection data, "0" will be returned.
	*
	* @param world The world.
	* @param type The type to serialize to JSON.
	* @return A JSON string with the serialized type info, or NULL if failed.
	*/
	type_info_to_json :: proc(world: ^World, type: Entity) -> cstring ---

	/** Serialize type info into JSON string buffer.
	* Same as ecs_type_info_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param type The type to serialize.
	* @param buf_out The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	type_info_to_json_buf :: proc(world: ^World, type: Entity, buf_out: ^Strbuf) -> i32 ---
}

/** Used with ecs_iter_to_json(). */
Entity_To_Json_Desc :: struct {
	serialize_entity_id:  bool,   /**< Serialize entity id */
	serialize_doc:        bool,   /**< Serialize doc attributes */
	serialize_full_paths: bool,   /**< Serialize full paths for tags, components and pairs */
	serialize_inherited:  bool,   /**< Serialize base components */
	serialize_values:     bool,   /**< Serialize component values */
	serialize_builtin:    bool,   /**< Serialize builtin data as components (e.g. "name", "parent") */
	serialize_type_info:  bool,   /**< Serialize type info (requires serialize_values) */
	serialize_alerts:     bool,   /**< Serialize active alerts for entity */
	serialize_refs:       Entity, /**< Serialize references (incoming edges) for relationship */
	serialize_matches:    bool,   /**< Serialize which queries entity matches with */

	/** Callback for if the component should be serialized */
	component_filter: proc "c" (^World, Entity) -> bool,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Serialize entity into JSON string.
	* This creates a JSON object with the entity's (path) name, which components
	* and tags the entity has, and the component values.
	*
	* The operation may fail if the entity contains components with invalid values.
	*
	* @param world The world.
	* @param entity The entity to serialize to JSON.
	* @return A JSON string with the serialized entity data, or NULL if failed.
	*/
	entity_to_json :: proc(world: ^World, entity: Entity, desc: ^Entity_To_Json_Desc) -> cstring ---

	/** Serialize entity into JSON string buffer.
	* Same as ecs_entity_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param entity The entity to serialize.
	* @param buf_out The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	entity_to_json_buf :: proc(world: ^World, entity: Entity, buf_out: ^Strbuf, desc: ^Entity_To_Json_Desc) -> i32 ---
}

/** Used with ecs_iter_to_json(). */
Iter_To_Json_Desc :: struct {
	serialize_entity_ids:              bool,   /**< Serialize entity ids */
	serialize_values:                  bool,   /**< Serialize component values */
	serialize_builtin:                 bool,   /**< Serialize builtin data as components (e.g. "name", "parent") */
	serialize_doc:                     bool,   /**< Serialize doc attributes */
	serialize_full_paths:              bool,   /**< Serialize full paths for tags, components and pairs */
	serialize_fields:                  bool,   /**< Serialize field data */
	serialize_inherited:               bool,   /**< Serialize inherited components */
	serialize_table:                   bool,   /**< Serialize entire table vs. matched components */
	serialize_type_info:               bool,   /**< Serialize type information */
	serialize_field_info:              bool,   /**< Serialize metadata for fields returned by query */
	serialize_query_info:              bool,   /**< Serialize query terms */
	serialize_query_plan:              bool,   /**< Serialize query plan */
	serialize_query_profile:           bool,   /**< Profile query performance */
	dont_serialize_results:            bool,   /**< If true, query won't be evaluated */
	serialize_alerts:                  bool,   /**< Serialize active alerts for entity */
	serialize_refs:                    Entity, /**< Serialize references (incoming edges) for relationship */
	serialize_matches:                 bool,   /**< Serialize which queries entity matches with */
	serialize_parents_before_children: bool,   /** If query matches both children and parent, serialize parent before children */

	/** Callback for if the component should be serialized */
	component_filter: proc "c" (^World, Entity) -> bool,
	query:            ^Poly, /**< Query object (required for serialize_query_[plan|profile]). */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Serialize iterator into JSON string.
	* This operation will iterate the contents of the iterator and serialize them
	* to JSON. The function accepts iterators from any source.
	*
	* @param iter The iterator to serialize to JSON.
	* @return A JSON string with the serialized iterator data, or NULL if failed.
	*/
	iter_to_json :: proc(iter: ^Iter, desc: ^Iter_To_Json_Desc) -> cstring ---

	/** Serialize iterator into JSON string buffer.
	* Same as ecs_iter_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param iter The iterator to serialize.
	* @param buf_out The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	iter_to_json_buf :: proc(iter: ^Iter, buf_out: ^Strbuf, desc: ^Iter_To_Json_Desc) -> i32 ---
}

/** Used with ecs_iter_to_json(). */
World_To_Json_Desc :: struct {
	serialize_builtin: bool, /**< Exclude flecs modules & contents */
	serialize_modules: bool, /**< Exclude modules & contents */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Serialize world into JSON string.
	* This operation iterates the contents of the world to JSON. The operation is
	* equivalent to the following code:
	*
	* @code
	* ecs_query_t *f = ecs_query(world, {
	*   .terms = {{ .id = EcsAny }}
	* });
	*
	* ecs_iter_t it = ecs_query_init(world, &f);
	* ecs_iter_to_json_desc_t desc = { .serialize_table = true };
	* ecs_iter_to_json(iter, &desc);
	* @endcode
	*
	* @param world The world to serialize.
	* @return A JSON string with the serialized iterator data, or NULL if failed.
	*/
	world_to_json :: proc(world: ^World, desc: ^World_To_Json_Desc) -> cstring ---

	/** Serialize world into JSON string buffer.
	* Same as ecs_world_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world to serialize.
	* @param buf_out The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	world_to_json_buf :: proc(world: ^World, buf_out: ^Strbuf, desc: ^World_To_Json_Desc) -> i32 ---
}

foreign lib {
	/**< Parent scope for prefixes. */
	EcsUnitPrefixes : Entity /**< Parent scope for prefixes. */

	/**< Yocto unit prefix. */
	EcsYocto : Entity /**< Yocto unit prefix. */

	/**< Zepto unit prefix. */
	EcsZepto : Entity /**< Zepto unit prefix. */

	/**< Atto unit prefix. */
	EcsAtto : Entity /**< Atto unit prefix. */

	/**< Femto unit prefix. */
	EcsFemto : Entity /**< Femto unit prefix. */

	/**< Pico unit prefix. */
	EcsPico : Entity /**< Pico unit prefix. */

	/**< Nano unit prefix. */
	EcsNano : Entity /**< Nano unit prefix. */

	/**< Micro unit prefix. */
	EcsMicro : Entity /**< Micro unit prefix. */

	/**< Milli unit prefix. */
	EcsMilli : Entity /**< Milli unit prefix. */

	/**< Centi unit prefix. */
	EcsCenti : Entity /**< Centi unit prefix. */

	/**< Deci unit prefix. */
	EcsDeci : Entity /**< Deci unit prefix. */

	/**< Deca unit prefix. */
	EcsDeca : Entity /**< Deca unit prefix. */

	/**< Hecto unit prefix. */
	EcsHecto : Entity /**< Hecto unit prefix. */

	/**< Kilo unit prefix. */
	EcsKilo : Entity /**< Kilo unit prefix. */

	/**< Mega unit prefix. */
	EcsMega : Entity /**< Mega unit prefix. */

	/**< Giga unit prefix. */
	EcsGiga : Entity /**< Giga unit prefix. */

	/**< Tera unit prefix. */
	EcsTera : Entity /**< Tera unit prefix. */

	/**< Peta unit prefix. */
	EcsPeta : Entity /**< Peta unit prefix. */

	/**< Exa unit prefix. */
	EcsExa : Entity /**< Exa unit prefix. */

	/**< Zetta unit prefix. */
	EcsZetta : Entity /**< Zetta unit prefix. */

	/**< Yotta unit prefix. */
	EcsYotta : Entity /**< Yotta unit prefix. */

	/**< Kibi unit prefix. */
	EcsKibi : Entity /**< Kibi unit prefix. */

	/**< Mebi unit prefix. */
	EcsMebi : Entity /**< Mebi unit prefix. */

	/**< Gibi unit prefix. */
	EcsGibi : Entity /**< Gibi unit prefix. */

	/**< Tebi unit prefix. */
	EcsTebi : Entity /**< Tebi unit prefix. */

	/**< Pebi unit prefix. */
	EcsPebi : Entity /**< Pebi unit prefix. */

	/**< Exbi unit prefix. */
	EcsExbi : Entity /**< Exbi unit prefix. */

	/**< Zebi unit prefix. */
	EcsZebi : Entity /**< Zebi unit prefix. */

	/**< Yobi unit prefix. */
	EcsYobi : Entity /**< Yobi unit prefix. */

	/**< Duration quantity. */
	EcsDuration : Entity /**< Duration quantity. */

	/**< PicoSeconds duration unit. */
	EcsPicoSeconds : Entity /**< PicoSeconds duration unit. */

	/**< NanoSeconds duration unit. */
	EcsNanoSeconds : Entity /**< NanoSeconds duration unit. */

	/**< MicroSeconds duration unit. */
	EcsMicroSeconds : Entity /**< MicroSeconds duration unit. */

	/**< MilliSeconds duration unit. */
	EcsMilliSeconds : Entity /**< MilliSeconds duration unit. */

	/**< Seconds duration unit. */
	EcsSeconds : Entity /**< Seconds duration unit. */

	/**< Minutes duration unit. */
	EcsMinutes : Entity /**< Minutes duration unit. */

	/**< Hours duration unit. */
	EcsHours : Entity /**< Hours duration unit. */

	/**< Days duration unit. */
	EcsDays : Entity /**< Days duration unit. */

	/**< Time quantity. */
	EcsTime : Entity /**< Time quantity. */

	/**< Date unit. */
	EcsDate : Entity /**< Date unit. */

	/**< Mass quantity. */
	EcsMass : Entity /**< Mass quantity. */

	/**< Grams unit. */
	EcsGrams : Entity /**< Grams unit. */

	/**< KiloGrams unit. */
	EcsKiloGrams : Entity /**< KiloGrams unit. */

	/**< ElectricCurrent quantity. */
	EcsElectricCurrent : Entity /**< ElectricCurrent quantity. */

	/**< Ampere unit. */
	EcsAmpere : Entity /**< Ampere unit. */

	/**< Amount quantity. */
	EcsAmount : Entity /**< Amount quantity. */

	/**< Mole unit. */
	EcsMole : Entity /**< Mole unit. */

	/**< LuminousIntensity quantity. */
	EcsLuminousIntensity : Entity /**< LuminousIntensity quantity. */

	/**< Candela unit. */
	EcsCandela : Entity /**< Candela unit. */

	/**< Force quantity. */
	EcsForce : Entity /**< Force quantity. */

	/**< Newton unit. */
	EcsNewton : Entity /**< Newton unit. */

	/**< Length quantity. */
	EcsLength : Entity /**< Length quantity. */

	/**< Meters unit. */
	EcsMeters : Entity /**< Meters unit. */

	/**< PicoMeters unit. */
	EcsPicoMeters : Entity /**< PicoMeters unit. */

	/**< NanoMeters unit. */
	EcsNanoMeters : Entity /**< NanoMeters unit. */

	/**< MicroMeters unit. */
	EcsMicroMeters : Entity /**< MicroMeters unit. */

	/**< MilliMeters unit. */
	EcsMilliMeters : Entity /**< MilliMeters unit. */

	/**< CentiMeters unit. */
	EcsCentiMeters : Entity /**< CentiMeters unit. */

	/**< KiloMeters unit. */
	EcsKiloMeters : Entity /**< KiloMeters unit. */

	/**< Miles unit. */
	EcsMiles : Entity /**< Miles unit. */

	/**< Pixels unit. */
	EcsPixels : Entity /**< Pixels unit. */

	/**< Pressure quantity. */
	EcsPressure : Entity /**< Pressure quantity. */

	/**< Pascal unit. */
	EcsPascal : Entity /**< Pascal unit. */

	/**< Bar unit. */
	EcsBar : Entity /**< Bar unit. */

	/**< Speed quantity. */
	EcsSpeed : Entity /**< Speed quantity. */

	/**< MetersPerSecond unit. */
	EcsMetersPerSecond : Entity /**< MetersPerSecond unit. */

	/**< KiloMetersPerSecond unit. */
	EcsKiloMetersPerSecond : Entity /**< KiloMetersPerSecond unit. */

	/**< KiloMetersPerHour unit. */
	EcsKiloMetersPerHour : Entity /**< KiloMetersPerHour unit. */

	/**< MilesPerHour unit. */
	EcsMilesPerHour : Entity /**< MilesPerHour unit. */

	/**< Temperature quantity. */
	EcsTemperature : Entity /**< Temperature quantity. */

	/**< Kelvin unit. */
	EcsKelvin : Entity /**< Kelvin unit. */

	/**< Celsius unit. */
	EcsCelsius : Entity /**< Celsius unit. */

	/**< Fahrenheit unit. */
	EcsFahrenheit : Entity /**< Fahrenheit unit. */

	/**< Data quantity. */
	EcsData : Entity /**< Data quantity. */

	/**< Bits unit. */
	EcsBits : Entity /**< Bits unit. */

	/**< KiloBits unit. */
	EcsKiloBits : Entity /**< KiloBits unit. */

	/**< MegaBits unit. */
	EcsMegaBits : Entity /**< MegaBits unit. */

	/**< GigaBits unit. */
	EcsGigaBits : Entity /**< GigaBits unit. */

	/**< Bytes unit. */
	EcsBytes : Entity /**< Bytes unit. */

	/**< KiloBytes unit. */
	EcsKiloBytes : Entity /**< KiloBytes unit. */

	/**< MegaBytes unit. */
	EcsMegaBytes : Entity /**< MegaBytes unit. */

	/**< GigaBytes unit. */
	EcsGigaBytes : Entity /**< GigaBytes unit. */

	/**< KibiBytes unit. */
	EcsKibiBytes : Entity /**< KibiBytes unit. */

	/**< MebiBytes unit. */
	EcsMebiBytes : Entity /**< MebiBytes unit. */

	/**< GibiBytes unit. */
	EcsGibiBytes : Entity /**< GibiBytes unit. */

	/**< DataRate quantity. */
	EcsDataRate : Entity /**< DataRate quantity. */

	/**< BitsPerSecond unit. */
	EcsBitsPerSecond : Entity /**< BitsPerSecond unit. */

	/**< KiloBitsPerSecond unit. */
	EcsKiloBitsPerSecond : Entity /**< KiloBitsPerSecond unit. */

	/**< MegaBitsPerSecond unit. */
	EcsMegaBitsPerSecond : Entity /**< MegaBitsPerSecond unit. */

	/**< GigaBitsPerSecond unit. */
	EcsGigaBitsPerSecond : Entity /**< GigaBitsPerSecond unit. */

	/**< BytesPerSecond unit. */
	EcsBytesPerSecond : Entity /**< BytesPerSecond unit. */

	/**< KiloBytesPerSecond unit. */
	EcsKiloBytesPerSecond : Entity /**< KiloBytesPerSecond unit. */

	/**< MegaBytesPerSecond unit. */
	EcsMegaBytesPerSecond : Entity /**< MegaBytesPerSecond unit. */

	/**< GigaBytesPerSecond unit. */
	EcsGigaBytesPerSecond : Entity /**< GigaBytesPerSecond unit. */

	/**< Angle quantity. */
	EcsAngle : Entity /**< Angle quantity. */

	/**< Radians unit. */
	EcsRadians : Entity /**< Radians unit. */

	/**< Degrees unit. */
	EcsDegrees : Entity /**< Degrees unit. */

	/**< Frequency quantity. */
	EcsFrequency : Entity /**< Frequency quantity. */

	/**< Hertz unit. */
	EcsHertz : Entity /**< Hertz unit. */

	/**< KiloHertz unit. */
	EcsKiloHertz : Entity /**< KiloHertz unit. */

	/**< MegaHertz unit. */
	EcsMegaHertz : Entity /**< MegaHertz unit. */

	/**< GigaHertz unit. */
	EcsGigaHertz : Entity /**< GigaHertz unit. */

	/**< URI quantity. */
	EcsUri : Entity /**< URI quantity. */

	/**< UriHyperlink unit. */
	EcsUriHyperlink : Entity /**< UriHyperlink unit. */

	/**< UriImage unit. */
	EcsUriImage : Entity /**< UriImage unit. */

	/**< UriFile unit. */
	EcsUriFile : Entity /**< UriFile unit. */

	/**< Color quantity. */
	EcsColor : Entity /**< Color quantity. */

	/**< ColorRgb unit. */
	EcsColorRgb : Entity /**< ColorRgb unit. */

	/**< ColorHsl unit. */
	EcsColorHsl : Entity /**< ColorHsl unit. */

	/**< ColorCss unit. */
	EcsColorCss : Entity /**< ColorCss unit. */

	/**< Acceleration unit. */
	EcsAcceleration : Entity /**< Acceleration unit. */

	/**< Percentage unit. */
	EcsPercentage : Entity /**< Percentage unit. */

	/**< Bel unit. */
	EcsBel : Entity /**< Bel unit. */

	/**< DeciBel unit. */
	EcsDeciBel : Entity /**< DeciBel unit. */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Units module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsUnits)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsUnitsImport :: proc(world: ^World) ---
}

FLECS_SCRIPT_FUNCTION_ARGS_MAX :: (16)

/* Must be the same as EcsPrimitiveKindLast */
FLECS_SCRIPT_VECTOR_FUNCTION_COUNT :: (18)

foreign lib {
	FLECS_IDEcsScriptID_           : Entity
	FLECS_IDEcsScriptTemplateID_   : Entity
	EcsScriptTemplate              : Entity
	FLECS_IDEcsScriptConstVarID_   : Entity
	FLECS_IDEcsScriptFunctionID_   : Entity
	FLECS_IDEcsScriptMethodID_     : Entity
	FLECS_IDEcsScriptVectorTypeID_ : Entity
	EcsScriptVectorType            : Entity
}

Script_Template :: struct {}

/** Script variable. */
Script_Var :: struct {
	name:      cstring,
	value:     Value,
	type_info: ^Type_Info,
	sp:        i32,
	is_const:  bool,
}

/** Script variable scope. */
Script_Vars :: struct {
	parent:    ^Script_Vars,
	sp:        i32,
	var_index: Hashmap,
	vars:      Vec,
	world:     ^World,
	stack:     ^Stack,
	cursor:    ^Stack_Cursor,
	allocator: ^Allocator,
}

/** Script object. */
Script :: struct {
	world: ^World,
	name:  cstring,
	code:  cstring,
}

Script_Runtime :: struct {}

/** Script component.
* This component is added to the entities of managed scripts and templates.
*/
Ecs_Script :: struct {
	filename:  cstring,
	code:      cstring,
	error:     cstring,          /* Set if script evaluation had errors */
	script:    ^Script,
	template_: ^Script_Template, /* Only set for template scripts */
}

/** Script function context. */
Function_Ctx :: struct {
	world:    ^World,
	function: Entity,
	ctx:      rawptr,
}

/** Script function callback. */
Function_Callback :: proc "c" (ctx: ^Function_Ctx, argc: i32, argv: ^Value, result: ^Value)

/** Script vector function callback. */
Vector_Function_Callback :: proc "c" (ctx: ^Function_Ctx, argc: i32, argv: ^Value, result: ^Value, elem_count: i32)

/** Function argument type. */
Script_Parameter :: struct {
	name: cstring,
	type: Entity,
}

/** Const component.
* This component describes a const variable that can be used from scripts.
*/
Ecs_Script_Const_Var :: struct {
	value:     Value,
	type_info: ^Type_Info,
}

Script_Function :: struct {
	return_type:      Entity,
	params:           Vec, /* vec<ecs_script_parameter_t> */
	callback:         Function_Callback,
	vector_callbacks: [18]Vector_Function_Callback,
	ctx:              rawptr,
}

/** Function component.
* This component describes a function that can be called from a script.
*/
Ecs_Script_Function :: Script_Function

/** Method component.
* This component describes a method that can be called from a script. Methods
* are functions that can be called on instances of a type. A method entity is
* stored in the scope of the type it belongs to.
*/
Ecs_Script_Method :: Script_Function

/** Used with ecs_script_parse() and ecs_script_eval() */
Script_Eval_Desc :: struct {
	vars:    ^Script_Vars,    /**< Variables used by script */
	runtime: ^Script_Runtime, /**< Reusable runtime (optional) */
}

/** Used to capture error output from script evaluation. */
Script_Eval_Result :: struct {
	error: cstring,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Parse script.
	* This operation parses a script and returns a script object upon success. To
	* run the script, call ecs_script_eval().
	*
	* If the script uses outside variables, an ecs_script_vars_t object must be
	* provided in the vars member of the desc object that defines all variables
	* with the correct types.
	*
	* When the result parameter is not NULL, the script will capture errors and
	* return them in the output struct. If result.error is set, it must be freed
	* by the application.
	*
	* @param world The world.
	* @param name Name of the script (typically a file/module name).
	* @param code The script code.
	* @param desc Parameters for script runtime.
	* @param result Output of script evaluation.
	* @return Script object if success, NULL if failed.
	*/
	script_parse :: proc(world: ^World, name: cstring, code: cstring, desc: ^Script_Eval_Desc, result: ^Script_Eval_Result) -> ^Script ---

	/** Evaluate script.
	* This operation evaluates (runs) a parsed script.
	*
	* If variables were provided to ecs_script_parse(), an application may pass
	* a different ecs_script_vars_t object to ecs_script_eval(), as long as the
	* object has all referenced variables and they are of the same type.
	*
	* When the result parameter is not NULL, the script will capture errors and
	* return them in the output struct. If result.error is set, it must be freed
	* by the application.
	*
	* @param script The script.
	* @param desc Parameters for script runtime.
	* @return Zero if success, non-zero if failed.
	*/
	script_eval :: proc(script: ^Script, desc: ^Script_Eval_Desc, result: ^Script_Eval_Result) -> i32 ---

	/** Free script.
	* This operation frees a script object.
	*
	* Templates created by the script rely upon resources in the script object,
	* and for that reason keep the script alive until all templates created by the
	* script are deleted.
	*
	* @param script The script.
	*/
	script_free :: proc(script: ^Script) ---

	/** Parse script.
	* This parses a script and instantiates the entities in the world.
	* This operation is the equivalent to doing:
	*
	* @code
	* ecs_script_t *script = ecs_script_parse(world, name, code);
	* ecs_script_eval(script);
	* ecs_script_free(script);
	* @endcode
	*
	* @param world The world.
	* @param name The script name (typically the file).
	* @param code The script.
	* @return Zero if success, non-zero otherwise.
	*/
	script_run :: proc(world: ^World, name: cstring, code: cstring, result: ^Script_Eval_Result) -> i32 ---

	/** Parse script file.
	* This parses a script file and instantiates the entities in the world. This
	* operation is equivalent to loading the file contents and passing it to
	* ecs_script_run().
	*
	* @param world The world.
	* @param filename The script file name.
	* @return Zero if success, non-zero if failed.
	*/
	script_run_file :: proc(world: ^World, filename: cstring) -> i32 ---

	/** Create runtime for script.
	* A script runtime is a container for any data created during script
	* evaluation. By default calling ecs_script_run() or ecs_script_eval() will
	* create a runtime on the spot. A runtime can be created in advance and reused
	* across multiple script evaluations to improve performance.
	*
	* When scripts are evaluated on multiple threads, each thread should have its
	* own script runtime.
	*
	* A script runtime must be deleted with ecs_script_runtime_free().
	*
	* @return A new script runtime.
	*/
	script_runtime_new :: proc() -> ^Script_Runtime ---

	/** Free script runtime.
	* This operation frees a script runtime created by ecs_script_runtime_new().
	*
	* @param runtime The runtime to free.
	*/
	script_runtime_free :: proc(runtime: ^Script_Runtime) ---

	/** Convert script AST to string.
	* This operation converts the script abstract syntax tree to a string, which
	* can be used to debug a script.
	*
	* @param script The script.
	* @param buf The buffer to write to.
	* @return Zero if success, non-zero if failed.
	*/
	script_ast_to_buf :: proc(script: ^Script, buf: ^Strbuf, colors: bool) -> i32 ---

	/** Convert script AST to string.
	* This operation converts the script abstract syntax tree to a string, which
	* can be used to debug a script.
	*
	* @param script The script.
	* @return The string if success, NULL if failed.
	*/
	script_ast_to_str :: proc(script: ^Script, colors: bool) -> cstring ---
}

/** Used with ecs_script_init(). */
Script_Desc :: struct {
	entity:   Entity,  /**< Set to customize entity handle associated with script */
	filename: cstring, /**< Set to load script from file */
	code:     cstring, /**< Set to parse script from string */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Load managed script.
	* A managed script tracks which entities it creates, and keeps those entities
	* synchronized when the contents of the script are updated. When the script is
	* updated, entities that are no longer in the new version will be deleted.
	*
	* This feature is experimental.
	*
	* @param world The world.
	* @param desc Script descriptor.
	*/
	script_init :: proc(world: ^World, desc: ^Script_Desc) -> Entity ---

	/** Update script with new code.
	*
	* @param world The world.
	* @param script The script entity.
	* @param instance An template instance (optional).
	* @param code The script code.
	*/
	script_update :: proc(world: ^World, script: Entity, instance: Entity, code: cstring) -> i32 ---

	/** Clear all entities associated with script.
	*
	* @param world The world.
	* @param script The script entity.
	* @param instance The script instance.
	*/
	script_clear :: proc(world: ^World, script: Entity, instance: Entity) ---

	/** Create new variable scope.
	* Create root variable scope. A variable scope contains one or more variables.
	* Scopes can be nested, which allows variables in different scopes to have the
	* same name. Variables from parent scopes will be shadowed by variables in
	* child scopes with the same name.
	*
	* Use the `ecs_script_vars_push()` and `ecs_script_vars_pop()` functions to
	* push and pop variable scopes.
	*
	* When a variable contains allocated resources (e.g. a string), its resources
	* will be freed when `ecs_script_vars_pop()` is called on the scope, the
	* ecs_script_vars_t::type_info field is initialized for the variable, and
	* `ecs_type_info_t::hooks::dtor` is set.
	*
	* @param world The world.
	*/
	script_vars_init :: proc(world: ^World) -> ^Script_Vars ---

	/** Free variable scope.
	* Free root variable scope. The provided scope should not have a parent. This
	* operation calls `ecs_script_vars_pop()` on the scope.
	*
	* @param vars The variable scope.
	*/
	script_vars_fini :: proc(vars: ^Script_Vars) ---

	/** Push new variable scope.
	*
	* Scopes created with ecs_script_vars_push() must be cleaned up with
	* ecs_script_vars_pop().
	*
	* If the stack and allocator arguments are left to NULL, their values will be
	* copied from the parent.
	*
	* @param parent The parent scope (provide NULL for root scope).
	* @return The new variable scope.
	*/
	script_vars_push :: proc(parent: ^Script_Vars) -> ^Script_Vars ---

	/** Pop variable scope.
	* This frees up the resources for a variable scope. The scope must be at the
	* top of a vars stack. Calling ecs_script_vars_pop() on a scope that is not the
	* last scope causes undefined behavior.
	*
	* @param vars The scope to free.
	* @return The parent scope.
	*/
	script_vars_pop :: proc(vars: ^Script_Vars) -> ^Script_Vars ---

	/** Declare a variable.
	* This operation declares a new variable in the current scope. If a variable
	* with the specified name already exists, the operation will fail.
	*
	* This operation does not allocate storage for the variable. This is done to
	* allow for variables that point to existing storage, which prevents having
	* to copy existing values to a variable scope.
	*
	* @param vars The variable scope.
	* @param name The variable name.
	* @return The new variable, or NULL if the operation failed.
	*/
	script_vars_declare :: proc(vars: ^Script_Vars, name: cstring) -> ^Script_Var ---

	/** Define a variable.
	* This operation calls `ecs_script_vars_declare()` and allocates storage for
	* the variable. If the type has a ctor, it will be called on the new storage.
	*
	* The scope's stack allocator will be used to allocate the storage. After
	* `ecs_script_vars_pop()` is called on the scope, the variable storage will no
	* longer be valid.
	*
	* The operation will fail if the type argument is not a type.
	*
	* @param vars The variable scope.
	* @param name The variable name.
	* @param type The variable type.
	* @return The new variable, or NULL if the operation failed.
	*/
	script_vars_define_id :: proc(vars: ^Script_Vars, name: cstring, type: Entity) -> ^Script_Var ---

	/** Lookup a variable.
	* This operation looks up a variable in the current scope. If the variable
	* can't be found in the current scope, the operation will recursively search
	* the parent scopes.
	*
	* @param vars The variable scope.
	* @param name The variable name.
	* @return The variable, or NULL if one with the provided name does not exist.
	*/
	script_vars_lookup :: proc(vars: ^Script_Vars, name: cstring) -> ^Script_Var ---

	/** Lookup a variable by stack pointer.
	* This operation provides a faster way to lookup variables that are always
	* declared in the same order in a ecs_script_vars_t scope.
	*
	* The stack pointer of a variable can be obtained from the ecs_script_var_t
	* type. The provided frame offset must be valid for the provided variable
	* stack. If the frame offset is not valid, this operation will panic.
	*
	* @param vars The variable scope.
	* @param sp The stack pointer to the variable.
	* @return The variable.
	*/
	script_vars_from_sp :: proc(vars: ^Script_Vars, sp: i32) -> ^Script_Var ---

	/** Print variables.
	* This operation prints all variables in the vars scope and parent scopes.asm
	*
	* @param vars The variable scope.
	*/
	script_vars_print :: proc(vars: ^Script_Vars) ---

	/** Preallocate space for variables.
	* This operation preallocates space for the specified number of variables. This
	* is a performance optimization only, and is not necessary before declaring
	* variables in a scope.
	*
	* @param vars The variable scope.
	* @param count The number of variables to preallocate space for.
	*/
	script_vars_set_size :: proc(vars: ^Script_Vars, count: i32) ---

	/** Convert iterator to vars
	* This operation converts an iterator to a variable array. This allows for
	* using iterator results in expressions. The operation only converts a
	* single result at a time, and does not progress the iterator.
	*
	* Iterator fields with data will be made available as variables with as name
	* the field index (e.g. "$1"). The operation does not check if reflection data
	* is registered for a field type. If no reflection data is registered for the
	* type, using the field variable in expressions will fail.
	*
	* Field variables will only contain single elements, even if the iterator
	* returns component arrays. The offset parameter can be used to specify which
	* element in the component arrays to return. The offset parameter must be
	* smaller than it->count.
	*
	* The operation will create a variable for query variables that contain a
	* single entity.
	*
	* The operation will attempt to use existing variables. If a variable does not
	* yet exist, the operation will create it. If an existing variable exists with
	* a mismatching type, the operation will fail.
	*
	* Accessing variables after progressing the iterator or after the iterator is
	* destroyed will result in undefined behavior.
	*
	* If vars contains a variable that is not present in the iterator, the variable
	* will not be modified.
	*
	* @param it The iterator to convert to variables.
	* @param vars The variables to write to.
	* @param offset The offset to the current element.
	*/
	script_vars_from_iter :: proc(it: ^Iter, vars: ^Script_Vars, offset: i32) ---
}

/** Used with ecs_expr_run(). */
Expr_Eval_Desc :: struct {
	name:          cstring,                                                     /**< Script name */
	expr:          cstring,                                                     /**< Full expression string */
	vars:          ^Script_Vars,                                                /**< Variables accessible in expression */
	type:          Entity,                                                      /**< Type of parsed value (optional) */
	lookup_action: proc "c" (_: ^World, value: cstring, ctx: rawptr) -> Entity, /**< Function for resolving entity identifiers */
	lookup_ctx:    rawptr,                                                      /**< Context passed to lookup function */

	/** Disable constant folding (slower evaluation, faster parsing) */
	disable_folding: bool,

	/** This option instructs the expression runtime to lookup variables by
	* stack pointer instead of by name, which improves performance. Only enable
	* when provided variables are always declared in the same order. */
	disable_dynamic_variable_binding: bool,

	/** Allow for unresolved identifiers when parsing. Useful when entities can
	* be created in between parsing & evaluating. */
	allow_unresolved_identifiers: bool,
	runtime:                      ^Script_Runtime, /**< Reusable runtime (optional) */
	script_visitor:               rawptr,          /**< For internal usage */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Run expression.
	* This operation runs an expression and stores the result in the provided
	* value. If the value contains a type that is different from the type of the
	* expression, the expression will be cast to the value.
	*
	* If the provided value for value.ptr is NULL, the value must be freed with
	* ecs_value_free() afterwards.
	*
	* @param world The world.
	* @param ptr The pointer to the expression to parse.
	* @param value The value containing type & pointer to write to.
	* @param desc Configuration parameters for the parser.
	* @return Pointer to the character after the last one read, or NULL if failed.
	*/
	expr_run :: proc(world: ^World, ptr: cstring, value: ^Value, desc: ^Expr_Eval_Desc) -> cstring ---

	/** Parse expression.
	* This operation parses an expression and returns an object that can be
	* evaluated multiple times with ecs_expr_eval().
	*
	* @param world The world.
	* @param expr The expression string.
	* @param desc Configuration parameters for the parser.
	* @return A script object if parsing is successful, NULL if parsing failed.
	*/
	expr_parse :: proc(world: ^World, expr: cstring, desc: ^Expr_Eval_Desc) -> ^Script ---

	/** Evaluate expression.
	* This operation evaluates an expression parsed with ecs_expr_parse()
	* and stores the result in the provided value. If the value contains a type
	* that is different from the type of the expression, the expression will be
	* cast to the value.
	*
	* If the provided value for value.ptr is NULL, the value must be freed with
	* ecs_value_free() afterwards.
	*
	* @param script The script containing the expression.
	* @param value The value in which to store the expression result.
	* @param desc Configuration parameters for the parser.
	* @return Zero if successful, non-zero if failed.
	*/
	expr_eval :: proc(script: ^Script, value: ^Value, desc: ^Expr_Eval_Desc) -> i32 ---

	/** Evaluate interpolated expressions in string.
	* This operation evaluates expressions in a string, and replaces them with
	* their evaluated result. Supported expression formats are:
	*  - $variable_name
	*  - {expression}
	*
	* The $, { and } characters can be escaped with a backslash (\).
	*
	* @param world The world.
	* @param str The string to evaluate.
	* @param vars The variables to use for evaluation.
	*/
	script_string_interpolate :: proc(world: ^World, str: cstring, vars: ^Script_Vars) -> cstring ---
}

/** Used with ecs_const_var_init */
Const_Var_Desc :: struct {
	/* Variable name. */
	name: cstring,

	/* Variable parent (namespace). */
	parent: Entity,

	/* Variable type. */
	type: Entity,

	/* Pointer to value of variable. The value will be copied to an internal
	* storage and does not need to be kept alive. */
	value: rawptr,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a const variable that can be accessed by scripts.
	*
	* @param world The world.
	* @param desc Const var parameters.
	* @return The const var, or 0 if failed.
	*/
	const_var_init :: proc(world: ^World, desc: ^Const_Var_Desc) -> Entity ---

	/** Returns value for a const variable.
	* This returns the value for a const variable that is created either with
	* ecs_const_var_init, or in a script with "export const v: ...".
	*
	* @param world The world.
	* @param var The variable associated with the entity.
	*/
	const_var_get :: proc(world: ^World, var: Entity) -> Value ---
}

/* Functions */
Vector_Fn_Callbacks :: struct {
	_i8:  Vector_Function_Callback,
	_i32: Vector_Function_Callback,
}

/** Used with ecs_function_init and ecs_method_init */
Function_Desc :: struct {
	/** Function name. */
	name: cstring,

	/** Parent of function. For methods the parent is the type for which the
	* method will be registered. */
	parent: Entity,

	/** Function parameters. */
	params: [16]Script_Parameter,

	/** Function return type. */
	return_type: Entity,

	/** Function implementation. */
	callback: Function_Callback,

	/** Vector function implementations.
	* Set these callbacks if a function has one or more arguments of type
	* flecs.script vector, and optionally a return type of flecs.script.vector.
	*
	* The flecs.script.vector type allows a function to be called with types
	* that meet the following constraints:
	* - The same type is provided for all arguments of type flecs.script.vector
	* - The provided type has one or members of the same type
	* - The member type must be a primitive type
	* - The vector_callbacks array has an implementation for the primitive type.
	*
	* This allows for statements like:
	* @code
	* const a = Rgb: {100, 150, 250}
	* const b = Rgb: {10, 10, 10}
	* const r = lerp(a, b, 0.1)
	* @endcode
	*
	* which would otherwise have to be written out as:
	*
	* @code
	* const r = Rgb: {
	*   lerp(a.r, b.r, 0.1),
	*   lerp(a.g, b.g, 0.1),
	*   lerp(a.b, b.b, 0.1)
	* }
	* @endcode
	*
	* To register vector functions, do:
	*
	* @code
	* ecs_function(world, {
	*     .name = "lerp",
	*     .return_type = EcsScriptVectorType,
	*     .params = {
	*         { .name = "a", .type = EcsScriptVectorType },
	*         { .name = "b", .type = EcsScriptVectorType },
	*         { .name = "t", .type = ecs_id(ecs_f64_t) }
	*     },
	*     .vector_callbacks = {
	*       [EcsF32] = flecs_lerp32,
	*       [EcsF64] = flecs_lerp64
	*     }
	* });
	* @endcode
	*
	*/
	vector_callbacks: [18]Vector_Function_Callback,

	/** Context passed to function implementation. */
	ctx: rawptr,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create new function.
	* This operation creates a new function that can be called from a script.
	*
	* @param world The world.
	* @param desc Function init parameters.
	* @return The function, or 0 if failed.
	*/
	function_init :: proc(world: ^World, desc: ^Function_Desc) -> Entity ---

	/** Create new method.
	* This operation creates a new method that can be called from a script. A
	* method is like a function, except that it can be called on every instance of
	* a type.
	*
	* Methods automatically receive the instance on which the method is invoked as
	* first argument.
	*
	* @param world Method The world.
	* @param desc Method init parameters.
	* @return The function, or 0 if failed.
	*/
	method_init :: proc(world: ^World, desc: ^Function_Desc) -> Entity ---

	/** Serialize value into expression string.
	* This operation serializes a value of the provided type to a string. The
	* memory pointed to must be large enough to contain a value of the used type.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @return String with expression, or NULL if failed.
	*/
	ptr_to_expr :: proc(world: ^World, type: Entity, data: rawptr) -> cstring ---

	/** Serialize value into expression buffer.
	* Same as ecs_ptr_to_expr(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @param buf The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	ptr_to_expr_buf :: proc(world: ^World, type: Entity, data: rawptr, buf: ^Strbuf) -> i32 ---

	/** Similar as ecs_ptr_to_expr(), but serializes values to string.
	* Whereas the output of ecs_ptr_to_expr() is a valid expression, the output of
	* ecs_ptr_to_str() is a string representation of the value. In most cases the
	* output of the two operations is the same, but there are some differences:
	* - Strings are not quoted
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @return String with result, or NULL if failed.
	*/
	ptr_to_str :: proc(world: ^World, type: Entity, data: rawptr) -> cstring ---

	/** Serialize value into string buffer.
	* Same as ecs_ptr_to_str(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @param buf The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	ptr_to_str_buf :: proc(world: ^World, type: Entity, data: rawptr, buf: ^Strbuf) -> i32 ---
}

Expr_Node :: struct {}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Script module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsScript)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsScriptImport :: proc(world: ^World) ---
}

foreign lib {
	FLECS_IDEcsDocDescriptionID_ : Entity /**< Component id for EcsDocDescription. */

	/** Tag for adding a UUID to entities.
	* Added to an entity as (EcsDocDescription, EcsUuid) by ecs_doc_set_uuid().
	*/
	EcsDocUuid : Entity

	/** Tag for adding brief descriptions to entities.
	* Added to an entity as (EcsDocDescription, EcsBrief) by ecs_doc_set_brief().
	*/
	EcsDocBrief : Entity

	/** Tag for adding detailed descriptions to entities.
	* Added to an entity as (EcsDocDescription, EcsDocDetail) by ecs_doc_set_detail().
	*/
	EcsDocDetail : Entity

	/** Tag for adding a link to entities.
	* Added to an entity as (EcsDocDescription, EcsDocLink) by ecs_doc_set_link().
	*/
	EcsDocLink : Entity

	/** Tag for adding a color to entities.
	* Added to an entity as (EcsDocDescription, EcsDocColor) by ecs_doc_set_link().
	*/
	EcsDocColor : Entity
}

/** Component that stores description.
* Used as pair together with the following tags to store entity documentation:
* - EcsName
* - EcsDocBrief
* - EcsDocDetail
* - EcsDocLink
* - EcsDocColor
*/
Ecs_Doc_Description :: struct {
	value: cstring,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Add UUID to entity.
	* Associate entity with an (external) UUID.
	*
	* @param world The world.
	* @param entity The entity to which to add the UUID.
	* @param uuid The UUID to add.
	*
	* @see ecs_doc_get_uuid()
	* @see flecs::doc::set_uuid()
	* @see flecs::entity_builder::set_doc_uuid()
	*/
	doc_set_uuid :: proc(world: ^World, entity: Entity, uuid: cstring) ---

	/** Add human-readable name to entity.
	* Contrary to entity names, human readable names do not have to be unique and
	* can contain special characters used in the query language like '*'.
	*
	* @param world The world.
	* @param entity The entity to which to add the name.
	* @param name The name to add.
	*
	* @see ecs_doc_get_name()
	* @see flecs::doc::set_name()
	* @see flecs::entity_builder::set_doc_name()
	*/
	doc_set_name :: proc(world: ^World, entity: Entity, name: cstring) ---

	/** Add brief description to entity.
	*
	* @param world The world.
	* @param entity The entity to which to add the description.
	* @param description The description to add.
	*
	* @see ecs_doc_get_brief()
	* @see flecs::doc::set_brief()
	* @see flecs::entity_builder::set_doc_brief()
	*/
	doc_set_brief :: proc(world: ^World, entity: Entity, description: cstring) ---

	/** Add detailed description to entity.
	*
	* @param world The world.
	* @param entity The entity to which to add the description.
	* @param description The description to add.
	*
	* @see ecs_doc_get_detail()
	* @see flecs::doc::set_detail()
	* @see flecs::entity_builder::set_doc_detail()
	*/
	doc_set_detail :: proc(world: ^World, entity: Entity, description: cstring) ---

	/** Add link to external documentation to entity.
	*
	* @param world The world.
	* @param entity The entity to which to add the link.
	* @param link The link to add.
	*
	* @see ecs_doc_get_link()
	* @see flecs::doc::set_link()
	* @see flecs::entity_builder::set_doc_link()
	*/
	doc_set_link :: proc(world: ^World, entity: Entity, link: cstring) ---

	/** Add color to entity.
	* UIs can use color as hint to improve visualizing entities.
	*
	* @param world The world.
	* @param entity The entity to which to add the link.
	* @param color The color to add.
	*
	* @see ecs_doc_get_color()
	* @see flecs::doc::set_color()
	* @see flecs::entity_builder::set_doc_color()
	*/
	doc_set_color :: proc(world: ^World, entity: Entity, color: cstring) ---

	/** Get UUID from entity.
	* @param world The world.
	* @param entity The entity from which to get the UUID.
	* @return The UUID.
	*
	* @see ecs_doc_set_uuid()
	* @see flecs::doc::get_uuid()
	* @see flecs::entity_view::get_doc_uuid()
	*/
	doc_get_uuid :: proc(world: ^World, entity: Entity) -> cstring ---

	/** Get human readable name from entity.
	* If entity does not have an explicit human readable name, this operation will
	* return the entity name.
	*
	* To test if an entity has a human readable name, use:
	*
	* @code
	* ecs_has_pair(world, e, ecs_id(EcsDocDescription), EcsName);
	* @endcode
	*
	* Or in C++:
	*
	* @code
	* e.has<flecs::doc::Description>(flecs::Name);
	* @endcode
	*
	* @param world The world.
	* @param entity The entity from which to get the name.
	* @return The name.
	*
	* @see ecs_doc_set_name()
	* @see flecs::doc::get_name()
	* @see flecs::entity_view::get_doc_name()
	*/
	doc_get_name :: proc(world: ^World, entity: Entity) -> cstring ---

	/** Get brief description from entity.
	*
	* @param world The world.
	* @param entity The entity from which to get the description.
	* @return The description.
	*
	* @see ecs_doc_set_brief()
	* @see flecs::doc::get_brief()
	* @see flecs::entity_view::get_doc_brief()
	*/
	doc_get_brief :: proc(world: ^World, entity: Entity) -> cstring ---

	/** Get detailed description from entity.
	*
	* @param world The world.
	* @param entity The entity from which to get the description.
	* @return The description.
	*
	* @see ecs_doc_set_detail()
	* @see flecs::doc::get_detail()
	* @see flecs::entity_view::get_doc_detail()
	*/
	doc_get_detail :: proc(world: ^World, entity: Entity) -> cstring ---

	/** Get link to external documentation from entity.
	*
	* @param world The world.
	* @param entity The entity from which to get the link.
	* @return The link.
	*
	* @see ecs_doc_set_link()
	* @see flecs::doc::get_link()
	* @see flecs::entity_view::get_doc_link()
	*/
	doc_get_link :: proc(world: ^World, entity: Entity) -> cstring ---

	/** Get color from entity.
	*
	* @param world The world.
	* @param entity The entity from which to get the color.
	* @return The color.
	*
	* @see ecs_doc_set_color()
	* @see flecs::doc::get_color()
	* @see flecs::entity_view::get_doc_color()
	*/
	doc_get_color :: proc(world: ^World, entity: Entity) -> cstring ---

	/** Doc module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsDoc)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsDocImport :: proc(world: ^World) ---
}

/** Max number of constants/members that can be specified in desc structs. */
MEMBER_DESC_CACHE_SIZE :: (32)

/** Primitive type definitions.
* These typedefs allow the builtin primitives to be used as regular components:
*
* @code
* ecs_set(world, e, ecs_i32_t, {10});
* @endcode
*
* Or a more useful example (create an enum constant with a manual value):
*
* @code
* ecs_set_pair_second(world, e, EcsConstant, ecs_i32_t, {10});
* @endcode
*/
Bool   :: bool        /**< Builtin bool type */
Char   :: i8          /**< Builtin char type */
Byte   :: u8          /**< Builtin  ecs_byte type */
U8     :: u8          /**< Builtin u8 type */
U16    :: u16         /**< Builtin u16 type */
U32    :: u32         /**< Builtin u32 type */
U64    :: u64         /**< Builtin u64 type */
Uptr   :: c.uintptr_t /**< Builtin uptr type */
I8     :: i8          /**< Builtin i8 type */
I16    :: i16         /**< Builtin i16 type */
I32    :: i32         /**< Builtin i32 type */
I64    :: i64         /**< Builtin i64 type */
Iptr   :: c.intptr_t  /**< Builtin iptr type */
F32    :: f32         /**< Builtin f32 type */
F64    :: f64         /**< Builtin f64 type */
String :: cstring     /**< Builtin string type */

foreign lib {
	FLECS_IDEcsTypeID_           : Entity /**< Id for component added to all types with reflection data. */
	FLECS_IDEcsTypeSerializerID_ : Entity /**< Id for component that stores a type specific serializer. */
	FLECS_IDEcsPrimitiveID_      : Entity /**< Id for component that stores reflection data for a primitive type. */
	FLECS_IDEcsEnumID_           : Entity /**< Id for component that stores reflection data for an enum type. */
	FLECS_IDEcsBitmaskID_        : Entity /**< Id for component that stores reflection data for a bitmask type. */
	FLECS_IDEcsConstantsID_      : Entity /**< Id for component that stores reflection data for a constants. */
	FLECS_IDEcsMemberID_         : Entity /**< Id for component that stores reflection data for struct members. */
	FLECS_IDEcsMemberRangesID_   : Entity /**< Id for component that stores min/max ranges for member values. */
	FLECS_IDEcsStructID_         : Entity /**< Id for component that stores reflection data for a struct type. */
	FLECS_IDEcsArrayID_          : Entity /**< Id for component that stores reflection data for an array type. */
	FLECS_IDEcsVectorID_         : Entity /**< Id for component that stores reflection data for a vector type. */
	FLECS_IDEcsOpaqueID_         : Entity /**< Id for component that stores reflection data for an opaque type. */
	FLECS_IDEcsUnitID_           : Entity /**< Id for component that stores unit data. */
	FLECS_IDEcsUnitPrefixID_     : Entity /**< Id for component that stores unit prefix data. */

	/**< Tag added to unit quantities. */
	EcsQuantity             : Entity /**< Tag added to unit quantities. */
	FLECS_IDecs_bool_tID_   : Entity /**< Builtin boolean type. */
	FLECS_IDecs_char_tID_   : Entity /**< Builtin char type. */
	FLECS_IDecs_byte_tID_   : Entity /**< Builtin byte type. */
	FLECS_IDecs_u8_tID_     : Entity /**< Builtin 8 bit unsigned int type. */
	FLECS_IDecs_u16_tID_    : Entity /**< Builtin 16 bit unsigned int type. */
	FLECS_IDecs_u32_tID_    : Entity /**< Builtin 32 bit unsigned int type. */
	FLECS_IDecs_u64_tID_    : Entity /**< Builtin 64 bit unsigned int type. */
	FLECS_IDecs_uptr_tID_   : Entity /**< Builtin pointer sized unsigned int type. */
	FLECS_IDecs_i8_tID_     : Entity /**< Builtin 8 bit signed int type. */
	FLECS_IDecs_i16_tID_    : Entity /**< Builtin 16 bit signed int type. */
	FLECS_IDecs_i32_tID_    : Entity /**< Builtin 32 bit signed int type. */
	FLECS_IDecs_i64_tID_    : Entity /**< Builtin 64 bit signed int type. */
	FLECS_IDecs_iptr_tID_   : Entity /**< Builtin pointer sized signed int type. */
	FLECS_IDecs_f32_tID_    : Entity /**< Builtin 32 bit floating point type. */
	FLECS_IDecs_f64_tID_    : Entity /**< Builtin 64 bit floating point type. */
	FLECS_IDecs_string_tID_ : Entity /**< Builtin string type. */
	FLECS_IDecs_entity_tID_ : Entity /**< Builtin entity type. */
	FLECS_IDecs_id_tID_     : Entity /**< Builtin (component) id type. */
}

/** Type kinds supported by meta addon */
Type_Kind :: enum u32 {
	PrimitiveType = 0,
	BitmaskType   = 1,
	EnumType      = 2,
	StructType    = 3,
	ArrayType     = 4,
	VectorType    = 5,
	OpaqueType    = 6,
	TypeKindLast  = 6,
}

/** Component that is automatically added to every type with the right kind. */
Ecs_Type :: struct {
	kind:     Type_Kind, /**< Type kind. */
	existing: bool,      /**< Did the type exist or is it populated from reflection */
	partial:  bool,      /**< Is the reflection data a partial type description */
}

/** Primitive type kinds supported by meta addon */
Primitive_Kind :: enum u32 {
	Bool              = 1,
	Char              = 2,
	Byte              = 3,
	U8                = 4,
	U16               = 5,
	U32               = 6,
	U64               = 7,
	I8                = 8,
	I16               = 9,
	I32               = 10,
	I64               = 11,
	F32               = 12,
	F64               = 13,
	UPtr              = 14,
	IPtr              = 15,
	String            = 16,
	Entity            = 17,
	Id                = 18,
	PrimitiveKindLast = 18,
}

/** Component added to primitive types */
Ecs_Primitive :: struct {
	kind: Primitive_Kind, /**< Primitive type kind. */
}

/** Component added to member entities */
Ecs_Member :: struct {
	type:       Entity, /**< Member type. */
	count:      i32,    /**< Number of elements for inline arrays. Leave to 0 for non-array members. */
	unit:       Entity, /**< Member unit. */
	offset:     i32,    /**< Member offset. */
	use_offset: bool,   /**< If offset should be explicitly used. */
}

/** Type expressing a range for a member value */
Member_Value_Range :: struct {
	min: f64, /**< Min member value. */
	max: f64, /**< Max member value. */
}

/** Component added to member entities to express valid value ranges */
Ecs_Member_Ranges :: struct {
	value:   Member_Value_Range, /**< Member value range. */
	warning: Member_Value_Range, /**< Member value warning range. */
	error:   Member_Value_Range, /**< Member value error range. */
}

/** Element type of members vector in EcsStruct */
Member :: struct {
	/** Must be set when used with ecs_struct_desc_t */
	name: cstring,

	/** Member type. */
	type: Entity,

	/** Element count (for inline arrays). May be set when used with
	* ecs_struct_desc_t. Leave to 0 for non-array members. */
	count: i32,

	/** May be set when used with ecs_struct_desc_t. Member offset. */
	offset: i32,

	/** May be set when used with ecs_struct_desc_t, will be auto-populated if
	* type entity is also a unit */
	unit: Entity,

	/** Set to true to prevent automatic offset computation. This option should
	* be used when members are registered out of order or where calculation of
	* member offsets doesn't match C type offsets. */
	use_offset: bool,

	/** Numerical range that specifies which values member can assume. This
	* range may be used by UI elements such as a progress bar or slider. The
	* value of a member should not exceed this range. */
	range: Member_Value_Range,

	/** Numerical range outside of which the value represents an error. This
	* range may be used by UI elements to style a value. */
	error_range: Member_Value_Range,

	/** Numerical range outside of which the value represents an warning. This
	* range may be used by UI elements to style a value. */
	warning_range: Member_Value_Range,

	/** Should not be set by ecs_struct_desc_t */
	size: Size,

	/** Should not be set by ecs_struct_desc_t */
	member: Entity,
}

/** Component added to struct type entities */
Ecs_Struct :: struct {
	/** Populated from child entities with Member component */
	members: Vec, /* vector<ecs_member_t> */
}

/** Type that describes an enum constant */
Enum_Constant :: struct {
	/** Must be set when used with ecs_enum_desc_t */
	name: cstring,

	/** May be set when used with ecs_enum_desc_t */
	value: i64,

	/** For when the underlying type is unsigned */
	value_unsigned: u64,

	/** Should not be set by ecs_enum_desc_t */
	constant: Entity,
}

/** Component added to enum type entities */
Ecs_Enum :: struct {
	underlying_type: Entity,
}

/** Type that describes an bitmask constant */
Bitmask_Constant :: struct {
	/** Must be set when used with ecs_bitmask_desc_t */
	name: cstring,

	/** May be set when used with ecs_bitmask_desc_t */
	value: Flags64,

	/** Keep layout the same with ecs_enum_constant_t */
	_unused: i64,

	/** Should not be set by ecs_bitmask_desc_t */
	constant: Entity,
}

/** Component added to bitmask type entities */
Ecs_Bitmask :: struct {
	dummy_: i32,
}

/** Component with datastructures for looking up enum/bitmask constants. */
Ecs_Constants :: struct {
	/** Populated from child entities with Constant component */
	constants: ^Map, /**< map<i32_t, ecs_enum_constant_t> */

	/** Stores the constants in registration order */
	ordered_constants: Vec, /**< vector<ecs_enum_constants_t> */
}

/** Component added to array type entities */
Ecs_Array :: struct {
	type:  Entity, /**< Element type */
	count: i32,    /**< Number of elements */
}

/** Component added to vector type entities */
Ecs_Vector :: struct {
	type: Entity, /**< Element type */
}

/** Serializer interface */
Serializer :: struct {
	/* Serialize value */
	value: proc "c" (ser: ^Serializer, type: Entity, value: rawptr) -> i32,

	/* Serialize member */
	member: proc "c" (ser: ^Serializer, member: cstring) -> i32,
	world:  ^World, /**< The world. */
	ctx:    rawptr, /**< Serializer context. */
}

/** Callback invoked serializing an opaque type. */
Meta_Serialize :: proc "c" (ser: ^Serializer, src: rawptr) -> i32

/** Callback invoked to serialize an opaque struct member */
Meta_Serialize_Member :: proc "c" (ser: ^Serializer, src: rawptr, name: cstring) -> i32

/** Callback invoked to serialize an opaque vector/array element */
Meta_Serialize_Element :: proc "c" (ser: ^Serializer, src: rawptr, elem: c.size_t) -> i32

/** Opaque type reflection data.
* An opaque type is a type with an unknown layout that can be mapped to a type
* known to the reflection framework. See the opaque type reflection examples.
*/
Ecs_Opaque :: struct {
	as_type:           Entity,                 /**< Type that describes the serialized output */
	serialize:         Meta_Serialize,         /**< Serialize action */
	serialize_member:  Meta_Serialize_Member,  /**< Serialize member action */
	serialize_element: Meta_Serialize_Element, /**< Serialize element action */

	/* Deserializer interface
	* Only override the callbacks that are valid for the opaque type. If a
	* deserializer attempts to assign a value type that is not supported by the
	* interface, a conversion error is thrown.
	*/
	
	/** Assign bool value */
	assign_bool: proc "c" (dst: rawptr, value: bool),

	/** Assign char value */
	assign_char: proc "c" (dst: rawptr, value: i8),

	/** Assign int value */
	assign_int: proc "c" (dst: rawptr, value: i64),

	/** Assign unsigned int value */
	assign_uint: proc "c" (dst: rawptr, value: u64),

	/** Assign float value */
	assign_float: proc "c" (dst: rawptr, value: f64),

	/** Assign string value */
	assign_string: proc "c" (dst: rawptr, value: cstring),

	/** Assign entity value */
	assign_entity: proc "c" (dst: rawptr, world: ^World, entity: Entity),

	/** Assign (component) id value */
	assign_id: proc "c" (dst: rawptr, world: ^World, id: Id),

	/** Assign null value */
	assign_null: proc "c" (dst: rawptr),

	/** Clear collection elements */
	clear: proc "c" (dst: rawptr),

	/** Ensure & get collection element */
	ensure_element: proc "c" (dst: rawptr, elem: c.size_t) -> rawptr,

	/** Ensure & get element */
	ensure_member: proc "c" (dst: rawptr, member: cstring) -> rawptr,

	/** Return number of elements */
	count: proc "c" (dst: rawptr) -> c.size_t,

	/** Resize to number of elements */
	resize: proc "c" (dst: rawptr, count: c.size_t),
}

/** Helper type to describe translation between two units. Note that this
* is not intended as a generic approach to unit conversions (e.g. from celsius
* to fahrenheit) but to translate between units that derive from the same base
* (e.g. meters to kilometers).
*
* Note that power is applied to the factor. When describing a translation of
* 1000, either use {factor = 1000, power = 1} or {factor = 1, power = 3}. */
Unit_Translation :: struct {
	factor: i32, /**< Factor to apply (e.g. "1000", "1000000", "1024") */
	power:  i32, /**< Power to apply to factor (e.g. "1", "3", "-9") */
}

/** Component that stores unit data. */
Ecs_Unit :: struct {
	symbol:      cstring,          /**< Unit symbol. */
	prefix:      Entity,           /**< Order of magnitude prefix relative to derived */
	base:        Entity,           /**< Base unit (e.g. "meters") */
	over:        Entity,           /**< Over unit (e.g. "per second") */
	translation: Unit_Translation, /**< Translation for derived unit */
}

/** Component that stores unit prefix data. */
Ecs_Unit_Prefix :: struct {
	symbol:      cstring,          /**< Symbol of prefix (e.g. "K", "M", "Ki") */
	translation: Unit_Translation, /**< Translation of prefix */
}

/** Serializer instruction opcodes.
* The meta type serializer works by generating a flattened array with
* instructions that tells a serializer what kind of fields can be found in a
* type at which offsets.
*/
Meta_Op_Kind :: enum u32 {
	OpPushStruct       = 0,  /**< Push struct. */
	OpPushArray        = 1,  /**< Push array. */
	OpPushVector       = 2,  /**< Push vector. */
	OpPop              = 3,  /**< Pop scope. */
	OpOpaqueStruct     = 4,  /**< Opaque struct. */
	OpOpaqueArray      = 5,  /**< Opaque array. */
	OpOpaqueVector     = 6,  /**< Opaque vector. */
	OpForward          = 7,  /**< Forward to type. Allows for recursive types. */
	OpScope            = 8,  /**< Marks last constant that can open/close a scope */
	OpOpaqueValue      = 9,  /**< Opaque value. */
	OpEnum             = 10,
	OpBitmask          = 11,
	OpPrimitive        = 12, /**< Marks first constant that's a primitive */
	OpBool             = 13,
	OpChar             = 14,
	OpByte             = 15,
	OpU8               = 16,
	OpU16              = 17,
	OpU32              = 18,
	OpU64              = 19,
	OpI8               = 20,
	OpI16              = 21,
	OpI32              = 22,
	OpI64              = 23,
	OpF32              = 24,
	OpF64              = 25,
	OpUPtr             = 26,
	OpIPtr             = 27,
	OpString           = 28,
	OpEntity           = 29,
	OpId               = 30,
	MetaTypeOpKindLast = 30,
}

/** Meta type serializer instruction data. */
Meta_Op :: struct {
	kind:            Meta_Op_Kind, /**< Instruction opcode. */
	underlying_kind: Meta_Op_Kind, /**< Underlying type kind (for enums). */
	offset:          Size,         /**< Offset of current field. */
	name:            cstring,      /**< Name of value (only used for struct members) */
	elem_size:       Size,         /**< Element size (for PushArray/PushVector) and element count (for PopArray) */
	op_count:        i16,          /**< Number of operations until next field or end */
	member_index:    i16,          /**< Index of member in struct */
	type:            Entity,       /**< Type entity */
	type_info:       ^Type_Info,   /**< Type info */

	is: struct #raw_union {
		members:   ^Hashmap,       /**< string -> member index (structs) */
		constants: ^Map,           /**< (u)int -> constant entity (enums/bitmasks) */
		opaque:    Meta_Serialize, /**< Serialize callback for opaque types */
	},
}

/** Component that stores the type serializer.
* Added to all types with reflection data. */
Ecs_Type_Serializer :: struct {
	kind: Type_Kind, /**< Quick access to type kind (same as EcsType) */
	ops:  Vec,       /**< vector<ecs_meta_op_t> */
}

/* Deserializer utilities */

/** Maximum level of type nesting.
* >32 levels of nesting is not sane.
*/
META_MAX_SCOPE_DEPTH :: (32)

/** Type with information about currently serialized scope. */
Meta_Scope :: struct {
	type:             Entity,      /**< The type being iterated */
	ops:              ^Meta_Op,    /**< The type operations (see ecs_meta_op_t) */
	ops_count:        i16,         /**< Number of elements in ops */
	ops_cur:          i16,         /**< Current element in ops */
	prev_depth:       i16,         /**< Depth to restore, in case dotmember was used */
	ptr:              rawptr,      /**< Pointer to ops[0] */
	opaque:           ^Ecs_Opaque, /**< Opaque type interface */
	members:          ^Hashmap,    /**< string -> member index */
	is_collection:    bool,        /**< Is the scope iterating elements? */
	is_empty_scope:   bool,        /**< Was scope populated (for vectors) */
	is_moved_scope:   bool,        /**< Was scope moved in (with ecs_meta_elem, for vectors) */
	elem, elem_count: i32,         /**< Set for collections */
}

/** Type that enables iterating/populating a value using reflection data. */
Meta_Cursor :: struct {
	world:              ^World,         /**< The world. */
	scope:              [32]Meta_Scope, /**< Cursor scope stack. */
	depth:              i16,            /**< Current scope depth. */
	valid:              bool,           /**< Does the cursor point to a valid field. */
	is_primitive_scope: bool,           /**< If in root scope, this allows for a push for primitive types */

	/** Custom entity lookup action for overriding default ecs_lookup */
	lookup_action: proc "c" (^World, cstring, rawptr) -> Entity,
	lookup_ctx:    rawptr, /**< Context for lookup_action */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Convert serializer to string. */
	meta_serializer_to_str :: proc(world: ^World, type: Entity) -> cstring ---

	/** Create meta cursor.
	* A meta cursor allows for walking over, reading and writing a value without
	* having to know its type at compile time.
	*
	* When a value is assigned through the cursor API, it will get converted to
	* the actual value of the underlying type. This allows the underlying type to
	* change without having to update the serialized data. For example, an integer
	* field can be set by a string, a floating point can be set as integer etc.
	*
	* @param world The world.
	* @param type The type of the value.
	* @param ptr Pointer to the value.
	* @return A meta cursor for the value.
	*/
	meta_cursor :: proc(world: ^World, type: Entity, ptr: rawptr) -> Meta_Cursor ---

	/** Get pointer to current field.
	*
	* @param cursor The cursor.
	* @return A pointer to the current field.
	*/
	meta_get_ptr :: proc(cursor: ^Meta_Cursor) -> rawptr ---

	/** Move cursor to next field.
	*
	* @param cursor The cursor.
	* @return Zero if success, non-zero if failed.
	*/
	meta_next :: proc(cursor: ^Meta_Cursor) -> i32 ---

	/** Move cursor to a field.
	*
	* @param cursor The cursor.
	* @return Zero if success, non-zero if failed.
	*/
	meta_elem :: proc(cursor: ^Meta_Cursor, elem: i32) -> i32 ---

	/** Move cursor to member.
	*
	* @param cursor The cursor.
	* @param name The name of the member.
	* @return Zero if success, non-zero if failed.
	*/
	meta_member :: proc(cursor: ^Meta_Cursor, name: cstring) -> i32 ---

	/** Same as ecs_meta_member() but doesn't throw an error.
	*
	* @param cursor The cursor.
	* @param name The name of the member.
	* @return Zero if success, non-zero if failed.
	* @see ecs_meta_member()
	*/
	meta_try_member :: proc(cursor: ^Meta_Cursor, name: cstring) -> i32 ---

	/** Move cursor to member.
	* Same as ecs_meta_member(), but with support for "foo.bar" syntax.
	*
	* @param cursor The cursor.
	* @param name The name of the member.
	* @return Zero if success, non-zero if failed.
	* @see ecs_meta_member()
	*/
	meta_dotmember :: proc(cursor: ^Meta_Cursor, name: cstring) -> i32 ---

	/** Same as ecs_meta_dotmember() but doesn't throw an error.
	*
	* @param cursor The cursor.
	* @param name The name of the member.
	* @return Zero if success, non-zero if failed.
	* @see ecs_meta_dotmember()
	*/
	meta_try_dotmember :: proc(cursor: ^Meta_Cursor, name: cstring) -> i32 ---

	/** Push a scope (required/only valid for structs & collections).
	*
	* @param cursor The cursor.
	* @return Zero if success, non-zero if failed.
	*/
	meta_push :: proc(cursor: ^Meta_Cursor) -> i32 ---

	/** Pop a struct or collection scope (must follow a push).
	*
	* @param cursor The cursor.
	* @return Zero if success, non-zero if failed.
	*/
	meta_pop :: proc(cursor: ^Meta_Cursor) -> i32 ---

	/** Is the current scope a collection?.
	*
	* @param cursor The cursor.
	* @return True if current scope is a collection, false if not.
	*/
	meta_is_collection :: proc(cursor: ^Meta_Cursor) -> bool ---

	/** Get type of current field.
	*
	* @param cursor The cursor.
	* @return The type of the current field.
	*/
	meta_get_type :: proc(cursor: ^Meta_Cursor) -> Entity ---

	/** Get unit of current field.
	*
	* @param cursor The cursor.
	* @return The unit of the current field.
	*/
	meta_get_unit :: proc(cursor: ^Meta_Cursor) -> Entity ---

	/** Get member name of current field.
	*
	* @param cursor The cursor.
	* @return The member name of the current field.
	*/
	meta_get_member :: proc(cursor: ^Meta_Cursor) -> cstring ---

	/** Get member entity of current field.
	*
	* @param cursor The cursor.
	* @return The member entity of the current field.
	*/
	meta_get_member_id :: proc(cursor: ^Meta_Cursor) -> Entity ---

	/** Set field with boolean value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	meta_set_bool :: proc(cursor: ^Meta_Cursor, value: bool) -> i32 ---

	/** Set field with char value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	meta_set_char :: proc(cursor: ^Meta_Cursor, value: i8) -> i32 ---

	/** Set field with int value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	meta_set_int :: proc(cursor: ^Meta_Cursor, value: i64) -> i32 ---

	/** Set field with uint value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	meta_set_uint :: proc(cursor: ^Meta_Cursor, value: u64) -> i32 ---

	/** Set field with float value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	meta_set_float :: proc(cursor: ^Meta_Cursor, value: f64) -> i32 ---

	/** Set field with string value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	meta_set_string :: proc(cursor: ^Meta_Cursor, value: cstring) -> i32 ---

	/** Set field with string literal value (has enclosing "").
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	meta_set_string_literal :: proc(cursor: ^Meta_Cursor, value: cstring) -> i32 ---

	/** Set field with entity value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	meta_set_entity :: proc(cursor: ^Meta_Cursor, value: Entity) -> i32 ---

	/** Set field with (component) id value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	meta_set_id :: proc(cursor: ^Meta_Cursor, value: Id) -> i32 ---

	/** Set field with null value.
	*
	* @param cursor The cursor.
	* @return Zero if success, non-zero if failed.
	*/
	meta_set_null :: proc(cursor: ^Meta_Cursor) -> i32 ---

	/** Set field with dynamic value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	meta_set_value :: proc(cursor: ^Meta_Cursor, value: ^Value) -> i32 ---

	/** Get field value as boolean.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	meta_get_bool :: proc(cursor: ^Meta_Cursor) -> bool ---

	/** Get field value as char.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	meta_get_char :: proc(cursor: ^Meta_Cursor) -> i8 ---

	/** Get field value as signed integer.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	meta_get_int :: proc(cursor: ^Meta_Cursor) -> i64 ---

	/** Get field value as unsigned integer.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	meta_get_uint :: proc(cursor: ^Meta_Cursor) -> u64 ---

	/** Get field value as float.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	meta_get_float :: proc(cursor: ^Meta_Cursor) -> f64 ---

	/** Get field value as string.
	* This operation does not perform conversions. If the field is not a string,
	* this operation will fail.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	meta_get_string :: proc(cursor: ^Meta_Cursor) -> cstring ---

	/** Get field value as entity.
	* This operation does not perform conversions.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	meta_get_entity :: proc(cursor: ^Meta_Cursor) -> Entity ---

	/** Get field value as (component) id.
	* This operation can convert from an entity.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	meta_get_id :: proc(cursor: ^Meta_Cursor) -> Id ---

	/** Convert pointer of primitive kind to float.
	*
	* @param type_kind The primitive type kind of the value.
	* @param ptr Pointer to a value of a primitive type.
	* @return The value in floating point format.
	*/
	meta_ptr_to_float :: proc(type_kind: Primitive_Kind, ptr: rawptr) -> f64 ---

	/** Get element count for array/vector operations.
	* The operation must either be EcsOpPushArray or EcsOpPushVector. If the
	* operation is EcsOpPushArray, the provided pointer may be NULL.
	*
	* @param op The serializer operation.
	* @param ptr Pointer to the array/vector value.
	* @return The number of elements.
	*/
	meta_op_get_elem_count :: proc(op: ^Meta_Op, ptr: rawptr) -> Size ---
}

/** Used with ecs_primitive_init(). */
Primitive_Desc :: struct {
	entity: Entity,         /**< Existing entity to use for type (optional). */
	kind:   Primitive_Kind, /**< Primitive type kind. */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new primitive type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	primitive_init :: proc(world: ^World, desc: ^Primitive_Desc) -> Entity ---
}

/** Used with ecs_enum_init(). */
Enum_Desc :: struct {
	entity:          Entity,            /**< Existing entity to use for type (optional). */
	constants:       [32]Enum_Constant, /**< Enum constants. */
	underlying_type: Entity,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new enum type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	enum_init :: proc(world: ^World, desc: ^Enum_Desc) -> Entity ---
}

/** Used with ecs_bitmask_init(). */
Bitmask_Desc :: struct {
	entity:    Entity,               /**< Existing entity to use for type (optional). */
	constants: [32]Bitmask_Constant, /**< Bitmask constants. */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new bitmask type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	bitmask_init :: proc(world: ^World, desc: ^Bitmask_Desc) -> Entity ---
}

/** Used with ecs_array_init(). */
Array_Desc :: struct {
	entity: Entity, /**< Existing entity to use for type (optional). */
	type:   Entity, /**< Element type. */
	count:  i32,    /**< Number of elements. */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new array type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	array_init :: proc(world: ^World, desc: ^Array_Desc) -> Entity ---
}

/** Used with ecs_vector_init(). */
Vector_Desc :: struct {
	entity: Entity, /**< Existing entity to use for type (optional). */
	type:   Entity, /**< Element type. */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new vector type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	vector_init :: proc(world: ^World, desc: ^Vector_Desc) -> Entity ---
}

/** Used with ecs_struct_init(). */
Struct_Desc :: struct {
	entity:                 Entity,     /**< Existing entity to use for type (optional). */
	members:                [32]Member, /**< Struct members. */
	create_member_entities: bool,       /**< Create entities for members. */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new struct type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	struct_init :: proc(world: ^World, desc: ^Struct_Desc) -> Entity ---

	/** Add member to struct.
	* This operation adds a member to a struct type. If the provided entity is not
	* a struct type, this operation will add the Struct component.
	*
	* @param world The world.
	* @param type The struct type.
	* @param member The member data.
	*/
	struct_add_member :: proc(world: ^World, type: Entity, member: ^Member) -> i32 ---

	/** Get member by name from struct.
	*
	* @param world The world.
	* @param type The struct type.
	* @param name The member name.
	* @return The member if found, or NULL if no member with the provided name exists.
	*/
	struct_get_member :: proc(world: ^World, type: Entity, name: cstring) -> ^Member ---

	/** Get member by index from struct.
	*
	* @param world The world.
	* @param type The struct type.
	* @param i The member index.
	* @return The member if found, or NULL if index is larger than the number of members for the struct.
	*/
	struct_get_nth_member :: proc(world: ^World, type: Entity, i: i32) -> ^Member ---
}

/** Used with ecs_opaque_init(). */
Opaque_Desc :: struct {
	entity: Entity,     /**< Existing entity to use for type (optional). */
	type:   Ecs_Opaque, /**< Type that the opaque type maps to. */
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new opaque type.
	* Opaque types are types of which the layout doesn't match what can be modelled
	* with the primitives of the meta framework, but which have a structure
	* that can be described with meta primitives. Typical examples are STL types
	* such as std::string or std::vector, types with a nontrivial layout, and types
	* that only expose getter/setter methods.
	*
	* An opaque type is a combination of a serialization function, and a handle to
	* a meta type which describes the structure of the serialized output. For
	* example, an opaque type for std::string would have a serializer function that
	* accesses .c_str(), and with type ecs_string_t.
	*
	* The serializer callback accepts a serializer object and a pointer to the
	* value of the opaque type to be serialized. The serializer has two methods:
	*
	* - value, which serializes a value (such as .c_str())
	* - member, which specifies a member to be serialized (in the case of a struct)
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	opaque_init :: proc(world: ^World, desc: ^Opaque_Desc) -> Entity ---
}

/** Used with ecs_unit_init(). */
Unit_Desc :: struct {
	/** Existing entity to associate with unit (optional). */
	entity: Entity,

	/** Unit symbol, e.g. "m", "%", "g". (optional). */
	symbol: cstring,

	/** Unit quantity, e.g. distance, percentage, weight. (optional). */
	quantity: Entity,

	/** Base unit, e.g. "meters" (optional). */
	base: Entity,

	/** Over unit, e.g. "per second" (optional). */
	over: Entity,

	/** Translation to apply to derived unit (optional). */
	translation: Unit_Translation,

	/** Prefix indicating order of magnitude relative to the derived unit. If set
	* together with "translation", the values must match. If translation is not
	* set, setting prefix will auto-populate it.
	* Additionally, setting the prefix will enforce that the symbol (if set)
	* is consistent with the prefix symbol + symbol of the derived unit. If the
	* symbol is not set, it will be auto populated. */
	prefix: Entity,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new unit.
	*
	* @param world The world.
	* @param desc The unit descriptor.
	* @return The new unit, 0 if failed.
	*/
	unit_init :: proc(world: ^World, desc: ^Unit_Desc) -> Entity ---
}

/** Used with ecs_unit_prefix_init(). */
Unit_Prefix_Desc :: struct {
	/** Existing entity to associate with unit prefix (optional). */
	entity: Entity,

	/** Unit symbol, e.g. "m", "%", "g". (optional). */
	symbol: cstring,

	/** Translation to apply to derived unit (optional). */
	translation: Unit_Translation,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	/** Create a new unit prefix.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new unit prefix, 0 if failed.
	*/
	unit_prefix_init :: proc(world: ^World, desc: ^Unit_Prefix_Desc) -> Entity ---

	/** Create a new quantity.
	*
	* @param world The world.
	* @param desc The quantity descriptor.
	* @return The new quantity, 0 if failed.
	*/
	quantity_init :: proc(world: ^World, desc: ^Entity_Desc) -> Entity ---

	/** Meta module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsMeta)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsMetaImport :: proc(world: ^World) ---

	/** Populate meta information from type descriptor. */
	meta_from_desc  :: proc(world: ^World, component: Entity, kind: Type_Kind, desc: cstring) -> i32 ---
	set_os_api_impl :: proc() ---

	/** Import a module.
	* This operation will load a modules and store the public module handles in the
	* handles_out out parameter. The module name will be used to verify if the
	* module was already loaded, in which case it won't be reimported. The name
	* will be translated from PascalCase to an entity path (pascal.case) before the
	* lookup occurs.
	*
	* Module contents will be stored as children of the module entity. This
	* prevents modules from accidentally defining conflicting identifiers. This is
	* enforced by setting the scope before and after loading the module to the
	* module entity id.
	*
	* A more convenient way to import a module is by using the ECS_IMPORT macro.
	*
	* @param world The world.
	* @param module The module import function.
	* @param module_name The name of the module.
	* @return The module entity.
	*/
	@(link_name="ecs_import")
	import_module :: proc(world: ^World, module: Module_Action, module_name: cstring) -> Entity ---

	/** Same as ecs_import(), but with name to scope conversion.
	* PascalCase names are automatically converted to scoped names.
	*
	* @param world The world.
	* @param module The module import function.
	* @param module_name_c The name of the module.
	* @return The module entity.
	*/
	import_c :: proc(world: ^World, module: Module_Action, module_name_c: cstring) -> Entity ---

	/** Import a module from a library.
	* Similar to ecs_import(), except that this operation will attempt to load the
	* module from a dynamic library.
	*
	* A library may contain multiple modules, which is why both a library name and
	* a module name need to be provided. If only a library name is provided, the
	* library name will be reused for the module name.
	*
	* The library will be looked up using a canonical name, which is in the same
	* form as a module, like `flecs.components.transform`. To transform this
	* identifier to a platform specific library name, the operation relies on the
	* module_to_dl callback of the os_api which the application has to override if
	* the default does not yield the correct library name.
	*
	* @param world The world.
	* @param library_name The name of the library to load.
	* @param module_name The name of the module to load.
	*/
	import_from_library :: proc(world: ^World, library_name: cstring, module_name: cstring) -> Entity ---

	/** Register a new module. */
	module_init                :: proc(world: ^World, c_name: cstring, desc: ^Component_Desc) -> Entity ---
	cpp_get_type_name          :: proc(type_name: cstring, func_name: cstring, len: c.size_t, front_len: c.size_t) -> cstring ---
	cpp_get_symbol_name        :: proc(symbol_name: cstring, type_name: cstring, len: c.size_t) -> cstring ---
	cpp_get_constant_name      :: proc(constant_name: cstring, func_name: cstring, len: c.size_t, back_len: c.size_t) -> cstring ---
	cpp_trim_module            :: proc(world: ^World, type_name: cstring) -> cstring ---
	cpp_component_register     :: proc(world: ^World, id: Entity, ids_index: i32, name: cstring, cpp_name: cstring, cpp_symbol: cstring, size: c.size_t, alignment: c.size_t, is_component: bool, explicit_registration: bool, registered_out: ^bool, existing_out: ^bool) -> Entity ---
	cpp_enum_init              :: proc(world: ^World, id: Entity, underlying_type: Entity) ---
	cpp_enum_constant_register :: proc(world: ^World, parent: Entity, id: Entity, name: cstring, value: rawptr, value_type: Entity, value_size: c.size_t) -> Entity ---
}

Cpp_Get_Mut :: struct {
	world:         ^World,
	stage:         ^Stage,
	ptr:           rawptr,
	call_modified: bool,
}

@(default_calling_convention="c", link_prefix="ecs_")
foreign lib {
	cpp_set         :: proc(world: ^World, entity: Entity, component: Id, new_ptr: rawptr, size: c.size_t) -> Cpp_Get_Mut ---
	cpp_assign      :: proc(world: ^World, entity: Entity, component: Id, new_ptr: rawptr, size: c.size_t) -> Cpp_Get_Mut ---
	cpp_new         :: proc(world: ^World, parent: Entity, name: cstring, sep: cstring, root_sep: cstring) -> Entity ---
	cpp_last_member :: proc(world: ^World, type: Entity) -> ^Member ---
}

