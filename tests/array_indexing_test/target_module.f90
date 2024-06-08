module target_module
    implicit none
    
    interface square_it
        module procedure square_it_scalar, square_it_array_1d !, square_it_array_2d
    end interface

    contains

    subroutine target_subroutine(result,dim)

        integer                                     :: dim
        real (kind=16)                              :: result
        real (kind=8), dimension(:,:), allocatable  :: array

        allocate( array(dim,dim) )

        call initialize_square_array(array, dim)

        result = square_it(array(1,1))
        result = square_it(array(:,1))
        result = square_it(array(1,1:4:2))

        deallocate( array )
        
    end subroutine

    subroutine initialize_square_array(array, dim)

        real (kind=8), dimension(dim,dim), intent(inout)    :: array
        integer                                             :: i, j, dim
        real (kind=8)                                       :: e = 2.718281828459045

        do i = 1,dim
            do j = 1,dim
                array(i,j) = e**(i*j)
            end do
        end do

    end subroutine

    function square_it_scalar(x) result(return_value)
        real (kind=8) :: x
        real (kind=8) :: return_value

        return_value = x**2

    end function

    function square_it_array_1d(x) result(return_value)
        real (kind=8), dimension(:) :: x
        integer                     :: i
        real (kind=8)               :: return_value

        do i=1, size(x,1)
            x(i) = x(i)**2
        end do

        return_value = sum(x)

    end function

    ! function square_it_array_2d(x) result(return_value)
    !     real (kind=8), dimension(:,:)     :: x
    !     integer                           :: i, j
    !     real (kind=8)                     :: return_value

    !     do i=1, size(x,1)
    !         do j=1, size(x,2)
    !             x(i,j) = x(i,j)**2
    !         end do
    !     end do

    !     return_value = sum(x)
    ! end function
    
end module target_module