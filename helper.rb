module Helper
	def is_numeric? num
		begin
			Float num
			true
		rescue
			false
		end
	end
end