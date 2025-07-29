Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EFC26B946;
	Tue, 29 Jul 2025 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771805; cv=none; b=TNIrXmNpqjTh+kSgjMeh5o9huMu9NZZMzIjbF4lq+BaDzqcJ2uOPy8ZqRUKFTqaBBey+MaQPzmcvqxYk1lUHmD7FmjkuQ+8i6LSsTjcp4znz36p31BNddYIhvLv9VBMmj3qp15c15BVLbSGCkd38RlL7o8j9emmQ41A+A/GAG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771805; c=relaxed/simple;
	bh=hJN86enl5gmK0j6E2nIzbbuzufIfnxZqoad3uvnxmwY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YAeGuwVdWSzVH8Rqinm+7Pu8L2Yi4KRh1Wuf6yeIT1hiW2902ggHKSCsDJOknDyCqzrOGjzwz+DtECyzHWrYz7s86/yhaRLfScvuoNfweDRqV66pqVNe6Arr6EEZ1ZPfInLDXNQhzyrwUnX8Qy3d62DpoMmhjU21uehIenO6TTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/zxfihb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/zxfihb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EAAC4CEF5;
	Tue, 29 Jul 2025 06:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753771805;
	bh=hJN86enl5gmK0j6E2nIzbbuzufIfnxZqoad3uvnxmwY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E/zxfihbEdRCgmHUx7IGqzltsWyr5UsoFp2oS7M/wmLoQOBsOZZzqfC4m0YLHGSml
	 8VuVFUgPpC863826D85mEDhf524iZ1qC1P3+urgtvE3UfdW+TSAOYTxR2dQVn1f9P5
	 g0oqdcfsPjyNRSM4s1c66EnDHU+QPVQiYcmfu6tjoh+LTH7uWPh40Mdy3SBf5qMIgn
	 iLXeS1ShXLRcm02bIpK/WegcomSzRvaQznuky2fB2lQbwSqVkiyE1NK45ctjV0vtWP
	 Q8ijxr1uUUyo4y1mpf04WmDUPXjFiXgDsU5a+g/v8VkbOcVCUJPoruAb4fApzTcQr1
	 FoE5WKtZSoEQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3F2E2383BF60;
	Tue, 29 Jul 2025 06:50:23 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aukywky7iv22b3noqkzx42hod5zbhgfgrhrt4uddg6c5k7nzlb@oey3yxxhroj6>
References: <aukywky7iv22b3noqkzx42hod5zbhgfgrhrt4uddg6c5k7nzlb@oey3yxxhroj6>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aukywky7iv22b3noqkzx42hod5zbhgfgrhrt4uddg6c5k7nzlb@oey3yxxhroj6>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.17-rc1
X-PR-Tracked-Commit-Id: 68b9272ca7ac948b71aba482ef8244dee8032f46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f38b7512903a50eaeb300e9c8d9448187dd3959c
Message-Id: <175377182210.1356386.1510852764792942020.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 06:50:22 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 11:45:55 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f38b7512903a50eaeb300e9c8d9448187dd3959c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
