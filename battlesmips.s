########################################################################
# COMP1521 22T3 -- Assignment 1 -- Battlesmips!
#
#
# !!! IMPORTANT !!!
# Before starting work on the assignment, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
# Instructions to configure your text editor can be found here:
#   https://cgi.cse.unsw.edu.au/~cs1521/22T3/resources/mips-editors.html
# !!! IMPORTANT !!!
#
# A simplified implementation of the classic board game battleship!
# This program was written by <Daniel Farnham> (z5115421)
# on 23/10/22
#
# Version 1.0 (2022/10/04): Team COMP1521 <cs1521@cse.unsw.edu.au>
#
################################################################################

#![tabsize(8)]

# Constant definitions.
# DO NOT CHANGE THESE DEFINITIONS

# True and False constants
TRUE			= 1
FALSE			= 0
INVALID			= -1

# Board dimensions
BOARD_SIZE		= 7

# Bomb cell types
EMPTY			= '-'
HIT			= 'X'
MISS			= 'O'

# Ship cell types
CARRIER_SYMBOL		= 'C'
BATTLESHIP_SYMBOL	= 'B'
DESTROYER_SYMBOL	= 'D'
SUBMARINE_SYMBOL	= 'S'
PATROL_BOAT_SYMBOL	= 'P'

# Ship lengths
CARRIER_LEN		= 5
BATTLESHIP_LEN		= 4
DESTROYER_LEN		= 3
SUBMARINE_LEN		= 3
PATROL_BOAT_LEN		= 2

# Players
BLUE			= 'B'
RED			= 'R'

# Direction inputs
UP			= 'U'
DOWN			= 'D'
LEFT			= 'L'
RIGHT			= 'R'

# Winners
WINNER_NONE		= 0
WINNER_RED		= 1
WINNER_BLUE		= 2


################################################################################
# DATA SEGMENT
# DO NOT CHANGE THESE DEFINITIONS
.data

# char blue_board[BOARD_SIZE][BOARD_SIZE];
blue_board:			.space  BOARD_SIZE * BOARD_SIZE

# char red_board[BOARD_SIZE][BOARD_SIZE];
red_board:			.space  BOARD_SIZE * BOARD_SIZE

# char blue_view[BOARD_SIZE][BOARD_SIZE];
blue_view:			.space  BOARD_SIZE * BOARD_SIZE

# char red_view[BOARD_SIZE][BOARD_SIZE];
red_view:			.space  BOARD_SIZE * BOARD_SIZE

# char whose_turn = BLUE;
whose_turn:			.byte   BLUE

# point_t target;
.align 2
target:						# struct point target {
				.space  4	# 	int row;
				.space  4	# 	int col;
						# }

# point_t start;
.align 2
start:						# struct point start {
				.space  4	# 	int row;
				.space  4	# 	int col;
						# }

# point_t end;
.align 2
end:						# struct point end {
				.space  4	# 	int row;
				.space  4	# 	int col;
						# }

# Strings
red_player_name_str:		.asciiz "RED"
blue_player_name_str:		.asciiz "BLUE"
place_ships_str:		.asciiz ", place your ships!\n"
your_final_board_str:		.asciiz ", Your final board looks like:\n\n"
red_wins_str:			.asciiz "RED wins!\n"
blue_wins_str:			.asciiz "BLUE wins!\n"
red_turn_str:			.asciiz "It is RED's turn!\n"
blue_turn_str:			.asciiz "It is BLUE's turn!\n"
your_curr_board_str:		.asciiz "Your current board:\n"
ship_input_info_1_str:		.asciiz "Placing ship type "
ship_input_info_2_str:		.asciiz ", with length "
ship_input_info_3_str:		.asciiz ".\n"
enter_start_row_str:		.asciiz "Enter starting row: "
enter_start_col_str:		.asciiz "Enter starting column: "
enter_direction_str:		.asciiz "Enter direction (U, D, L, R): "
invalid_direction_str:		.asciiz "Invalid direction. Try again.\n"
invalid_length_str:		.asciiz "Ship doesn't fit in this direction. Try again.\n"
invalid_overlaps_str:		.asciiz "Ship overlaps with another ship. Try again.\n"
invalid_coords_already_hit_str:	.asciiz "You've already hit this target. Try again.\n"
invalid_coords_out_bounds_str:	.asciiz "Coordinates out of bounds. Try again.\n"
enter_row_target_str:		.asciiz "Please enter the row for your target: "
enter_col_target_str:		.asciiz "Please enter the column for your target: "
hit_successful_str: 		.asciiz "Successful hit!\n"
you_missed_str:			.asciiz "Miss!\n"







############################################################
####                                                    ####
####   Your journey begins here, intrepid adventurer!   ####
####                                                    ####
############################################################


################################################################################
#
# Implement the following functions,
# and check these boxes as you finish implementing each function.
#
#  - [X] main
#  - [X] initialise_boards
#  - [X] initialise_board
#  - [X] setup_boards
#  - [X] setup_board
#  - [X] place_ship
#  - [ ] is_coord_out_of_bounds
#  - [ ] is_overlapping
#  - [X] place_ship_on_board
#  - [X] play_game
#  - [X] play_turn
#  - [X] perform_hit
#  - [X] check_player_win
#  - [X] check_winner
#  - [X] print_board			(provided for you)
#  - [X] swap_turn			(provided for you)
#  - [X] get_end_row			(provided for you)
#  - [X] get_end_col			(provided for you)
################################################################################

################################################################################
# .TEXT <main>
.text
main:
	# Args:     void
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   main
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

main__prologue:
		begin								# begin a new stack frame
		push	$ra							# | $ra

main__body:
	

		jal initialise_boards

		jal setup_boards

		jal play_game


main__epilogue:
	
		pop		$ra						# | $ra
		end								# ends the current stack frame

		li		$v0, 0
		jr		$ra						# return 0;



################################################################################
# .TEXT <initialise_boards>
.text
initialise_boards:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$a0]
	# Clobbers: [$a0]
	#
	# Locals:
	#   - $a0: stores board
	#
	# Structure:
	#   initialise_boards
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

