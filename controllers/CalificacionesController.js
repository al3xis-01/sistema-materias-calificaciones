const connection = require("../bin/connection");

function show_by_estudiantes(req, resp) {

  const cuatrimestre  = req.body.cuatrimestre ?? 1;
  let alumnos    =   [];

  const queryAlumno   =   'SELECT \n' +
      '    a.id,\n' +
      '    a.matricula,\n' +
      '    a.nombre,\n' +
      '    a.apellido_paterno,\n' +
      '    a.apellido_materno\n' +
      'FROM sistema_db.alumnos a\n' ;

  connection.query(queryAlumno,[], function (error, results) {
    if (error) {
      console.error('Error al consultar en la base de datos:', error);
      resp.status(500).send('Error al guardar los datos');
    } else {
      alumnos =   results;
      resp.render('calificaciones/estudiantes', {cuatrimestre, alumnos});
    }
  });


}

function store_by_estudiantes(req, resp) {
  const alumnos = req.body['alumno[]'];
  const calificaciones = req.body['calificacion[]'];
  const cuatrimestre = req.body.cuatrimestre;
  const materia = req.body.materia;
  const parcial = req.body.parcial;

  if (
      alumnos &&
      calificaciones &&
      alumnos.length === calificaciones.length &&
      cuatrimestre &&
      materia &&
      parcial
  ) {
    const selectQuery =
        "SELECT * FROM calificaciones WHERE id_materia = ? AND id_alumno = ?";
    const updateQuery =
        `UPDATE calificaciones SET parcial${parcial} = ? WHERE id_materia = ? AND id_alumno = ?`;
    const insertQuery =
        "INSERT INTO calificaciones (parcial1, parcial2, parcial3, extraordinario, id_materia, id_alumno) " +
        "VALUES (?, ?, ?, ?, ?, ?)";

    for (let i = 0; i < alumnos.length; i++) {
      const calif = calificaciones[i];

      connection.query(selectQuery, [materia, alumnos[i]], function (error, results) {
        if (error) {
          console.error("Error al consultar en la base de datos:", error);
        } else {
          if (results.length > 0) {
            const updateValues = [calif, materia, alumnos[i]];
            connection.query(updateQuery, updateValues, function (error, updateResult) {
              if (error) {
                console.error("Error al actualizar en la base de datos:", error);
              } else {
                console.log("Datos actualizados correctamente:", updateResult);
              }
            });
          } else {
            const parcialValues = [null, null, null, null];
            parcialValues[parcial - 1] = calif;
            const insertValues = [...parcialValues, materia, alumnos[i]];

            connection.query(insertQuery, insertValues, function (error, insertResult) {
              if (error) {
                console.error("Error al insertar en la base de datos:", error);
              } else {
                console.log("Datos insertados correctamente:", insertResult);
              }
            });
          }
        }
      });
    }

    resp.redirect("/");
  } else {
    resp.status(400).send("Datos incorrectos en la solicitud: " + JSON.stringify(req.body));
  }
}

function search_by_estudiantes(req,resp) {
  resp.render('calificaciones/boleta-alumno');
}


