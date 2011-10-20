module Paginates
  def paginate(page_nbr, per_page)
    page(page_nbr).per per_page
  end
end