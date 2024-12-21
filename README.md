# **MoneyCat**
### An intuitive app for university students to track their expenses, analyze spending habits, and improve financial decision-making.

## Motivation

### 1. Our Investigation
Our survey of college students revealed two critical insights:
. **Do students track their spending?**
   - Approximately **46.7% of students track their spending**, while **53.3% do not**.  
   <img src="問卷調查結果/IMG_7608.JPG" alt="Pie Chart - Spending Habit" width="300">

 **Does tracking spending change financial habits?**
   - Among those who do track their spending, only **51% successfully changed their financial habits**, while **49% did not**.  
   <img src="問卷調查結果/IMG_7609.JPG" alt="Pie Chart - Spending Habit" width="300">

These results show that while many students try to track their spending, doing so does not necessarily lead to meaningful changes in their financial habits.

---

### 2. Questions to Current Apps
Despite the availability of numerous expense tracking apps, several questions remain unanswered:
- **Does tracking expenses really help us save money?**
- **How can expense tracking become a more practical tool for college students, especially given the increasing financial pressure they face?**
- Many existing apps focus on making expense tracking **fun** rather than **effective**, prioritizing gamified features over genuinely helping users save money.

---

### 3. Our Aim
To address these gaps, our goal is to create an app that emphasizes **practicality and effectiveness**. MoneyCat is designed with three main functions to help students not only track their expenses but also make better financial decisions:

a. **Need vs. Want Categorization**  
   - Students can identify whether their expenses are necessities or discretionary, allowing for clearer financial planning.

b. **KANO Analysis**  
   - A unique feature that helps users analyze and rate their expenses based on their impact on satisfaction and financial goals.

c. **Personalized Spending Suggestions**  
   - Based on their spending patterns, users receive actionable advice to help them save money and make informed financial choices.

## KANO Model Analysis

The **KANO Model** is a framework we use to analyze and categorize user needs. It allows us to evaluate the impact of different features on user satisfaction and prioritize their implementation. The model breaks down features into the following categories:

### 1. KANO Model Overview
![KANO Model Diagram](問卷調查結果/Kano_Model_Dimensions-1024x642.jpg)

- **Basic Needs (Must-be Requirements):** These are essential features that users expect. Failing to meet these needs results in dissatisfaction, but meeting them does not necessarily lead to high satisfaction.
- **Performance Needs (One-dimensional):** These needs directly impact satisfaction. The more these needs are fulfilled, the higher the satisfaction.
- **Attractive Needs (Excitement):** These are unexpected features that delight users and exceed their expectations.
- **Indifferent Needs:** These features do not significantly impact user satisfaction, whether present or absent.
- **Reverse Needs:** Features that, if overemphasized, may lead to dissatisfaction.

---

### 2. Questionnaires for User Needs Analysis
We use the following questions to evaluate user requirements based on the KANO Model:

#### **Basic Needs (Must-be Requirements)**
- **Question 1:** Does this product help improve your life?  
  (1 = Not helpful at all, 5 = Very helpful)
- **Question 2:** If this product did not exist, would it negatively impact your life?  
  (1 = No impact at all, 5 = Significant negative impact)

#### **Attractive Needs (Excitement Requirements)**
- **Question 3:** Does this product bring happiness or excitement?  
  (1 = Not at all, 5 = Very much)
- **Question 4:** If you didn't have this product, would you feel regretful?  
  (1 = Not at all, 5 = Very much)

#### **Performance Needs (One-dimensional Requirements)**
- **Question 5:** Does this product meet your expected value (e.g., price, durability)?  
  (1 = Not at all, 5 = Very much)
- **Question 6:** Do you think other products could surpass this one's value?  
  (1 = Not at all, 5 = Very much)

#### **Indifferent Needs**
- **Question 7:** If the product came with a free gift, how would you feel?  
  (1 = Very happy, 5 = No feeling at all)
- **Question 8:** If the product did not come with a free gift, how would you feel?  
  (1 = Very happy, 5 = No feeling at all)

---

### 3. Calculation of Better-Worse Coefficients
The KANO Model helps derive the **Better-Worse Coefficients**, which are used to evaluate the impact of features on satisfaction:

- **Better Coefficient (Positive Impact):**  
  Measures how strongly the presence of a feature improves user satisfaction.
- **Worse Coefficient (Negative Impact):**  
  Measures how strongly the absence of a feature decreases user satisfaction.

Formulas:  
- **Better Coefficient** = (Calculated Value based on survey responses)  
- **Worse Coefficient** = (-1) × (Calculated Value based on survey responses)

- A **Better Coefficient** close to **1** indicates the feature has a significant positive impact on satisfaction.  
- A **Worse Coefficient** close to **-1** indicates the absence of the feature has a strong negative impact.

---

### 4. Conclusion and Recommendations
The following categories summarize user needs:
- **Basic Needs:** These must be fulfilled to prevent dissatisfaction.
- **Performance Needs:** Meeting these improves satisfaction proportionally.
- **Attractive Needs:** Exceeding expectations with these features leads to delight and user loyalty.
- **Indifferent Needs:** These features can be deprioritized.

MoneyCat integrates the KANO Model to ensure we prioritize features that maximize user satisfaction while avoiding unnecessary features that don’t provide value.

# **Project Demo**

## 1. Reports Page

The Reports Page serves as the analytical hub of the app, where users can gain insights into their spending patterns and receive tailored suggestions.

### Key Features:

1. **Analyze an Expense (GIF Demonstration)**  
   Users can analyze an expense to determine its impact on their overall satisfaction and financial priorities. This is done through the KANO analysis process.  
   ![Analyze an Expense](Demo/Analyze_an_Expense.gif)

