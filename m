Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693903;
	b=5TX3JOY7/J10lZK3Wih43dZ7Lt9l7DXa0Np7vpvGEkGSJC8eSx6SdB/QcBMewQV2MFPc
	 U3/+s68it0NTTjnsdBBHazG0DXwLSQk7ocxLdY7HwYr6SQFhxGT8uZPWGzw2UA6go0aTI
	 G+rR8m2JJPqkHlI/mUcPxJJpxeFJ7vR3qNFTYbCXuvpCCSYeDbeHrc0JhGf9hvNPRy0iU
	 zSx2K104gTVdNkQ5AmbiTrMu+AnDpb3Fw6x6hiwZWpW2mzGxKTPqVhcj5U8i5q3AfU6uj
	 nw01r1fCaTsohSYea4mb4qiS7AsWq4xJHJgxpMB2fYNh70uabxxjv/GFjJD0R8i/TBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693903;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=QWE8sQ7bW7l8UFMlB2/eQFFNNkOh3PQiRIxua5iQ4Ck=;
	b=nhq8BTORUZwK9MN8T5Z26o6+A1uw1ENBChYKcsldhxblywd6xBTvhH6TXCSUi1mU2k95
	 JrHkn5jxEzoy7HbP2FRJxL05hkZNhPSzplkXm6RNMksjTBPzUAiZq1svPshZhdyBIy+1D
	 jzYUZEl+JJDBC17aLJXgErgAKDNKUU4UH9kBqvmGNFWeeCXlaHK7CtgYAMfLbUVuH6cJJ
	 mPDeyUx3W64zt40atRyOEiGY7xSVYTvYEJ1fybXNoRJ9JSHbhYfOn6TxvQr92++HoW2og
	 yWo65IzK2DPSsn1sjLSKpmDNzKH45zYX8cRV9ywoDlwdI5xapayRwElPOjj+jURPpBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zxt4C8nS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2416E606B7E9;
	Thu, 22 Oct 2026 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zxt4C8nS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E11E1F031E1;
	Thu, 22 Oct 2026 18:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693903;
	bh=QWE8sQ7bW7l8UFMlB2/eQFFNNkOh3PQiRIxua5iQ4Ck=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Zxt4C8nSPHvDiSaieoQr2MAbMoHginP4K+eYIeYllu+XpWWdyF5xyKI6DC3HrTjWo
	 B6Uf6AHVYSfK9Ll6uZhTlDB/p21H1j5Kw5PTdTCO8UfLD5ojSYBLjrKwDELNs6o3Zz
	 uNjzylG9yNkxeNxPdKN4Vj89z7f07u/v+ta1ScqsW6YN0L3cFSRmvr+Iz50YGtQJXI
	 m7z3ToMHIWZ2KIrPmzx1TTlrH3ItMjFCai0mFXLcVSy94w7Lk0hjP6SLj3OJ6zMZwb
	 zZOUBOzVUUmsXVJSc9UCaHEO1KrUMx/zKOiOhbY7lEZ7znw40blNxcNYejwESrVfgr
	 r1wgXCQLOjAzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 06E533808222;
	Thu, 22 Oct 2026 18:31:43 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <atHZhAtSk7UGkVGX@monoceros>
References: <atHZhAtSk7UGkVGX@monoceros>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <atHZhAtSk7UGkVGX@monoceros>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.4-rc1
X-PR-Tracked-Commit-Id: 00e917df050d79ac26ec700717680ad6421d2808
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0e1eda687a2f19a8fa3958303fbb45d493ea46b
Message-Id: <179269390179.87271.13614341424514409803.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 18:31:41 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 16 Oct 2026 10:15:45 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0e1eda687a2f19a8fa3958303fbb45d493ea46b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
