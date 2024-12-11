# Sistema de Gerenciamento de Faculdade

Este projeto implementa o modelo de dados para o gerenciamento de uma faculdade. Ele inclui tabelas para alunos, professores, disciplinas, cursos, departamentos e os relacionamentos necessários para atender aos requisitos do sistema.

## Estrutura do Projeto

### Arquivos Incluídos

- `modelo_logico_faculdade.sql`: Script SQL contendo a estrutura do banco de dados relacional.
- `modelagem_dados.md`: Modelagem de dados, incluindo o dicionário de atributos, normalização e diagramas.
- `README.md`: Documentação sobre o projeto.

## Pré-requisitos

1. Um ambiente de banco de dados relacional, como:
   - **MySQL** (versão 8.0 ou superior)
   - **PostgreSQL** (versão 12 ou superior)
   - Ou qualquer outro banco de dados compatível.
2. Um cliente para executar o SQL:
   - MySQL Workbench
   - pgAdmin
   - SQL Tools no VS Code

## Regras de Negócio

- Alunos possuem um código de identificação (RA).
- Um aluno só pode estar matriculado em um curso por vez.
- Cursos são compostos por disciplinas.
- As disciplinas podem ser obrigatórias ou optativas, dependendo do curso.
- As disciplinas pertencem a departamentos específicos.
- Cada disciplina possui um código de identificação.
- Alunos podem trancar matrícula, não estando matriculados em nenhuma disciplina no semestre.
- Em cada semestre, cada aluno pode se matricular em no máximo 9 disciplinas.
- O aluno só pode ser reprovado no máximo 3 vezes na mesma disciplina.
- A faculdade terá no máximo 3.000 alunos matriculados simultaneamente, em 10 cursos distintos.
- Entram 300 alunos novos por ano.
- Existem 90 disciplinas no total disponíveis.
- O histórico escolar traz todas as disciplinas cursadas por um aluno, incluindo nota final, frequência e período do curso realizado.
- Professores podem ser cadastrados mesmo sem lecionar disciplinas.
- Existem 40 professores trabalhando na escola.
- Cada professor irá lecionar no máximo 4 disciplinas diferentes.
- Cada professor é vinculado a um departamento.
- Professores são identificados por um código de professor.

