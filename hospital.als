module hospital

-----------------------------------------------------------------------------------------------------------
-- ASSINATURAS
-----------------------------------------------------------------------------------------------------------

abstract sig Funcionario {
	paciente: set Paciente
}

sig Medico extends Funcionario{}

sig Enfermeiro extends Funcionario{}

abstract sig Paciente{}

sig PacienteCirurgiado extends Paciente{} 

sig PacienteNaoCirurgiado extends Paciente{}

-----------------------------------------------------------------------------------------------------------
-- FATOS
-----------------------------------------------------------------------------------------------------------

fact relacaoFuncionarioPaciente{
	all f: Funcionario | qtdePacientesDoFuncionario[f] 
}

fact atendimentoPacienteCirurgiado{
	all p:PacienteCirurgiado  | funcionariosDoPacienteCirurgiado[p]
}

fact atendimentoPacienteNaoCirurgiado{
	all p:PacienteNaoCirurgiado  | funcionariosDoPacienteNaoCirurgiado[p]
}

-----------------------------------------------------------------------------------------------------------
-- PREDICADOS
-----------------------------------------------------------------------------------------------------------

pred qtdePacientesDoFuncionario[f: Funcionario]{
	#f.paciente < 6
}

pred funcionariosDoPacienteCirurgiado[p: PacienteCirurgiado]{
	one getMedicosPacienteCirurgiado[p]
	#(getEnfermeiroPacienteCirurgiado [p])=2
}

pred funcionariosDoPacienteNaoCirurgiado[p: PacienteNaoCirurgiado]{
	no getMedicosPacienteNaoCirurgiado[p]
	one getEnfermeiroPacienteNaoCirurgiado[p]
}

-----------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------

fun getMedicosPacienteCirurgiado [p: PacienteCirurgiado] : set Medico {
    Medico & p.~paciente
}

fun getEnfermeiroPacienteCirurgiado [p: PacienteCirurgiado] : set Enfermeiro {
    Enfermeiro & p.~paciente
}

fun getEnfermeiroPacienteNaoCirurgiado [p: PacienteNaoCirurgiado] : set Enfermeiro {
    Enfermeiro & p.~paciente
}

fun getMedicosPacienteNaoCirurgiado [p: PacienteNaoCirurgiado] : set Medico {
    Medico & p.~paciente
}

fun medePressao[]: set Funcionario{
    Enfermeiro
}

fun aplicaSoro[]: set Funcionario{
    Enfermeiro
}

fun ministraMedicamentos[]: set Funcionario{
    Enfermeiro
}

fun realizaCirurgias[]: set Funcionario{
    Medico
}

-----------------------------------------------------------------------------------------------------------
-- TESTES
-----------------------------------------------------------------------------------------------------------

assert testPacienteTemNoMinimoUmEnfermeiro{
	all p : Paciente | #(Enfermeiro & p.~paciente) > 0
}

check testPacienteTemNoMinimoUmEnfermeiro for 20

assert testPacienteCirurgiadoTemDoisEnfermeiros{
	all p : PacienteCirurgiado | #(Enfermeiro & p.~paciente) = 2
}

check testPacienteCirurgiadoTemDoisEnfermeiros for 20

assert testPacienteCirurgiadoTemUmMedico{
	all p : PacienteCirurgiado | #(Medico & p.~paciente) = 1
}

check testPacienteCirurgiadoTemUmMedico for 20

assert testPacienteNaoCirurgiadoTemUmEnfermeiro{
	all p : PacienteNaoCirurgiado | #(Enfermeiro & p.~paciente) = 1
}

check testPacienteNaoCirurgiadoTemUmEnfermeiro for 20

assert testEnfermeiroTemNoMaximoCincoPacientes{
	all e : Enfermeiro | #e.paciente <= 5
}

check testEnfermeiroTemNoMaximoCincoPacientes for 20

assert testMedicoTemNoMaximoCincoPacientes{
	all m : Medico | #m.paciente <= 5
}

check testMedicoTemNoMaximoCincoPacientes for 20

assert testFuncionarios{
	Funcionario = Medico + Enfermeiro
}

check testFuncionarios for 20

assert testPacientes{
	Paciente = PacienteCirurgiado + PacienteNaoCirurgiado
}

check testPacientes for 20

assert testMedePressao{
	all e:medePressao[] | e in Enfermeiro
}

check testMedePressao for 20

assert testAplicaSoro{
	all e:aplicaSoro[] | e in Enfermeiro
}

check testAplicaSoro for 20

assert testMinistraMedicamentos{
	all e:ministraMedicamentos | e in Enfermeiro
}

check testMinistraMedicamentos for 20

assert testRealizaCirurgias{
	all m:realizaCirurgias | m in Medico
}

pred show[]{}
run show for 20
