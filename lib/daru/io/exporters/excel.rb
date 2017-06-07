require 'daru/io/exporters/linkages/excel'

module Daru
  module IO
    module Exporters
      class Excel
        def initialize(dataframe, path, opts={})
          @dataframe = dataframe
          @path      = path
          @opts      = opts
        end

        # @note
        #
        # The +format+ variable used in this method, has to be given
        # as options by the user via the +opts+ hash input.
        #
        # Signed off by @athityakumar on 03/06/2017 at 7:00PM
        def write
          book  = Spreadsheet::Workbook.new
          sheet = book.create_worksheet

          format = Spreadsheet::Format.new color: :blue, weight: :bold

          sheet.row(0).concat(@dataframe.vectors.to_a.map(&:to_s)) # Unfreeze strings
          sheet.row(0).default_format = format
          @dataframe.each_row_with_index { |row, i| sheet.row(i+1).concat(row.to_a) }

          book.write(@path)
        end
      end
    end
  end
end