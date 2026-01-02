import 'package:flutter/material.dart';
import 'package:frontend/routes.dart';

const String SYSTEM_PROMPT = '''
You are a **Legal AI Chatbot** strictly specialized in **Indian Laws only** 🇮🇳.

━━━━━━━━━━━━━━━━━━
🔹 Scope of Work
━━━━━━━━━━━━━━━━━━
• Answer queries related to **Indian Acts, Sections, and Constitutional Articles**.
• If a real-life situation is shared, **identify the applicable law** and explain it clearly.

━━━━━━━━━━━━━━━━━━
🔹 Language Rules (STRICT)
━━━━━━━━━━━━━━━━━━
• Question in **English** → Reply in **English**
• प्रश्न हिंदी में → उत्तर **हिंदी (देवनागरी)** में
• Question in **Hinglish** → Reply in **Hinglish** (Hindi using English letters)

━━━━━━━━━━━━━━━━━━
🔹 Mandatory Answer Format
━━━━━━━━━━━━━━━━━━
Section / Article Number  
Introduction  
Punishment / Legal Consequences (if applicable)  
Example Scenario  

━━━━━━━━━━━━━━━━━━
🔹 Restrictions (VERY IMPORTANT)
━━━━━━━━━━━━━━━━━━
• If the query is **not related to Indian Law**, reply ONLY:
"I am a Legal Chatbot and I don't have knowledge about other domains or topics."

• If asked about your creator or development, reply ONLY:
"I am developed by Ahmad Raza and Naseem during Final Year Project."

━━━━━━━━━━━━━━━━━━
🔹 Writing Style
━━━━━━━━━━━━━━━━━━
• Use **simple, clear, and easy-to-understand language**
• Avoid unnecessary legal jargon
• Be accurate, structured, and helpful
• All responses must be written in **Markdown format** using proper headings, bold keywords, and clean structure for readability.

━━━━━━━━━━━━━━━━━━
Question:
''';


const projectName = "Legal Help";
const themeMode = "themeMode";

List<Map> categories = [
  {
    "text": "Indian Constitution",
    "icon": Icons.book,
    "navigation": MyRoutes.articlesAndParts,
  },
  {
    "text": "Criminal Laws",
    "icon": Icons.article,
    "navigation": MyRoutes.listOfCriminalLaws,
  },
  {
    "text": "Civil Laws",
    "icon": Icons.article,
    "navigation": MyRoutes.listOfCivilLaws,
  },
  {
    "text": "Other Laws",
    "icon": Icons.article,
    "navigation": MyRoutes.listOfOtherLaws,
  },
];

List<String> lawyerSpecializations = [
  "Criminal",
  "Civil",
  "Family",
  "Divorce",
  "Property",
  "Corporate",
  "Cyber Crime",
  "Consumer Court",
  "GST & Tax",
  "Labour & Employment",
];

Map indianConstitutions = {
  "name": "Constitution of India",
  "jsonPath": "assets/laws_in_json/indian_constitution.json",
  "description":
      "The supreme law of India that lays down the framework defining political principles, structure of government, fundamental rights, duties, and directive principles for citizens and institutions.",
  "billPassedDate": "26 Nov 1949",
  "applicableFrom": "26 Jan 1950",
  "totalParts": 25,
  "totalArticles": 448,
  "ministry": "Supreme Law of India",
};

List<Map> criminalLaws = [
  {
    "name": "Bharatiya Nyaya Sanhita (BNS)",
    "jsonPath": "assets/laws_in_json/criminal_law/bhartiya_nyay_sanhita.json",
    "description":
        "India’s primary criminal law defining offences and punishments. It replaces IPC and emphasizes justice, victim rights, speedy trials, and modern crimes including cyber and organized offences.",
    "billPassedDate": "21 Dec 2023",
    "applicableFrom": "1 July 2024",
    "totalChapters": 20,
    "totalSections": 358,
    "ministry": "Ministry of Home Affairs\nMinistry of Law & Justice",
  },
  {
    "name": "Bharatiya Sakshya Adhiniyam (BSA)",
    "jsonPath":
        "assets/laws_in_json/criminal_law/bharatiya_sakshya_adhiniyam.json",
    "description":
        "This law governs admissibility of evidence in courts. It replaces the Indian Evidence Act and recognizes digital, electronic, and technological evidence during investigation and criminal trials.",
    "billPassedDate": "21 Dec 2023",
    "applicableFrom": "1 July 2024",
    "totalChapters": 11,
    "totalSections": 170,
    "ministry": "Ministry of Home Affairs\nMinistry of Law & Justice",
  },
  {
    "name": "Indian Penal Code (IPC)",
    "jsonPath": "assets/laws_in_json/criminal_law/indian_penal_code.json",
    "description":
        "The former main criminal law of India defining offences like murder, theft, and cheating with punishments. It has been replaced by Bharatiya Nyaya Sanhita.",
    "billPassedDate": "6 Oct 1860",
    "applicableFrom": "1 Jan 1862",
    "totalChapters": 23,
    "totalSections": 511,
    "ministry": "Ministry of Home Affairs\nMinistry of Law & Justice",
  },
  {
    "name": "Criminal Procedure Code (CrPC)",
    "jsonPath": "assets/laws_in_json/criminal_law/criminal_procedure_code.json",
    "description":
        "This law explains procedures for criminal cases including investigation, arrest, bail, trial, and judgments, ensuring due process, fairness, and protection of rights within the justice system.",
    "billPassedDate": "25 Jan 1974",
    "applicableFrom": "1 April 1974",
    "totalChapters": 37,
    "totalSections": 484,
    "ministry": "Ministry of Home Affairs\nMinistry of Law & Justice",
  },
  {
    "name": "Indian Evidence Act (IEA)",
    "jsonPath": "assets/laws_in_json/criminal_law/indian_evidence_act.json",
    "description":
        "This law defined rules for proving facts in court through documents and witnesses. It has been replaced by Bharatiya Sakshya Adhiniyam for handling modern evidence.",
    "billPassedDate": "15 Mar 1872",
    "applicableFrom": "1 Sep 1872",
    "totalChapters": 11,
    "totalSections": 167,
    "ministry": "Ministry of Home Affairs\nMinistry of Law & Justice",
  },
];

