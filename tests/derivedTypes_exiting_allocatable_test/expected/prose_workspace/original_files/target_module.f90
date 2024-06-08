module target_module
    use auxiliary_module, only  : construct_array
    use auxiliary_type, only    : my_derived_type
    implicit none

    contains

    subroutine target_subroutine(result)

        real (kind=16)                  :: result
        type(my_derived_type)           :: dt
        real (kind=8), dimension(:), allocatable :: array
        integer                         :: i

        dt%array_dim = 3
        dt%scalar = 2.0

        allocate(array(dt%array_dim))

        call construct_array(array, dt)
        result = 0
        do i = 1,dt%array_dim
            result = result + array(i)
        end do

        deallocate(array)

    end subroutine
    
end module target_module