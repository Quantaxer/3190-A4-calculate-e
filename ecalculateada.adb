with ada.Text_IO; use Ada.Text_IO;
with ada.integer_Text_IO; use Ada.integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with Ada.Numerics.Elementary_Functions;

procedure ecalculateada is
	numOfItems : unbounded_string;
	type unknownArray is array(integer range <>) of Integer;
	done: integer;

	-- Helper function to determine if a file exists in the local directory
	-- Param: fileName: The name of the file to check
	-- Return: boolean (true if it does exist)
	function isFileExists(fileName : unbounded_string) return boolean is
		infp: file_type;
	begin
		open(infp, in_file, to_string(fileName));
		close(infp);
		return True;
	exception
		when name_error =>
			return False;
	end isFileExists;

	-- Main function to calculate the values of e
	-- Param: n: number of digits to calculate
	-- Return: custom type of array where size is not specified. This array will have all the values filled in.
	function ecalculation(n : integer) return unknownArray is
		m, carry, temp: Integer;
		test: Float;
		d : unknownArray(0..n);
	begin
		-- Algorithm implemented here
		m := 4;
		test := (float(n) + 1.0) * 2.30258509;
		while float(m) * (Ada.Numerics.Elementary_Functions.log(float(m)) - 1.0) + 0.5 * Ada.Numerics.Elementary_Functions.log(6.2831852 * float(m)) <= test loop
			m := m + 1;
		end loop;

		-- Declare the length of the coefficient array, then using that new array perform more calculations
		declare
			coef: unknownArray (0..m - 1);
		begin
			for i in 2..m-1 loop
				coef(i) := 1;
			end loop;

			d(0) := 2;
			for i in 1..n loop
				carry := 0;
				for j in reverse 2..m-1 loop
					temp := coef(j) * 10 + carry;
					carry := temp / j;
					coef(j) := temp - carry * j;
				end loop;
				d(i) := carry;
			end loop;
		end;
		return d;
	end ecalculation;

	-- Helper function to actually calculate the digits and write to a user-specified file
	-- Param: n: The number of digits to calculate
	-- Returns: integer that lets the main program know if it completed successfully
	function calculateAndWriteToFile(n : integer) return integer is
		arrayOfDigits: unknownArray (0..n);
		outfp: file_type;
		fileName: unbounded_string;
	begin
		arrayOfDigits := ecalculation(n);

		--Get user input for filename. If file DNE create it.
		put_line("Enter the name of the file to store the value of e");
		get_line(fileName);
		if isFileExists(filename) then 
			open(outfp, out_file, to_string(fileName));
		else
			create(outfp, out_file, to_string(fileName));
		end if;

		-- Loop through array of digits and write it to a file
		for i in 0..n loop
			if i = 0 then
				-- Also write decimal point
				put (outfp, arrayOfDigits(i), 0, 10);
				put (outfp, ".");
			else
				put (outfp, arrayOfDigits(i), 0, 10);
			end if;
		end loop;
		close(outfp);
		return 1;
	end calculateAndWriteToFile;

-- Main program
begin
	put_line("Enter a positive number of decimal points to calculate for e");
	get_line(numOfItems);
	done := calculateAndWriteToFile(Integer'Value(to_string(numOfItems)));

	if done = 1 then
		put_line("Successfully calculated digits");
	end if;

end ecalculateada;
