module ApplicationHelper
  def random_message
    messages = [
      "... with a name .com hipsters love!",
      "... what\'s \"Articl\" in Spanish anyway?",
      "... my cousin works for Bit.ly",
      "... not just for the country of Spain",
      "... my favorite radio staion is Last.fm",
      "... all your \"Articl\" are belong to us"
    ]
    num = rand(messages.size)
    messages[num]
  end
end
