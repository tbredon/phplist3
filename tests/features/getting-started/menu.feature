
@javascript
Feature: Navigate the app using the menu
  In order to access different application pages
  As an admin user
  I need to be able to view and navigate navigation menu links

  Scenario Outline: Use main menu navigation links
    Given I have logged in as an administrator
    Then I should see "<Pagename>"
    Examples:
      | Pagename                  |
      | dashboard                 |
      | subscribers               |
      | campaigns                 |
      | statistics                |
      | system                    |
      | config                    |
      | develop                   |
     Then I should see "Recently Visited"
     Then I should see "logout"
     Then I should see "Dashboard"


    Scenario Outline: Browse Subscribers menu
        Given I have logged in as an administrator
        Given I follow "Subscribers"
        Then I should see "<Innerpages>"
        Examples:
         | Innerpages                |
         | Search subscribers        |
         | Manage subscribers        |
         | Configure attributes      |
         | Subscriber lists          |
         | Import subscribers        |
         | Export subscribers        |
         | View bounces per list     |
         | Suppression List          |
         | Reconcile subscribers     |

    Scenario Outline: Browse Campaigns menu
        Given I have logged in as an administrator
        Given I follow "Campaigns"
        Then I should see "<Innerpages>"
        Examples:
         | Innerpages                |
         | Send a campaign           |
         | List of campaigns         |
         | Manage campaign templates |
    
    Scenario Outline: Browse Statistics menu
        Given I have logged in as an administrator
        Given I follow "Statistics"
        Then I should see "<Innerpages>"
        Examples:
         | Innerpages                |
         | Statistics overview       |
         | View Opens                |
         | Campaign click statistics |
         | URL click statistics      |
         | Domain statistics         |

    Scenario Outline: Browse System menu
        Given I have logged in as an administrator
        Given I follow "System"
        Then I should see "<Innerpages>"
        Examples:
         | Innerpages                |
         | Update translations       |
         | Verify the DB structure   |
         | Log of events             |
         | Initialise the database   |
         | Upgrade phpList           |
         | Manage bounces            |
         | Send the queue            |
         | Rebuild DB indexes        |
         | system                    |
     Scenario Outline: Browse Config menu
        Given I have logged in as an administrator
        Given I follow "Config"
        Then I should see "<Innerpages>"
        Examples:
         | Innerpages                         |
         | Checklist                          |
         | Settings                           |
         | Manage plugins                     |
         | Subscribe pages                    |
         | Bounce rules                       |
         | Check bounce rules                 |
         | Categorise lists                   |
         | Manage administrators              |
         | Edit or add an administrator       |
         | Import administrators              |
         | Configure administrator attributes |
    
#    Scenario Outline: Browse Develop menu
#        Given I have logged in as an administrator
#        Given I follow "Develop"
#        Then I should see "<Innerpages>"
#        Examples:
#         | Innerpages                |
#         | Subscriber statistics     |
#         | tests                     |
         
    
