@mod @mod_workshop @accessibility
Feature: Workshop colour mode accessibility
  In order to take part in a workshop in either colour mode
  As a user
  I need mod_workshop to meet the same accessibility standards whichever colour mode is in use

  The light examples are the baseline: each pair checks the same page, so a failure which only appears in the
  dark example is a colour mode regression rather than a pre-existing problem with the page itself.

  Background:
    Given the following config values are set as admin:
      | enablecolourmodes | 1 | theme_boost |
    And the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | One      | teacher1@example.com |
      | student1 | One       | Student  | student1@example.com |
      | student2 | Two       | Student  | student2@example.com |
    And the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | student1 | C1     | student        |
      | student2 | C1     | student        |
    And the following "activities" exist:
      | activity | name       | course | submissiontypetext |
      | workshop | Workshop 1 | C1     | 2                  |
    And I am on the "Workshop 1" "workshop activity" page logged in as teacher1
    And I edit assessment form in workshop "Workshop 1" as:
      | id_description__idx_0_editor | Aspect1 |
    And I change phase in workshop "Workshop 1" to "Submission phase"
    And I am on the "Workshop 1" "workshop activity" page logged in as student1
    And I add a submission in workshop "Workshop 1" as:
      | Title              | Submission 1         |
      | Submission content | Submission 1 content |
    And I am on the "Workshop 1" "workshop activity" page logged in as student2
    And I add a submission in workshop "Workshop 1" as:
      | Title              | Submission 2         |
      | Submission content | Submission 2 content |
    And I am on the "Workshop 1" "workshop activity" page logged in as teacher1
    And I change phase in workshop "Workshop 1" to "Assessment phase"
    And I log out

  @javascript
  Scenario Outline: The phase planner and grading report meet accessibility standards in <mode> mode
    Given the following "user preferences" exist:
      | user     | preference             | value  |
      | teacher1 | theme_boost_colourmode | <mode> |
    When I am on the "Workshop 1" "workshop activity" page logged in as teacher1
    Then the page should meet accessibility standards with "best-practice" extra tests

    Examples:
      | mode  |
      | light |
      | dark  |

  @javascript
  Scenario Outline: A submission meets accessibility standards in <mode> mode
    Given the following "user preferences" exist:
      | user     | preference             | value  |
      | teacher1 | theme_boost_colourmode | <mode> |
    And I am on the "Workshop 1" "workshop activity" page logged in as teacher1
    When I click on "Submission 1" "link"
    Then the page should meet accessibility standards with "best-practice" extra tests

    Examples:
      | mode  |
      | light |
      | dark  |

  @javascript
  Scenario Outline: The manual allocation screen meets accessibility standards in <mode> mode
    Given the following "user preferences" exist:
      | user     | preference             | value  |
      | teacher1 | theme_boost_colourmode | <mode> |
    And I am on the "Workshop 1" "workshop activity" page logged in as teacher1
    When I follow "Submissions allocation"
    Then the page should meet accessibility standards with "best-practice" extra tests

    Examples:
      | mode  |
      | light |
      | dark  |
