module auxiliary_module
    use auxiliary_type, only: my_derived_type

    implicit none

    public  ::  construct_array

    interface construct_array
        module procedure construct_array_dummy
        module procedure construct_array_target
    end interface

    contains

    subroutine construct_array_target(array, dt)

        type(my_derived_type)           :: dt
        real (kind=8), dimension(dt%array_dim)   :: array
        integer                         :: i

        do i = 1,dt%array_dim
            array(i) = dt%scalar**(i-1)
        end do

    end subroutine

    subroutine construct_array_dummy(array, dt)
        type(my_derived_type)           :: dt
        real (kind=16), dimension(dt%array_dim)   :: array
        integer                         :: i

        do i = 1,dt%array_dim
            array(i) = dt%scalar**(i-1)
        end do
    end subroutine

end module auxiliary_module