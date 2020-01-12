! Main program loop
program ecalculatefortran
    implicit none

    integer :: numOfItems, i
    character (len=50) :: filename
    integer, dimension(:), allocatable :: arrayOfDigits

!   Get user input and call calculation function
    write(*, *) 'Enter a positive number of decimal points to calculate for e'
    read(*, *) numOfItems

!   Allocate the array with the correct size of elements in e
    allocate (arrayOfDigits(0:numOfItems))

    call ecalculation(numOfItems, arrayOfDigits)

!   Get filename and write the output to the file
    write(*, *) 'Enter the name of the file to store the value of e (max 50 characters)'
    read (*, *) filename

    open(unit=9, file=filename, action='write')

!   Actually write to the file
    do i = 0, numOfItems, 1
        if (i == 0) then
!           Include the decimal character
            write(9, 1000, advance="no") arrayOfDigits(i), '.'
        else 
            write(9, 1000, advance="no") arrayOfDigits(i)
        end if
    end do

!   Deallocate any pointers set
    close(9, status='keep')
    deallocate(arrayOfDigits)

    1000 format(I1, A)
end

! Function to calculate the value of e
! Param: n: The number of decimal points to calculate for e. (in)
! Param: arr: the array of every number of e (out)
subroutine ecalculation(n, arr)
    implicit none

    integer :: i, j, n, m, carry, temp
    real :: test
    integer, dimension(0:n) :: arr
    integer, dimension(:), allocatable :: coef

!   Calculate the max size of the coefficient array
    m = 4
    test = (n + 1) * 2.30258509
    do
        if (m * (log(real(m)) - 1.0) + 0.5 * log(6.2831852 * m) > test) exit
        m = m + 1
    end do

!   Allocate the coefficient array now that we know the max size and fill it with temp values
    allocate (coef(0:m))
    do i = 2, m, 1
        coef(i) = 1;
    end do

!   Perform the calculations
    arr(0) = 2
    do i = 1, n, 1
        carry = 0
        do j = m - 1, 2, -1
            temp = coef(j) * 10 + carry
            carry = temp / j
            coef(j) = temp - carry * j
        end do
        arr(i) = carry
    end do

    deallocate(coef)
    return
end