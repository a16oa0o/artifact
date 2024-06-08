program main
    use target_module, only: square_it
    use auxiliary_module, only: init_array
    implicit none

    real                        :: begin, end
    integer                     :: i, n_iters

    ! input variables
    real, target                        :: scalar_input
    real, target, dimension(10)         :: array_input1
    real, target, dimension(10,10)      :: array_input2
    real, target, dimension(10,10,10)   :: array_input3
    real, pointer                       :: ptr1_scalar_input, ptr2_scalar_input
    real, dimension(:), pointer         :: ptr1_array_input1, ptr2_array_input1
    real, dimension(:,:), pointer       :: ptr1_array_input2, ptr2_array_input2
    real, dimension(:,:,:), pointer     :: ptr1_array_input3, ptr2_array_input3 

    ! initialize values
    scalar_input = 2.718281828459045
    CALL init_array(array_input1, scalar_input)
    CALL init_array(array_input2, scalar_input)
    CALL init_array(array_input3, scalar_input)

    ! initialize pointers
    ptr1_scalar_input => scalar_input
    allocate(ptr2_scalar_input)
    ptr2_scalar_input = scalar_input

    ptr1_array_input1 => array_input1
    allocate(ptr2_array_input1(size(array_input1)))
    ptr2_array_input1 = array_input1

    ptr1_array_input2 => array_input2
    allocate(ptr2_array_input2(size(array_input2,1),size(array_input2,2)))
    ptr2_array_input2 = array_input2
    
    ptr1_array_input3 => array_input3
    allocate(ptr2_array_input3(size(array_input3,1),size(array_input3,2),size(array_input3,3)))
    ptr2_array_input3 = array_input3

    ! call subroutines
    n_iters = 10000000

    call cpu_time(begin)
    do i=1, n_iters
        call square_it(scalar_input)
    end do
    call cpu_time(end)
    print *, "scalar_input time: ", end-begin

    call cpu_time(begin)
    do i=1, n_iters
        call square_it(array_input1)
    end do
    call cpu_time(end)
    print *, "1d array input time: ", end-begin

    call cpu_time(begin)
    do i=1, n_iters
        call square_it(array_input2)
    end do
    call cpu_time(end)
    print *, "2d array input time: ", end-begin

    call cpu_time(begin)
    do i=1, n_iters
        call square_it(array_input3)
    end do
    call cpu_time(end)
    print *, "3d array input time: ", end-begin

    call cpu_time(begin)
    do i=1, n_iters
        call square_it(ptr1_scalar_input)
    end do
    call cpu_time(end)
    print *, "ptr => scalar_input time: ", end-begin

    call cpu_time(begin)
    do i=1, n_iters
        call square_it(ptr2_scalar_input)
    end do
    call cpu_time(end)
    print *, "ptr =  scalar_input time: ", end-begin

    call cpu_time(begin)
    do i=1, n_iters
        call square_it(ptr1_array_input1)
    end do
    call cpu_time(end)
    print *, "ptr => 1d array input time: ", end-begin
    
    call cpu_time(begin)
    do i=1, n_iters
        call square_it(ptr2_array_input1)
    end do
    call cpu_time(end)
    print *, "ptr =  1d array input time: ", end-begin

    call cpu_time(begin)
    do i=1, n_iters
        call square_it(ptr1_array_input2)
    end do
    call cpu_time(end)
    print *, "ptr => 2d array input time: ", end-begin
    
    call cpu_time(begin)
    do i=1, n_iters
        call square_it(ptr2_array_input2)
    end do
    call cpu_time(end)
    print *, "ptr =  2d array input time: ", end-begin

    call cpu_time(begin)
    do i=1, n_iters
        call square_it(ptr1_array_input3)
    end do
    call cpu_time(end)
    print *, "ptr => 3d array input time: ", end-begin
    
    call cpu_time(begin)
    do i=1, n_iters
        call square_it(ptr2_array_input3)
    end do
    call cpu_time(end)
    print *, "ptr =  3d array input time: ", end-begin

    deallocate(ptr2_scalar_input)
    deallocate(ptr2_array_input1)
    deallocate(ptr2_array_input2)
    deallocate(ptr2_array_input3)

end program main