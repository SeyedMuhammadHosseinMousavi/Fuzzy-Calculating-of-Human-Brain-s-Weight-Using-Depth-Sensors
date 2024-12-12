# Fuzzy Calculating of Human Brain’s Weight Using Depth Sensors
### Link to the paper:
- https://www.researchgate.net/publication/328558987_Fuzzy_Calculating_of_Human_Brain's_Weight_Using_Depth_Sensors
### Please cite :    
- Mousavi, Seyed Muhammad Hossein. "Fuzzy Calculating of Human Brain’s Weight Using Depth Sensors." 2nd Iranian Symposium on Brain Mapping (ISBM2018). Vol. 10. National Brain Mapping Lab (NBML), 2018.


## Abstract
This paper presents a novel, cost-effective, and non-invasive method for estimating human brain weight using depth sensors, such as Kinect V.2. The proposed method is aimed at detecting abnormalities like **Microcephaly** and **Macrocephaly**, which are typically diagnosed through expensive and time-consuming MRI imaging. By leveraging depth data and fuzzy classification, the method achieves promising results with a recognition accuracy of **97.2%** for three classes: **Normal**, **Microcephaly**, and **Macrocephaly**.

### Key Features:
- **Fast and Low-Cost**: Uses depth sensors instead of MRI, reducing time and financial costs.
- **Non-Invasive**: Does not expose individuals to magnetic fields or radiation.
- **Real-Time Applicability**: Designed for real-time processing and decision-making.
- **Fuzzy Classification**: Employs fuzzy logic for robust and interpretable classification.

---

## Methodology
1. **Data Acquisition**:
   - Two depth images (front and side views) are recorded using Kinect V.2 sensors.
   - The depth data is preprocessed to create a 3D model of the subject's head.

2. **3D Model Reconstruction**:
   - Depth images are registered using **non-rigid registration** techniques to create a full 3D representation of the head.
   - Skull and skin volumes are removed (~10% of the total volume) to estimate brain volume.

3. **Brain Weight Calculation**:
   - The brain volume is normalized based on age-specific average brain weights.
   - The volume is converted to weight using a custom mapping.

4. **Fuzzy Classification**:
   - The estimated brain weight is classified into one of three categories: **Normal**, **Microcephaly**, or **Macrocephaly**.
   - Fuzzy sets and linguistic variables are used for classification.

5. **Validation**:
   - Tested on 10 subjects (6 normal, 4 abnormal).
   - Achieved a **mean squared error (MSE)** of 2.8% compared to actual brain weights.

---

## Results
- Recognition Accuracy: **97.2%**
- Classification Categories:
  - **Normal**
  - **Microcephaly**
  - **Macrocephaly**
- Mean Squared Error (MSE): **2.8%**

---




![image](https://github.com/user-attachments/assets/2fc246d2-abce-4b08-bf52-60abd9b316c6)
![image](https://github.com/user-attachments/assets/65920989-854a-4944-951a-2a637db6cf8e)
![111](https://github.com/user-attachments/assets/c21acca7-b6be-4378-aa0b-3cb3a7f146c6)

![image](https://github.com/user-attachments/assets/b9b6309c-8efd-4541-b2d9-3cc6b7632c5d)
![image](https://github.com/user-attachments/assets/5631958e-cf37-493e-a643-ab3bcd1c1175)
![image](https://github.com/user-attachments/assets/a41bc11f-bd15-45d9-90e7-d1f1726a93e8)
![image](https://github.com/user-attachments/assets/626aa93e-5389-44f2-bf73-03fd36808d33)
