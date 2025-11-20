
This project involved the complete mechanical and electronic rework of a deprecated 6-Degrees-of-Freedom (6DOF) robotic arm design, culminating in a custom control system capable of stable, coordinated motion using multiple input sources.

---
### **Mechanical & Hardware Rework**

- **Design Rework and Component Integration:** Successfully **reworked and fixed a deprecated robotic arm design**. This required adapting the existing structure and mechanical constraints to function seamlessly with **off-the-shelf components** (Commercial Off-the-Shelf or COTS).

- **Complex Actuator System:** The design required the stable control and coordination of **over nine motors** (servos and steppers) to achieve smooth, predictable 6DOF movement, which is essential for complex tasks like object manipulation.
---
### **Electronic Integration & Motion Control**

- **Microcontroller and Driver Integration:** Implemented the core electronic control system using an **Arduino Uno** as the central processing unit. This required interfacing with specialized motor drivers:
    
    - **PCA9685 Servo Driver:** Used to manage and precisely control the multiple servo motors required for fine angular movement.
    - **A4988 Stepper Driver:** Used to control the stepper motors, ensuring accuracy and repeatable positioning.
    
- **Coordinated Input System:** Programmed the system to read and process input from **two separate joystick inputs**. The firmware was engineered to **coordinate these inputs** to translate joystick commands into stable, simultaneous movements across the arm's many axes.

- **Stable Motion Delivery:** The final achievement was developing the control logic necessary to deliver **stable and repeatable motion**, managing the communication and power requirements for the nine-plus motors to move in concert rather than conflicting with one another.