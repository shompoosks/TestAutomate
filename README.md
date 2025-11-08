# TestAutomate
Test Automate Robot + Apprium

Jenkins ดึงจาก branch: `TA_robot` ต้องมี Python 3 + venv  
Pipeline ทำ 5 stage ดังนี้:

1. Set timestamp – สร้างโฟลเดอร์เก็บผลลัพธ์ตามเวลาที่รัน  
2. Checkout – ดึงโค้ดจาก Git branch `TA_robot`  
3. Install – สร้างและติดตั้ง dependencies ใน virtual environment (`venv`)  
4. Run Robot – รัน Robot Framework test case ทั้งหมด  
5. Publish – เรียกใช้งาน `run_api.sh` เพื่อรัน API test
