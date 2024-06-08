module target_module
    use auxiliary_module, only  : get_param
    use auxiliary_type, only    : param_file_type

    implicit none

    contains

    subroutine target_subroutine(result)

        real                           :: result
        type (param_file_type)         :: param_file
        character(len=3)               :: mdl = "foo"

        result = 2.718281828459045

        call get_param(param_file, mdl, "CORIOLIS_BLEND_WT_LIN", result, &
        "A weighting value for the ratio of inverse thicknesses, "//&
        "beyond which the blending between Sadourny Energy and "//&
        "Arakawa & Hsu goes linearly to 0 when CORIOLIS_SCHEME "//&
        "is ARAWAKA_LAMB_BLEND. This must be between 1 and 1e-16.", &
        units="nondim", default=0.125)
        
    end subroutine
    
end module target_module