class DeckOfQuestions

  def initialize
    @questions = {
      'Pop' => Array.new(50) { |i| "Pop Question #{i}" },
      'Science' => Array.new(50) { |i| "Science Question #{i}" },
      'Sports' => Array.new(50) { |i| "Sports Question #{i}" },
      'Rock' => Array.new(50) { |i| "Rock Question #{i}" }
    }
  end

  def pick_question_for(category)
    questions = questions_for(category)
    questions.shift
  end

  def questions_for(category)
    @questions[category]
  end

  def current_category(place)
    categories[place]
  end

  private

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