initialise_boards__prologue:
		
		begin 
		push 	$ra 

	
initialise_boards__body:
	
		la 		$a0, blue_board
		jal 	initialise_board

		la 		$a0, blue_view
		jal 	initialise_board

		la 		$a0, red_board
		jal 	initialise_board

		la 		$a0, red_view
		jal 	initialise_board
		
initialise_boards__epilogue:


		pop 	$ra 
		end
		
		jr		$ra							# return;


################################################################################
# .TEXT <initialise_board>
.text
initialise_board:
	# Args:
        #   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0]
	# Uses:     [$a0, $v0, $t0, $t1, $t2, $t3, $t4, $s0]
	# Clobbers: [$a0, $v0, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:
	#   - $s0: is board
	#   - $t0: is row
	#   - $t1: is column
	#   - $t2: board[row][column]
	#   - $t3: store for EMPTY
	#   - $t4: base address
	#
	# Structure:
	#   initialise_board
	#   -> [prologue]
	#   -> body
	#		-> for_row_init
	#		-> for_row_cond
	#		-> for_row_body
		#		-> for_col_init
		#		-> for_col_cond
		#		-> for_col_body
		#		-> for_col_exitpoint
		#		-> for_col_exit
	#		-> for_col_exitpoint
	#		-> for_col_exit
	#   -> [epilogue]

initialise_board__prologue:
    	
		begin
		push 	$ra
		push 	$s0 

initialise_board__body:
		
		move 	$s0, $a0 

initialise_board__for_row_init:
	
		li		$t0, 0			

initialise_board__for_row_cond:
	
		bge		$t0, BOARD_SIZE, initialise_board__for_row_exit		# if (row >= BOARD_SIZE) goto print_board__for_row_post;

initialise_board__for_row_body:
												

initialise_board__for_col_init:
	
		li 		$t1, 0 

initialise_board__for_col_cond:
	
		bge 	$t1, BOARD_SIZE, initialise_board__for_col_exit


initialise_board__for_col_body:

		mul		$t2, $t0, BOARD_SIZE			# this is setting the size of the board, setting space equivalent to number of rows * board size
		add		$t2, $t2, $t1					# adding on another column in the space provided    
		mul		$t2, $t2, 1						# multiply by size of char = board[row][column]
		li 		$t3, EMPTY						# storing EMPTY in $t3 
		add 	$t4, $s0, $t2					# board[row][column] = EMPTY

		sb 		$t3, ($t4)						

	
initialise_board__for_col_exitpoint:
	
		addi 	$t1, $t1, 1					# col++; 
	
		b 		initialise_board__for_col_cond

initialise_board__for_col_exit:

initialise_board_for_row_exitpoint:
	
		addi	$t0, $t0, 1					# row++;
	
		b		initialise_board__for_row_cond			# goto print_board__for_row_cond;

initialise_board__for_row_exit:

initialise_board__epilogue:

		pop 	$s0 
		pop 	$ra
		end
	
		jr		$ra		# return;


################################################################################
# .TEXT <setup_boards>
.text
setup_boards:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $a1]
	# Clobbers: [$a0, $a1]
	#
	# Locals:
	#   - $a0: saved *board
	#	- $a1: saved *player_name
	#
	# Structure:
	#   setup_boards
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

setup_boards__prologue:

		begin
		push 	$ra


setup_boards__body:


		la 		$a0, blue_board
		la 		$a1, blue_player_name_str
    	jal 	setup_board

		la 		$a0, red_board
		la 		$a1, red_player_name_str
		jal 	setup_board


setup_boards__epilogue:

		pop 	$ra 
		end

		jr		$ra		# return;


################################################################################
# .TEXT <setup_board>
.text
setup_board:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#   - $a1: char *player
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1]
	# Uses:     [$s0, $s1, $a0, $a1, $v0]
	# Clobbers: [$a0, $a1, $v0]
	#
	# Locals:
	#   - $s0: # storing board in s0
	#   - $s1: # storing player name string in s1
	#
	# Structure:
	#   setup_board
	#   -> [prologue]
	#   -> body
	#   	-> setup_board__place_ships_string
	#   	-> setup_board__place_ship_call
	#   	-> setup_board__final_board_string
	#   	-> setup_board__final_board   	
	#   -> [epilogue]

setup_board__prologue:

		begin
		push 	$ra 
		push 	$s0
		push	$s1 

setup_board__body:
	
		move 	$s0, $a0					# storing board in s0. 
		move 	$s1, $a1					# storing player name string in s1. 
	
setup_board__place_ships_string: 
	
		li 		$v0, 4						# printf("%s, place your ships!\n", player);
		move 	$a0, $s1 
		syscall

		la 		$a0, place_ships_str			
		li 		$v0, 4
		syscall
	

setup_board__place_ship_call: 


		move 	$a0, $s0 					# place_ship(board, CARRIER_LEN, CARRIER_SYMBOL);
		li 		$a1, CARRIER_LEN				
		la 		$a2, CARRIER_SYMBOL
		
		jal 	place_ship			

		move 	$a0, $s0 					# place_ship(board, BATTLESHIP_LEN, BATTLESHIP_SYMBOL);
		li 		$a1, BATTLESHIP_LEN			
		la 		$a2, BATTLESHIP_SYMBOL
		
		jal 	place_ship

		move 	$a0, $s0 					# place_ship(board, DESTROYER_LEN, DESTROYER_SYMBOL);
		li 		$a1, DESTROYER_LEN			
		la 		$a2, DESTROYER_SYMBOL
		
		jal 	place_ship

		move 	$a0, $s0 					# place_ship(board, SUBMARINE_LEN, SUBMARINE_SYMBOL);
		li 		$a1, SUBMARINE_LEN			
		la 		$a2, SUBMARINE_SYMBOL
		
		jal 	place_ship

		move 	$a0, $s0 					# place_ship(board, PATROL_BOAT_LEN, PATROL_BOAT_SYMBOL);
		li 		$a1, PATROL_BOAT_LEN			
		la 		$a2, PATROL_BOAT_SYMBOL
		
		jal 	place_ship

