module target_module

    implicit none

    interface my_sum
        module procedure my_sum_2d
        module procedure my_sum_3d
    end interface

    contains

    subroutine target_subroutine(result, array2)

        real, target    :: array1(4,4)
        real, optional  :: array2(2,2,4)     
        real, pointer   :: ptr1(:,:), ptr2(:,:,:)
        real (kind=16)  :: result

        array1=reshape((/3.5, 6.0, 2.5, 2.0, &
                        6.5, 4.0, 4.5, 3.0, &
                        5.5, 6.0, 6.5, 4.0, &
                        7.5, 8.0, 8.5, 5.0/), &
                        shape(array1), order=(/2,1/))

        ptr1 => array1(2:3,2:3)

        if (present(array2)) then
            allocate(ptr2(2,2,4))
            ptr2 = array2
        else
            ptr2 => null()
        end if

        result = my_sum(ptr1) + my_sum(ptr2)

        if (present(array2)) then
            array2 = ptr2
            deallocate(ptr2)
        end if
        
    end subroutine

    function my_sum_2d(ptr) result(return_value)
        real, pointer           :: ptr(:,:)
        real                    :: return_value
        integer                 :: i,j
        integer, dimension(2)   :: arr_shape

        arr_shape = shape(ptr)

        return_value = 0
        do i = 1, arr_shape(1)
            do j = 1, arr_shape(2)
                return_value = return_value + ptr(i,j)
            end do
        end do
    end function

    function my_sum_3d(ptr) result(return_value)
        real, pointer           :: ptr(:,:,:)
        real                    :: return_value
        integer                 :: i,j,k
        integer, dimension(3)   :: arr_shape

        arr_shape = shape(ptr)

        return_value = 0
        do i = 1, arr_shape(1)
            do j = 1, arr_shape(2)
                do k = 1, arr_shape(3)
                    return_value = return_value + ptr(i,j,k)
                end do
            end do
        end do
    end function
    
end module target_module