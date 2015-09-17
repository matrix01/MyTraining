{\rtf1\ansi\ansicpg1252\cocoartf1344\cocoasubrtf720
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red164\green8\blue0;\red102\green177\blue50;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab287
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardeftab287

\f0\fs32 \cf0 \expnd0\expndtw0\kerning0
\CocoaLigature0 public class Node \{\
	private Node nextNode;\
	public Node getNextNode() \{\
		return nextNode;\
	\}\
	public void setNextNode(Node nextNode) \{\
		this.nextNode = nextNode;\
	\}\
\}\
\
public class LinkList \{\
	private Node firstNode;\
	public void addNode(Node newNode) \{\
		...\
	\}\
	public Node getFirstNode() \{\
		return firstNode;\
	\}\
\}\
\cf2 public class Employee extends Node \{ //Employee is not Node\
	String employeeId;\
	String name;\
	...\
\}\
\cf0 \
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardeftab287
\cf3 \expnd0\expndtw0\kerning0
public class Employee\{\
	Node employeeNode = new Node();\
	String employeeId;\
	String name;\
	...\
\}\cf2 \
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardeftab287
\cf0 \expnd0\expndtw0\kerning0
\
public class EmployeeList extends LinkList \{\
	public void addEmployee(Employee employee) \{\
		addNode(employee);\
	\}\
	public Employee getFirstEmployee() \{\
		return (Employee)getFirstNode();\
	\}\
	...\
\}}