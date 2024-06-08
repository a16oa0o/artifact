module target_module
    use auxiliary_module, only  : generic_name
    implicit none

    contains

    subroutine target_subroutine(result)

        real(kind=8)    :: result
        real(kind=8)    :: result1
        real(kind=8)    :: result2
        real(kind=8)    :: result3
        real(kind=8)    :: result4

        call generic_name(result1)                                      ! 2.0
        call generic_name(result2, 1, result1)                          ! 3.0
        call generic_name(result3, multiplicand=result2)                ! 4.0
        call generic_name(result4, multiplicand=result3, iterations=2)  ! 25.0
        call generic_name(result)

        result = result1 + result2 + result3 + result4                  ! 36.0
        
    end subroutine
    
end module target_module