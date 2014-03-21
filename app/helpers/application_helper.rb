module ApplicationHelper
  def slugify string
    string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if string
  end
end
