require 'csv'

CSV.generate do |csv|
  column_questions = %w(タイトル 回答数 ブックマーク数)
  csv << column_questions
  @results.each do |question|
    column_values = [
      question.title,
      question.answers_count,
      question.bookmarks_count
    ]
    csv << column_values
  end
end
