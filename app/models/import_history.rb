class ImportHistory < ActiveRecord::Base
  belongs_to :survey, :class_name => 'EpiSurveyor::Survey'
  has_many :sync_errors, :dependent => :destroy
  has_many :object_histories, :class_name => 'Salesforce::ObjectHistory', :dependent => :destroy
  
  validates :survey_id, :presence => true
  validates :survey_response_id, :presence => true
  
  default_scope :order => 'import_histories.created_at DESC'

  def status
    return 'Success' if sync_errors.blank?
    return 'Incomplete' if object_histories.present?
    'Failed'
  end
end