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

end

World(TableHelpers)