## Como Executar o Projeto

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/gerenciamento_faculdade.git
   cd gerenciamento_faculdade
   ```

2. Conecte-se ao seu banco de dados usando seu cliente favorito.

3. Crie o banco de dados:
   ```sql
   CREATE DATABASE faculdade;
   USE faculdade;
   ```

4. Execute o script SQL para criar as tabelas e os relacionamentos:
   ```sql
   source modelo_logico_faculdade.sql;
   ```

## Estrutura do Banco de Dados

### Entidades Principais

1. **Departamento**: Gerencia cursos e disciplinas.
2. **Curso**: Agrupa disciplinas e alunos matriculados.
3. **Disciplina**: Representa os módulos de ensino vinculados aos cursos e departamentos.
4. **Professor**: Docentes que podem ou não estar vinculados a disciplinas.
5. **Aluno**: Estudantes matriculados em cursos e disciplinas.

### Relacionamentos

- **Aluno - Curso**: Um aluno só pode estar matriculado em um curso por vez.
- **Aluno - Disciplina**: Um aluno pode cursar várias disciplinas por semestre.
- **Professor - Disciplina**: Professores lecionam disciplinas.
- **Departamento - Disciplina**: Cada disciplina pertence a um departamento.
- **Disciplina - Pré-requisitos**: Algumas disciplinas têm pré-requisitos obrigatórios.

## Dicionário de Dados

| Entidade       | Atributo             | Tipo           | Descrição                                     |
|----------------|----------------------|----------------|---------------------------------------------|
| **Aluno**      | RA                  | INT            | Código único do aluno.                      |
|                | Nome_Aluno          | VARCHAR(100)   | Nome completo do aluno.                     |
|                | CPF                 | VARCHAR(11)    | CPF do aluno.                               |
|                | Status              | ENUM('Ativo', 'Inativo', 'Trancado') | Status atual do aluno.        |
|                | Codigo_Curso        | INT            | Código do curso matriculado.                |
| **Professor**  | Codigo_Professor    | INT            | Código único do professor.                  |
|                | Nome_Professor      | VARCHAR(100)   | Nome do professor.                          |
|                | Codigo_Departamento | INT            | Código do departamento vinculado.           |
| **Curso**      | Codigo_Curso        | INT            | Código único do curso.                      |
|                | Nome_Curso          | VARCHAR(100)   | Nome do curso.                              |
|                | Codigo_Departamento | INT            | Código do departamento responsável.         |
| **Disciplina** | Codigo_Disciplina   | INT            | Código único da disciplina.                 |
|                | Nome_Disciplina     | VARCHAR(100)   | Nome da disciplina.                         |
|                | Codigo_Departamento | INT            | Código do departamento responsável.         |
|                | Num_Alunos          | INT            | Número de alunos matriculados.              |
| **Departamento** | Codigo_Departamento | INT            | Código único do departamento.               |
|                | Nome_Departamento   | VARCHAR(100)   | Nome do departamento.                       |

## Normalização

### Primeira Forma Normal (1FN)
- Garantia de que todos os atributos possuem valores atômicos.
- Exemplo: Dividir o atributo "Endereço" de alunos em "Rua", "Número", "CEP", "Cidade", "Estado".

### Segunda Forma Normal (2FN)
- Garantia de que todos os atributos não-chave dependem diretamente da chave primária.
- Exemplo: Em "Matricula_Disciplina", os atributos como "Nota_Final" dependem apenas de RA e Codigo_Disciplina.

### Terceira Forma Normal (3FN)
- Eliminação de dependências transitivas.
- Exemplo: No caso de "Curso", garantir que informações do departamento (como "Nome_Departamento") estejam em uma tabela separada de "Departamento".

## Diagramas

### Diagrama Entidade-Relacionamento (E-R)

![Modelo ER](https://via.placeholder.com/800x400.png?text=Modelo+ER+do+Sistema+de+Faculdade)

**Descrição do Diagrama**:
- O modelo representa as entidades principais (Aluno, Professor, Disciplina, Curso, Departamento) e seus relacionamentos.
- Inclui cardinalidades e eliminação de relacionamentos N:N, representando entidades intermediárias, como "Matricula_Disciplina" e "Disciplina_Pre_Requisito".

## Testes Básicos

Após executar o script SQL, você pode testar a estrutura inserindo dados nas tabelas. Aqui está um exemplo de inserção:

### Inserção de um Departamento
```sql
INSERT INTO Departamento (Codigo_Departamento, Nome_Departamento)
VALUES (1, 'Ciências Exatas');
```

### Inserção de um Curso
```sql
INSERT INTO Curso (Codigo_Curso, Nome_Curso, Codigo_Departamento)
VALUES (101, 'Engenharia de Computação', 1);
```

### Inserção de um Aluno
```sql
INSERT INTO Aluno (RA, Nome_Aluno, CPF, Status, Codigo_Curso)
VALUES (12345, 'João Silva', '12345678901', 'Ativo', 101);
```

### Inserção de uma Disciplina
```sql
INSERT INTO Disciplina (Codigo_Disciplina, Nome_Disciplina, Codigo_Departamento, Num_Alunos)
VALUES (1001, 'Algoritmos', 1, 50);
```

## Como Contribuir

1. Faça um fork deste repositório.
2. Crie uma nova branch para suas alterações:
   ```bash
   git checkout -b minha-feature
   ```
3. Commit suas alterações:
   ```bash
   git commit -m "Adiciona nova funcionalidade"
   ```
4. Envie suas alterações:
   ```bash
   git push origin minha-feature
   ```
5. Abra um Pull Request.

## Licença
Este projeto está sob a licença MIT. Consulte o arquivo `LICENSE` para mais informações.

## Contato
Se tiver dúvidas ou sugestões, entre em contato pelo [GitHub](https://github.com/vanessagomes-dev).