setup_board__final_board_string:

		li 		$v0, 4
		move 	$a0, $s1 
		syscall

		la 		$a0, your_final_board_str
		li 		$v0, 4
		syscall


setup_board__final_board: 
	
		move 	$a0, $s0
		jal 	print_board					# calling print_board function


setup_board__epilogue:

		pop 	$s1
		pop 	$s0 
		pop 	$ra 
		end

		jr		$ra							# return;


################################################################################
# .TEXT <place_ship>
.text
place_ship:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#   - $a1: int  ship_len
	#   - $a2: char ship_type
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3, $s4, $s5, $s6]
	# Uses:     [$s0, $s1, $s2, $s3, $s4, $s5, $s6, $t0, $t1, $t2, $t3, $a0, $a2]
	# Clobbers: [...]
	#
	# Locals:
	#   - $t0: when $t0 = 1 break for loop
	# 	- $s0: is board
	# 	- $s1: ship length
	# 	- $s1: ship type
	# 	- $s3: is start.row
	# 	- $s4: is start.col
	#	- $t3: is direction_char
	#	- $s5: end.row
	#	- $s6: end.col
	#
	# Structure:
	#   place_ship
	#   -> [prologue]
	#   -> body
	#  		-> place_ship__for_loop_init
	#   	-> place_ship__for_loop_cond
	#   	-> place_ship__for_loop
	#   		-> place_ship__print_current_board
	#   		-> place_ship__print_placing_ship
	#   		-> place_ship__get_starting_coord
	#   		-> place_ship__check_coordinates_out_of_bounds_start
	#			-> place_ship__get_direction
	#   		-> place_ship__get_end_row_col
	#   		-> place_ship_end_row_OR_col_invalid
	#   			-> place_ship_end_row_OR_col_invalid_end
	#   		-> place_ship__check_coordinates_out_of_bounds_end
	#			-> place_ship__row_compare_cond
	#   			-> place_ship__row_compare
	#   		-> place_ship__col_compare_cond
	#   			-> place_ship__col_compare
	#   		-> place_ship__col_compare_exit
	#   		-> place_ship__exit_for_loop
	#   -> [epilogue]

place_ship__prologue:

		begin
		push 	$ra 
		push 	$s0							# s0 = board
		push 	$s1							# s1 = ship length
		push 	$s2 						# s2 = ship type 
		push 	$s3 						# s3 = start.row
		push 	$s4							# s4 = start.col
		push 	$s5							# s5 = end.row
		push	$s6							# s6 = end.row

place_ship__body:

		move 	$s0, $a0 					# board stored in $s0 
		move 	$s1, $a1 					# store ship length, $s1
		move 	$s2, $a2 					# store ship type, $s2 

place_ship__for_loop_init: 

		li 		$t0, 0; 


place_ship__for_loop_cond:
	
		beq 	$t0, 1, place_ship__exit_for_loop	

place_ship__for_loop: 


place_ship__print_current_board: 


		la 		$a0, your_curr_board_str
		li 		$v0, 4
		syscall

		move 	$a0, $s0
		jal 	print_board					# calling print_board function

	
place_ship__print_placing_ship: 

		la 		$a0, ship_input_info_1_str	#  printf("Placing ship type %c, with length %d.\n", ship_type, ship_len);
		li 		$v0, 4
		syscall

		move 	$a0, $s2 					# printing ship_type 
		li 		$v0, 11
		syscall 

		la 		$a0, ship_input_info_2_str	#  printf("Placing ship type %c, with length %d.\n", ship_type, ship_len);
		li 		$v0, 4
		syscall

		move 	$a0, $s1 					# printing ship_length
		li 		$v0, 1 
		syscall 

		la 		$a0, ship_input_info_3_str
		li 		$v0, 4
		syscall


place_ship__get_starting_coord: 


		la 		$a0, enter_start_row_str	# Enter starting row
		li 		$v0, 4
		syscall

		li 		$v0, 5						# scanf("%d", &start.row)   
		syscall

		la 		$s3, start 
		sw 		$v0, 0($s3)		


		la 		$a0, enter_start_col_str	# Enter starting column
		li 		$v0, 4
		syscall

		li 		$v0, 5
		syscall

		la 		$s4, start 	
		sw 		$v0, 4($s4)					# column is just offset by 4, stored in $s4 register 

place_ship__check_coordinates_out_of_bounds_start: 


place_ship__get_direction:  

		la 		$a0, enter_direction_str	# printf("Enter direction (U, D, L, R): ");
		li 		$v0, 4
		syscall

		li 		$v0, 12 					# scanf(" %c", &direction_char);
		syscall

		move 	$t3, $v0 					# $t3 = direction char

place_ship__get_end_row_col:

		lw 		$a0, ($s3)					# $a0 = start row 
		move 	$a1, $t3					# $a1 = char direction
		move 	$a2, $s1 					# $a2 = int ship length 
		

		jal 	get_end_row

		
		la 		$s5, end 	
		sw 		$v0, 0($s5)		


		lw 		$a0, 4($s4)					# $a0 = start col 
		move 	$a1, $t3					# $a1 = char direction
		move 	$a2, $s1 					# $a2 = int ship length 
		
		jal 	get_end_col

		la 		$s6, end 		
		sw 		$v0, 4($s6) 				# end col = $v0 

	
place_ship_end_row_OR_col_invalid: 

		# if (end.row == INVALID || end.col == INVALID) {


		beq 	$s5, INVALID, place_ship_end_row_OR_col_invalid_end
		beq 	$s6, INVALID, place_ship_end_row_OR_col_invalid_end

		j		place_ship__check_coordinates_out_of_bounds_end				

place_ship_end_row_OR_col_invalid_end: 

		la 		$a0, invalid_direction_str	# printf("Invalid direction. Try again.\n");
		li 		$v0, 4
		syscall
	

place_ship__check_coordinates_out_of_bounds_end: 

	

place_ship__row_compare_cond:

		lw 		$t0, ($s3)					# start.row
		lw 		$t1, ($s5)					# end.row

		bgt 	$t1, $t0, place_ship__col_compare_cond  				

place_ship__row_compare:
	
		move 	$t6, $s3 					# int temp = start.row
		move 	$s3, $s5 					# start.row = end.row
		move 	$s5, $t6 					# end.row = temp