2. **Reports Chart**  
   The chart visualizes the user's expenses as colored dots based on their category. The chart dimensions are derived from the **Better-Worse coefficients** of each expense:
   - **X-axis (Horizontal):** Represents whether an expense is a basic need or one-dimensional performance feature.
   - **Y-axis (Vertical):** Represents how attractive or indifferent the expense is.

   By interpreting the chart, users can identify which types of expenses dominate their spending habits.  
   ![Reports Chart](Demo/reports_chart.png)

3. **Recommendation Box**  
   The recommendation box provides tailored suggestions based on the analyzed expenses:
   - **Criteria:** Highlights the importance of a particular type of expense.
   - **Suggestions:** Offers actionable advice to improve financial habits.

   Example:  
   - *Criteria:* High impact on satisfaction but not critical.  
   - *Suggestions:* These expenses enhance quality of life. Allocate your budget wisely but avoid overindulgence.  
   ![Recommendation Box](Demo/recomendation_box.png)

## 2. Add Expense Page

The Add Expense Page allows users to quickly and easily input their expenses, ensuring a seamless experience for tracking their spending.

### Key Features:

1. **Input Expense Details**
   Users can input the following details for each expense:
   - **Amount:** Specify the amount spent.
   - **Category:** Choose a category for the expense (e.g., food, entertainment, transportation).
   - **Date:** Select the date of the expense.
   - **Note:** Add optional notes for additional context.
   - **Need or Want:** Categorize the expense as a necessity or a discretionary item.

   ![Add an Expense](Demo/Add_an_expense.gif)

2. **User-friendly Interface**
   The interface is designed to minimize friction:
   - Dropdowns and pickers make selection quick and intuitive.
   - Clear labeling ensures users can easily input and categorize their expenses.

3. **Purpose**
   This page lays the foundation for effective financial analysis by enabling accurate and consistent data entry. By distinguishing between "Needs" and "Wants," users gain a better understanding of their spending priorities.

---

## 3. Expense Overview Page

The Expense Overview Page provides users with a detailed and visualized breakdown of their spending habits. It combines clear summaries, interactive charts, and advanced filtering options to ensure ease of use and financial insight.

   <img src="path_to_gif.gif" alt="Bar Chart and Pie Chart GIF" width="400">

### Key Features:

#### 1. Interactive Bar Chart and Pie Chart Visualization
   - **Bar Chart:**  
     Displays overall spending trends across different time ranges (week, month, year). This chart is particularly useful for identifying patterns and monitoring spending over time.  
     Example: A user can quickly see if their spending increased significantly in a specific category during the current month.

   - **Pie Chart:**  
     Offers a percentage breakdown of spending by category. This allows users to clearly understand the proportion of their expenses in areas like food, entertainment, or utilities.  
   ![Bar Chart Example](Demo/bar_chart.png)  
   ![Pie Chart Example](Demo/pie_chart.png)

---

#### 2. Top Box Summary
   - **Total Spending:**  
     The top box dynamically updates to show the total amount spent for the selected time range (week, month, or year).  

   - **Top Spending Category:**  
     Highlights the category where the highest expenditure occurred. For instance, if a user spent the most on "3C" during the month, the top category will display this result prominently.

 ![Top Box](Demo/top_box.png)


   Example:  
   - Total: **$2,440**  
   - Top Category: **3C**  

---

#### 3. Advanced Search and Filter Options
   - **Search Bar:**  
     Users can search for specific expenses by keywords, such as "groceries" or "rent."  
   - **Filter Options:**  
     Filters allow users to organize their expenses based on criteria like:
     - Alphabetical order (A-Z or Z-A)  
     - Expense amount (low-to-high or high-to-low)  
     - Date of entry  

   ![expense list](Demo/list.png)

---

#### 4. Detailed Expense List
   - Below the charts, users can review a detailed list of all expenses for the selected time range.  
   - Each entry includes:  
     - **Expense Title**  
     - **Amount**  
     - **Category**  
     - **Additional Notes**  

   Example Entry:  
   - **Title:** HI  
   - **Amount:** $500  
   - **Category:** Health  

---
## 4. Settings Page

The Settings Page provides users with options to customize the app and manage their preferences effectively. It ensures the app adapts to individual needs, enhancing user experience.

### Key Features:

#### 1. Add Category
   - Users can create their own categories by:
     - **Selecting a color** for the category to make it distinct on the reports chart.
     - **Naming the category**, allowing better tracking and customization.
   - This feature ensures that reports are personalized and visually clear.  

   Example:  
   - A user can add a new category for “Drink” and assign it a custom color to easily identify related expenses in the reports chart.  

   <img src="Demo/Add_Category.gif" alt="Add Category Demo" width="400">

---

#### 2. Other Customization Options
   The settings page includes additional features to manage the app:
   - **Language Settings:** Choose the app’s language based on user preference.
   - **Theme Settings:** Switch between different color themes to personalize the app’s appearance.
   - **Notification Preferences:** Manage reminders and notifications for expense tracking.

#### 3. Account and Data Management (Unfinished)
   - **User Profile:** Manage account details and preferences.
   - **Account Management:** Update or modify account settings.  
   - **Erase All Data:** Clear all stored expenses and reset the app. This is useful for starting fresh or managing privacy.

   <img src="Demo/Settings_Page.png" alt="Settings Page" width="400">

---

## Conclusion

MoneyCat is designed to help users better understand and control their spending habits. Through features like customizable categories, insightful reports, and expense analysis powered by the KANO model, the app ensures that users can make informed financial decisions.

### Why MoneyCat Stands Out:
- Combines expense tracking with meaningful insights and actionable recommendations.
- Offers a user-friendly interface tailored for college students.
- Empowers users to categorize and visualize expenses effectively, enhancing financial literacy.
