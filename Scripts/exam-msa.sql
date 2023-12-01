DROP TABLE IF EXISTS `msa_raw`;
DROP TABLE IF EXISTS `msa_facts`;
DROP TABLE IF EXISTS `msa_areas`;
DROP TABLE IF EXISTS `msa_states`;
DROP TABLE IF EXISTS `msa_jobs`;


CREATE TABLE `msa_areas` (
  `areaID` int(11) NOT NULL,
  `areaName` varchar(71) NOT NULL,
  `areaState` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `msa_facts` (
  `jobID` char(7) NOT NULL,
  `areaID` int(11) NOT NULL,
  `calendarYear` smallint(6) NOT NULL,
  `employed` int(11) DEFAULT NULL,
  `employedError` decimal(7,4) DEFAULT NULL,
  `jobsPerK` decimal(8,4) DEFAULT NULL,
  `hourlyMean` decimal(8,4) DEFAULT NULL,
  `annualMean` int(11) DEFAULT NULL,
  `meanError` decimal(7,4) DEFAULT NULL,
  `hourlyMedian` decimal(8,4) DEFAULT NULL,
  `annualMedian` int(11) DEFAULT NULL,
  `annualOnly` char(4) DEFAULT NULL,
  `hourlyOnly` char(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `msa_jobs` (
  `jobID` char(7) NOT NULL,
  `jobName` varchar(105) NOT NULL,
  `jobLevel` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `msa_raw` (
  `state` char(2) NOT NULL,
  `calendarYear` smallint(6) NOT NULL,
  `areaID` int(11) NOT NULL,
  `areaName` varchar(120) NOT NULL,
  `jobID` char(7) NOT NULL,
  `jobName` varchar(120) NOT NULL,
  `jobLevel` char(5) DEFAULT NULL,
  `employed` int(11) DEFAULT NULL,
  `employedError` decimal(7,4) DEFAULT NULL,
  `jobsPerK` decimal(8,4) DEFAULT NULL,
  `hourlyMean` decimal(8,4) DEFAULT NULL,
  `annualMean` int(11) DEFAULT NULL,
  `meanError` decimal(7,4) DEFAULT NULL,
  `hourlyMedian` decimal(8,4) DEFAULT NULL,
  `annualMedian` int(11) DEFAULT NULL,
  `annualOnly` char(4) DEFAULT NULL,
  `hourlyOnly` char(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `msa_states` (
  `state` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

