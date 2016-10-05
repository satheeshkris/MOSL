/*
	Memory Optimised Library for SQL Server 2014: 
	Shows details for the Garbage Collector
	Version: 0.1.0 Beta, September 2016

	Copyright 2015-2016 Niko Neugebauer, OH22 IS (http://www.nikoport.com/), (http://www.oh22.is/)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

SELECT 
	(SELECT COUNT(*)
		FROM sys.dm_db_xtp_transactions tr
		WHERE tr.transaction_id > 0
			AND tr.state = 0 /*Active*/) as ActiveTransactions,
	(SELECT COUNT(*)
		FROM sys.dm_db_xtp_transactions tr
		WHERE tr.transaction_id > 0
			AND tr.state = 1 /*Succesfull*/) as SuccesfullTransactions,
	COUNT(*) as Queues,
	Cast(AVG(total_dequeues * 100. / case total_enqueues when 0 then 1 else total_enqueues end ) as Decimal(6,2)) as [De/En Queues],
	SUM(current_queue_depth) as TotalQueueDepth,
	MAX(current_queue_depth) as MaxDepth,
	AVG(current_queue_depth) as AvgDepth,
	MAX(maximum_queue_depth) as MaxQueueDepth
		FROM sys.dm_xtp_gc_queue_stats

--SELECT *
--	FROM sys.dm_xtp_gc_queue_stats

--SELECT *
--	FROM sys.dm_xtp_gc_stats

--SELECT *
--	FROM sys.dm_db_xtp_gc_cycle_stats
