Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB737E2FA;
	Wed, 15 Apr 2026 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290493; cv=none; b=FItSwdH3J1rib1sxUwwuf0ZIrfMfIxcXUOmBkoNXZtUbAXds+rzo3YmVITFln09yoGYxw+6JiGRg5N8o7QeMk6Tcd7U0wSw86fGCNXZvD5XS/CAAoazVeeWhEvOJ/Grji1G7gYa8gFhBVRBrtClAIQwU+ZDpfrTruvViL+Fsbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290493; c=relaxed/simple;
	bh=DuH4ZckBrP/vdXKVcHbXCLNYcoumcEg9s9CyXTU6xQ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A3+JZDNpzgvHxdhUXJN3pMR+2psvkHrGojZ/q+4LGLiiNueZ92M4kcPWI7B1vw2BaWfR6nFWipmJA9ML2VO7M0UDOYbVx8g1HTRChihL8+OW/hEKuFnHZWJ37XkH/R/iTuCPSKGcZBvfPa//kHAvTlKIQ3glvnqf89n2wPYHZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g67Rttuj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g67Rttuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CF9C2BCB3;
	Wed, 15 Apr 2026 22:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776290493;
	bh=DuH4ZckBrP/vdXKVcHbXCLNYcoumcEg9s9CyXTU6xQ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g67RttujsFIV39jHx471c5pPZAzx7NWW3G7iV8BjnrQF7nxLbgChVEKq0hGC+RTUJ
	 oH4jCveUgJ0fLPuuFFwrsj+tZIHyITX0vpiiA8/h5r0gfltjA9oY0ZcTM09FCKlxfC
	 PKec2XCNp59j6bCvsLnyz+CJggzwr1nTKhHbF5llFkmf8OmwtMGoIq8/79iFm0v0MS
	 a0RwJX1lEWFx6YXji6NTTb3+G9jYPk+6n96fWXB5KkCuIkCuPihBnTAHPmPPqx89MN
	 O1df4xKm8+L1FefQWaticskPneMFD0ecUS15WmcWy2mA0Htt6N63osAI+jX6wQL0an
	 cgnp3L8PdvXwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC5F380A964;
	Wed, 15 Apr 2026 22:01:04 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <adymoAWvo5IOs3yv@monoceros>
References: <adymoAWvo5IOs3yv@monoceros>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <adymoAWvo5IOs3yv@monoceros>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.1-rc1
X-PR-Tracked-Commit-Id: aa8f35172ab66c57d4355a8c4e28d05b44c938e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9962335d4c6dee152e95dce9f0dd32048735a6d
Message-Id: <177629046306.2457809.6919278602603095280.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 22:01:03 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 Apr 2026 10:22:44 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9962335d4c6dee152e95dce9f0dd32048735a6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
