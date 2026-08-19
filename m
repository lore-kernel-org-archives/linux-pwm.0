Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436D490C0C;
	Wed, 19 Aug 2026 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160095; cv=none; b=pc2x2CQybAmFwwuIt1K5LasndBjQ5IPjyGgACjnf0nIkWYt0kfXxSh06LTkE2uhVSGrrWNkB83q1nRiQwylEx0JtMEQ7Fq8xulVfzkht8dnqKx4MSvxipe5rJBOxWdEWGctufcwsTlimDouC8nF3rNWdF2mE0VX17Yf4wd9A7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160095; c=relaxed/simple;
	bh=ze96uZvOAhp+GHkhn7HuCtVTnhEi7WrmrWKSoy5ggGw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cg1xDCwax3s+Yo4gnCxATvcLyHD5Xg4UKlc7MwWw2hvfkVAa2Lav4adxHfrlM6ntrmKzDi1bSeAdCeDSk9rbDHkmDez0AGpRz8N8FvwtJ+yJSaot0JyNpbR15rIi8HRGkNivJNvBGMg2x4iOiIfb5JsxtK2FMYje0Bi2BMGhSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pdx+aTbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pdx+aTbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171D01F32F2A;
	Wed, 19 Aug 2026 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787160082;
	bh=tJfzr/56PDel6q19RyxBaEGwC6SiUQyLNbdu0IXDJUY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Pdx+aTbfLy2v+zEr9YI1AK6mZQfS73yTSQs5VDEJXiM2ty/gBX4rnaPxdXPiMh//S
	 uhLhTAL0p3Uk7ao1/cQPRByRrCFa6nsP/r+IfmIFt436XhERCKxpmVnvONiWst3yrS
	 8HEoBFQozcjkYmsYMGFqMuoxEb6k0MkCFrCKvSieUTLC6ZAJeGdjkcXKBRmiY003gP
	 fEyitembPG+t7SIzIy83WRCIFhzBAzmMN9GZT82pyH+M49+q3DUWjxjtD3eTFlQfEu
	 ylEQE9HHxaqSdjGJz54FfLjun3ccwG9Rt2I0viEN/6o7qwtFo0pPPpuUyZTCoMkgbE
	 gFgzkH8grswsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4335C38119E7;
	Wed, 19 Aug 2026 17:20:34 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aoI4RihmFwccNTL3@monoceros>
References: <aoI4RihmFwccNTL3@monoceros>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <aoI4RihmFwccNTL3@monoceros>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.3-rc1
X-PR-Tracked-Commit-Id: b4e94b0418ad6dbe62b6ca53369159ed3d9f0d8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a288cd69f7dea3cd232b721f935c379b74a69814
Message-Id: <178716003290.3599392.17609554669618119960.pr-tracker-bot@kernel.org>
Date: Wed, 19 Aug 2026 17:20:32 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 00:33:28 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a288cd69f7dea3cd232b721f935c379b74a69814

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
