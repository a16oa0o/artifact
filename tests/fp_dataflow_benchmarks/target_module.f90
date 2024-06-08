module target_module

    implicit none
    
    interface square_it
        module procedure square_it_scalar, square_it_array_1d, square_it_array_2d, square_it_array_3d
    end interface
    
    contains

    subroutine square_it_scalar(x)
        real, intent(inout)     :: x

        x = x**2

    end subroutine

    subroutine square_it_array_1d(x)
        real, dimension(:), intent(inout)   :: x
        integer                             :: i

        do i=1, size(x,1)
            x(i) = x(i)**2
        end do
    end subroutine

    subroutine square_it_array_2d(x)
        real, dimension(:,:), intent(inout)     :: x
        integer                                 :: i, j

        do i=1, size(x,1)
            do j=1, size(x,2)
                x(i,j) = x(i,j)**2
            end do
        end do
    end subroutine

    subroutine square_it_array_3d(x)
        real, dimension(:,:,:), intent(inout)   :: x
        integer                                 :: i, j, k

        do i=1, size(x,1)
            do j=1, size(x,2)
                do k=1, size(x,3)
                    x(i,j,k) = x(i,j,k)**2
                end do
            end do
        end do
    end subroutine

end module target_module