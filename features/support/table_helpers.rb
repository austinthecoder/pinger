module TableHelpers

  def diff_tables!(actual, expected)
    raw_expected = expected.raw
    expected.diff!(actual)
  rescue Cucumber::Ast::Table::Different => e
    raise StandardError, <<-ERROR.strip_heredoc
      #{e}

      Expected:
      #{raw_expected.inspect}

      Actual:
      #{actual.inspect}

    ERROR
  end

  def table_array(row_selector, column_selectors)
    doc = Nokogiri::HTML(body)
    spans = nil
    max_cols = 0

    # Parse the table.
    rows = doc.search(row_selector).map do |row|
      cells = case(column_selectors)
      when String
        row.search(column_selectors)
      when Proc
        column_selectors.call(row)
      end

      # TODO: max_cols should be sum of colspans
      max_cols = [max_cols, cells.length].max

      spans ||= Array.new(max_cols, 1)

      cell_index = 0

      cells = (0...spans.length).inject([]) do |array, n|
        span = spans[n]

        cell = if span > 1
          row_span, col_span = 1, 1
          nil
        else
          cell = cells[cell_index]

          row_span, col_span = _parse_spans(cell)

          if col_span > 1
            ((n + 1)...(n + col_span)).each do |m|
              spans[m] = row_span + 1
            end
          end

          cell_index +=1
          cell
        end

        spans[n] = row_span > 1 ? row_span : ([span - 1, 1].max)

        array << case cell
          when String then cell.strip
          when nil then ''
          else cell.text.strip
        end

        array
      end

      cells
    end
  end

  def _parse_spans(cell)
    if cell.is_a?(Nokogiri::XML::Node)
      [
        cell.attributes['rowspan'].to_s.to_i || 1,
        cell.attributes['colspan'].to_s.to_i || 1
      ]
    else
      [1, 1]
    end
  end

end

World(TableHelpers)