module auxiliary_module

    implicit none

    public  ::  construct_array

    interface construct_array
        module procedure construct_array_dummy
        module procedure construct_array_target
    end interface

    contains

    subroutine construct_array_target(array)
        real (kind=8), dimension(:)   :: array
        integer                         :: i

        do i = 1,size(array)
            array(i) = 2**(i-1)
        end do

    end subroutine

    subroutine construct_array_dummy(array)
        real (kind=16), dimension(:)   :: array
        integer                         :: i

        do i = 1,size(array)
            array(i) = 2**(i-1)
        end do
    end subroutine

end module auxiliary_module