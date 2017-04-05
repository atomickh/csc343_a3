declare variable $dataset0 external;
declare variable $dataset1 external;


<histogram>
{
  let $hasSkills := $dataset1//resumes/resume/skills/skill
  let $skills := $dataset0//postings/posting/reqSkill/@what
  let $skills := distinct-values($skills)
  for $s in $skills

  return
      <skill name="{$s}">
	  {for $i in 1 to 5
	      let $is := (for $hs in $hasSkills
			  where ($hs/@what=$s and $hs/@level=$i)
			  return ($hs))
	      return(
	      <count
		level="{$i}" 
		n="{count($is)}"/>)
	  }
      </skill>
}
</histogram>