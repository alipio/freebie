# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( admin.css )

Rails.application.config.assets.precompile += %w( home_bg.jpg )
Rails.application.config.assets.precompile += %w( finding_stuffs.jpg )
Rails.application.config.assets.precompile += %w( campaign.jpg )
Rails.application.config.assets.precompile += %w( donations_hires.jpg )
Rails.application.config.assets.precompile += %w( find_stuff_2.jpg )
Rails.application.config.assets.precompile += %w( clothes.jpg )