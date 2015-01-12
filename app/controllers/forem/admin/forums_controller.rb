module Forem
  module Admin
    class ForumsController < BaseController
      before_filter :find_forum, :only => [:edit, :update, :destroy, :change_position]

      def index
        @forums = Forem::Forum.all
      end

      def new
        @forum = Forem::Forum.new
      end

      def create
        @forum = Forem::Forum.new(forum_params.merge(position: Forem::Category.find(params[:forum][:category_id]).forums.maximum(:position) + 1))
        if @forum.save
          create_successful
        else
          create_failed
        end
      end

      def update
        if @forum.update_attributes(forum_params)
          update_successful
        else
          update_failed
        end
      end

      def destroy
        @forum.destroy
        reorganize_positions
        destroy_successful
      end

      def change_position
        Forem::ChangePosition.new(@forum, params[:direction]).process
        update_successful
      end

      private

      def forum_params
        params.require(:forum).permit(:category_id, :title, :description, { :moderator_ids => []})
      end

      def find_forum
        @forum = Forem::Forum.friendly.find(params[:id])
      end

      def create_successful
        flash[:notice] = t("forem.admin.forum.created")
        redirect_to admin_forums_path
      end

      def create_failed
        flash.now.alert = t("forem.admin.forum.not_created")
        render :action => "new"
      end

      def destroy_successful
        flash[:notice] = t("forem.admin.forum.deleted")
        redirect_to admin_forums_path
      end

      def update_successful
        flash[:notice] = t("forem.admin.forum.updated")
        redirect_to admin_forums_path
      end

      def update_failed
        flash.now.alert = t("forem.admin.forum.not_updated")
        render :action => "edit"
      end

      def reorganize_positions
        Forem::Forum.reorganize_positions(@forum.category_id, @forum.position)
      end

    end
  end
end