function search_by_estudiante_with_matricula(req, resp) {
  const matricula = req.params.matricula;
  const cuatrimestre = req.params.cuatrimestre;

  const queryCalificaciones =
      `SELECT m.clave_materia, m.nombre, IFNULL(c.parcial1, '-') AS parcial1, IFNULL(c.parcial2, '-') AS parcial2, IFNULL(c.parcial3, '-') AS parcial3, IFNULL(c.extraordinario, '-') AS extraordinario
     FROM materias AS m
     LEFT JOIN calificaciones AS c ON m.id = c.id_materia AND c.id_alumno = (SELECT id FROM alumnos WHERE matricula = ?)
     WHERE m.cuatrimestre = ?`;

  const queryAlumno =
      `SELECT * FROM alumnos WHERE matricula = ?`;

  const results = {};

  connection.query(queryCalificaciones, [matricula, cuatrimestre], function(error, calificacionesResults) {
    if (error) {
      console.error("Error al consultar en la base de datos:", error);
      resp.status(500).send("Error al buscar los datos");
    } else {
      results.calificaciones = calificacionesResults;

      connection.query(queryAlumno, [matricula], function(alumnoError, alumnoResult) {
        if (alumnoError) {
          console.error("Error al consultar el alumno en la base de datos:", alumnoError);
          resp.status(500).send("Error al buscar los datos del alumno");
        } else {
          if (alumnoResult.length === 0) {
            results.calificaciones  = [];
            results.alumno  = {};
            resp.status(200).send(results);
          } else {
            results.alumno = alumnoResult[0];
            resp.status(200).json(results);
          }
        }
      });
    }
  });
}


function show_all_calificaciones_by_cuatrimestre(req, resp) {
  const cuatrimestre = req.params.cuatrimestre;

  const queryEstudiantes =
      `SELECT id, matricula, CONCAT(nombre, ' ', apellido_paterno, ' ', apellido_materno) AS nombre_completo
     FROM alumnos`;

  const queryMaterias =
      `SELECT id, nombre
     FROM materias
     WHERE cuatrimestre = ?`;

  connection.query(queryEstudiantes, function(estudiantesError, estudiantesResults) {
    if (estudiantesError) {
      console.error("Error al consultar estudiantes en la base de datos:", estudiantesError);
      resp.status(500).send("Error al buscar los estudiantes");
    } else {
      connection.query(queryMaterias, [cuatrimestre], function(materiasError, materiasResults) {
        if (materiasError) {
          console.error("Error al consultar materias en la base de datos:", materiasError);
          resp.status(500).send("Error al buscar las materias");
        } else {
          const estudiantes = estudiantesResults;
          const materias = materiasResults;

          const calificacionesQuery =
              `SELECT c.id_alumno, c.id_materia, AVG((IFNULL(c.parcial1,0) + IFNULL(c.parcial2, 0) + IFNULL(c.parcial3, 0) + IFNULL(c.extraordinario, 0)) / 4) AS promedio_individual
             FROM calificaciones AS c
             INNER JOIN materias AS m ON c.id_materia = m.id
             WHERE m.cuatrimestre = ?
             GROUP BY c.id_alumno, c.id_materia`;

          connection.query(calificacionesQuery, [cuatrimestre], function(calificacionesError, calificacionesResults) {
            if (calificacionesError) {
              console.error("Error al consultar calificaciones en la base de datos:", calificacionesError);
              resp.status(500).send("Error al buscar las calificaciones");
            } else {
              const info = {};

              info.estudiantes = estudiantes;
              info.materias = materias;

              calificacionesResults.forEach(function(row) {
                if (!info[row.id_alumno]) {
                  info[row.id_alumno] = {};
                }
                info[row.id_alumno][row.id_materia] = row.promedio_individual;
              });

              info.promediosMaterias = {};
              materias.forEach(function(materia) {
                const materiaId = materia.id;
                let total = 0;
                let count = 0;
                estudiantes.forEach(function(estudiante) {
                  if (info[estudiante.id] && info[estudiante.id][materiaId] !== undefined) {
                    total += info[estudiante.id][materiaId];
                    count++;
                  }
                });
                if (count > 0) {
                  info.promediosMaterias[materiaId] = total / count;
                } else {
                  info.promediosMaterias[materiaId] = null;
                }
              });

              resp.render('calificaciones/all-calificaciones', { cuatrimestre, info });
            }
          });
        }
      });
    }
  });
}



module.exports  =   {
  show_by_estudiantes,
  store_by_estudiantes,
  search_by_estudiantes,
  search_by_estudiante_with_matricula,
  show_all_calificaciones_by_cuatrimestre
};
