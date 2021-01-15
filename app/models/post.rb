class Post < ActiveRecord::Base
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction)}
  validate :click_bait

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top [0-9]*/i,
    /Guess/i
  ]

  def click_bait
    if CLICKBAIT_PATTERNS.none? {|pattern| pattern.match(self.title)}
      self.errors.add(:title, "is not clickbait enough")
    end
  end
end