List<Map> civilLaws = [
  {
    "name": "Civil Procedure Code (CPC)",
    "jsonPath": "assets/laws_in_json/civil_law/civil_procedure_code.json",
    "description":
        "This law lays down procedures followed by civil courts in matters like property disputes, contracts, money recovery, injunctions, and appeals to ensure orderly civil justice.",
    "billPassedDate": "21 Mar 1908",
    "applicableFrom": "1 Jan 1909",
    "totalChapters": 11,
    "totalSections": 158,
    "ministry": "Ministry of Law and Justice",
  },
  {
    "name": "Indian Divorce Act (IDA)",
    "jsonPath": "assets/laws_in_json/civil_law/indian_divorce_act.json",
    "description":
        "This law governs divorce, judicial separation, and matrimonial matters for Christians in India, explaining legal grounds, procedures, and reliefs granted by civil courts.",
    "billPassedDate": "23 Mar 1869",
    "applicableFrom": "1 Apr 1869",
    "totalChapters": 11,
    "totalSections": 56,
    "ministry": "Ministry of Law and Justice",
  },
  {
    "name": "Negotiable Instruments Act (NIA)",
    "jsonPath": "assets/laws_in_json/civil_law/negotiable_instrument_act.json",
    "description":
        "This law regulates negotiable instruments such as cheques and promissory notes, including cheque bounce offences, ensuring trust, reliability, and legality in financial transactions.",
    "billPassedDate": "9 Dec 1881",
    "applicableFrom": "1 Mar 1882",
    "totalChapters": 17,
    "totalSections": 142,
    "ministry": "Ministry of Law and Justice\nMinistry of Finance",
  },
  {
    "name": "Consumer Protection Act (CPA)",
    "jsonPath": "assets/laws_in_json/civil_law/consumer_protection_act.json",
    "description":
        "This law protects consumer rights against unfair trade practices and defective goods or services, providing consumer courts and grievance redressal mechanisms for speedy justice.",
    "billPassedDate": "9 Aug 2019",
    "applicableFrom": "20 Jul 2020",
    "totalChapters": 4,
    "totalSections": 107,
    "ministry": "Ministry of Consumer Affairs, Food and Public Distribution",
  },
];

List<Map> otherLaws = [
  {
    "name": "Motor Vehicles Act (MVA)",
    "jsonPath": "assets/laws_in_json/other_laws/motor_vehicle_act.json",
    "description":
        "This law regulates road transport, vehicle registration, driving licences, traffic rules, road safety, offences, and compensation for victims of road accidents in India.",
    "billPassedDate": "14 Oct 1988",
    "applicableFrom": "1 Jul 1989",
    "totalChapters": 14,
    "totalSections": 217,
    "ministry": "Ministry of Road Transport and Highways",
  },
  {
    "name": "Indian Railways Act (IRA)",
    "jsonPath": "assets/laws_in_json/other_laws/indian_railway_act.json",
    "description":
        "This law governs railway operations in India, covering passenger safety, railway property, offences, liabilities, and responsibilities of railway authorities and passengers.",
    "billPassedDate": "22 Dec 1989",
    "applicableFrom": "1 Jul 1990",
    "totalChapters": 9,
    "totalSections": 199,
    "ministry": "Ministry of Railways",
  },
  {
    "name": "Information Technology Act (ITA)",
    "jsonPath":
        "assets/laws_in_json/other_laws/information_technology_act.json",
    "description":
        "This law deals with cyber laws in India, covering electronic records, digital signatures, cyber crimes, data protection, and legal issues arising from online activities.",
    "billPassedDate": "9 Jun 2000",
    "applicableFrom": "17 Oct 2000",
    "totalChapters": 13,
    "totalSections": 94,
    "ministry": "Ministry of Electronics and Information Technology",
  },
];
