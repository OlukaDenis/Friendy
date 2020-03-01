module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    @like = Like.find_by(post: post, user: current_user)
  end

  def post_date(post)
    post.created_at.strftime('%b %d, %Y at %I:%M %p')
  end

  def comment_date(comment)
    "#{time_ago_in_words(comment.created_at)} ago"
  end
end