place_ship__col_compare_cond:

		lw 		$t1, 4($s4) 				#load $s4 into $t1 = start.col 
		lw 		$t2, 4($s6) 				#load $s6 into $t2 = end.col 

		bgt 	$t2, $t1, place_ship__col_compare_exit					



place_ship__col_compare:

		move 	$t6, $s4						# int temp = start.col
		move	$s4, $s6 						# start.col = end.col 	
		move 	$s6, $t6 						# end.col = temp


place_ship__col_compare_exit:

		li 		$t0, 1; 						# exitpoint for loop

		jal 	place_ship__for_loop_cond

place_ship__exit_for_loop: 

	
	
		move 	$a0, $s0 					# $a0 = board
		move 	$a2, $s2					# $a2 = ship_type
		move 	$t1, $s3 					# $t1 = $s3 = start.row
		move 	$t2, $s4 					# $t2 = $s4 = start.col
		move 	$t6, $s5 					# $t6 = $s5 = end.row 
		move 	$t5, $s6					# end col

		jal 	place_ship_on_board
	

place_ship__epilogue:

		pop 	$s6 
		pop 	$s5
		pop 	$s4
		pop 	$s3
		pop 	$s2
		pop 	$s1
		pop 	$s0
		pop 	$ra 
		end

		jr	$ra		# return;


################################################################################
# .TEXT <is_coord_out_of_bounds>
.text
is_coord_out_of_bounds:
	# Args:
	#   - $a0: point_t *coord
	#
	# Returns:
	#   - $v0: bool
	#
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   is_coord_out_of_bounds
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

is_coord_out_of_bounds__prologue:

is_coord_out_of_bounds__body:
	# TODO: add your code for the `is_coord_out_of_bounds` function here

is_coord_out_of_bounds__epilogue:
	jr	$ra		# return;


################################################################################
# .TEXT <is_overlapping>
.text
is_overlapping:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#
	# Returns:
	#   - $v0: bool
	#
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   is_overlapping
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

is_overlapping__prologue:

is_overlapping__body:
	# TODO: add your code for the `is_overlapping` function here

is_overlapping__epilogue:
	jr	$ra		# return;


################################################################################
# .TEXT <place_ship_on_board>
.text
place_ship_on_board:
	# This function is for the most part implemented however it does not call overlapping ships or coordinates out of bounds - ran out of time :( 
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#   - $a2: char ship_type
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3, $s4, $s5]
	# Uses:     [$s0, $s1, $s2, $s3, $s4, $s5, $a0, $a2 $t1, $t2, $t3, $t6, $v0]
	# Clobbers: [$a0, $a2 $t1, $t2, $t3, $t6, $v0]
	#
	# Locals:
	#   - $t1: $t1 is start.row
	# 	- $s4: $t2 is start.col
	#	- $t4: end.row
	#	- $t5: end.col
	#
	#
	# Structure:
	#   place_ship_on_board
	#   -> [prologue]
	#   -> body
	#   	-> place_ship_on_board__if_cond
	#   		-> place_ship_on_board__if_body
	#   			-> place_ship_on_board_for_loop_horizontal_init
	#   			-> place_ship_on_board_for_loop_horizontal_cond
	#   				-> place_ship_on_board_for_loop_horizontal_body
	#   			-> place_ship_on_board_for_loop_horizontal_exitpoint
	#   			-> place_ship_on_board_for_loop_horizontal_exit
	#   		-> place_ship_on_board_else_body
	#   			-> place_ship_on_board_for_loop_vertical_init
	#   			-> place_ship_on_board_for_loop_vertical_cond
	#   				-> place_ship_on_board_for_loop_vertical_body
	#   			-> place_ship_on_board_for_loop_vertical_exitpoint
	#   			-> place_ship_on_board_for_loop_vertical_exit
	#   -> [epilogue]

place_ship_on_board__prologue:

		push 	$ra 
		push	$s0 					
		push 	$s1
		push 	$s2
		push 	$s3 
		push 	$s4 
		push 	$s5

		move 	$s0, $a0				# board
		move 	$s1, $a2				# ship_type
		move 	$s2, $t1				# start row
		move 	$s3, $t2				# start col
		move 	$s4, $t6				# end row
		move 	$s5, $t5				# end col
		
	

place_ship_on_board__body:			

place_ship_on_board__if_cond:

		lw 		$t0, ($s2)
		lw 		$t1, ($s4) 

		bne 	$t0, $t1, place_ship_on_board_else_body  	

place_ship_on_board__if_body: 

place_ship_on_board_for_loop_horizontal_init:

		lw 		$t0, 4($s3)					# loading start column into $t0, int col = start.col			
		lw 		$t6, 4($s5)					# loading end column into $t4 l = end.col

place_ship_on_board_for_loop_horizontal_cond: 

place_ship_on_board_for_loop_horizontal_body: 

		bgt 	$t0, $t6, place_ship_on_board_for_loop_horizontal_exit # col <= end.col
		
		# row major = bassAddr + (rowIndex * colSize + ColIndex) * Datasize 

		lw 		$t1, ($s2)					# $t1 should be equal to the start.row [start.row]
		mul 	$t2, $t1, BOARD_SIZE		# $t2 = rowIndex * colSize 
		add 	$t2, $t2, $t0				# $t0					# column index, should be equal to [col]
		add 	$t3, $s0, $t2				# base address

											
		sb 		$s1, ($t3)					# setting board[row][col] = ship_type


place_ship_on_board_for_loop_horizontal_exitpoint: 
	
		addi 	$t0, $t0, 1					# col++ 

		jal 	place_ship_on_board_for_loop_horizontal_cond

place_ship_on_board_for_loop_horizontal_exit: 

		jal 	place_ship_on_board__epilogue


place_ship_on_board_else_body: 	


place_ship_on_board_for_loop_vertical_init:

		# 	$s0,							# board
		#	$s1,							# ship_type
		#	$s2,							# start row
		#	$s3,							# start col
		#	$s4,							# end row
		#	$s5,							# end col

		lw 		$t0, ($s2)					# loading start row into $t0, int row = start.row			
		lw 		$t6, ($s4)					# loading end row into $t4 l = end.row

