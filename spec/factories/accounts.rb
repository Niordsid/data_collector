# == Schema Information
#
# Table name: accounts
#
#  id                      :uuid             not null, primary key
#  code                    :string
#  type                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  base_token_10           :string
#  base_token_20           :string
#  base_token_30           :string
#  base_token_40           :string
#  base_token_50           :string
#  base_token_60           :string
#  base_token_70           :string
#  base_token_80           :string
#  base_token_90           :string
#  base_token_100          :string

FactoryBot.define do
  factory :account do
    code '20101020089'
    type 'student'
    base_token_10 'pepito/perez'
    base_token_20 'pepito/perez'
    base_token_30 'pepito/perez'
    base_token_40 'pepito/perez'
    base_token_50 'pepito/perez'
    base_token_60 'pepito/perez'
    base_token_70 'pepito/perez'
    base_token_80 'pepito/perez'
    base_token_90 'pepito/perez'
    base_token_100 'pepito/perez'
  end
end
