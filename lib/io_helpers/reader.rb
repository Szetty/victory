module IOHelpers
  class Reader
    def self.file(path, options = {})
      line_sep = options[:line_sep] || "\n"
      lines = File.readlines(path, line_sep, chomp: true)
      map_lines(lines, options)
    end

    def self.string(str, options = {})
      line_sep = options[:line_sep] || "\n"
      lines = str.split(line_sep)
      map_lines(lines, options)
    end

    def self.stream(path)
      IO.foreach(path).lazy
    end

    def self.map_lines(lines, options)
      col_sep = options[:col_sep]
      as = options[:as] || 's'
      mapper = options[:mapper]
      if col_sep
        lines.map { |line| line.split(col_sep).map { |col| map_element(col, as, mapper) } }
      else
        lines.map { |line| map_element(line, as, mapper) }
      end
    end

    def self.map_element(element, as, mapper)
      if mapper
        mapper.call(element)
      else
        element.method("to_#{as}").call
      end
    end
  end
end