place_ship_on_board_for_loop_vertical_cond: 

		bgt 	$t0, $t6, place_ship_on_board_for_loop_vertical_exit 


place_ship_on_board_for_loop_vertical_body: 

	# col major = (rowIndex * colSize + start.col) + base address 


		lw 		$t1, 4($s3)					# start.col

		mul 	$t2, $t0, BOARD_SIZE		# (rowIndex * colSize)
		add 	$t3, $t2, $t1				# (rowIndex * colSize) + row index 
		add 	$t3, $s0, $t3 				# base address + (column index * rowSize) + row index
										 
		sb 		$s1, ($t3)					# ship type
	

place_ship_on_board_for_loop_vertical_exitpoint: 
	
		addi 	$t0, $t0, 1					# col++ 

		jal 	place_ship_on_board_for_loop_vertical_cond

place_ship_on_board_for_loop_vertical_exit: 

place_ship_on_board__epilogue:

		pop 	$s5 
		pop		$s4
		pop 	$s3
		pop 	$s2
		pop 	$s1
		pop 	$s0 
		pop 	$ra 

		jr		$ra		# return;


################################################################################
# .TEXT <play_game>
.text
play_game:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $v0, $s0, $s1, $s2]
	# Clobbers: [$a0, $v0]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   play_game
	#   -> [prologue]
	#   -> body
	#   	-> play_game_while_loop
	#   	-> play_game_while_loop_exit
	#   	-> play_game_if_statement
	#   	-> play_game_else_statement
	#   -> [epilogue]

play_game__prologue:

		begin 
		push 	$ra 
		push 	$s0 
		push 	$s1 
		push 	$s2 

play_game__body:

	# WINNER_NONE = 0 
	# WINNER_BLUE/RED = 1 
	# WINNER_RED = 2 
	
								
		li 		$s0, 0 						# int winner = WINNER_NONE
		li 		$s1, 0 
	

play_game_while_loop: 

		# if winner != WINNER_NONE, continue while loop. Break if not
	
		bne 	$s1, $s0, play_game_while_loop_exit 

		jal 	play_turn					# play_turn(); 
		jal 	check_winner 
		
		move 	$s1, $v0 					# winner = check_winner(); 

		j 	play_game_while_loop


play_game_while_loop_exit: 


play_game_if_statement: 

		li 		$s2, 2						# $s2 = WINNER_RED 

		# if winner != WINNER RED, jump to else statement 

		bne 	$s1, $s2, play_game_else_statement			
		
		la 		$a0, red_wins_str			# printf("RED wins!\n");
		li 		$v0, 4 
		syscall

		j 		play_game__epilogue 

play_game_else_statement: 

		la 		$a0, blue_wins_str			# printf("BLUE wins!\n")
		li 		$v0, 4 
		syscall

play_game__epilogue:

		pop 	$s2 
		pop 	$s1 
		pop 	$s0
		pop 	$ra 
		end 


		jr		$ra							# return;


################################################################################
# .TEXT <play_turn>
.text
play_turn:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3]
	# Uses:     [$s0, $s1, $s2, $s3, $t0, $a0, $v0]
	# Clobbers: [$t0, $a0, $v0]
	#
	# Locals:
	#   - $t0: load whose turn 
	#	- $s1: row target
	#	- $s2: column target
	#	- $s3: hit status
	#
	# Structure:
	#   play_turn
	#   -> [prologue]
	#   -> body
	#   	-> play_turn__if_blues_turn
	#   	-> play_turn__if_reds_turn
	#   	-> play_turn__enter_coordinates
	#   	-> play_turn__invalid_coordinates
	# 		-> play_turn__hit_status_if_blue
	#		-> play_turn__hit_status_if_red
	# 		-> play_turn__hit_status_if_invalid
	#		-> play_turn__hit_status_if_hit
	#   -> [epilogue]

play_turn__prologue:

		begin 
		push 	$ra 
		push 	$s0
		push 	$s1 
		push 	$s2
		push 	$s3 						# int hit status 

play_turn__body:

play_turn__if_blues_turn: 


		# if whose_turn != BLUE, play reds turn

		lb		$t0, whose_turn	
		bne		$t0, BLUE, play_turn__if_reds_turn	  

		la 		$a0, blue_turn_str
		li 		$v0, 4 
		syscall

		la 		$a0, blue_view
		jal 	print_board	
		
		j 		play_turn__enter_coordinates

play_turn__if_reds_turn: 

		la 		$a0, red_turn_str
		li 		$v0, 4 
		syscall
		
		la 		$a0, red_view							
		jal 	print_board	

play_turn__enter_coordinates: 

		# Receiving target row 
		
		la 		$a0, enter_row_target_str
		li 		$v0, 4
		syscall

		li 		$v0, 5						# scanf("%d", &target.row) 			
		syscall

		la 		$s1, target 
		sw 		$v0, 0($s1)	

		# Receiving target column 

		la 		$a0, enter_col_target_str
		li 		$v0, 4 
		syscall

		li 		$v0, 5						# scanf("%d", &target.col) 			
		syscall

		la 		$s2, target 
		sw 		$v0, 4($s2)	


play_turn__invalid_coordinates: 

play_turn__hit_status_if_blue: 

		li 		$s3, 0 						# hit status 

		# if whose_turn != BLUE jump to play_turn_hit_status 

		lb		$t0, whose_turn	
		bne		$t0, BLUE, play_turn__hit_status_if_red				

		la 		$a0, red_board
		la 		$a1, blue_view 

		move 	$a2, $s1					# target.row
		move 	$a3, $s2					# target.col 

		jal 	perform_hit 

		move 	$s3, $v0 

		j 		play_turn__hit_status_if_invalid

play_turn__hit_status_if_red: 

		la 		$a0, blue_board
		la 		$a1, red_view 

		jal 	perform_hit 

		move 	$s3, $v0 

play_turn__hit_status_if_invalid:

		bne		$s3, INVALID, play_turn__hit_status_if_hit

		la 		$a0, invalid_coords_already_hit_str
		li 		$v0, 4 
		syscall
		
		j 		play_turn_swap_turn			


