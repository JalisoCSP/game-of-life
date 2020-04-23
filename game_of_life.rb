class GameOfLife
  INITIAL_DISPLAY_TIME = 3
  DEFAULT_DELAY = 0.2
  BACKGROUND_COLOUR = :yellow
  LIVE_CELL_COLOUR = :black

  def initialize(array: Pattern::JOHN, lives: 1000)
    @array = array
    @lives = lives
    @changes = []
  end

  def call
    initial_display

    @lives.times do |life|
      calculate_changes_from_rules
      apply_changes
      display_array_after_life
      reset_change_list
    end
  end

  private

  def initial_display
    display_array_after_life(INITIAL_DISPLAY_TIME)
  end

  def calculate_changes_from_rules
    @array.each_with_index do |row, row_number|

      row.each_with_index do |cell, column_number|

        neighbours = neighbouring_cells(row_number, column_number).count(1)
        calculate_changes_for_cell(row_number, column_number, neighbours)

      end
    end
  end

  def apply_changes
    @changes.each do |change|
      @array[change[0]][change[1]] = change[2]
    end
  end

  def display_array_after_life(delay = DEFAULT_DELAY)
    system "clear"
    @array.each do |row|
      puts row.join
        .gsub("0", " ".colorize(background: BACKGROUND_COLOUR))
        .gsub("1", " ".colorize(background: LIVE_CELL_COLOUR))
    end
    sleep(delay)
  end

  def reset_change_list
    @changes = []
  end

  def calculate_changes_for_cell(row_number, column_number, alive_count)
    if cell_alive?(row_number, column_number)

      if alive_count < 2 # Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
        add_cell_to_kill_changes(row_number, column_number)
      elsif alive_count.between? 2, 3 # Any live cell with two or three live neighbours lives on to the next generation.
        # Do nothing, it stays alive
      elsif alive_count > 3 # Any live cell with more than three live neighbours dies, as if by overpopulation.
        add_cell_to_kill_changes(row_number, column_number)
      end

    else # cell is dead
      if alive_count == 3 # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
        add_cell_to_revive_changes(row_number, column_number)
      end
    end

  end

  # similar actions for above, below and current rows
  # tidy this method
  def neighbouring_cells(row_number, column_number)
    row_above_number = row_number - 1
    if row_above_number >= 0
      row_above = @array[row_above_number]
      if column_number == 0 # -1 would be opposite end of array
        cells_row_above = row_above[(column_number)..(column_number + 1)]
      else
        cells_row_above = row_above[(column_number - 1)..(column_number + 1)]
      end
    else
      cells_row_above = []
    end

    row_below_number = row_number + 1
    if row_below_number <= @array.size - 1
      row_below = @array[row_below_number]
      if column_number == 0 # -1 would be opposite end of array
        cells_row_below = row_below[(column_number)..(column_number + 1)]
      else
        cells_row_below = row_below[(column_number - 1)..(column_number + 1)]
      end
    else
      cells_row_below = []
    end

    current_row = [
      @array[row_number][column_number - 1],
      @array[row_number][column_number + 1]
    ]

    return cells_row_above + cells_row_below + current_row
  end

  def cell_alive?(row_number, column_number)
    @array[row_number][column_number] == 1
  end

  def add_cell_to_kill_changes(row_number, column_number)
    @changes << [row_number, column_number, 0]
  end

  def add_cell_to_revive_changes(row_number, column_number)
    @changes << [row_number, column_number, 1]
  end
end
