# README

* Initial Setup
- Initiate Project
    - rails new creators_payouts_app -d postgresql --css=tailwind --javascript=esbuild
    - Integrate tailwind
        - ./bin/bundle add tailwindcss-rails
        - ./bin/rails tailwindcss:install
    - bin/setup
    - bin/dev
- Create Database
    - rails db:create
- Generate Creator and Payout models
    - rails g model Creator name:string email:string status:integer
    - rails g model Payout creator:references amount:decimal status:string paid_at:datetime
    - rails db:migrate
- Set up model
    - Code assumptions for using enums
        - Used enum for more flexibility rather . For instance, creator status can have values like "Blocked" or "Suspended"
        - Used enum for more flexibility. For instance, payout status can have values like "In Transit" for next day transfers or "Failed" for failed transactions
    