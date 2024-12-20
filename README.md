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
   ![Analyze an Expense](path_to_gif_or_image.gif)

2. **Reports Chart**  
   The chart visualizes the user's expenses as colored dots based on their category. The chart dimensions are derived from the **Better-Worse coefficients** of each expense:
   - **X-axis (Horizontal):** Represents whether an expense is a basic need or one-dimensional performance feature.
   - **Y-axis (Vertical):** Represents how attractive or indifferent the expense is.

   By interpreting the chart, users can identify which types of expenses dominate their spending habits.  
   ![Reports Chart](path_to_reports_chart.png)

3. **Recommendation Box**  
   The recommendation box provides tailored suggestions based on the analyzed expenses:
   - **Criteria:** Highlights the importance of a particular type of expense.
   - **Suggestions:** Offers actionable advice to improve financial habits.

   Example:  
   - *Criteria:* High impact on satisfaction but not critical.  
   - *Suggestions:* These expenses enhance quality of life. Allocate your budget wisely but avoid overindulgence.  
   ![Recommendation Box](path_to_recommendation_box.png)
