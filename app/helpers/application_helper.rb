# frozen_string_literal: true

module ApplicationHelper
  def secondary_button_classes
    %w[
      bg-stone-200
      duration-300
      hover:bg-pink-500
      hover:text-white
      leading-none
      no-underline
      p-2
      rounded-md
      text-inherit
      transition-colors
    ].join(' ')
  end

  def markdown(text)
    options = %i[hard_wrap autolink no_intra_emphasis fenced_code_blocks]
    Markdown.new(text, *options).to_html.html_safe
  end
end
