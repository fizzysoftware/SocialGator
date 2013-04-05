module ApplicationHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:dd) do
      link_to link_text, link_path, class: class_name
    end
  end

  def next_post_time(business)
    next_time = Time.now
    business.post_times.each do |t|
      next_time = Time.parse(t.time)
      break if (next_time > Time.now)
    end
    return next_time.strftime("%e %B at %H:%M")
  end
end