play_turn__hit_status_if_hit: 

		bne		$s3, HIT, play_turn_end

		la 		$a0, hit_successful_str
		li 		$v0, 4 
		syscall

		j 		play_turn_swap_turn

play_turn_end: 

	
		la 		$a0, you_missed_str
		li 		$v0, 4 
		syscall

play_turn_swap_turn: 

		jal swap_turn 
		
	

play_turn__epilogue:
	
		pop 	$s3 
		pop 	$s2 
		pop 	$s1
		pop 	$s0 
		pop 	$ra
		end

		jr		$ra							# return 0;
	


################################################################################
# .TEXT <perform_hit>
.text
perform_hit:
	# Args:
	#   - $a0: char their_board[BOARD_SIZE][BOARD_SIZE]
	#   - $a1: char our_view[BOARD_SIZE][BOARD_SIZE]
	#	- $a2: target.row 
	#	- $a3: target.col 
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3]
	# Uses:     [$s0, $s1, $s2, $s3, $a0, $a1, $a2, $a3]
	# Clobbers: [...]
	#
	# Locals:
	#   - 
	#
	# Structure:
	#   perform_hit
	#   -> [prologue]
	#   -> body
	#		-> perform_hit__initialise 
	#   	-> perform_hit__invalid
	#   	-> perform_hit__hit
	#   	-> perform_hit__miss
	#   -> [epilogue]

perform_hit__prologue:

		push 	$ra 
		push 	$s0
		push 	$s1
		push 	$s2 
		push 	$s3
		push 	$s4 						# target cell 

		move 	$s0, $a0 					# their board
		move 	$s1, $a1 					# our view
		move 	$s2, $a2					# target.row 
		move 	$s3, $a3 					# target.col 


perform_hit__body:
	
perform_hit__initialise: 

		# this chunk of code is finding the coordinates on the *our_view* board 

		# CHANGE $t7 and $t6 to control coordinates. 

		lw 		$t6,($s2) 					# = target.row 
		lw 		$t7, 4($s3)					# = target.col

		mul 	$t2, $t6, BOARD_SIZE		# $t2 = rowIndex * colSize 
		add 	$t2, $t2, $t7				# $t2 = (rowIndex * colSize) + start.col
		mul 	$t2, $t2, 1
		add 	$t3, $s1, $t2				# $t3 = (rowIndex * colSize) + start.col + our_view 

perform_hit__invalid: 
 
		lb 		$s4, ($t3) 

		# if our_view[target.row][target.col] == EMPTY, go to perform hit

		beq 	$s4, EMPTY, perform_successful__hit_initialise		
		
		la 		$v0, INVALID

		j 		perform_hit__epilogue


perform_successful__hit_initialise: 

		# CHANGE $t7 and $t6 to control coordinates. 

		# initialising their_board for hit. 

		lw 		$t6,($s2) 					# = target.row 
		lw 		$t7, 4($s3)					# = target.col

		mul 	$t2, $t6, BOARD_SIZE		# $t2 = rowIndex * colSize 
		add 	$t2, $t2, $t7				# $t2 = (rowIndex * colSize) + start.col 
		mul 	$t2, $t2, 1
		add 	$t3, $s0, $t2				# $t3 = (rowIndex * colSize) + start.col + their_board

		lb 		$s4, ($t3)  

		# if their_board[target.row][target.col] == EMPTY, go to perform_hit__miss
		# it means that no target was found and it should be recorded as a miss. 

		beq 	$s4, EMPTY, perform_hit__miss	
											


		lw 		$t6,($s2) 					# = target.row 
		lw 		$t7, 4($s3)					# = target.col

		mul 	$t2, $t6, BOARD_SIZE		# $t2 = rowIndex * colSize 
		add 	$t2, $t2, $t7				# $t2 = (rowIndex * colSize) + start.col
		mul 	$t2, $t2, 1
		add 	$t3, $s1, $t2				# $t3 = (rowIndex * colSize) + start.col + our_view 

		li 		$t5, HIT 
		sb 		$t5, ($t3) 					# saving hit at coordinates

		la 		$v0, HIT

		j 		perform_hit__epilogue 

perform_hit__miss: 


		lw 		$t6,($s2) 					# = target.row 
		lw 		$t7, 4($s3)					# = target.col

		mul 	$t2, $t6, BOARD_SIZE		# $t2 = rowIndex * colSize 
		add 	$t2, $t2, $t7				# $t2 = (rowIndex * colSize) + start.col
		mul 	$t2, $t2, 1
		add 	$t3, $s1, $t2				# $t3 = (rowIndex * colSize) + start.col + our_view 

		li 		$t5, MISS 
		sb 		$t5, ($t3) 					# saving hit at coordinates

		la 		$v0, MISS 

perform_hit__epilogue:

		pop 	$s4 
		pop 	$s3 
		pop 	$s2 
		pop		$s1 
		pop 	$s0
		pop 	$ra 
		
		jr		$ra							# return;


################################################################################
# .TEXT <check_winner>
.text
check_winner:
	# Args:	    void
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   check_winner
	#   -> [prologue]
	#   -> body
	#   	-> check_winner__blue
	#   	-> check_winner__red
	#   	-> check_winner__none
	#   -> [epilogue]

check_winner__prologue:

		begin
		push 	$ra 
		push 	$s0


check_winner__body:	

	
		# 0 = No winner yet 
		# 1 = Winner Blue
		# 2 = Winner Red 

check_winner__blue: 

		la 		$a0, red_board
		la 		$a1, blue_view


		jal 	check_player_win

		move 	$t0, $v0					# $t0 = returned value from check_player_win 

		# TRUE = 1
		# FALSE = 0 

		bne 	$t0, 1, check_winner__red 	# if $t0 != TRUE jump to check winner red 

		li 		$v0, 1 						# return winner_blue 
		j 		check_winner__epilogue

check_winner__red: 

		la 		$a0, blue_board
		la 		$a1, red_view

		jal 	check_player_win

		move 	$t0, $v0					# $t0 = returned value from check_player_win 

		# TRUE = 1
		# FALSE = 0 

		bne 	$t0, 1, check_winner__none	# if $t0 != TRUE jump to check winner none 

		li 		$v0, 2 						# return winner_red
		j 		check_winner__epilogue


