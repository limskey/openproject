class ChangeDurationDefaultValue < ActiveRecord::Migration[7.0]
  def up
    # Reset duration only when the feature flag was not enabled
    unless Setting.find_by(name: 'work_packages_duration_field_active')&.value
      reset_duration(:work_packages)
      reset_duration(:work_package_journals)
    end
  end

  private

  def reset_duration(table)
    execute <<~SQL.squish
      UPDATE #{table} SET duration = NULL
    SQL
  end
end
