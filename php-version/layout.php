<?php
function head($title,$tab=''){$u=user();
$links=['index.php'=>'Dashboard','appointments.php'=>'Appointments','patients.php'=>'Patients and records','doctors.php'=>'Doctors'];
if($u&&$u['role']==='staff')$links=['index.php'=>'Dashboard','book.php'=>'Book appointment']+array_slice($links,1);
?><!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title><?=e($title)?> – Bayanihan Family Clinic</title><link rel="stylesheet" href="style.css"></head><body>
<header><div class="wrap"><?php if($u):?><span class="who"><?=e($u['name'])?> (<?=e($u['role'])?>) · <a href="logout.php">Log out</a></span><?php endif;?>
<h1>Bayanihan Family Clinic</h1><p>Appointments, patient records and doctor schedules in one place</p>
<?php if($u):?><nav><?php foreach($links as $f=>$l):?><a href="<?=$f?>" <?=$f===$tab?'aria-current="true"':''?>><?=$l?></a><?php endforeach;?></nav><?php endif;?></div></header>
<main class="wrap"><?php if($m=flash()):?><div class="msg" role="status"><?=e($m)?></div><?php endif;
}
function foot(){echo '</main></body></html>';}
