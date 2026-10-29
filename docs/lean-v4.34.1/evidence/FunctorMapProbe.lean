import HoTTLean.ForMathlib.Tactic.CategoryTheory.FunctorMap
universe u v
namespace CategoryTheory
variable {C : Type u} [Category.{v} C]
@[functor_map (attr := reassoc (attr := simp))]
theorem functorMapMigrationProbe {X Y : C} (f g : X ⟶ Y) (h : f = g) : f ≫ 𝟙 Y = g := by simpa using h
#check functorMapMigrationProbe_functor_map
#check functorMapMigrationProbe_functor_map_assoc
example {D : Type u} [Category.{v} D] (F : C ⥤ D) {X Y : C} (f g : X ⟶ Y) (h : f = g) :
    F.map f = F.map g := (functor_map_of% (functorMapMigrationProbe f g h)) F
end CategoryTheory
