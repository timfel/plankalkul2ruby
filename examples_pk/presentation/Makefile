all:
	ruby ../../pkc.rb -i inc.pk
	echo "\n\nputs \"* Increment function\"\nputs \"  inc(1): ( \"+Plankalkuel.p1(1)[0].to_i.to_s+\", \"+Plankalkuel.p1(1)[1].to_i.to_s+\")\"\nputs \"  inc(65535): ( \"+Plankalkuel.p1(65535)[0].to_i.to_s+\", \"+Plankalkuel.p1(65535)[1].to_i.to_s+\")\"" >> inc.rb
	ruby inc.rb
	ruby ../../pkc.rb -i maj.pk
	echo "\n\nputs \"* Major function\"\nputs \"  max(16, 18): \"+Plankalkuel.p2(16, 18).to_i.to_s\nputs \"  max(18, 16): \"+Plankalkuel.p2(18, 16).to_i.to_s\nputs \"  max(16, 16): \"+Plankalkuel.p2(16, 16).to_i.to_s" >> maj.rb
	ruby maj.rb
	ruby ../../pkc.rb -i sym.pk
	echo "\n\nputs \"* Symmetry (for 16bit numbers)\"\nputs \"  sym(0): \"+Plankalkuel.p3(0).to_i.to_s\nputs \"  sym(8): \"+Plankalkuel.p3(8).to_i.to_s" >> sym.rb
	ruby sym.rb

