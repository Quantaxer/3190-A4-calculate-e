with ada.Text_IO; use Ada.Text_IO;
with ada.integer_Text_IO; use Ada.integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with Ada.Numerics.Elementary_Functions;

procedure ecalculateada is
	numOfItems : unbounded_string;
	type unknownArray is array(integer range <>) of Integer;
	done: integer;

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

	function ecalculation(n : integer) return unknownArray is
		m, carry, temp: Integer;
		test: Float;
		d : unknownArray(0..n);
	begin
		m := 4;
		test := (float(n) + 1.0) * 2.30258509;
		while float(m) * (Ada.Numerics.Elementary_Functions.log(float(m)) - 1.0) + 0.5 * Ada.Numerics.Elementary_Functions.log(6.2831852 * float(m)) <= test loop
			m := m + 1;
		end loop;

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

	function calculateAndWriteToFile(n : integer) return integer is
		arrayOfDigits: unknownArray (0..n - 1);
		outfp: file_type;
		fileName: unbounded_string;
	begin
		arrayOfDigits := ecalculation(n - 1);

		put_line("Enter the name of the file to store the value of e");
		get_line(fileName);
		if isFileExists(filename) then 
			open(outfp, out_file, to_string(fileName));
		else
			create(outfp, out_file, to_string(fileName));
		end if;

		for i in 0..n - 1 loop
			if i = 0 then
				put (outfp, arrayOfDigits(i), 0, 10);
				put (outfp, ".");
			else
				put (outfp, arrayOfDigits(i), 0, 10);
			end if;
		end loop;
		close(outfp);
		return 1;
	end calculateAndWriteToFile;

begin
	put_line("Enter the number of decimal points to calculate");
	get_line(numOfItems);
	done := calculateAndWriteToFile(Integer'Value(to_string(numOfItems)));

end ecalculateada;
