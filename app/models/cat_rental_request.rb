class CatRentalRequest < ActiveRecord::Base
  belongs_to :cat

  validates :cat_id, :start_date, :end_date, :status, presence: true
  STATUSES = ["PENDING", "APPROVED", "DENIED"]
  validates :status, inclusion: { in: STATUSES }
  validate :overlapping_approved_requests

  def overlapping_requests
    requests = CatRentalRequest.where(cat_id: self.cat_id)
    if requests.any?
      requests.select do |request|
        if self.id != request.id
          if self.start_date <= request.end_date && self.start_date >= request.start_date
            true
          elsif self.start_date < request.start_date && self.end_date >= request.start_date
            true
          else
            false
          end
        end
      end
    else
      nil
    end
  end

  def overlapping_approved_requests
    if requests = overlapping_requests
      requests.each do |request|
        if request.approved?
          errors.add(:base, "Another request has been approved from #{request.start_date} to #{request.end_date}")
        end
      end
    end
  end

  def approved?
    status == "APPROVED"
  end
end
