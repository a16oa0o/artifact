module auxiliary_module
    implicit none

interface init_array
    module procedure init_array_1d, init_array_2d, init_array_3d
end interface

    contains

    subroutine init_array_1d(array, init_value)
        real, intent(in)                    :: init_value
        real, dimension(:), intent(inout)   :: array
        integer                             :: i

        do i=1, size(array)
            array(i) = init_value
        end do
    end subroutine

    subroutine init_array_2d(array, init_value)
        real, intent(in)                    :: init_value
        real, dimension(:,:), intent(inout) :: array
        integer                             :: i,j

        do i=1, size(array, 1)
            do j=1, size(array,2)
                array(i,j) = init_value
            end do
        end do
    end subroutine

    subroutine init_array_3d(array, init_value)
        real, intent(in)                        :: init_value
        real, dimension(:,:,:), intent(inout)   :: array
        integer                                 :: i,j,k

        do i=1, size(array,1)
            do j=1, size(array,2)
                do k=1, size(array,3)
                    array(i,j,k) = init_value
                end do
            end do
        end do
    end subroutine

end module auxiliary_module