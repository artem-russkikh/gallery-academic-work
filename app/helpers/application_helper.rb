module ApplicationHelper
  def flash_keys
    {
      error: 'danger',
      alert: 'warning',
      notice: 'success'
    }
  end
end
