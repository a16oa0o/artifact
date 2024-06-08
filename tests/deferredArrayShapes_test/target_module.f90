module target_module
    use auxiliary_module, only  : construct_array
    use auxiliary_type, only    : my_derived_type
    implicit none

    contains

    subroutine target_subroutine(result, dt)

        real (kind=16)                          :: result
        type(my_derived_type)                   :: dt
        real (kind=8), dimension(dt%array_dim)  :: array
        integer                                 :: i

        dt%scalar = 2.0

        call construct_array(array)
        result = 0
        do i = 1,dt%array_dim
            result = result + array(i)
        end do

    end subroutine
    
end module target_module