

enable_language(Fortran)

# add_definitions(-D_GIL_)
if ( APPLE )
add_definitions(-D_MAC_)
add_definitions(-DCRY_OSMAC)
else()
add_definitions(-D_MIN_)
add_definitions(-DCRY_OSWIN32)
endif()

add_definitions(-DCRY_GNU)
add_definitions(-fno-sign-zero)
add_definitions(-D_GNUF77_)
add_definitions(-std=legacy)
add_definitions(-fno-automatic)
add_definitions(-fno-inline)
add_definitions(-fexceptions)
add_definitions(-D _HOL_)
add_definitions(-I ../sleef)
#add_definitions(-arch x86_64)

SET (cry_sources 
solve_helper.F90
mrgrnk.f90
absorb.F
accumula.F
alter5.F
aniso.F
anisotfs.F
calcul.F
characte.F
control.F
crystals.F
csdcode.F
difabs.F
disc.F
distan.F
distangl.F
empabs.F
execute.F
fiddle.F
findfrag.F
foreig.F
fourie.F
fourier.F
genedit.F
geomet.F
geometry.F
guibit.F
hydrogen.F
input.F
input6.F
invert.F
lexical.F
link.F
list11.F
list12.F
list16.F
list26.F
list4.F
list50.F
list6.F
lists1.F
lists2.F
lists3.F
lists4.F
matrix.F
modify5.F
mtapes.F
normal.F
paramlist.F
planes.F
prcss.F
prcss6.F
presets.F
publsh.F
punch.F
read.F
read6.F
reductio.F
regular.F
restr.F
results.F
rotax.F
script.F
service.F
setting.F
sfls.F
slant.F
solve.F
sort.F
spacegrp.F
special.F
specific.F
summary.F
syntax.F
torsion.F
trial.F
vcv.F
weight.F
lapack.F
)


if(CRY_NOGUI)
add_library(CrystalsFortran SHARED ${cry_sources})
else()
add_library(CrystalsFortran OBJECT ${cry_sources})
endif()


SET_SOURCE_FILES_PROPERTIES(lapack.F PROPERTIES COMPILE_FLAGS -O0)
