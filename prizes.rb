class LotteryPrizes
  # 5w + 1   = Grand prize -- 1:292201338
  # 5w       = 1,000,000 -- 1:11688053.52
  # 4w + 1   = 50,000 -- 1:913129.18
  # 4w       = 100 -- 1:36525.17
  # 3w + 1   = 100 -- 1:14494.11
  # 3w       = 7 -- 1:579.76
  # 2w + 1   = 7 -- 1:701.33
  # 1w + 1   = 4 -- 1:91.98
  # 1        = 4 -- 1:38.32

  def prize_five_plus_red

  end

  def prize_five
    return 1000000
  end

  def prize_four_plus_red
    return 50000
  end

  def prize_four
    return 100
  end

  def prize_three_plus_red
    return 100
  end

  def prize_three
    return 7
  end

  def prize_two_plus_red
    return 7
  end

  def prize_one_plus_red
    return 4
  end

  def prize_red
    return 4
  end

end