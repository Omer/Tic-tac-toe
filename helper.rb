module Helper
	def is_numeric? n
		begin
			Float n
			true
		rescue
			false
		end
	end
end