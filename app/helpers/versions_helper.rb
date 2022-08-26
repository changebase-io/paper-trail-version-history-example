# frozen_string_literal: true

module VersionsHelper
  def version_link_class(version)
    classes = %w[
      block
      border-b
      border-l-[.35rem]
      no-underline
      p-4
      text-inherit
    ]
    if version.id == @version.id
      classes.push('border-l-pink-500')
    else
      classes.push('border-l-stone-100', 'hover:border-l-stone-300')
    end
    classes.join(' ')
  end
end
