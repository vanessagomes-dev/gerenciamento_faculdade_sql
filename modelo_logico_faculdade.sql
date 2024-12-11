-- Script para o Modelo Lógico do Sistema de Gerenciamento de Faculdade

-- Tabela: Departamento
CREATE TABLE Departamento (
    Codigo_Departamento INT PRIMARY KEY,
    Nome_Departamento VARCHAR(100) NOT NULL
);

-- Tabela: Curso
CREATE TABLE Curso (
    Codigo_Curso INT PRIMARY KEY,
    Nome_Curso VARCHAR(100) NOT NULL,
    Codigo_Departamento INT NOT NULL,
    FOREIGN KEY (Codigo_Departamento) REFERENCES Departamento(Codigo_Departamento)
);

-- Tabela: Disciplina
CREATE TABLE Disciplina (
    Codigo_Disciplina INT PRIMARY KEY,
    Nome_Disciplina VARCHAR(100) NOT NULL,
    Descricao_Curricular TEXT,
    Codigo_Departamento INT NOT NULL,
    Num_Alunos INT,
    FOREIGN KEY (Codigo_Departamento) REFERENCES Departamento(Codigo_Departamento)
);

-- Tabela: Professor
CREATE TABLE Professor (
    Codigo_Professor INT PRIMARY KEY,
    Nome_Professor VARCHAR(100) NOT NULL,
    Sobrenome_Professor VARCHAR(100),
    Codigo_Departamento INT NOT NULL,
    Status ENUM('Ativo', 'Inativo') NOT NULL,
    FOREIGN KEY (Codigo_Departamento) REFERENCES Departamento(Codigo_Departamento)
);

-- Tabela: Aluno
CREATE TABLE Aluno (
    RA INT PRIMARY KEY,
    Nome_Aluno VARCHAR(100) NOT NULL,
    Endereco JSON,
    Telefone JSON,
    CPF VARCHAR(11) NOT NULL UNIQUE,
    Status ENUM('Ativo', 'Inativo', 'Trancado') NOT NULL,
    Filiacao VARCHAR(200),
    Sexo ENUM('Masculino', 'Feminino', 'Outro'),
    Codigo_Curso INT NOT NULL,
    Cod_Turma INT,
    FOREIGN KEY (Codigo_Curso) REFERENCES Curso(Codigo_Curso)
);

-- Tabela Intermediária: Matricula_Disciplina
CREATE TABLE Matricula_Disciplina (
    RA INT NOT NULL,
    Codigo_Disciplina INT NOT NULL,
    Nota_Final DECIMAL(5,2),
    Frequencia INT,
    Periodo VARCHAR(10) NOT NULL,
    PRIMARY KEY (RA, Codigo_Disciplina),
    FOREIGN KEY (RA) REFERENCES Aluno(RA),
    FOREIGN KEY (Codigo_Disciplina) REFERENCES Disciplina(Codigo_Disciplina)
);

-- Tabela Intermediária: Disciplina_Pre_Requisito
CREATE TABLE Disciplina_Pre_Requisito (
    Codigo_Disciplina INT NOT NULL,
    Codigo_Pre_Requisito INT NOT NULL,
    PRIMARY KEY (Codigo_Disciplina, Codigo_Pre_Requisito),
    FOREIGN KEY (Codigo_Disciplina) REFERENCES Disciplina(Codigo_Disciplina),
    FOREIGN KEY (Codigo_Pre_Requisito) REFERENCES Disciplina(Codigo_Disciplina)
);