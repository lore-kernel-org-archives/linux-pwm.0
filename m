Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E53ABD90;
	Tue, 16 Jun 2026 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575891; cv=none; b=mSULwJRN/PZLSec3ytxx75rkdwe0RmBvbtNPYB81tknMFPghnlCRW6qrslG8YVXdCfOKNO1t42CspSecURFf/B9wDDWu+e2QSXeEogh8AlIy6qH+SpnS+LT0oIAQm/gZjJGWxAGJKHXtOV2TLR+T0kjy7Ee9X7y9QvtbT8qSwLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575891; c=relaxed/simple;
	bh=hfIqkDLNcjv8ghTui/6OzgVgL5FTtMciiv1Uh/FGdDo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fUqzvwAgtU2wX94RUJJrDOjbSYavYI0vOtGfdZJBrc5T+cxAkdr2jtNTY4ILLajGc/p1JAhMfqkeN0OqXZ5YntuCofHl8a0Hf8NHQx1nxReHN52s4D2y03Bv8HWtB3cv2/uWBqOKOS2K1Nq3EPGjMpEALO1JA/KYpXAHYbHgNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9YBIhsa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9YBIhsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BDC1F000E9;
	Tue, 16 Jun 2026 02:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575889;
	bh=PqvdLKdDzSmUZhgF3YahrwAG68Txf4SWXUFvk0CI+/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=K9YBIhsa6xd72tlK6qfesEGVuMJOhve92SFJqvar1CGxIZC9tmCIPHeb6ZIbSLkG0
	 +EWuV1Z8p0iF9b5UGgpsg9TJxF9dB8uyyjbUzfOuY2HLQKk0n/tBS17rqvSoCxwzSp
	 4wlo1I0/7d5fAKxq67Sl7TYP5IZ6/sb1heyuGe/LKWMH8Ca8k3fHILkymIDx+Ygztw
	 rmAmRY9QjnemVlLXvxxSrF7C5ESVDpjZz1OeeEj2D9LEqkz9ioTNImMHbDVfjF6KV9
	 aBVQdPGWvVH1ECCxEFjnAgy2wF79OyJzgN8feQzyad3HcMhktgRkJrHtLbmkutlUnM
	 Un2BKVywNqDGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A283839A26;
	Tue, 16 Jun 2026 02:11:25 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ai-PyEf2c2Ce63FQ@monoceros>
References: <ai-PyEf2c2Ce63FQ@monoceros>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <ai-PyEf2c2Ce63FQ@monoceros>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.2-rc1
X-PR-Tracked-Commit-Id: 6f9b73071c15001530e6697491b6db1bf639f4c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b617c82580599994c8dd078ab0dcb0375b42eda
Message-Id: <178157588436.390807.13377302349431390382.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 02:11:24 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 07:46:40 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b617c82580599994c8dd078ab0dcb0375b42eda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
