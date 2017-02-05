SimpleCov.start 'rails' do
  minimum_coverage 90
  refuse_coverage_drop
  add_filter "/spec/"
end