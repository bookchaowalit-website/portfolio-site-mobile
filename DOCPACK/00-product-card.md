---
title: Portfolio Mobile — Product Card
doc_id: CARD-bookchaowalit-portfolio-mobile
doc_type: product-card
verdict: showcase
version: 0.1
date: 2026-10-08
status: ร่างเพื่อพิจารณา
owner: Product owner (Book Dev)
---

# Portfolio Mobile — Product Card

## 1. สรุปคุณค่าในหนึ่งประโยค

ช่วยผู้ประเมินที่ใช้มือถือดูผลงาน ทักษะ และข้อมูลติดต่อของเจ้าของในแอป Flutter ตัวเดียวที่รันได้ทั้งเว็บและ native

## 2. ปัญหาและผู้ใช้เป้าหมาย

เว็บพอร์ตหลักเป็นช่องทางหลักอยู่แล้ว repo นี้แสดงความสามารถข้ามแพลตฟอร์มด้วย Flutter ผู้ใช้เป้าหมายคือผู้สรรหาและผู้สัมภาษณ์ที่ต้องการเห็นหลักฐานงาน mobile

## 3. สิ่งที่ทำได้จริงตอนนี้

- หน้าจอ splash, home, projects, project detail, skills explorer, about, contact, settings (`lib/screens/`)
- ข้อมูลผลงานแบบ static ใน `lib/data/project_data.dart` (186 บรรทัด)
- บันทึกรายการโปรดผ่าน `lib/services/favorites_service.dart`
- PRODUCT.md ระบุว่า `flutter analyze`, `flutter test` ผ่าน และ build web release ใช้เป็น preview สาธารณะ (ไม่ได้รันซ้ำในรอบนี้)

## 4. หลักฐานสถานะ

- Stack: Flutter
- Commits: 13 (แรก 2026-07-28, ล่าสุด 2026-08-24)
- Source: 24 ไฟล์ / 4638 บรรทัด; tests: 1 ไฟล์; CI workflows: 1
- Deploy config: ไม่พบใน repo
- Live URL: https://portfolio-mobile.bookchaowalit.com (จากการเก็บข้อมูล; ไม่ได้เปิดตรวจในรอบนี้)
- โครงสร้างซ้ำกับ repo อื่น: template_family_size = 1

## 5. คุณค่าและจุดต่าง

เป็นหลักฐานงาน Flutter ข้ามแพลตฟอร์มที่บอกขอบเขตตรงไปตรงมา (ไม่อ้างว่าอยู่บน store) ไม่ใช่ธุรกิจ ไม่มีช่องทางรายได้โดยตรง

## 6. ช่องว่างสำคัญ

- ข้อมูลผลงานเป็น static แยกจาก `src/data/app-projects.ts` ของเว็บหลัก จึงล้าสมัยได้
- ไฟล์ signing (`*.mobileprovision`, `*.cer`) ถูกเอาออกจาก tree แล้วเมื่อ 2026-10-21 และ `scripts/check-signing-files.sh` กันไม่ให้กลับมา แต่ยังอยู่ใน git history (`.cer` เป็น public cert ไม่มี private key, profile หมดอายุ 2026-09-28) การ revoke/ล้าง history/ทำ private เป็นการตัดสินใจของเจ้าของ (D1)
- native release ยังไม่ผ่าน device smoke, signing และ store review

## 7. คำตัดสิน

**showcase — เก็บเป็นผลงาน** — ใช้งานได้และสื่อทักษะ mobile ได้ดี แต่ไม่ได้แก้ปัญหาทางธุรกิจที่เว็บหลักยังไม่ได้แก้ จะเปลี่ยนเป็น invest ถ้าดึงข้อมูลสดจาก API/MCP ของ portfolio และขึ้น store จริง

## 8. ขั้นต่อไป

1. ให้แอปอ่านข้อมูลผลงานจาก MCP/API ของ `bookchaowalit-portfolio-frontend` แทนข้อมูล static
2. ย้ายไฟล์ signing ออกจาก git หลังเจ้าของยืนยัน
3. รวม `bookchaowalit-portfolio-mobile-frontend` เข้ามาที่นี่

## การอนุมัติ

| บทบาท | การตัดสิน | วันที่ |
|---|---|---|
| Product owner (Book Dev) | รอพิจารณา | **[ต้องยืนยัน]** |

## แหล่งข้อมูล

- `README.md`
- `PRODUCT.md`
- `lib/screens/`
- `lib/data/project_data.dart`
- `lib/services/favorites_service.dart`
