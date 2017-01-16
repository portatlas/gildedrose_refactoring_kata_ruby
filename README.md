# Project Title

Gilded Rose Refactoring Kata in Ruby

## About

This was a pairing excercise to refactor existing code in Ruby. Apart from the requirements, there were no clear instructions and test were not provided. My pair and I created an approach to write test, refactor, and then add additional feature requirements. This was a great excercise to get familar with working on existing code base.

### Process

1. Read, analyze, and clarified the requirements with my pair
2. Timeboxed reviewing the legacy code to get an understanding of what is going on
3. Ran the initial rspec test that was provided and created test for each requirement
4. Refactored the legacy code
   a. Quick Wins - clean up the nested ifs
   b. Refactored repetitive logic by writing methods for redundant logic and creating constances for redundant values
   c. Refactor methods for single responsibility and readibility
5. Add the new feature requirement


## Running the tests

The tests were written in rspec.

To run the test:
```
rspec gilded_rose_spec.rb
```

### Takeaways

1. In hindsight writing the test was actually more insightful to understand the requirements than reading the legacy code as it was convulted with multiple nested if statements. This is based on the assumption that the legacy code met all the requirements.
2. Writing test were critical for refactoring successfully. Before refactoring I got a question from my pair of whether I am confident refactoring with the current test. Going forward, I needed to think about all the edgecases that I should test in order to make refactoring painless and ensure the code meets the requirements.
3. After creating the test, I was initially tempted to abandon the legacy code and rewrite the code from scratch. Thankfully, my pair raised some concerns. I am glad I didn't do that because for one that is not always a feasible approach, the purpose of the excercise was to refactor, and it turned out to be easier to refactor. Once I was able to align the requirements with the existing code, I had a better grasp of how I could refactor the code.

### Potential To Dos
1. Refactor #update_quality_for_item_positive_sellin. Having conditional statements handle each item will not be ideal assuming the variety of items increase as the business grows. Since the item categories are currently small, I decided not to refactor for now. I believe one scalable approach to handle multiple items with different rules is to write methods to handle the rules and tag items to be treated based on those rules. Currently, the code is checking for an item and applying rules. I feel like in the real world situation there would be more items than business rules so a different approach might be feasible. However, I can not make that assumption with the current requirements and since the requirements prevented me from updating the items this might not be a feasible approach for now.

## Acknowledgments

* Emily Bache for Creating the Kata which can be found here https://github.com/emilybache/GildedRose-Refactoring-Kata/tree/master/ruby
* Tony Baik for Pairing with me
