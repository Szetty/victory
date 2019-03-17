module IOHelpers
  class Writer
    def self.file(path, data, options = {})
      File.write(path, string(data, options))
    end

    def self.string(data, options = {})
      line_sep = options[:line_sep] || "\n"
      col_sep = options[:col_sep]
      mapper = options[:mapper] || ->(x) { x.to_s }
      if col_sep
        data.map { |line| line.map(&mapper).join(col_sep) }.join(line_sep)
      else
        data.map(&mapper).join(line_sep)
      end
    end
  end
end