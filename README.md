# Simple Survey

## Project Overview

This is a simple **Survey Tool** built with **Ruby on Rails 7.1.2** and **Ruby 3.2**. It allows users to create surveys, vote (Yes/No), and view real-time statistics. The app includes pagination, percentage calculations, and a mobile-friendly UI.


## Requirements

Ensure you have the following installed before running the app:

- **Ruby** 3.2
- **Rails** 7.1.2
- **SQLite3** (default database)
- **Bundler** (for gem dependencies)


## Installation & Setup

### 1️⃣ Clone the Repository

```sh
$ git clone https://github.com/swawibe/simple-survey.git
$ cd simple-survey
```

### 2️⃣ Install Dependencies

```sh
$ bundle install
```

### 3️⃣ Set Up the Database

```sh
$ rails db:create db:migrate
```

### 4️⃣ Start the Rails Server

```sh
$ rails server
```

Now visit [**http://localhost:3000/**](http://localhost:3000/) in your browser! 🎉

Also, you can see the demo here: [**https://simple-survey.onrender.com/**](https://simple-survey.onrender.com/)


## Features

✅ **Create Surveys** – Users can create a survey with a single Yes/No question.\
✅ **Vote on Surveys** – Users can respond to surveys multiple times.\
✅ **Real-Time Results** – The app calculates and displays Yes/No percentages dynamically.\
✅ **Pagination** – Surveys are paginated for better navigation.\
✅ **Mobile-Friendly UI** – Fully responsive using **Bootstrap**.\
✅ **Edit Surveys** – Users can update survey questions.\
✅ **Back Navigation** – Users are redirected back to the last paginated page after voting.


## Usage Guide

### 📝 Create a Survey

1. Click the **"New Survey"** button on the homepage.
2. Enter your survey question.
3. Click **"Create Survey"** – It appears in the list.

### ✅ Vote on a Survey

1. Click on a survey from the homepage.
2. Click **"Yes"** or **"No"** to submit a response.
3. The survey results update automatically.

### 📊 View Results

- The homepage displays the **Yes/No percentages** for each survey.
- Click on a survey to view detailed responses.

### 🔄 Pagination

- The homepage lists surveys with **pagination(default: 20 surveys/page)**.
- Clicking "Next" or "Previous" navigates through surveys.
- After voting, the user is **redirected back to the last paginated page**.


## Notes

- This app does **not** include user authentication.
- It uses **SQLite3** as the default database.
- Built with **Bootstrap** for UI enhancements.

## 🧪 Testing with RSpec and SimpleCov

This project uses **RSpec** for testing and **SimpleCov** for code coverage.

### 1️⃣ Install SimpleCov

SimpleCov is already added to the `Gemfile` to track code coverage for your tests. It is initialized automatically when you run the tests.

If you need to install the necessary gems for testing, run:

```sh
$ bundle install
```

### 2️⃣ Running RSpec Tests

To run your RSpec tests and see the output, use the following command:

```sh
$ bundle exec rspec
```

This will run the tests in the `spec` directory and display the results in the terminal.

### 3️⃣ View Test Coverage Report

Once the tests are executed, SimpleCov will generate a coverage report. You can view the detailed test coverage by opening the generated `coverage/index.html` file in your browser.

```sh
$ open coverage/index.html
```

This will show you a detailed coverage report that includes:

- **Percentage of lines covered by tests**
- **Covered and uncovered files**
- **Details on which lines of code were covered and which were not**

### 4️⃣ Example RSpec Command Output

When running the tests, you'll see output like this:

```sh
$ bundle exec rspec
.

Finished in 0.05 seconds (files took 0.15367 seconds to load)
1 example, 0 failures, 0 pending
```

SimpleCov will also display a summary of test coverage at the end of the test output.


## Support

For any issues, please contact at swawibe.alam@queensu.ca 😊

