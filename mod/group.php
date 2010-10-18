<?php

function validate_members(&$item) {
	$item = intval($item);
}

function group_init(&$a) {
	if(local_user()) {
		require_once('include/group.php');
		$a->page['aside'] = group_side();
	}
}



function group_post(&$a) {

	if(! local_user()) {
		notice( t('Permission denied.') . EOL);
		return;
	}

	if(($a->argc == 2) && ($a->argv[1] === 'new')) {
		$name = notags(trim($_POST['groupname']));
		$r = group_add(get_uid(),$name);
		if($r) {
			notice( t('Group created.') . EOL );
			$r = group_byname(get_uid(),$name);
			if($r)
				goaway($a->get_baseurl() . '/group/' . $r);
		}
		else
			notice( t('Could not create group.') . EOL );	
		goaway($a->get_baseurl() . '/group');
		return; // NOTREACHED
	}
	if(($a->argc == 2) && (intval($a->argv[1]))) {
		$r = q("SELECT * FROM `group` WHERE `id` = %d AND `uid` = %d LIMIT 1",
			intval($a->argv[1]),
			intval(get_uid())
		);
		if(! count($r)) {
			notice( t('Group not found.') . EOL );
			goaway($a->get_baseurl() . '/contacts');
			return; // NOTREACHED
		}
		$group = $r[0];
		$groupname = notags(trim($_POST['groupname']));
		if((strlen($groupname))  && ($groupname != $group['name'])) {
			$r = q("UPDATE `group` SET `name` = '%s' WHERE `uid` = %d AND `id` = %d LIMIT 1",
				dbesc($groupname),
				intval(get_uid()),
				intval($group['id'])
			);
			if($r)
				notice( t('Group name changed.') . EOL );
		}
		$members = $_POST['group_members_select'];
		array_walk($members,'validate_members');
		$r = q("DELETE FROM `group_member` WHERE `gid` = %d AND `uid` = %d",
			intval($a->argv[1]),
			intval(get_uid())
		);
		$result = true;
		if(count($members)) {
			foreach($members as $member) {
				$r = q("INSERT INTO `group_member` ( `uid`, `gid`, `contact-id`)
					VALUES ( %d, %d, %d )",
					intval(get_uid()),
					intval($group['id']),
					intval($member)
				);
				if(! $r)
					$result = false;
			}
		}
		if($result)
			notice( t('Membership list updated.') . EOL);
		$a->page['aside'] = group_side();
	}
	return;	
}

function group_content(&$a) {

	if(! local_user()) {
		notice( t('Permission denied') . EOL);
		return;
	}

	if(($a->argc == 2) && ($a->argv[1] === 'new')) {
		$tpl = load_view_file('view/group_new.tpl');
		$o .= replace_macros($tpl,array());
		return $o;
	}

	if(($a->argc == 3) && ($a->argv[1] === 'drop')) {
		if(intval($a->argv[2])) {
			$r = q("SELECT `name` FROM `group` WHERE `id` = %d AND `uid` = %d LIMIT 1",
				intval($a->argv[2]),
				intval(get_uid())
			);
			if(count($r)) 
				$result = group_rmv(get_uid(),$r[0]['name']);
			if($result)
				notice( t('Group removed.') . EOL);
			else
				notice( t('Unable to remove group.') . EOL);
		}
		goaway($a->get_baseurl() . '/group');
		return; // NOTREACHED
	}


	if(($a->argc == 2) && (intval($a->argv[1]))) {
		require_once('view/acl_selectors.php');
		$r = q("SELECT * FROM `group` WHERE `id` = %d AND `uid` = %d LIMIT 1",
			intval($a->argv[1]),
			intval(get_uid())
		);
		if(! count($r)) {
			notice( t('Group not found.') . EOL );
			goaway($a->get_baseurl() . '/contacts');
		}
		$group = $r[0];
		$ret = group_get_members($group['id']);
		$preselected = array();
		if(count($ret))	{
			foreach($ret as $p)
				$preselected[] = $p['id'];
		}

		$drop_tpl = load_view_file('view/group_drop.tpl');
		$drop_txt = replace_macros($drop_tpl, array(
			'$id' => $group['id'],
			'$delete' => t('Delete')
		));

		$celeb = ((($a->user['page-flags'] == PAGE_SOAPBOX) || ($a->user['page-flags'] == PAGE_COMMUNITY)) ? true : false);

		$tpl = load_view_file('view/group_edit.tpl');
		$o .= replace_macros($tpl, array(
			'$gid' => $group['id'],
			'$name' => $group['name'],
			'$drop' => $drop_txt,
			'$selector' => contact_select('group_members_select','group_members_select',$preselected,25,false,$celeb)
		));

	}
	return $o;

}