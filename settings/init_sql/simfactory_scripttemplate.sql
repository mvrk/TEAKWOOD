SET FOREIGN_KEY_CHECKS=0;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `teakwood`
--

-- --------------------------------------------------------

--
-- Table structure for table `simfactory_scripttemplate`
--

CREATE TABLE IF NOT EXISTS `simfactory_scripttemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) DEFAULT NULL,
  `machine_id` int(11) DEFAULT NULL,
  `preprocessor` longtext,
  `postprocessor` longtext,
  `cmd_line` longtext,
  `native_script` longtext,
  `viz_script` longtext,
  `viz_scriptname` varchar(64) DEFAULT NULL,
  `data_file` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `model_id` (`model_id`,`machine_id`),
  KEY `simfactory_scripttemplate_aff30766` (`model_id`),
  KEY `simfactory_scripttemplate_5a994bc4` (`machine_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `simfactory_scripttemplate`
--

INSERT INTO `simfactory_scripttemplate` (`id`, `model_id`, `machine_id`, `preprocessor`, `postprocessor`, `cmd_line`, `native_script`, `viz_script`, `viz_scriptname`, `data_file`) VALUES
(1, 1, 1, 'export SWAN_HOME=/home/alex/tools/swan\r\nMPI_RUN=/usr/local/packages/mvapich/1.1/intel-11.1/bin/mpirun\r\n', 'date', '$MPI_RUN  -np $NPROCS $SWAN_HOME/swan.exe  > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err', '', '', '', ''),
(2, 1, 2, '# intel compiler\r\nsource /home/teakwood/local/intel/composer_xe_2013.0.079/bin/compilervars.sh intel64\r\n\r\nexport SWAN_HOME=/home/teakwood/swan\r\n\r\nMPI_RUN=/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/bin/mpirun\r\n\r\n# Set some (environment) parameters\r\nexport LD_LIBRARY_PATH=$SWAN_HOME:/home/teakwood/local/lib:/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/lib:$LD_LIBRARY_PATH', 'date', '$MPI_RUN  -np $NPROCS $SWAN_HOME/swan.exe  > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err', NULL, NULL, NULL, NULL),
(3, 2, 1, '# Specify the config file to be used here (will be set in Teakwood)\r\nargfile=config_flow2d3d.ini\r\n\r\n# Set the directory containing delftflow.exe here\r\nexport ARCH=intel\r\nexport D3D_HOME=/usr/local/packages/delft3d/5.00.09.1882/mvapich2-1.8.1-gcc-4.7.0\r\nexport MPI_RUN=/usr/local/packages/mvapich2/1.8.1/gcc-4.7.0/bin/mpirun \r\n\r\n# Set some (environment) parameters\r\nexport LD_LIBRARY_PATH=$D3D_HOME/bin:$D3D_HOME/lib:$LD_LIBRARY_PATH', 'date', '# run mvapich2 jobs\r\n$MPI_RUN -np $NPROCS $D3D_HOME/bin/deltares_hydro.tcl $argfile > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err', '# Specify the config file to be used here (will be set in Teakwood)\r\n# env variables from the pbs script generator:\r\n# WORK_DIR, NPROCS, OVERALL_RUNID, NESTED_RUNID\r\n\r\nargfile=config_flow2d3d.ini\r\n\r\n# Set the directory containing delftflow.exe here\r\nexport ARCH=intel\r\nexport D3D_HOME=/usr/local/packages/delft3d/5.00.09.1882/mvapich2-1.8.1-gcc-4.7.0\r\nexport MPI_RUN=/usr/local/packages/mvapich2/1.8.1/gcc-4.7.0/bin/mpirun \r\nexport LD_LIBRARY_PATH=$D3D_HOME/bin:$D3D_HOME/lib:$LD_LIBRARY_PATH\r\n\r\nD3D_EXE="${D3D_HOME}/bin/deltares_hydro.tcl"\r\nnesthd1="${D3D_HOME}/bin/nesthd1"\r\nnesthd2="${D3D_HOME}/bin/nesthd2"\r\n\r\n# cd the nesting dir\r\necho "Running nesthd1 and generate obs file ..."\r\n\r\n# create the input file for nesthd1\r\n# $NESTED_RUNID.bnd should be the local boundary that others will upload.\r\ncat > ./nesthd1.input <<DELIM\r\n$OVERALL_RUNID.grd\r\n$OVERALL_RUNID.enc\r\n$NESTED_RUNID.grd\r\n$NESTED_RUNID.enc\r\n$NESTED_RUNID.bnd\r\n$NESTED_RUNID.adm\r\n$OVERALL_RUNID.obs\r\nDELIM\r\n\r\n# generate obsfile and copy it to overall dir.\r\n${nesthd1} < nesthd1.input > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err\r\necho "Finish running nesthd1."\r\n\r\necho "Running the overall mode and generate trih-$OVERALL_RUNID.dat|def ..."\r\nsed "s/Filsta.*/Filsta = #$OVERALL_RUNID.obs#/" < "$OVERALL_RUNID.mdf" >  "$OVERALL_RUNID.mdf.tmp"\r\nmv "$OVERALL_RUNID.mdf.tmp" "$OVERALL_RUNID.mdf"\r\n\r\n# automatically generate $argfile\r\ncat > ./$argfile <<DELIM\r\n[FileInformation]\r\n   FileCreationDate = `date`\r\n   FileVersion      = 00.01\r\n[Component]\r\n   Name    = flow2d3d\r\n   MDFfile = $OVERALL_RUNID\r\nDELIM\r\n\r\n# run overall and copy trih-*.dat and trih-*.def to nesting\r\n\r\n$MPI_RUN  -np $NPROCS ${D3D_EXE} "$argfile" >> $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err\r\necho "Finish running the overall model."\r\n\r\necho "Running nesthd2 and generate $NESTED_RUNID.bct ..."\r\n\r\ncat > ./nesthd2.input <<DELIM\r\n$NESTED_RUNID.bnd\r\n$NESTED_RUNID.adm\r\n$OVERALL_RUNID\r\n$NESTED_RUNID.bct\r\n$NESTED_RUNID.bcc\r\n$NESTED_RUNID.dia\r\n$A0_CORRECTION\r\nDELIM\r\n\r\n# run nesthd2 and copy files to Bsound\r\n${nesthd2} < nesthd2.input >> $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err\r\necho "Finish running nesthd2."\r\n\r\necho "Running the nested model ..."\r\nsed "s/FilbcT.*/FilbcT = #$NESTED_RUNID.bct#/" < "$NESTED_RUNID.mdf" >  "$NESTED_RUNID.mdf.tmp"\r\nmv "$NESTED_RUNID.mdf.tmp" "$NESTED_RUNID.mdf"\r\n# run the Bsound model\r\n# automatically generate $argfile\r\ncat > ./$argfile <<DELIM\r\n[FileInformation]\r\n   FileCreationDate = `date`\r\n   FileVersion      = 00.01\r\n[Component]\r\n   Name    = flow2d3d\r\n   MDFfile = $NESTED_RUNID\r\nDELIM\r\n\r\n$MPI_RUN  -np $NPROCS ${D3D_EXE} "$argfile" >> $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err\r\necho "Finish running the nested model."', '', '/data/klhu/viz/d3d_field_view.sh', 'trim'),
(4, 2, 2, '# intel compiler\r\nsource /home/teakwood/local/intel/composer_xe_2013.0.079/bin/compilervars.sh intel64\r\n\r\n# Specify the config file to be used here (will be set in Teakwood)\r\nargfile=config_flow2d3d.ini\r\n\r\nexport ARCH=intel\r\nexport D3D_HOME=/home/teakwood/delft3d/trunk/bin/lnx\r\n\r\nexedir=$D3D_HOME/flow2d3d/bin\r\nlibdir=$D3D_HOME/flow2d3d/lib\r\n\r\nMPI_RUN=/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/bin/mpirun\r\n\r\n# Set some (environment) parameters\r\nexport LD_LIBRARY_PATH=$exedir:$libdir:/home/teakwood/local/lib:/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/lib:$LD_LIBRARY_PATH', 'date', '$MPI_RUN  -np $NPROCS $exedir/deltares_hydro.exe $argfile > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err', NULL, NULL, NULL, NULL),
(5, 4, 2, '# intel compiler\r\nsource /home/teakwood/local/intel/composer_xe_2013.0.079/bin/compilervars.sh intel64\r\n\r\nexport CAFUNWAVE_HOME=/home/teakwood/cafunwave\r\n\r\nMPI_RUN=/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/bin/mpirun\r\n\r\n# Set some (environment) parameters\r\nexport LD_LIBRARY_PATH=/home/teakwood/local/lib:/home/teakwood/local/mpich2-1.5-intel-13-gcc-4.7.2/lib:$LD_LIBRARY_PATH', 'date', '$MPI_RUN  -np $NPROCS $CAFUNWAVE_HOME/exe/cafunwave.exe  cafunwave.par > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err', NULL, NULL, NULL, NULL),
(6, 5, 1, '# set up running environment\r\nexport FVCOM_HOME=/home/alex/tools/fvcom\r\nexport MPI_RUN=/usr/local/packages/mvapich/1.1/intel-11.1/bin/mpirun\r\nsed "s/INPDIR.*/INPDIR = \\.\\//" < "${CASE_NAME}_run.dat" >  "${CASE_NAME}_run.tmp"\r\nmv "${CASE_NAME}_run.tmp" "${CASE_NAME}_run.dat"', 'date', '# run job\r\n$MPI_RUN -np $NPROCS $FVCOM_HOME/fvcom_Joao_Variable_Wind_LONI $CASE_NAME > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err', '', '', '', ''),
(7, 3, 1, '# set environment variables\r\nexport MPI_RUN=/usr/local/packages/mvapich/1.1/intel-11.1/bin/mpirun\r\nexport ADCIRC_HOME=/home/alex/tools/adcirc\r\n\r\n# create option files for adcprep\r\ncat > ./opt1 <<DELIM\r\n$NPROCS\r\n1\r\nfort.14\r\nDELIM\r\n\r\ncat > ./opt2 <<DELIM\r\n$NPROCS\r\n2\r\nDELIM\r\n', 'date', '#run adcirc prepariation\r\n\r\n$ADCIRC_HOME/adcprep < opt1\r\n$ADCIRC_HOME/adcprep < opt2\r\n\r\n# run mpi job\r\nif $SWAN; then\r\n  $MPI_RUN -np $NPROCS $ADCIRC_HOME/padcswan > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err\r\nelse\r\n  $MPI_RUN -np $NPROCS $ADCIRC_HOME/padcirc > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err\r\nfi', '', '', '', ''),
(8, 3, 4, '# set environment variables\r\nexport MPI_RUN=/usr/local/packages/mvapich2/1.8.1/Intel-13.0.0/bin/mpirun\r\nexport ADCIRC_HOME=/home/alex/tools/adcirc\r\n\r\n# create option files for adcprep\r\ncat > ./opt1 <<DELIM\r\n$NPROCS\r\n1\r\nfort.14\r\nDELIM\r\n\r\ncat > ./opt2 <<DELIM\r\n$NPROCS\r\n2\r\nDELIM', 'date', '#run adcirc prepariation\r\n\r\n$ADCIRC_HOME/adcprep < opt1\r\n$ADCIRC_HOME/adcprep < opt2\r\n\r\n# run mpi job\r\nif $SWAN; then\r\n  $MPI_RUN -np $NPROCS $ADCIRC_HOME/padcswan > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err\r\nelse\r\n  $MPI_RUN -np $NPROCS $ADCIRC_HOME/padcirc > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err\r\nfi', '', '', '', ''),
(9, 6, 2, 'export WINE=/usr/bin/wine\r\nexport EFDC=/home/teakwood/efdc/efdc.exe', 'date', '$WINE  $EFDC  > $WORK_DIR/teakwood.out 2> $WORK_DIR/teakwood.err', '', '', '', '');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
