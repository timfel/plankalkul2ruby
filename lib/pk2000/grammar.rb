module Pk2000
  include Treetop::Runtime

  def root
    @root || :program
  end

  module Program0
    def number
      elements[1]
    end

    def randauszug
      elements[2]
    end

    def lines
      elements[4]
    end

  end

  def _nt_program
    start_index = index
    if node_cache[:program].has_key?(index)
      cached = node_cache[:program][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index("P", index) == index
      r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("P")
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_number
      s1 << r3
      if r3
        r4 = _nt_randauszug
        s1 << r4
        if r4
          if input.index("\n", index) == index
            r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("\n")
            r5 = nil
          end
          s1 << r5
          if r5
            r6 = _nt_lines
            s1 << r6
            if r6
              if input.index("\nEND", index) == index
                r7 = instantiate_node(SyntaxNode,input, index...(index + 4))
                @index += 4
              else
                terminal_parse_failure("\nEND")
                r7 = nil
              end
              s1 << r7
            end
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(PKMethodNode,input, i1...index, s1)
      r1.extend(Program0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r8 = _nt_lines
      if r8
        r0 = r8
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:program][start_index] = r0

    return r0
  end

  module Randauszug0
    def vTuple
      elements[0]
    end

    def rTuple
      elements[2]
    end
  end

  def _nt_randauszug
    start_index = index
    if node_cache[:randauszug].has_key?(index)
      cached = node_cache[:randauszug][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_vTuple
    s0 << r1
    if r1
      if input.index("=>", index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure("=>")
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_rTuple
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Randauszug0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:randauszug][start_index] = r0

    return r0
  end

  module VTuple0
    def type
      elements[1]
    end

  end

  module VTuple1
    def type
      elements[1]
    end

    def type
      elements[3]
    end

  end

  module VTuple2
    def type
      elements[1]
    end

    def type
      elements[3]
    end

    def type
      elements[5]
    end

  end

  module VTuple3
    def type
      elements[1]
    end

    def type
      elements[3]
    end

    def type
      elements[5]
    end

    def type
      elements[7]
    end

  end

  module VTuple4
    def type
      elements[1]
    end

    def type
      elements[3]
    end

    def type
      elements[5]
    end

    def type
      elements[7]
    end

    def type
      elements[9]
    end

  end

  module VTuple5
    def type
      elements[1]
    end

    def type
      elements[3]
    end

    def type
      elements[5]
    end

    def type
      elements[7]
    end

    def type
      elements[9]
    end

    def type
      elements[11]
    end

  end

  module VTuple6
	 def toRuby
	    # only need comma-delimited list of var-names
	    masgn = text_value.gsub(/\(|\)|\[[^V]*\]/, "").downcase.split(",")
    sexp = s(:args)
	    masgn.each { |arg| sexp << arg.to_sym }
	    sexp
	 end
  end

  def _nt_vTuple
    start_index = index
    if node_cache[:vTuple].has_key?(index)
      cached = node_cache[:vTuple][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index("(V0[:", index) == index
      r2 = instantiate_node(SyntaxNode,input, index...(index + 5))
      @index += 5
    else
      terminal_parse_failure("(V0[:")
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_type
      s1 << r3
      if r3
        if input.index("])", index) == index
          r4 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("])")
          r4 = nil
        end
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(VTuple0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(VTuple6)
    else
      i5, s5 = index, []
      if input.index("(V0[:", index) == index
        r6 = instantiate_node(SyntaxNode,input, index...(index + 5))
        @index += 5
      else
        terminal_parse_failure("(V0[:")
        r6 = nil
      end
      s5 << r6
      if r6
        r7 = _nt_type
        s5 << r7
        if r7
          if input.index("],V1[:", index) == index
            r8 = instantiate_node(SyntaxNode,input, index...(index + 6))
            @index += 6
          else
            terminal_parse_failure("],V1[:")
            r8 = nil
          end
          s5 << r8
          if r8
            r9 = _nt_type
            s5 << r9
            if r9
              if input.index("])", index) == index
                r10 = instantiate_node(SyntaxNode,input, index...(index + 2))
                @index += 2
              else
                terminal_parse_failure("])")
                r10 = nil
              end
              s5 << r10
            end
          end
        end
      end
      if s5.last
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
        r5.extend(VTuple1)
      else
        self.index = i5
        r5 = nil
      end
      if r5
        r0 = r5
        r0.extend(VTuple6)
      else
        i11, s11 = index, []
        if input.index("(V0[:", index) == index
          r12 = instantiate_node(SyntaxNode,input, index...(index + 5))
          @index += 5
        else
          terminal_parse_failure("(V0[:")
          r12 = nil
        end
        s11 << r12
        if r12
          r13 = _nt_type
          s11 << r13
          if r13
            if input.index("],V1[:", index) == index
              r14 = instantiate_node(SyntaxNode,input, index...(index + 6))
              @index += 6
            else
              terminal_parse_failure("],V1[:")
              r14 = nil
            end
            s11 << r14
            if r14
              r15 = _nt_type
              s11 << r15
              if r15
                if input.index("],V2[:", index) == index
                  r16 = instantiate_node(SyntaxNode,input, index...(index + 6))
                  @index += 6
                else
                  terminal_parse_failure("],V2[:")
                  r16 = nil
                end
                s11 << r16
                if r16
                  r17 = _nt_type
                  s11 << r17
                  if r17
                    if input.index("])", index) == index
                      r18 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure("])")
                      r18 = nil
                    end
                    s11 << r18
                  end
                end
              end
            end
          end
        end
        if s11.last
          r11 = instantiate_node(SyntaxNode,input, i11...index, s11)
          r11.extend(VTuple2)
        else
          self.index = i11
          r11 = nil
        end
        if r11
          r0 = r11
          r0.extend(VTuple6)
        else
          i19, s19 = index, []
          if input.index("(V0[:", index) == index
            r20 = instantiate_node(SyntaxNode,input, index...(index + 5))
            @index += 5
          else
            terminal_parse_failure("(V0[:")
            r20 = nil
          end
          s19 << r20
          if r20
            r21 = _nt_type
            s19 << r21
            if r21
              if input.index("],V1[:", index) == index
                r22 = instantiate_node(SyntaxNode,input, index...(index + 6))
                @index += 6
              else
                terminal_parse_failure("],V1[:")
                r22 = nil
              end
              s19 << r22
              if r22
                r23 = _nt_type
                s19 << r23
                if r23
                  if input.index("],V2[:", index) == index
                    r24 = instantiate_node(SyntaxNode,input, index...(index + 6))
                    @index += 6
                  else
                    terminal_parse_failure("],V2[:")
                    r24 = nil
                  end
                  s19 << r24
                  if r24
                    r25 = _nt_type
                    s19 << r25
                    if r25
                      if input.index("],V3[:", index) == index
                        r26 = instantiate_node(SyntaxNode,input, index...(index + 6))
                        @index += 6
                      else
                        terminal_parse_failure("],V3[:")
                        r26 = nil
                      end
                      s19 << r26
                      if r26
                        r27 = _nt_type
                        s19 << r27
                        if r27
                          if input.index("])", index) == index
                            r28 = instantiate_node(SyntaxNode,input, index...(index + 2))
                            @index += 2
                          else
                            terminal_parse_failure("])")
                            r28 = nil
                          end
                          s19 << r28
                        end
                      end
                    end
                  end
                end
              end
            end
          end
          if s19.last
            r19 = instantiate_node(SyntaxNode,input, i19...index, s19)
            r19.extend(VTuple3)
          else
            self.index = i19
            r19 = nil
          end
          if r19
            r0 = r19
            r0.extend(VTuple6)
          else
            i29, s29 = index, []
            if input.index("(V0[:", index) == index
              r30 = instantiate_node(SyntaxNode,input, index...(index + 5))
              @index += 5
            else
              terminal_parse_failure("(V0[:")
              r30 = nil
            end
            s29 << r30
            if r30
              r31 = _nt_type
              s29 << r31
              if r31
                if input.index("],V1[:", index) == index
                  r32 = instantiate_node(SyntaxNode,input, index...(index + 6))
                  @index += 6
                else
                  terminal_parse_failure("],V1[:")
                  r32 = nil
                end
                s29 << r32
                if r32
                  r33 = _nt_type
                  s29 << r33
                  if r33
                    if input.index("],V2[:", index) == index
                      r34 = instantiate_node(SyntaxNode,input, index...(index + 6))
                      @index += 6
                    else
                      terminal_parse_failure("],V2[:")
                      r34 = nil
                    end
                    s29 << r34
                    if r34
                      r35 = _nt_type
                      s29 << r35
                      if r35
                        if input.index("],V3[:", index) == index
                          r36 = instantiate_node(SyntaxNode,input, index...(index + 6))
                          @index += 6
                        else
                          terminal_parse_failure("],V3[:")
                          r36 = nil
                        end
                        s29 << r36
                        if r36
                          r37 = _nt_type
                          s29 << r37
                          if r37
                            if input.index("],V4[:", index) == index
                              r38 = instantiate_node(SyntaxNode,input, index...(index + 6))
                              @index += 6
                            else
                              terminal_parse_failure("],V4[:")
                              r38 = nil
                            end
                            s29 << r38
                            if r38
                              r39 = _nt_type
                              s29 << r39
                              if r39
                                if input.index("])", index) == index
                                  r40 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                  @index += 2
                                else
                                  terminal_parse_failure("])")
                                  r40 = nil
                                end
                                s29 << r40
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
            if s29.last
              r29 = instantiate_node(SyntaxNode,input, i29...index, s29)
              r29.extend(VTuple4)
            else
              self.index = i29
              r29 = nil
            end
            if r29
              r0 = r29
              r0.extend(VTuple6)
            else
              i41, s41 = index, []
              if input.index("(V0[:", index) == index
                r42 = instantiate_node(SyntaxNode,input, index...(index + 5))
                @index += 5
              else
                terminal_parse_failure("(V0[:")
                r42 = nil
              end
              s41 << r42
              if r42
                r43 = _nt_type
                s41 << r43
                if r43
                  if input.index("],V1[:", index) == index
                    r44 = instantiate_node(SyntaxNode,input, index...(index + 6))
                    @index += 6
                  else
                    terminal_parse_failure("],V1[:")
                    r44 = nil
                  end
                  s41 << r44
                  if r44
                    r45 = _nt_type
                    s41 << r45
                    if r45
                      if input.index("],V2[:", index) == index
                        r46 = instantiate_node(SyntaxNode,input, index...(index + 6))
                        @index += 6
                      else
                        terminal_parse_failure("],V2[:")
                        r46 = nil
                      end
                      s41 << r46
                      if r46
                        r47 = _nt_type
                        s41 << r47
                        if r47
                          if input.index("],V3[:", index) == index
                            r48 = instantiate_node(SyntaxNode,input, index...(index + 6))
                            @index += 6
                          else
                            terminal_parse_failure("],V3[:")
                            r48 = nil
                          end
                          s41 << r48
                          if r48
                            r49 = _nt_type
                            s41 << r49
                            if r49
                              if input.index("],V4[:", index) == index
                                r50 = instantiate_node(SyntaxNode,input, index...(index + 6))
                                @index += 6
                              else
                                terminal_parse_failure("],V4[:")
                                r50 = nil
                              end
                              s41 << r50
                              if r50
                                r51 = _nt_type
                                s41 << r51
                                if r51
                                  if input.index("],V5[:", index) == index
                                    r52 = instantiate_node(SyntaxNode,input, index...(index + 6))
                                    @index += 6
                                  else
                                    terminal_parse_failure("],V5[:")
                                    r52 = nil
                                  end
                                  s41 << r52
                                  if r52
                                    r53 = _nt_type
                                    s41 << r53
                                    if r53
                                      if input.index("])", index) == index
                                        r54 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                        @index += 2
                                      else
                                        terminal_parse_failure("])")
                                        r54 = nil
                                      end
                                      s41 << r54
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
              if s41.last
                r41 = instantiate_node(SyntaxNode,input, i41...index, s41)
                r41.extend(VTuple5)
              else
                self.index = i41
                r41 = nil
              end
              if r41
                r0 = r41
                r0.extend(VTuple6)
              else
                self.index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:vTuple][start_index] = r0

    return r0
  end

  module RTuple0
    def type
      elements[1]
    end

  end

  module RTuple1
    def type
      elements[1]
    end

  end

  module RTuple2
    def type
      elements[1]
    end

    def type
      elements[3]
    end

  end

  module RTuple3
    def type
      elements[1]
    end

    def type
      elements[3]
    end

    def type
      elements[5]
    end

  end

  module RTuple4
    def type
      elements[1]
    end

    def type
      elements[3]
    end

    def type
      elements[5]
    end

    def type
      elements[7]
    end

  end

  module RTuple5
    def type
      elements[1]
    end

    def type
      elements[3]
    end

    def type
      elements[5]
    end

    def type
      elements[7]
    end

    def type
      elements[9]
    end

  end

  module RTuple6
    def type
      elements[1]
    end

    def type
      elements[3]
    end

    def type
      elements[5]
    end

    def type
      elements[7]
    end

    def type
      elements[9]
    end

    def type
      elements[11]
    end

  end

  def _nt_rTuple
    start_index = index
    if node_cache[:rTuple].has_key?(index)
      cached = node_cache[:rTuple][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index("R0[:", index) == index
      r2 = instantiate_node(SyntaxNode,input, index...(index + 4))
      @index += 4
    else
      terminal_parse_failure("R0[:")
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_type
      s1 << r3
      if r3
        if input.index("]", index) == index
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("]")
          r4 = nil
        end
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(PKVariableNode,input, i1...index, s1)
      r1.extend(RTuple0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i5, s5 = index, []
      if input.index("(R0[:", index) == index
        r6 = instantiate_node(SyntaxNode,input, index...(index + 5))
        @index += 5
      else
        terminal_parse_failure("(R0[:")
        r6 = nil
      end
      s5 << r6
      if r6
        r7 = _nt_type
        s5 << r7
        if r7
          if input.index("])", index) == index
            r8 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("])")
            r8 = nil
          end
          s5 << r8
        end
      end
      if s5.last
        r5 = instantiate_node(PKVariableNode,input, i5...index, s5)
        r5.extend(RTuple1)
      else
        self.index = i5
        r5 = nil
      end
      if r5
        r0 = r5
      else
        i9, s9 = index, []
        if input.index("(R0[:", index) == index
          r10 = instantiate_node(SyntaxNode,input, index...(index + 5))
          @index += 5
        else
          terminal_parse_failure("(R0[:")
          r10 = nil
        end
        s9 << r10
        if r10
          r11 = _nt_type
          s9 << r11
          if r11
            if input.index("],R1[:", index) == index
              r12 = instantiate_node(SyntaxNode,input, index...(index + 6))
              @index += 6
            else
              terminal_parse_failure("],R1[:")
              r12 = nil
            end
            s9 << r12
            if r12
              r13 = _nt_type
              s9 << r13
              if r13
                if input.index("])", index) == index
                  r14 = instantiate_node(SyntaxNode,input, index...(index + 2))
                  @index += 2
                else
                  terminal_parse_failure("])")
                  r14 = nil
                end
                s9 << r14
              end
            end
          end
        end
        if s9.last
          r9 = instantiate_node(PKVariableNode,input, i9...index, s9)
          r9.extend(RTuple2)
        else
          self.index = i9
          r9 = nil
        end
        if r9
          r0 = r9
        else
          i15, s15 = index, []
          if input.index("(R0[:", index) == index
            r16 = instantiate_node(SyntaxNode,input, index...(index + 5))
            @index += 5
          else
            terminal_parse_failure("(R0[:")
            r16 = nil
          end
          s15 << r16
          if r16
            r17 = _nt_type
            s15 << r17
            if r17
              if input.index("],R1[:", index) == index
                r18 = instantiate_node(SyntaxNode,input, index...(index + 6))
                @index += 6
              else
                terminal_parse_failure("],R1[:")
                r18 = nil
              end
              s15 << r18
              if r18
                r19 = _nt_type
                s15 << r19
                if r19
                  if input.index("],R2[:", index) == index
                    r20 = instantiate_node(SyntaxNode,input, index...(index + 6))
                    @index += 6
                  else
                    terminal_parse_failure("],R2[:")
                    r20 = nil
                  end
                  s15 << r20
                  if r20
                    r21 = _nt_type
                    s15 << r21
                    if r21
                      if input.index("])", index) == index
                        r22 = instantiate_node(SyntaxNode,input, index...(index + 2))
                        @index += 2
                      else
                        terminal_parse_failure("])")
                        r22 = nil
                      end
                      s15 << r22
                    end
                  end
                end
              end
            end
          end
          if s15.last
            r15 = instantiate_node(PKVariableNode,input, i15...index, s15)
            r15.extend(RTuple3)
          else
            self.index = i15
            r15 = nil
          end
          if r15
            r0 = r15
          else
            i23, s23 = index, []
            if input.index("(R0[:", index) == index
              r24 = instantiate_node(SyntaxNode,input, index...(index + 5))
              @index += 5
            else
              terminal_parse_failure("(R0[:")
              r24 = nil
            end
            s23 << r24
            if r24
              r25 = _nt_type
              s23 << r25
              if r25
                if input.index("],R1[:", index) == index
                  r26 = instantiate_node(SyntaxNode,input, index...(index + 6))
                  @index += 6
                else
                  terminal_parse_failure("],R1[:")
                  r26 = nil
                end
                s23 << r26
                if r26
                  r27 = _nt_type
                  s23 << r27
                  if r27
                    if input.index("],R2[:", index) == index
                      r28 = instantiate_node(SyntaxNode,input, index...(index + 6))
                      @index += 6
                    else
                      terminal_parse_failure("],R2[:")
                      r28 = nil
                    end
                    s23 << r28
                    if r28
                      r29 = _nt_type
                      s23 << r29
                      if r29
                        if input.index("],R3[:", index) == index
                          r30 = instantiate_node(SyntaxNode,input, index...(index + 6))
                          @index += 6
                        else
                          terminal_parse_failure("],R3[:")
                          r30 = nil
                        end
                        s23 << r30
                        if r30
                          r31 = _nt_type
                          s23 << r31
                          if r31
                            if input.index("])", index) == index
                              r32 = instantiate_node(SyntaxNode,input, index...(index + 2))
                              @index += 2
                            else
                              terminal_parse_failure("])")
                              r32 = nil
                            end
                            s23 << r32
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
            if s23.last
              r23 = instantiate_node(PKVariableNode,input, i23...index, s23)
              r23.extend(RTuple4)
            else
              self.index = i23
              r23 = nil
            end
            if r23
              r0 = r23
            else
              i33, s33 = index, []
              if input.index("(R0[:", index) == index
                r34 = instantiate_node(SyntaxNode,input, index...(index + 5))
                @index += 5
              else
                terminal_parse_failure("(R0[:")
                r34 = nil
              end
              s33 << r34
              if r34
                r35 = _nt_type
                s33 << r35
                if r35
                  if input.index("],R1[:", index) == index
                    r36 = instantiate_node(SyntaxNode,input, index...(index + 6))
                    @index += 6
                  else
                    terminal_parse_failure("],R1[:")
                    r36 = nil
                  end
                  s33 << r36
                  if r36
                    r37 = _nt_type
                    s33 << r37
                    if r37
                      if input.index("],R2[:", index) == index
                        r38 = instantiate_node(SyntaxNode,input, index...(index + 6))
                        @index += 6
                      else
                        terminal_parse_failure("],R2[:")
                        r38 = nil
                      end
                      s33 << r38
                      if r38
                        r39 = _nt_type
                        s33 << r39
                        if r39
                          if input.index("],R3[:", index) == index
                            r40 = instantiate_node(SyntaxNode,input, index...(index + 6))
                            @index += 6
                          else
                            terminal_parse_failure("],R3[:")
                            r40 = nil
                          end
                          s33 << r40
                          if r40
                            r41 = _nt_type
                            s33 << r41
                            if r41
                              if input.index("],R4[:", index) == index
                                r42 = instantiate_node(SyntaxNode,input, index...(index + 6))
                                @index += 6
                              else
                                terminal_parse_failure("],R4[:")
                                r42 = nil
                              end
                              s33 << r42
                              if r42
                                r43 = _nt_type
                                s33 << r43
                                if r43
                                  if input.index("])", index) == index
                                    r44 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                    @index += 2
                                  else
                                    terminal_parse_failure("])")
                                    r44 = nil
                                  end
                                  s33 << r44
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
              if s33.last
                r33 = instantiate_node(PKVariableNode,input, i33...index, s33)
                r33.extend(RTuple5)
              else
                self.index = i33
                r33 = nil
              end
              if r33
                r0 = r33
              else
                i45, s45 = index, []
                if input.index("(R0[:", index) == index
                  r46 = instantiate_node(SyntaxNode,input, index...(index + 5))
                  @index += 5
                else
                  terminal_parse_failure("(R0[:")
                  r46 = nil
                end
                s45 << r46
                if r46
                  r47 = _nt_type
                  s45 << r47
                  if r47
                    if input.index("],R1[:", index) == index
                      r48 = instantiate_node(SyntaxNode,input, index...(index + 6))
                      @index += 6
                    else
                      terminal_parse_failure("],R1[:")
                      r48 = nil
                    end
                    s45 << r48
                    if r48
                      r49 = _nt_type
                      s45 << r49
                      if r49
                        if input.index("],R2[:", index) == index
                          r50 = instantiate_node(SyntaxNode,input, index...(index + 6))
                          @index += 6
                        else
                          terminal_parse_failure("],R2[:")
                          r50 = nil
                        end
                        s45 << r50
                        if r50
                          r51 = _nt_type
                          s45 << r51
                          if r51
                            if input.index("],R3[:", index) == index
                              r52 = instantiate_node(SyntaxNode,input, index...(index + 6))
                              @index += 6
                            else
                              terminal_parse_failure("],R3[:")
                              r52 = nil
                            end
                            s45 << r52
                            if r52
                              r53 = _nt_type
                              s45 << r53
                              if r53
                                if input.index("],R4[:", index) == index
                                  r54 = instantiate_node(SyntaxNode,input, index...(index + 6))
                                  @index += 6
                                else
                                  terminal_parse_failure("],R4[:")
                                  r54 = nil
                                end
                                s45 << r54
                                if r54
                                  r55 = _nt_type
                                  s45 << r55
                                  if r55
                                    if input.index("],R5[:", index) == index
                                      r56 = instantiate_node(SyntaxNode,input, index...(index + 6))
                                      @index += 6
                                    else
                                      terminal_parse_failure("],R5[:")
                                      r56 = nil
                                    end
                                    s45 << r56
                                    if r56
                                      r57 = _nt_type
                                      s45 << r57
                                      if r57
                                        if input.index("])", index) == index
                                          r58 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                          @index += 2
                                        else
                                          terminal_parse_failure("])")
                                          r58 = nil
                                        end
                                        s45 << r58
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
                if s45.last
                  r45 = instantiate_node(PKVariableNode,input, i45...index, s45)
                  r45.extend(RTuple6)
                else
                  self.index = i45
                  r45 = nil
                end
                if r45
                  r0 = r45
                else
                  self.index = i0
                  r0 = nil
                end
              end
            end
          end
        end
      end
    end

    node_cache[:rTuple][start_index] = r0

    return r0
  end

  module Lines0
    def next
      elements[1]
    end
  end

  module Lines1
    def first
      elements[0]
    end

    def rest
      elements[1]
    end
  end

  def _nt_lines
    start_index = index
    if node_cache[:lines].has_key?(index)
      cached = node_cache[:lines][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_statement
    s0 << r1
    if r1
      i3, s3 = index, []
      if input.index("\n", index) == index
        r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("\n")
        r4 = nil
      end
      s3 << r4
      if r4
        r5 = _nt_lines
        s3 << r5
      end
      if s3.last
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        r3.extend(Lines0)
      else
        self.index = i3
        r3 = nil
      end
      if r3
        r2 = r3
      else
        r2 = instantiate_node(SyntaxNode,input, index...index)
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(PKLinesNode,input, i0...index, s0)
      r0.extend(Lines1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:lines][start_index] = r0

    return r0
  end

  module Statement0
    def sub
      elements[1]
    end

  end

  def _nt_statement
    start_index = index
    if node_cache[:statement].has_key?(index)
      cached = node_cache[:statement][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_assignment
    if r1
      r0 = r1
    else
      r2 = _nt_ifThen
      if r2
        r0 = r2
      else
        r3 = _nt_while
        if r3
          r0 = r3
        else
          r4 = _nt_block
          if r4
            r0 = r4
          else
            r5 = _nt_builtIns
            if r5
              r0 = r5
            else
              r6 = _nt_term2
              if r6
                r0 = r6
              else
                i7, s7 = index, []
                if input.index("(", index) == index
                  r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure("(")
                  r8 = nil
                end
                s7 << r8
                if r8
                  r9 = _nt_statement
                  s7 << r9
                  if r9
                    if input.index(")", index) == index
                      r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure(")")
                      r10 = nil
                    end
                    s7 << r10
                  end
                end
                if s7.last
                  r7 = instantiate_node(PKBracketNode,input, i7...index, s7)
                  r7.extend(Statement0)
                else
                  self.index = i7
                  r7 = nil
                end
                if r7
                  r0 = r7
                else
                  self.index = i0
                  r0 = nil
                end
              end
            end
          end
        end
      end
    end

    node_cache[:statement][start_index] = r0

    return r0
  end

  module Assignment0
    def from
      elements[0]
    end

    def to
      elements[2]
    end
  end

  module Assignment1
    def from
      elements[0]
    end

    def to
      elements[2]
    end
  end

  module Assignment2
    def from
      elements[0]
    end

    def to
      elements[2]
    end
  end

  module Assignment3
    def toRuby
       s(:call, to.toRuby, :<=, s(:arglist, from.toRuby))
    end
  end

  def _nt_assignment
    start_index = index
    if node_cache[:assignment].has_key?(index)
      cached = node_cache[:assignment][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_term2
    s1 << r2
    if r2
      if input.index("=>", index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure("=>")
        r3 = nil
      end
      s1 << r3
      if r3
        r4 = _nt_variable
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Assignment0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(Assignment3)
    else
      i5, s5 = index, []
      r6 = _nt_tuple
      s5 << r6
      if r6
        if input.index("=>", index) == index
          r7 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("=>")
          r7 = nil
        end
        s5 << r7
        if r7
          r8 = _nt_variable
          s5 << r8
        end
      end
      if s5.last
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
        r5.extend(Assignment1)
      else
        self.index = i5
        r5 = nil
      end
      if r5
        r0 = r5
        r0.extend(Assignment3)
      else
        i9, s9 = index, []
        r10 = _nt_tuple
        s9 << r10
        if r10
          if input.index("=>", index) == index
            r11 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("=>")
            r11 = nil
          end
          s9 << r11
          if r11
            r12 = _nt_varTuple
            s9 << r12
          end
        end
        if s9.last
          r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
          r9.extend(Assignment2)
        else
          self.index = i9
          r9 = nil
        end
        if r9
          r0 = r9
          r0.extend(Assignment3)
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:assignment][start_index] = r0

    return r0
  end

  module IfThen0
    def term2
      elements[0]
    end

    def statement
      elements[2]
    end
  end

  module IfThen1
    def toRuby
       s(:if, term2.toRuby, s(:block, statement.toRuby), nil)
    end
  end

  module IfThen2
    def term2
      elements[0]
    end

    def block
      elements[2]
    end
  end

  module IfThen3
	 def toRuby
	    s(:if, term2.toRuby, block.toRuby, nil)
	 end
  end

  def _nt_ifThen
    start_index = index
    if node_cache[:ifThen].has_key?(index)
      cached = node_cache[:ifThen][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_term2
    s1 << r2
    if r2
      if input.index("->", index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure("->")
        r3 = nil
      end
      s1 << r3
      if r3
        r4 = _nt_statement
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(IfThen0)
      r1.extend(IfThen1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i5, s5 = index, []
      r6 = _nt_term2
      s5 << r6
      if r6
        if input.index("->", index) == index
          r7 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("->")
          r7 = nil
        end
        s5 << r7
        if r7
          r8 = _nt_block
          s5 << r8
        end
      end
      if s5.last
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
        r5.extend(IfThen2)
        r5.extend(IfThen3)
      else
        self.index = i5
        r5 = nil
      end
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:ifThen][start_index] = r0

    return r0
  end

  module While0
    def level
      elements[1]
    end

  end

  module While1
    def count
      elements[1]
    end

    def lvl
      elements[2]
    end

    def conditionalLines
      elements[4]
    end

  end

  module While2
    def level
      elements[1]
    end

  end

  module While3
    def count
      elements[1]
    end

    def lvl
      elements[2]
    end

    def forTo
      elements[4]
    end

    def block
      elements[6]
    end
  end

  def _nt_while
    start_index = index
    if node_cache[:while].has_key?(index)
      cached = node_cache[:while][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    i2 = index
    if input.index("w", index) == index
      r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("w")
      r3 = nil
    end
    if r3
      r2 = r3
    else
      if input.index("W", index) == index
        r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("W")
        r4 = nil
      end
      if r4
        r2 = r4
      else
        self.index = i2
        r2 = nil
      end
    end
    s1 << r2
    if r2
      if input.index("1", index) == index
        r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("1")
        r6 = nil
      end
      if r6
        r5 = r6
      else
        r5 = instantiate_node(SyntaxNode,input, index...index)
      end
      s1 << r5
      if r5
        i8, s8 = index, []
        if input.index("[", index) == index
          r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("[")
          r9 = nil
        end
        s8 << r9
        if r9
          r10 = _nt_digits
          s8 << r10
          if r10
            if input.index("]", index) == index
              r11 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("]")
              r11 = nil
            end
            s8 << r11
          end
        end
        if s8.last
          r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
          r8.extend(While0)
        else
          self.index = i8
          r8 = nil
        end
        if r8
          r7 = r8
        else
          r7 = instantiate_node(SyntaxNode,input, index...index)
        end
        s1 << r7
        if r7
          if input.index("[", index) == index
            r12 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("[")
            r12 = nil
          end
          s1 << r12
          if r12
            r13 = _nt_conditionalLines
            s1 << r13
            if r13
              if input.index("]", index) == index
                r14 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("]")
                r14 = nil
              end
              s1 << r14
            end
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(PKWhileNode,input, i1...index, s1)
      r1.extend(While1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i15, s15 = index, []
      i16 = index
      if input.index("w", index) == index
        r17 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("w")
        r17 = nil
      end
      if r17
        r16 = r17
      else
        if input.index("W", index) == index
          r18 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("W")
          r18 = nil
        end
        if r18
          r16 = r18
        else
          self.index = i16
          r16 = nil
        end
      end
      s15 << r16
      if r16
        if input.index("1", index) == index
          r20 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("1")
          r20 = nil
        end
        if r20
          r19 = r20
        else
          r19 = instantiate_node(SyntaxNode,input, index...index)
        end
        s15 << r19
        if r19
          i22, s22 = index, []
          if input.index("[", index) == index
            r23 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("[")
            r23 = nil
          end
          s22 << r23
          if r23
            r24 = _nt_digits
            s22 << r24
            if r24
              if input.index("]", index) == index
                r25 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("]")
                r25 = nil
              end
              s22 << r25
            end
          end
          if s22.last
            r22 = instantiate_node(SyntaxNode,input, i22...index, s22)
            r22.extend(While2)
          else
            self.index = i22
            r22 = nil
          end
          if r22
            r21 = r22
          else
            r21 = instantiate_node(SyntaxNode,input, index...index)
          end
          s15 << r21
          if r21
            if input.index("(", index) == index
              r26 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("(")
              r26 = nil
            end
            s15 << r26
            if r26
              r27 = _nt_operation
              s15 << r27
              if r27
                if input.index(")", index) == index
                  r28 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure(")")
                  r28 = nil
                end
                s15 << r28
                if r28
                  r29 = _nt_block
                  s15 << r29
                end
              end
            end
          end
        end
      end
      if s15.last
        r15 = instantiate_node(PKForNode,input, i15...index, s15)
        r15.extend(While3)
      else
        self.index = i15
        r15 = nil
      end
      if r15
        r0 = r15
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:while][start_index] = r0

    return r0
  end

  module ConditionalLines0
    def next
      elements[1]
    end
  end

  module ConditionalLines1
    def first
      elements[0]
    end

    def rest
      elements[1]
    end
  end

  def _nt_conditionalLines
    start_index = index
    if node_cache[:conditionalLines].has_key?(index)
      cached = node_cache[:conditionalLines][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_ifThen
    s0 << r1
    if r1
      i3, s3 = index, []
      if input.index("\n", index) == index
        r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("\n")
        r4 = nil
      end
      s3 << r4
      if r4
        r5 = _nt_conditionalLines
        s3 << r5
      end
      if s3.last
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        r3.extend(ConditionalLines0)
      else
        self.index = i3
        r3 = nil
      end
      if r3
        r2 = r3
      else
        r2 = instantiate_node(SyntaxNode,input, index...index)
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(PKLinesNode,input, i0...index, s0)
      r0.extend(ConditionalLines1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:conditionalLines][start_index] = r0

    return r0
  end

  module Block0
    def lines
      elements[1]
    end

  end

  module Block1
    def toRuby
	    lines.toRuby
    end
  end

  def _nt_block
    start_index = index
    if node_cache[:block].has_key?(index)
      cached = node_cache[:block][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("[", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("[")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_lines
      s0 << r2
      if r2
        if input.index("]", index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("]")
          r3 = nil
        end
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Block0)
      r0.extend(Block1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:block][start_index] = r0

    return r0
  end

  module BuiltIns0
  end

  def _nt_builtIns
    start_index = index
    if node_cache[:builtIns].has_key?(index)
      cached = node_cache[:builtIns][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("FIN", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 3))
      @index += 3
    else
      terminal_parse_failure("FIN")
      r1 = nil
    end
    s0 << r1
    if r1
      r3 = _nt_number
      if r3
        r2 = r3
      else
        r2 = instantiate_node(SyntaxNode,input, index...index)
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(PKFinNode,input, i0...index, s0)
      r0.extend(BuiltIns0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:builtIns][start_index] = r0

    return r0
  end

  def _nt_term2
    start_index = index
    if node_cache[:term2].has_key?(index)
      cached = node_cache[:term2][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_call
    if r1
      r0 = r1
    else
      r2 = _nt_condition
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:term2][start_index] = r0

    return r0
  end

  module Call0
    def number
      elements[1]
    end

    def comp
      elements[3]
    end

    def type
      elements[5]
    end

    def argumentTuple
      elements[8]
    end

  end

  def _nt_call
    start_index = index
    if node_cache[:call].has_key?(index)
      cached = node_cache[:call][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("R", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("R")
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if input.index(Regexp.new('[0-9]'), index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      if s2.empty?
        self.index = i2
        r2 = nil
      else
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      end
      s0 << r2
      if r2
        if input.index("[", index) == index
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("[")
          r4 = nil
        end
        s0 << r4
        if r4
          r6 = _nt_component
          if r6
            r5 = r6
          else
            r5 = instantiate_node(SyntaxNode,input, index...index)
          end
          s0 << r5
          if r5
            if input.index(":", index) == index
              r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(":")
              r7 = nil
            end
            s0 << r7
            if r7
              r8 = _nt_type
              s0 << r8
              if r8
                if input.index("]", index) == index
                  r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure("]")
                  r9 = nil
                end
                s0 << r9
                if r9
                  if input.index("(", index) == index
                    r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure("(")
                    r10 = nil
                  end
                  s0 << r10
                  if r10
                    r11 = _nt_argumentTuple
                    s0 << r11
                    if r11
                      if input.index(")", index) == index
                        r12 = instantiate_node(SyntaxNode,input, index...(index + 1))
                        @index += 1
                      else
                        terminal_parse_failure(")")
                        r12 = nil
                      end
                      s0 << r12
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(PKCallNode,input, i0...index, s0)
      r0.extend(Call0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:call][start_index] = r0

    return r0
  end

  module ArgumentTuple0
    def comma
      elements[0]
    end

    def next
      elements[1]
    end
  end

  module ArgumentTuple1
    def first
      elements[0]
    end

    def rest
      elements[1]
    end
  end

  def _nt_argumentTuple
    start_index = index
    if node_cache[:argumentTuple].has_key?(index)
      cached = node_cache[:argumentTuple][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_term2
    s0 << r1
    if r1
      i3, s3 = index, []
      r4 = _nt_comma
      s3 << r4
      if r4
        r5 = _nt_argumentTuple
        s3 << r5
      end
      if s3.last
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        r3.extend(ArgumentTuple0)
      else
        self.index = i3
        r3 = nil
      end
      if r3
        r2 = r3
      else
        r2 = instantiate_node(SyntaxNode,input, index...index)
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(PKIterativeNode,input, i0...index, s0)
      r0.extend(ArgumentTuple1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:argumentTuple][start_index] = r0

    return r0
  end

  module Count0
    def variable
      elements[1]
    end

  end

  module Count1
	 def toRuby
	    s(:call, variable.toRuby, :n_extent, s(:arglist))
	 end
  end

  def _nt_count
    start_index = index
    if node_cache[:count].has_key?(index)
      cached = node_cache[:count][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("N(", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 2))
      @index += 2
    else
      terminal_parse_failure("N(")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_variable
      s0 << r2
      if r2
        if input.index(")", index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(")")
          r3 = nil
        end
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Count0)
      r0.extend(Count1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:count][start_index] = r0

    return r0
  end

  module Prefix0
  end

  def _nt_prefix
    start_index = index
    if node_cache[:prefix].has_key?(index)
      cached = node_cache[:prefix][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("-", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("-")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i2, s2 = index, []
      if input.index("!", index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("!")
        r3 = nil
      end
      s2 << r3
      if r3
        i4 = index
        i5 = index
        if input.index(Regexp.new('[A-Z0-9]'), index) == index
          r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r6 = nil
        end
        if r6
          r5 = r6
        else
          if input.index("(", index) == index
            r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("(")
            r7 = nil
          end
          if r7
            r5 = r7
          else
            r8 = _nt_genericVariable
            if r8
              r5 = r8
            else
              self.index = i5
              r5 = nil
            end
          end
        end
        if r5
          self.index = i4
          r4 = instantiate_node(SyntaxNode,input, index...index)
        else
          r4 = nil
        end
        s2 << r4
      end
      if s2.last
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
        r2.extend(Prefix0)
      else
        self.index = i2
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:prefix][start_index] = r0

    return r0
  end

  def _nt_term
    start_index = index
    if node_cache[:term].has_key?(index)
      cached = node_cache[:term][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_genericVariable
    if r1
      r0 = r1
    else
      r2 = _nt_variable
      if r2
        r0 = r2
      else
        r3 = _nt_constant
        if r3
          r0 = r3
        else
          r4 = _nt_count
          if r4
            r0 = r4
          else
            self.index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:term][start_index] = r0

    return r0
  end

  module PrefixedTerm0
    def term2
      elements[1]
    end

  end

  module PrefixedTerm1
    def prefix
      elements[0]
    end

    def subterm
      elements[1]
    end
  end

  module PrefixedTerm2
    def sub
      elements[1]
    end

  end

  def _nt_prefixedTerm
    start_index = index
    if node_cache[:prefixedTerm].has_key?(index)
      cached = node_cache[:prefixedTerm][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_prefix
    s1 << r2
    if r2
      i3 = index
      i4, s4 = index, []
      if input.index("(", index) == index
        r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("(")
        r5 = nil
      end
      s4 << r5
      if r5
        r6 = _nt_term2
        s4 << r6
        if r6
          if input.index(")", index) == index
            r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(")")
            r7 = nil
          end
          s4 << r7
        end
      end
      if s4.last
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        r4.extend(PrefixedTerm0)
      else
        self.index = i4
        r4 = nil
      end
      if r4
        r3 = r4
      else
        r8 = _nt_term2
        if r8
          r3 = r8
        else
          self.index = i3
          r3 = nil
        end
      end
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(PKPrefixNode,input, i1...index, s1)
      r1.extend(PrefixedTerm1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r9 = _nt_term
      if r9
        r0 = r9
      else
        i10, s10 = index, []
        if input.index("(", index) == index
          r11 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("(")
          r11 = nil
        end
        s10 << r11
        if r11
          r12 = _nt_term2
          s10 << r12
          if r12
            if input.index(")", index) == index
              r13 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(")")
              r13 = nil
            end
            s10 << r13
          end
        end
        if s10.last
          r10 = instantiate_node(PKBracketNode,input, i10...index, s10)
          r10.extend(PrefixedTerm2)
        else
          self.index = i10
          r10 = nil
        end
        if r10
          r0 = r10
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:prefixedTerm][start_index] = r0

    return r0
  end

  module Tuple0
    def comma
      elements[0]
    end

    def next
      elements[1]
    end
  end

  module Tuple1
    def first
      elements[1]
    end

    def rest
      elements[2]
    end

  end

  def _nt_tuple
    start_index = index
    if node_cache[:tuple].has_key?(index)
      cached = node_cache[:tuple][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_varTuple
    if r1
      r0 = r1
    else
      i2, s2 = index, []
      if input.index("(", index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("(")
        r3 = nil
      end
      s2 << r3
      if r3
        r4 = _nt_term2
        s2 << r4
        if r4
          s5, i5 = [], index
          loop do
            i6, s6 = index, []
            r7 = _nt_comma
            s6 << r7
            if r7
              r8 = _nt_term2
              s6 << r8
            end
            if s6.last
              r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
              r6.extend(Tuple0)
            else
              self.index = i6
              r6 = nil
            end
            if r6
              s5 << r6
            else
              break
            end
          end
          if s5.empty?
            self.index = i5
            r5 = nil
          else
            r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
          end
          s2 << r5
          if r5
            if input.index(")", index) == index
              r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(")")
              r9 = nil
            end
            s2 << r9
          end
        end
      end
      if s2.last
        r2 = instantiate_node(PKIterativeNode,input, i2...index, s2)
        r2.extend(Tuple1)
      else
        self.index = i2
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:tuple][start_index] = r0

    return r0
  end

  module VarTuple0
    def comma
      elements[0]
    end

    def next
      elements[1]
    end
  end

  module VarTuple1
    def first
      elements[1]
    end

    def rest
      elements[2]
    end

  end

  def _nt_varTuple
    start_index = index
    if node_cache[:varTuple].has_key?(index)
      cached = node_cache[:varTuple][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("(", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_variable
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          i4, s4 = index, []
          r5 = _nt_comma
          s4 << r5
          if r5
            r6 = _nt_variable
            s4 << r6
          end
          if s4.last
            r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
            r4.extend(VarTuple0)
          else
            self.index = i4
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        if s3.empty?
          self.index = i3
          r3 = nil
        else
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        end
        s0 << r3
        if r3
          if input.index(")", index) == index
            r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(")")
            r7 = nil
          end
          s0 << r7
        end
      end
    end
    if s0.last
      r0 = instantiate_node(PKIterativeNode,input, i0...index, s0)
      r0.extend(VarTuple1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:varTuple][start_index] = r0

    return r0
  end

  module Condition0
    def prefixedTerm
      elements[0]
    end

    def op
      elements[1]
    end

    def condition
      elements[2]
    end
  end

  module Condition1
    def tuple
      elements[0]
    end

    def tuple
      elements[2]
    end
  end

  def _nt_condition
    start_index = index
    if node_cache[:condition].has_key?(index)
      cached = node_cache[:condition][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_prefixedTerm
    s1 << r2
    if r2
      i3 = index
      if input.index("=", index) == index
        r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("=")
        r4 = nil
      end
      if r4
        r3 = r4
      else
        if input.index("<", index) == index
          r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("<")
          r5 = nil
        end
        if r5
          r3 = r5
        else
          if input.index(">", index) == index
            r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(">")
            r6 = nil
          end
          if r6
            r3 = r6
          else
            self.index = i3
            r3 = nil
          end
        end
      end
      s1 << r3
      if r3
        r7 = _nt_condition
        s1 << r7
      end
    end
    if s1.last
      r1 = instantiate_node(PKOperationNode,input, i1...index, s1)
      r1.extend(Condition0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i8, s8 = index, []
      r9 = _nt_tuple
      s8 << r9
      if r9
        if input.index("=", index) == index
          r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("=")
          r10 = nil
        end
        s8 << r10
        if r10
          r11 = _nt_tuple
          s8 << r11
        end
      end
      if s8.last
        r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
        r8.extend(Condition1)
      else
        self.index = i8
        r8 = nil
      end
      if r8
        r0 = r8
      else
        r12 = _nt_operation
        if r12
          r0 = r12
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:condition][start_index] = r0

    return r0
  end

  module Operation0
    def prefixedTerm
      elements[0]
    end

    def op
      elements[1]
    end

    def condition
      elements[2]
    end
  end

  def _nt_operation
    start_index = index
    if node_cache[:operation].has_key?(index)
      cached = node_cache[:operation][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_prefixedTerm
    s1 << r2
    if r2
      i3 = index
      if input.index("+", index) == index
        r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("+")
        r4 = nil
      end
      if r4
        r3 = r4
      else
        if input.index("-", index) == index
          r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("-")
          r5 = nil
        end
        if r5
          r3 = r5
        else
          if input.index("*", index) == index
            r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("*")
            r6 = nil
          end
          if r6
            r3 = r6
          else
            if input.index("/", index) == index
              r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("/")
              r7 = nil
            end
            if r7
              r3 = r7
            else
              if input.index("&", index) == index
                r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("&")
                r8 = nil
              end
              if r8
                r3 = r8
              else
                if input.index("|", index) == index
                  r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure("|")
                  r9 = nil
                end
                if r9
                  r3 = r9
                else
                  if input.index("~", index) == index
                    r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure("~")
                    r10 = nil
                  end
                  if r10
                    r3 = r10
                  else
                    self.index = i3
                    r3 = nil
                  end
                end
              end
            end
          end
        end
      end
      s1 << r3
      if r3
        r11 = _nt_condition
        s1 << r11
      end
    end
    if s1.last
      r1 = instantiate_node(PKOperationNode,input, i1...index, s1)
      r1.extend(Operation0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r12 = _nt_prefixedTerm
      if r12
        r0 = r12
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:operation][start_index] = r0

    return r0
  end

  def _nt_constant
    start_index = index
    if node_cache[:constant].has_key?(index)
      cached = node_cache[:constant][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("0", index) == index
      r1 = instantiate_node(PKNumberNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("0")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r2 = _nt_number
      if r2
        r0 = r2
      else
        r3 = _nt_logConstant
        if r3
          r0 = r3
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:constant][start_index] = r0

    return r0
  end

  module LogConstant0
  end

  module LogConstant1
  end

  def _nt_logConstant
    start_index = index
    if node_cache[:logConstant].has_key?(index)
      cached = node_cache[:logConstant][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index("+", index) == index
      r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("+")
      r2 = nil
    end
    s1 << r2
    if r2
      s3, i3 = [], index
      loop do
        r4 = _nt_logConstant
        if r4
          s3 << r4
        else
          break
        end
      end
      r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(LogConstant0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i5, s5 = index, []
      if input.index("-", index) == index
        r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("-")
        r6 = nil
      end
      s5 << r6
      if r6
        s7, i7 = [], index
        loop do
          r8 = _nt_logConstant
          if r8
            s7 << r8
          else
            break
          end
        end
        r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
        s5 << r7
      end
      if s5.last
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
        r5.extend(LogConstant1)
      else
        self.index = i5
        r5 = nil
      end
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:logConstant][start_index] = r0

    return r0
  end

  module Variable0
    def comp
      elements[3]
    end

    def type
      elements[5]
    end

  end

  def _nt_variable
    start_index = index
    if node_cache[:variable].has_key?(index)
      cached = node_cache[:variable][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i1 = index
    if input.index("V", index) == index
      r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("V")
      r2 = nil
    end
    if r2
      r1 = r2
    else
      if input.index("Z", index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("Z")
        r3 = nil
      end
      if r3
        r1 = r3
      else
        if input.index("R", index) == index
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("R")
          r4 = nil
        end
        if r4
          r1 = r4
        else
          self.index = i1
          r1 = nil
        end
      end
    end
    s0 << r1
    if r1
      s5, i5 = [], index
      loop do
        if input.index(Regexp.new('[0-9]'), index) == index
          r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r6 = nil
        end
        if r6
          s5 << r6
        else
          break
        end
      end
      if s5.empty?
        self.index = i5
        r5 = nil
      else
        r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
      end
      s0 << r5
      if r5
        if input.index("[", index) == index
          r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("[")
          r7 = nil
        end
        s0 << r7
        if r7
          r9 = _nt_component
          if r9
            r8 = r9
          else
            r8 = instantiate_node(SyntaxNode,input, index...index)
          end
          s0 << r8
          if r8
            if input.index(":", index) == index
              r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(":")
              r10 = nil
            end
            s0 << r10
            if r10
              r11 = _nt_type
              s0 << r11
              if r11
                if input.index("]", index) == index
                  r12 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure("]")
                  r12 = nil
                end
                s0 << r12
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(PKVariableNode,input, i0...index, s0)
      r0.extend(Variable0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:variable][start_index] = r0

    return r0
  end

  def _nt_dot
    start_index = index
    if node_cache[:dot].has_key?(index)
      cached = node_cache[:dot][index]
      @index = cached.interval.end if cached
      return cached
    end

    if input.index(".", index) == index
      r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(".")
      r0 = nil
    end

    node_cache[:dot][start_index] = r0

    return r0
  end

  def _nt_comma
    start_index = index
    if node_cache[:comma].has_key?(index)
      cached = node_cache[:comma][index]
      @index = cached.interval.end if cached
      return cached
    end

    if input.index(",", index) == index
      r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(",")
      r0 = nil
    end

    node_cache[:comma][start_index] = r0

    return r0
  end

  def _nt_simpleType
    start_index = index
    if node_cache[:simpleType].has_key?(index)
      cached = node_cache[:simpleType][index]
      @index = cached.interval.end if cached
      return cached
    end

    if input.index("0", index) == index
      r0 = instantiate_node(PKNumberNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("0")
      r0 = nil
    end

    node_cache[:simpleType][start_index] = r0

    return r0
  end

  module Type0
    def number
      elements[0]
    end

    def dot
      elements[1]
    end

    def type
      elements[2]
    end
  end

  def _nt_type
    start_index = index
    if node_cache[:type].has_key?(index)
      cached = node_cache[:type][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_simpleType
    if r1
      r0 = r1
    else
      r2 = _nt_tupleType
      if r2
        r0 = r2
      else
        i3, s3 = index, []
        r4 = _nt_number
        s3 << r4
        if r4
          r5 = _nt_dot
          s3 << r5
          if r5
            r6 = _nt_type
            s3 << r6
          end
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(Type0)
        else
          self.index = i3
          r3 = nil
        end
        if r3
          r0 = r3
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:type][start_index] = r0

    return r0
  end

  module TupleType0
    def comma
      elements[0]
    end

    def next
      elements[1]
    end
  end

  module TupleType1
    def first
      elements[1]
    end

    def rest
      elements[2]
    end

  end

  def _nt_tupleType
    start_index = index
    if node_cache[:tupleType].has_key?(index)
      cached = node_cache[:tupleType][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("(", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_type
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          i4, s4 = index, []
          r5 = _nt_comma
          s4 << r5
          if r5
            r6 = _nt_type
            s4 << r6
          end
          if s4.last
            r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
            r4.extend(TupleType0)
          else
            self.index = i4
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        if s3.empty?
          self.index = i3
          r3 = nil
        else
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        end
        s0 << r3
        if r3
          if input.index(")", index) == index
            r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(")")
            r7 = nil
          end
          s0 << r7
        end
      end
    end
    if s0.last
      r0 = instantiate_node(PKIterativeNode,input, i0...index, s0)
      r0.extend(TupleType1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:tupleType][start_index] = r0

    return r0
  end

  module Component0
    def dot
      elements[1]
    end

    def component
      elements[2]
    end
  end

  def _nt_component
    start_index = index
    if node_cache[:component].has_key?(index)
      cached = node_cache[:component][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    s2, i2 = [], index
    loop do
      if input.index(Regexp.new('[0-9]'), index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r3 = nil
      end
      if r3
        s2 << r3
      else
        break
      end
    end
    if s2.empty?
      self.index = i2
      r2 = nil
    else
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
    end
    s1 << r2
    if r2
      r4 = _nt_dot
      s1 << r4
      if r4
        r5 = _nt_component
        s1 << r5
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Component0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r6 = _nt_term2
      if r6
        r0 = r6
      else
        s7, i7 = [], index
        loop do
          if input.index(Regexp.new('[0-9]'), index) == index
            r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            r8 = nil
          end
          if r8
            s7 << r8
          else
            break
          end
        end
        if s7.empty?
          self.index = i7
          r7 = nil
        else
          r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
        end
        if r7
          r0 = r7
        else
          r9 = _nt_variable
          if r9
            r0 = r9
          else
            r10 = _nt_genericVariable
            if r10
              r0 = r10
            else
              self.index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:component][start_index] = r0

    return r0
  end

  module GenericVariable0
    def number
      elements[1]
    end
  end

  def _nt_genericVariable
    start_index = index
    if node_cache[:genericVariable].has_key?(index)
      cached = node_cache[:genericVariable][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index("i", index) == index
      r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("i")
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_number
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(PKGenericVariableNode,input, i1...index, s1)
      r1.extend(GenericVariable0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if input.index("i", index) == index
        r4 = instantiate_node(PKGenericVariableNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("i")
        r4 = nil
      end
      if r4
        r0 = r4
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:genericVariable][start_index] = r0

    return r0
  end

  module Number0
    def digits
      elements[1]
    end
  end

  def _nt_number
    start_index = index
    if node_cache[:number].has_key?(index)
      cached = node_cache[:number][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[1-9]'), index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_digits
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(PKNumberNode,input, i0...index, s0)
      r0.extend(Number0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:number][start_index] = r0

    return r0
  end

  def _nt_digits
    start_index = index
    if node_cache[:digits].has_key?(index)
      cached = node_cache[:digits][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[0-9]'), index) == index
        r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(PKNumberNode,input, i0...index, s0)

    node_cache[:digits][start_index] = r0

    return r0
  end

end

class Pk2000Parser < Treetop::Runtime::CompiledParser
  include Pk2000
end

