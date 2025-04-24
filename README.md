# 🔐 8086 Assembly Secure Room Access System

## 📌 Overview

This project implements a secure room access system using 8086 Assembly language for the **Computer Organization and Assembly Language (ENCS336)** course. The system simulates a security lock for a company with 10 employees. Each employee is identified by a unique 16-bit ID and an 8-bit password.

The system allows employees to access a secure room only after successful authentication based on their ID and password. 

---

## 👤 Employee Authentication Process

Employees are required to input:

- **Employee ID (16-bit number)**
- **Password (8-bit number)**

Once entered, the program checks the credentials and displays:

**Access Allowed**
or
**Access Denied**


based on whether the credentials match the stored encrypted data.

---

## 🔒 Password Encryption Scheme

The employee passwords are stored in memory in encrypted form. The encryption method is defined as:

1. If the **most significant bit (MSB)** and **least significant bit (LSB)** of the password are **not equal**:
   - Swap the MSB and LSB.
2. If the **MSB and LSB are equal**:
   - Rotate the password **right by 2 bits**.

This ensures a simple but effective transformation of the original password before storage. The system expects users to input their **unencrypted password**, and the program applies the same encryption logic at runtime to verify access.

---

## 🛠️ How the Program Solves It

The assembly code performs the following:

- **Initializes memory** with a list of 10 employee IDs and their **encrypted passwords**.
- Accepts **ID and password input** from the user:
  - Password input uses **INT 21h, function 08h** to read characters without displaying them on screen.
- Applies the **encryption algorithm** on the entered password:
  - Checks MSB and LSB.
  - Performs either bit-swapping or rotates right by 2 bits.
- **Searches the stored data** for the entered ID.
- If found, compares the encrypted input password with the stored encrypted password.
- Displays **Access Allowed** or **Access Denied** message accordingly.

---

## 💾 Stored Data Example

The following are the 10 employee credentials (IDs and original passwords) used:

| Employee ID | Original Password |
|-------------|-------------------|
| 65          | 125               |
| 148         | 84                |
| 526         | 29                |
| 2036        | 37                |
| 1504        | 187               |
| 82          | 219               |
| 112         | 62                |
| 2840        | 75                |
| 940         | 141               |
| 1292        | 243               |

Passwords are encrypted using the described scheme **before** being stored in memory.

---

## 📂 Project Files

- `CODE_ASM.asm` – Complete 8086 Assembly source code.
- `Assembly_Project.pdf` – Project assignment description and requirements.
- `Project_Report.pdf` – Project Report shows our solution by providing screenshots.
---

## 📚 Acknowledgments

This project was developed as part of the coursework for:

**ENCS336 – Computer Organization and Assembly Language**  
Semester: *Fall 2024/2025*
---

