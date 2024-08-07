##### General overview:

###### Table structure

![Table relations](https://i.imgur.com/AkQLgjn.png "Table relations")

###### Explanation

- There are 9 tables in this database. I will explain the functionality of each table separately, but the general purpose of the database is to store user data, product data, and sales data which is related to both entities. As mentioned in the assignment, either a user or a product can have discount coupons at a given time. These coupons can be applied simultaneously or separately, or not at all. If two coupons are active at the same time, their discounts should be combined. For example, if an item has a 10% coupon and the user has a VIP subscription that provides a 7% discount, the total discount would be 17%. I will provide more details about the VIP system later. The database also stores user login information, including usernames and hashed passwords. Next, I will explain the functionality and relationships of each table.

- Tables and description:
  - Users:
    Each user has its own user id, which is the primary key of the table, it is autoincremental so as new users are being created the index updates accordingly. It stores the passwords in a VARCHAR type of column, the passwords are meant to be stored in a hashed way, hence the max length size. The table also stores personal user information such as name, date of birth and email. As well as metadata indicating the user create date an update date. Type indicates whether a user is a regular user, an admin, or in this case, a VIP member, which has exclusive discounts based on a monthly membership. Newsletter indicates if the user is subscribed to the website's newsletter.
  - User Type:
    Indicates all of the different roles a designated user can be.
  - VIP:
    The VIP table's main focus is on tracking users subscribed to the VIP program. The VIP program is an optional, loyalty-based subscription system where users can choose to pay a monthly membership fee to receive exclusive discounts on all products sitewide. The loyalty-based system means that the longer a user remains subscribed, the greater their perks become over the subscription period. If a user cancels their subscription, they lose all their perks. If they resume their membership, the loyalty system also resets. It is important to note that the foreign key for the user is unique, meaning that a user can only have one active VIP subscription at a given time. When a user cancels their subscription, the "end_date" field is populated, and the status changes to inactive (0). If the same user subscribes again, the start date is updated, the end date is cleared, and the status returns to active. The tier calculation is based on comparing the current date to the start date and extracting the number of months. All billing information should ideally be stored in a junction table with the VIP ID and a billing date, which relates to the original VIP table. However, due to time constraints, this could not be implemented.
  - VIP Tiers:
    Names of the different VIP tiers, their minimum length required (expressed in months), and the discount rate (expressed in percentages).
  - Product:
    One of the main tables in the database, stores the product name, metadata such as the date added and modified, the base price, attached coupons, the physical stock of the product, and its category. Ideally, there would be an additional junction table to log every change to the products, but due to time constraints, this was not possible.
  - Categories:
    The different categories the products belong to.
  - Coupons:
    In this table we store the coupons that are assigned to the individual products, as well as if they're active at the moment or not. This state validation should happen within the code of the project the database is designed for.
  - Sales:
    In this table, we store all of the sales made. The user that made them, the date that it occurred and the grand total of the purchase, including all user and product discounts, if any.
  - Sales junction:
    In this junction table we expand on the sales table for the possibility of multiple items being in the buyers purchase. Also, here is where all of the discounts should be individually applied to the products, taking into account the product discount, if any, or the user discount, if any.

##### Conclusion

In conclusion, the database schema I designed effectively addresses both user management and coupon functionalities. It securely stores user login details, such as usernames and hashed passwords, along with additional personal information and user roles. This setup accommodates different user types and their respective permissions. For handling coupons, the schema includes mechanisms to manage and apply discounts both at the product level and for individual users and tracks how these discounts are applied during sales. Overall, I think the schema meets the requirements for efficiently managing user data and processing discounts.