check_winner__none: 

	
		li 		$v0, 0						# return winner_none

	

check_winner__epilogue:

		pop 	$s0 
		pop 	$ra
		end 

		jr		$ra		# return;


################################################################################
# .TEXT <check_player_win>
.text
check_player_win:
	# This function has issues in determining when exactly a player has won. 
	# It normally allows a game to play out indefinitely in an infinite loop
	# For submission I have overrided this so that a winner is determined almost immediately. 
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] their_board
	#   - $a1: char[BOARD_SIZE][BOARD_SIZE] our_view
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $a1, $v0]
	# Clobbers: [...]
	#
	# Locals:
	#   - $t0, row index 
	# 	- $t1, col index 
	#
	# Structure:
	#   check_player_win
	#   -> [prologue]
	#   -> body
	#   	-> check_player_win__row_for_loop_init
	#   	-> check_player_win__row_for_loop_cond
	#   	-> check_player_win__row_for_loop_body
	#   		-> check_player_win__col_for_loop_init
	#   		-> check_player_win__col_for_loop_cond
	#   		-> check_player_win__col_for_loop_body
	#   			-> check_player_win__checking_non_hit_ship
	#					-> check_player_win__return_false
	#   		-> check_player_win__col_for_loop_exitpoint
	#   		-> check_player_win__col_for_loop_exit
	#   	-> check_player_win__col_for_loop_exitpoint
	#		-> check_player_win__col_for_loop_exit
	#		-> check_player_win__return_true
	#   -> [epilogue]

check_player_win__prologue:

		begin 
		push 	$ra 
		push 	$s0
		push 	$s1 
		push 	$s2 
		push 	$s3 
		
		move $s0, $a0 						# $s0 = their_board
		move $s1, $a1 						# $s1 = our_view

		# TRUE = 1
		# FALSE = 0 
		# s2 = current coordinates of their board
		# s3 = current coordinates of our_view 

check_player_win__body:

check_player_win__row_for_loop_init:
		li		$t0, 0	

check_player_win__row_for_loop_cond:
		
		bge		$t0, BOARD_SIZE, check_player_win__row_for_loop_exit

	

check_player_win__row_for_loop_body: 


check_player_win__col_for_loop_init:
		li 		$t1, 0 

check_player_win__col_for_loop_cond:
	
		bge 	$t1, BOARD_SIZE, check_player_win__col_for_loop_exit


check_player_win__col_for_loop_body: 

		mul		$t2, $t0, BOARD_SIZE		# this checks their board. 
		add		$t2, $t2, $t1					    
		mul		$t2, $t2, 1												
		add 	$t4, $s0, $t2			

		lb 		$s2, ($t4) 					# current coordinates of their_board


		mul		$t2, $t0, BOARD_SIZE		# this checks our view. 
		add		$t2, $t2, $t1					    
		mul		$t2, $t2, 1												
		add 	$t4, $s1, $t2		

		lb 	$s3, ($t4) 						# current coordinates of our_view 


check_player_win__checking_non_hit_ship: 

		# if their_board == EMPTY, go to the end. 		i.e. if their board[row][col] != EMPTY 
		# if our view != EMPTY, go to return false 		i.e. && if our view[row][col] == EMPTY 
		# else return true 

		# their_board[row][column] == EMPTY execute code else their_board[row][column] != EMPTY jump to next condition 	

		beq 	$s2, EMPTY, next_if_statement					


		j 		check_player_win__col_for_loop_exitpoint

next_if_statement: 

		# our_view[row][column] != EMPTY execute code else our_view[row][column] == EMPTY jump to return false	

		bne 	$s3, EMPTY, check_player_win__return_false

	
		j 	check_player_win__col_for_loop_exitpoint
									
	
check_player_win__return_false:  


		li 		$v0, 0 						# FALSE = 0 

		j check_player_win__epilogue

check_player_win__col_for_loop_exitpoint: 

		addi 	$t1, $t1, 1 
	
		j check_player_win__col_for_loop_cond

check_player_win__col_for_loop_exit: 

check_player_win__row_for_loop_exitpoint:
	
		addi 	$t0, $t0, 1 
		
		j check_player_win__row_for_loop_cond

check_player_win__row_for_loop_exit:

check_player_win__return_true: 

		li 		$v0, 1 						# TRUE = 1 


check_player_win__epilogue:
	
		pop 	$s3
		pop 	$s2 
		pop 	$s1 
		pop 	$s0
		pop 	$ra
		end 

		jr		$ra							# return;


################################################################################
################################################################################
###                 PROVIDED FUNCTIONS — DO NOT CHANGE THESE                 ###
################################################################################
################################################################################


################################################################################
# .TEXT <print_board>
# YOU DO NOT NEED TO CHANGE THE PRINT_BOARD FUNCTION
.text
print_board:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0]
	# Uses:     [$a0, $v0, $t0, $t1, $t2, $t3, $t4, $s0]
	# Clobbers: [$a0, $v0, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:
	#   - $s0: saved $a0
	#   - $t0: col, row
	#   - $t1: col
	#   - $t2: [row][col]
	#   - $t3: &board[row][col]
	#   - $t4: board[row][col]
	#
	# Structure:
	#   print_board
	#   -> [prologue]
	#   -> body
	#      -> for_header_init
	#      -> for_header_cond
	#      -> for_header_body
	#      -> for_header_step
	#      -> for_header_post
	#      -> for_row_init
	#      -> for_row_cond
	#      -> for_row_body
	#         -> for_col_init
	#         -> for_col_cond
	#         -> for_col_body
	#         -> for_col_step
	#         -> for_col_post
	#      -> for_row_step
	#      -> for_row_post
	#   -> [epilogue]

print_board__prologue:
	begin							# begin a new stack frame
	push	$ra						# | $ra
	push	$s0						# | $s0

print_board__body:
	move 	$s0, $a0

	li	$v0, 11						# syscall 11: print_char
	la	$a0, ' '					#
	syscall							# printf("%c", ' ');
	syscall							# printf("%c", ' ');

