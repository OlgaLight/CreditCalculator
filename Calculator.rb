class Calculate_credit

  def initialize(sum, percent, month, type)
    @percent = percent
    @sum = sum
    @type = type
    @month = month
  end

  def calc_credit
    if @type == 'usual'
      calc_standard_credit
    elsif @type == 'equal'
      calc_annuity_credit
    end
  end

  private
  def calc_standard_credit
    payments_arr = []

    loan_body = @sum / @month
    percent_per_month = @percent / 12
    sum_left = @sum

    total_percent_sum = 0.0
    total_payments = 0.0

    @month.times do |month|
      percent_sum = sum_left * percent_per_month / 100.0
      total_sum = percent_sum + loan_body
      sum_left -= loan_body

      total_percent_sum += percent_sum
      total_payments += total_sum

      payments_arr << {month: month + 1, loan_body: loan_body.round(2), percent_sum: percent_sum.round(2),
                       total_sum: total_sum.round(2), rest_sum: sum_left.round(2)}
    end

    payments_arr << {month: '', loan_body: '', percent_sum: total_percent_sum.round(2),
                     total_sum: total_payments.round(2), rest_sum: ''}
  end

  private
  def calc_annuity_credit
    payments_arr = []

    percent_per_month = @percent / 12 / 100.0
    sum_left = @sum

    total_percent_sum = 0
    total_payments = 0

    total_sum = @sum * (percent_per_month + percent_per_month / ((1 + percent_per_month)**@month - 1))

    @month.times do |month|
      percent_sum = sum_left * percent_per_month
      loan_body = total_sum - percent_sum

      total_percent_sum += percent_sum
      total_payments += total_sum

      sum_left -= loan_body

      payments_arr << {month: month + 1, loan_body: loan_body.round(2), percent_sum: percent_sum.round(2),
                       total_sum: total_sum.round(2), rest_sum: sum_left.round(2)}
    end

    payments_arr << {month: '', loan_body: '', percent_sum: total_percent_sum.round(2),
                     total_sum: total_payments.round(2), rest_sum: ''}
  end
end

#######################

# arr = Calculate_credit.new(1200, 12, 12, 'equal').calc_credit
# arr.each do |el|
#   # print el[:month]
#   puts el
# end