require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(build(:user)).to be_valid }

  subject! { create(:user) }

  describe 'ActiveModel' do
    context 'attributes' do
      it { expect(subject).to have_attr_accessor(:token) }
      it { expect(subject).to have_secure_password }
      it do
        subject.username = '     '
        expect(subject).not_to be_valid
      end
      it do
        subject.email = '     '
        expect(subject).not_to be_valid
      end
      it do
        subject.username = 'a' * 51
        expect(subject).not_to be_valid
      end
      it do
        subject.email = "#{'a' * 244}@example.com"
        expect(subject).not_to be_valid
      end
      it do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                             first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          subject.email = valid_address
          expect(subject).to be_valid
        end
      end
      it do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                               foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          subject.email = invalid_address
          expect(subject).not_to be_valid
        end
      end
      it do
        duplicate_user = subject.dup
        duplicate_user.email = subject.email.upcase
        subject.save
        expect(duplicate_user).not_to be_valid
      end
      it do
        mixed_case_email = 'Foo@ExAMPle.CoM'
        subject.email = mixed_case_email
        subject.save
        assert_equal mixed_case_email.downcase, subject.reload.email
      end
      it do
        subject.password = subject.password_confirmation = ' ' * 6
        expect(subject).not_to be_valid
      end
      it do
        subject.password = subject.password_confirmation = 'a' * 5
        expect(subject).not_to be_valid
      end
    end
  end
end
