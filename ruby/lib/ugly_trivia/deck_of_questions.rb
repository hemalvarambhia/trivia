class DeckOfQuestions

  def initialize
    pop_questions = Array.new(50) { |i| "Pop Question #{i}" }
    science_questions = Array.new(50) { |i| "Science Question #{i}" }
    sports_questions = Array.new(50) { |i| "Sports Question #{i}" }
    rock_questions = Array.new(50) { |i| "Rock Question #{i}" }
    @questions = {
      'Pop' => pop_questions,
      'Science' => science_questions,
      'Sports' => sports_questions,
      'Rock' => rock_questions
    }
  end

  def categories
    {
      0 => 'Pop',
      4 => 'Pop',
      8 => 'Pop',
      1 => 'Science',
      5 => 'Science',
      9 => 'Science',
      2 => 'Sports',
      6 => 'Sports',
      10 => 'Sports',
      3 => 'Rock',
      7 => 'Rock',
      11 => 'Rock'
    }
  end
end
