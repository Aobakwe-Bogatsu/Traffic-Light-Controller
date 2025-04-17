# Traffic-Light-Controller

This project simulates a **traffic light controller** using the **PIC16F627 microcontroller**. The system cycles through three main states: **Red → Green → Yellow → Red** and includes a **pedestrian button** to safely interrupt the sequence for pedestrian crossing.

---

## 📋 Project Description

The controller is implemented in Assembly language using **PIC Simulator IDE**. It performs the following functions:

- Cycles automatically through Red, Green, and Yellow lights.
- Detects input from a **pedestrian button**.
- When pressed, the pedestrian crossing state activates:
  - Red traffic light is ON for **10 seconds**.
  - Green pedestrian light is ON for **10 seconds**.
- After the pedestrian crossing state completes, the traffic light resumes its previous cycle.

---

## 🧰 Tools Used

- **Software**: PIC Simulator IDE  
- **Microcontroller**: PIC16F627  
- **Language**: Assembly (ASM)

---

## 🗂️ How to Open the Project

1. Open **PIC Simulator IDE**.
2. Go to `File > Open` or click the **Open File** icon.
3. Select the `traffic_light.asm` file from this project directory.
4. Load the file into the IDE.

---

## 🛠️ How to Run the Simulation

Follow these steps in **PIC Simulator IDE**:

### 1. Setup

- Set the **Microcontroller** to `PIC16F627`
- Set the **Clock Frequency** to `4.0 MHz`

### 2. Open Peripheral Views

- Open **Microcontroller View**:  
  `Tools > Microcontroller View`
- Open **8 x LED Board**:  
  `Tools > 8 x LED Controller`

### 3. Simulate

- Start simulation:  
  `Simulation > Start`
- Stop simulation:  
  `Simulation > Stop`

---

## 💡 Pin Configuration

| Pin  | Function                  |
|------|---------------------------|
| RB0  | Red Traffic Light         |
| RB1  | Yellow Traffic Light      |
| RB2  | Green Traffic Light       |
| RB3  | Pedestrian Button (Input) |
| RB6  | Green Pedestrian Light    |
| RB7  | Red Pedestrian Light      |

---

## 📂 Project Files

- `traffic_light.asm` – Main Assembly source code
- `traffic_light.hex` – Compiled HEX file 
- `README.md` – Project documentation (this file)

---

## 📄 Results Document

A Word document with simulation screenshots and descriptions of each traffic state and pedestrian mode is included:

👉 [traffic light controller results.docx](traffic light controller results.docx)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).  
You are free to use, modify, and distribute it with proper credit.

---

## 🙋‍♂️ Author

**Aobakwe Bogatsu**  
Computer Systems Engineering Student  