print_board__for_header_init:
	li	$t0, 0						# int col = 0;

print_board__for_header_cond:
	bge	$t0, BOARD_SIZE, print_board__for_header_post	# if (col >= BOARD_SIZE) goto print_board__for_header_post;

print_board__for_header_body:
	li	$v0, 1						# syscall 1: print_int
	move	$a0, $t0					#
	syscall							# printf("%d", col);

	li	$v0, 11						# syscall 11: print_char
	li	$a0, ' '					#
	syscall							# printf("%c", ' ');

print_board__for_header_step:
	addiu	$t0, 1						# col++;
	b	print_board__for_header_cond

print_board__for_header_post:
	li	$v0, 11						# syscall 11: print_char
	la	$a0, '\n'					#
	syscall							# printf("%c", '\n');

print_board__for_row_init:
	li	$t0, 0						# int row = 0;

print_board__for_row_cond:
	bge	$t0, BOARD_SIZE, print_board__for_row_post	# if (row >= BOARD_SIZE) goto print_board__for_row_post;

print_board__for_row_body:
	li	$v0, 1						# syscall 1: print_int
	move	$a0, $t0					#
	syscall							# printf("%d", row);

	li	$v0, 11						# syscall 11: print_char
	li	$a0, ' '					#
	syscall							# printf("%c", ' ');

print_board__for_col_init:
	li	$t1, 0						# int col = 0;

print_board__for_col_cond:
	bge	$t1, BOARD_SIZE, print_board__for_col_post	# if (col >= BOARD_SIZE) goto print_board__for_col_post;

print_board__for_col_body:
	mul	$t2, $t0, BOARD_SIZE				# &board[row][col] = (row * BOARD_SIZE
	add	$t2, $t2, $t1					#		      + col)
	mul	$t2, $t2, 1					# 		      * sizeof(char)
	add 	$t3, $s0, $t2					# 		      + &board[0][0]
	lb	$t4, ($t3)					# board[row][col]

	li	$v0, 11						# syscall 11: print_char
	move	$a0, $t4					#
	syscall							# printf("%c", board[row][col]);

	li	$v0, 11						# syscall 11: print_char
	li	$a0, ' '					#
	syscall							# printf("%c", ' ');

print_board__for_col_step:
	addi	$t1, $t1, 1					# col++;
	b	print_board__for_col_cond			# goto print_board__for_col_cond;

print_board__for_col_post:
	li	$v0, 11						# syscall 11: print_char
	li	$a0, '\n'					#
	syscall							# printf("%c", '\n');

print_board__for_row_step:
	addi	$t0, $t0, 1					# row++;
	b	print_board__for_row_cond			# goto print_board__for_row_cond;

print_board__for_row_post:
print_board__epilogue:
	pop	$s0						# | $s0
	pop	$ra						# | $ra
	end							# ends the current stack frame

	jr	$ra						# return;


################################################################################
# .TEXT <swap_turn>
.text
swap_turn:
	# Args:	    void
	#
	# Returns:  void
	#
	# Frame:    []
	# Uses:     [$t0]
	# Clobbers: [$t0]
	#
	# Locals:
	#
	# Structure:
	#   swap_turn
	#   -> body
	#      -> red
	#      -> blue
	#   -> [epilogue]

swap_turn__body:	
	bne	$t0, BLUE, swap_turn__blue			# if (whose_turn != BLUE) goto swap_turn__blue;

swap_turn__red:
	li	$t0, RED						# whose_turn = RED;
	sb	$t0, whose_turn					# 
	
	j	swap_turn__epilogue				# return;

swap_turn__blue:
	li	$t0, BLUE					# whose_turn = BLUE;
	sb	$t0, whose_turn					# 

swap_turn__epilogue:
	jr	$ra						# return;

################################################################################
# .TEXT <get_end_row>
.text
get_end_row:
	# Args:
	#   - $a0: int  start_row
	#   - $a1: char direction
	#   - $a2: int  ship_len
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#
	# Structure:
	#   get_end_row
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

get_end_row__prologue:
	begin							# begin a new stack frame
	push	$ra						# | $ra

get_end_row__body:
	move $v0, $a0					
	beq	$a1, 'L', get_end_row__epilogue			# if (direction == 'L') return start_row;
	beq	$a1, 'R', get_end_row__epilogue			# if (direction == 'R') return start_row;

	sub	$t0, $a2, 1
	sub	$v0, $a0, $t0
	beq	$a1, 'U', get_end_row__epilogue			# if (direction == 'U') return start_row - (ship_len - 1);

	sub	$t0, $a2, 1
	add	$v0, $a0, $t0
	beq	$a1, 'D', get_end_row__epilogue			# if (direction == 'D') return start_row + (ship_len - 1);

	li	$v0, INVALID					# return INVALID;

get_end_row__epilogue:
	pop	$ra						# | $ra
	end							# ends the current stack frame

	jr	$ra						# return;


################################################################################
# .TEXT <get_end_col>
.text
get_end_col:
	# Args:
	#   - $a0: int  start_col
	#   - $a1: char direction
	#   - $a2: int  ship_len
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#
	# Structure:
	#   get_end_col
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

get_end_col__prologue:
	begin							# begin a new stack frame
	push	$ra						# | $ra

get_end_col__body:
	move	$v0, $a0					
	beq	$a1, 'U', get_end_col__epilogue			# if (direction == 'U') return start_col;
	beq	$a1, 'D', get_end_col__epilogue			# if (direction == 'D') return start_col;

	sub	$t0, $a2, 1
	sub	$v0, $a0, $t0
	beq	$a1, 'L', get_end_col__epilogue			# if (direction == 'L') return start_col - (ship_len - 1);

	sub	$t0, $a2, 1
	add	$v0, $a0, $t0
	beq	$a1, 'R', get_end_col__epilogue			# if (direction == 'R') return start_col + (ship_len - 1);

	li	$v0, INVALID					# return INVALID;

get_end_col__epilogue:
	pop	$ra						# | $ra
	end							# ends the current stack frame

	jr	$ra						# return;

