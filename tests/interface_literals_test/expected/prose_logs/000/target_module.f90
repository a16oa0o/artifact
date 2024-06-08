MODULE target_module
USE auxiliary_module, ONLY : get_param
USE auxiliary_type, ONLY : param_file_type
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=8) :: result
TYPE ( param_file_type )  :: param_file
CHARACTER(len=3) :: mdl = "foo"
result = 2.718281828459045_8
CALL get_param(param_file,mdl,"CORIOLIS_BLEND_WT_LIN",result,"A weighting value for the ratio of inverse thicknesses, " // &
"beyond which the blending between Sadourny Energy and " // "Arakawa & Hsu goes linearly to 0 when CORIOLIS_SCHEME " // &
"is ARAWAKA_LAMB_BLEND. This must be between 1 and 1e-16.",units="nondim",default=0.125)
END SUBROUTINE 

END MODULE target_module

