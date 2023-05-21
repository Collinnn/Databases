use hospital;
select diseaseName from disease
where diseaseType = "infectious";

select diseaseName, count(specialty) from disease left join doctor on doctor.specialty = disease.diseaseName
group by diseaseName;


create function NumberOfPatientsInRoom(vroom SMALLINT) returns int
 return (select count(patientid) from patient where vroom = room);

select NumberOfPatientsInRoom(11);

select roomNo, NumberOfPatientsInRoom(roomNo) from room;

select patientid,diseaseName from suffers natural join treats natural join doctor
where doctor.specialty <> suffers.diseasename; ###WRONG


