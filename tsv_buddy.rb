# frozen_string_literal: true

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # Converts a String with TSV data into internal data structure @data
  # arguments: tsv - a String in TSV format
  # returns: nothing
  def take_tsv(tsv)
    lines = tsv.split("\n")
    @in_categories = lines.shift.split("\t")
    @data = lines.map { |line| line_to_hash(line) }
  end

  def line_to_hash(line)
    entries = line.chomp.split("\t")
    @in_categories.zip(entries).to_h
  end

  # Converts @data into tsv string
  # arguments: none
  # returns: String in TSV format
  def to_tsv
    @out_categories = @data[0].keys
    output = parse_header
    output << parse_body.join("\n")
    output << "\n"
    output
  end

  def parse_header
    "#{@out_categories.join("\t")}\n"
  end

  def parse_body
    @data.map { |line| line.values.join("\t") }
  end
end
