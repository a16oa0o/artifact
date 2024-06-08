MODULE target_module
USE auxiliary_module, ONLY : get_param_real_wrapper_0004008xxxxxxx_to_00080088000088
USE auxiliary_module, ONLY : get_param
USE auxiliary_type, ONLY : param_file_type
IMPLICIT NONE
public target_subroutine_wrapper_8_to_4
INTERFACE target_subroutine_wrapper_8_to_4
MODULE PROCEDURE target_subroutine_wrapper_8_to_4
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: result
TYPE ( param_file_type )  :: param_file
CHARACTER(len=3) :: mdl = "foo"
result = 2.718281828459045_4
CALL get_param_real_wrapper_0004008xxxxxxx_to_00080088000088(param_file,mdl,"CORIOLIS_BLEND_WT_LIN",result,&
"A weighting value for the ratio of inverse thicknesses, " // "beyond which the blending between Sadourny Energy and " // &
"Arakawa & Hsu goes linearly to 0 when CORIOLIS_SCHEME " // "is ARAWAKA_LAMB_BLEND. This must be between 1 and 1e-16.",units=&
"nondim",default=0.125)
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_8_to_4(result)
REAL(kind=8) :: result
REAL(kind=4) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

