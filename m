Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C8215F58;
	Wed, 22 Jan 2025 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572759; cv=none; b=QJEy8dn+0jJrfb4oANYCwG3ApjWBsZkKVt98ypeIPa/cLfuVSPyYO5W0qKFiVnq1onKqYggNbimBeZCVdU7/YTLPIDEdl8wZWVxM/oyhrWYpdOgdOJcVZH1IBwDD3rkuRQUKep9uCsCzdl29lSW43D0hGZAOMiG5FGjv71sO+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572759; c=relaxed/simple;
	bh=hX+WaW3T+YYx/lO7JdpKSrBglJpHxZHVXndPqlWclSk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tkS5A3YECKPfFpzfDoJH8iIw9ny1F/M1pGMQWiifUiwqSB03QxYKoo5Y/qDG89zHAWM1JZk7HDqViuonxCgZQIAUN1Qwl9bn8cRZlRr99ZYoVqgklivMWUVDyoVlB/vsy7mOSwbhGGA3e4ZWc5N8oZHxS8dU+jttUUy+DoV8mGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6azB/zg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6azB/zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0403EC4CED2;
	Wed, 22 Jan 2025 19:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737572759;
	bh=hX+WaW3T+YYx/lO7JdpKSrBglJpHxZHVXndPqlWclSk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f6azB/zgrUCCygeBu/9FAsmlYviRrtIXzyQniCtKCUFqB9s3BfhTGmuBl97528TGd
	 h+TbQ6gpRCCq8QxYXAZqmjUy5Me4yuPwqTUVbHpqK0lty4F+w1+aaB7x2c4QVZfDWt
	 zo0uZZxbaDjChPhTIZnV83aFX2z24ozCPh9U0EVgPYJEXEKE+W7kTp5R/Ogqg49PA+
	 zhkk35cfmZc/PbFPdWZbxeJeetGPn96E/EbPNn30Wj4qKDbrV6o967/DscbBRYCyLm
	 dSuknrXsar+Y4FHtGqd6G0gtOKucl2PX04R37UxYJDBictGdT2ORrVPmWrh7daiCCA
	 K6MKhwkDJDh+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDA3380AA62;
	Wed, 22 Jan 2025 19:06:24 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <2cig3eu5b6noqdtx7jjken4larht3ch7rlmfizw7kzpm7aqx22@qm7etmdulru6>
References: <2cig3eu5b6noqdtx7jjken4larht3ch7rlmfizw7kzpm7aqx22@qm7etmdulru6>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <2cig3eu5b6noqdtx7jjken4larht3ch7rlmfizw7kzpm7aqx22@qm7etmdulru6>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.14-rc1
X-PR-Tracked-Commit-Id: e8c59791ebb60790c74b2c3ab520f04a8a57219a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d12f68b5ba08e8b4527532fa8a61c404c9832842
Message-Id: <173757278314.783272.7266112324743093001.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 19:06:23 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 22:56:38 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d12f68b5ba08e8b4527532fa8a61c404c9832842

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
