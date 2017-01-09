# rspec spec
# rspec spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, :type => :model do
  
  let! (:andy) { create :user, :andy }
  let! (:user_attrs) {
    [
      :name, :email, :active, :country, :country_code, :currency, :currency_code, :created_at, :updated_at
    ]
  }
  # todo: after Devise > only comment other articles from OTHER users!
  let! (:article_active)    { create :article, :active, parent_id: andy.id, user_id: andy.id }
  let! (:article_inactive)  { create :article, :inactive, parent_id: andy.id, user_id: andy.id }
  let! (:comment_active)    { create :comment, :active, parent_id: article_active.id, user_id: andy.id }
  let! (:comment_inactive)  { create :comment, :inactive, parent_id: article_active.id, user_id: andy.id }
  
  describe 'validations' do
    
    context 'create new user' do
      it 'valid new user' do
        expect(User.count).to eq 1
        expect(User.first.name).to eq 'andy'
        expect(User.first).to eq andy
      end

      it 'invalid email' do
        user = build :user, :other, email: 'andy@'
        user.save
        
        expect(user.errors.messages[:email]).to include "is invalid"
      end
      
      shared_examples 'must be unique' do |attr|
        it "'#{attr}' has already been taken" do
          this_user.save
          expect(User.count).to eq 1
          expect(this_user.errors.messages[attr]).to include "has already been taken"
        end
      end

      shared_examples 'must be present' do |attr|
        it "'#{attr}' can't be blank" do
          this_user.save
          expect(User.count).to eq 1
          expect(this_user.errors.messages[attr]).to include "can't be blank"
        end
      end
      
      describe 'unique' do
        it_behaves_like 'must be unique', :name do let(:this_user) { build :user, :other, name: 'andy' } end
        it_behaves_like 'must be unique', :email do let(:this_user) {
          build :user, :other, email: 'andreas.wenk@sumcumo.com' }
        end
      end

      describe 'presence' do
        it_behaves_like 'must be present', :name  do let(:this_user) { build :user, :other, name: '' } end
        it_behaves_like 'must be present', :email do let(:this_user) { build :user, :other, email: '' } end
        it_behaves_like 'must be present', :country do let(:this_user) { build :user, :other, country: '' } end
        it_behaves_like 'must be present', :country_code do
          let(:this_user) { build :user, :other, country_code: '' }
        end
        it_behaves_like 'must be present', :currency do let(:this_user) { build :user, :other, currency: '' } end
        it_behaves_like 'must be present', :currency_code do
          let(:this_user) { build :user, :other, currency_code: '' }
        end
      end
      
    end
  end
  
  describe 'assocs' do
  
    describe 'articles' do
      it 'one user has n articles' do
        expect(andy.articles.size).to eq 2
      end
      it 'scope active_segments' do
        expect(andy.articles.active_segments.size).to eq 1
      end
      it 'scope inactive_segments' do
        expect(andy.articles.inactive_segments.size).to eq 1
      end
    end
    
    describe 'comments' do
      it 'one user has n comments' do
        expect(andy.comments.size).to eq 2
      end
      it 'scope active_segments' do
        expect(andy.comments.active_segments.size).to eq 1
      end
      it 'scope inactive_segments' do
        expect(andy.comments.inactive_segments.size).to eq 1
      end
    end

    # todo: changes after devise, see top!
    describe 'received comments' do
      it 'one user has n received comments' do
        expect(andy.received_comments.size).to eq 2
      end
      it 'scope active_segments' do
        expect(andy.received_comments.active_segments.size).to eq 1
      end
      it 'scope inactive_segments' do
        expect(andy.received_comments.inactive_segments.size).to eq 1
      end
    end
 
  end
  
  describe 'methods' do
    
    describe '#show_attributes' do
      it 'get show attributes' do
        expect(andy.show_attributes).to eq user_attrs
      end
    end
  
    describe 'User#edit_attributes' do
      it 'get show attributes' do
        compare = user_attrs - [:created_at, :updated_at]
        expect(User.edit_attributes).to eq compare
      end
    end
  
    describe '#get_value' do
      it 'get show attributes' do
        expect(andy.get_value(:active)).to eq 'Yes'
        expect(andy.get_value(:created_at)).to eq andy.created_at.to_time.strftime("%d.%m.%Y %H:%M")
        expect(andy.get_value(:name)).to eq andy.name
      end
    end
  
    describe '#get_label' do
      it 'get label text' do
        expect(andy.get_label(:active)).to eq 'Active'
        expect(andy.get_label(:created_at)).to eq 'Created At'
        expect(andy.get_label(:name)).to eq 'Name'
      end
    end
  
    describe 'User#get_label' do
      it 'get label text' do
        expect(User.get_label(:active)).to eq 'Active'
        expect(User.get_label(:created_at)).to eq 'Created At'
        expect(User.get_label(:name)).to eq 'Name'
      end
    end
  end
  
  
end