declare variable $dataset0 external;
declare variable $dataset1 external;

<bestskills>
{
  for $interview in $dataset0//interviews/interview
    let $rID := $interview/@rID
    let $name :=
	      (for $resume in $dataset1//resumes/resume
	      where ($resume/@rID = $rID)
	      return $resume/identification/name/forename)
    let $pID := $interview/@pID
    let $assess := $interview/assessment
    let $col := 
	      (if (exists($assess/collegiality))
	      then (data($assess/collegiality))
	      else (0))
    let $com_best := 
	      (if (data($assess/communication) >= data($assess/enthusiasm) 
		  and data($assess/communication) >= $col)
	      then ($assess/communication)
	      else ())
    let $enth_best := 
	      (if (data($assess/enthusiasm) >= data($assess/communication) 
		  and data($assess/enthusiasm) >= $col)
	      then ($assess/enthusiasm)
	      else ())
    let $col_best := 
	      (if ($col >= data($assess/enthusiasm) 
		  and $col >= data($assess/communication))
	      then ($assess/collegiality)
	      else ())
    let $best := ($com_best, $enth_best, $col_best)
    for $skill in $best
    return
      <best resume="{data($name)}" position="{data($pID)}">
	{$skill}
      </best>
}
</bestskills>
