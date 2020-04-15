require 'rails_helper'

RSpec.describe "/articles", type: :request do

  let(:user) { create :user }
  let!(:article) { create :article, author: user }

  let(:invalid_attributes) do
    {
      description: 'description',
      preview: '',
      user_id: '',
    }
  end

  before { sign_in user }

  describe "GET /index" do
    it "renders a successful response" do
      get articles_path

      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get article_path(article)

      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_article_url

      expect(response).to be_successful
    end

    context 'when not sign_in' do
      before { sign_out user }

      it 'redirect to sign_in' do
        get new_article_url

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_article_url(article)

      expect(response).to be_successful
    end

    context 'when not sign_in' do
      before { sign_out user }

      it "redirect to sign_in" do
        get edit_article_url(article)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Article" do
        expect {
          post articles_url, params: { article: attributes_for(:article) }
        }.to change(Article, :count).by(1)
      end

      it "redirects to the created article" do
        post articles_url, params: { article: attributes_for(:article) }

        expect(response).to redirect_to(article_url(Article.last))
      end

      context 'when not sign_in' do
        before { sign_out user }

        it "redirect to sign_in" do
          expect {
            post articles_url, params: attributes_for(:article)
          }.to change(Article, :count).by(0)

          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    context "with invalid parameters" do
      it "does not create a new Article" do
        expect {
          post articles_url, params: { article: invalid_attributes }
        }.to change(Article, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post articles_url, params: { article: invalid_attributes }

        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          preview: 'new preview',
          description: 'new_description',
        }
      end

      it "updates the requested article" do
        patch article_url(article), params: { article: new_attributes }

        article.reload

        expect(article.preview).to eq(new_attributes[:preview])
        expect(article.description).to eq(new_attributes[:description])
      end

      it "redirects to the article" do
        patch article_url(article), params: { article: new_attributes }

        article.reload

        expect(response).to redirect_to(article_url(article))
      end

      context 'when not sign_in' do
        before { sign_out user }

        it "redirect to sign_in" do
          patch article_url(article), params: { article: new_attributes }

          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch article_url(article), params: { article: invalid_attributes }

        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested article" do
      expect {
        delete article_url(article)
      }.to change(Article, :count).by(-1)
    end

    it "redirects to the articles list" do
      delete article_url(article)

      expect(response).to redirect_to(articles_url)
    end

    context 'when not sign_in' do
      before { sign_out user }

      it "redirect to sign_in" do
        delete article_url(article)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
