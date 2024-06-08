module target_module
    implicit none

    type, public :: my_derived_type ; private
        integer         :: array_dim
        real            :: scalar
    end type        
    
    contains

    subroutine target_subroutine(result)

        real (kind=16)                  :: result
        type(my_derived_type)           :: dt
        real, dimension(:), allocatable :: array
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

    subroutine construct_array(array, dt)

        type(my_derived_type)           :: dt
        real, dimension(dt%array_dim)   :: array
        integer                         :: i

        do i = 1,dt%array_dim
            array(i) = dt%scalar**(i-1)
        end do

    end subroutine
    
end module target_module