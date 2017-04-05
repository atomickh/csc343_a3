declare variable $dataset0 external;


<important>
{
  let $products :=
	  for $skill in $dataset0//postings/posting/reqSkill
	  return
	  <skill posting="{data($skill/../@pID)}" what="{data($skill/@what)}" product="{data($skill/@importance) * data($skill/@level)}"/>
	  
  let $max_prod := max(data($products/@product))
  let $max_posts := 
	      for $prod in $products
	      where (data($prod/@product) = $max_prod)
	      return data($prod/@posting)
	      
  let $max_posts := distinct-values($max_posts)
  for $post in $max_posts
      for $p in $dataset0//postings/posting
      where (data($p/@pID) = $post)
      return $p
}
</important>