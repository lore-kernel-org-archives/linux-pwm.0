Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2437F8DA;
	Sat, 27 Jun 2026 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782594806; cv=none; b=tew/z+A4WNHdBF/cQNUNQ4eWvkZqfIRdVpWzAPQN9UysYqhIAzxGhyMz8Nf4yig8ViCbwbBVDELMVsFyEDsEfjjyjcjcoLlbMLid8AXYxgqqGyJO8Rgf6MOwzUnzKFpp4KJyveQr4kmYhHIvQeXQJagCYa7a+sT7fqFqw2Ww4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782594806; c=relaxed/simple;
	bh=1Ve1lnWL8MqFDY6x1F0a+Cr5ERd75xeWjxCaFn1PWAo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sIf8/mNYA2M8X0zs+NKtBmsQP57fG1Z1VuVLOQ3y6UB/S0S3KGiSprWwCCNFWOiedBZKymByO4229GwWwhiw9GV8//O729qd0JOINLeupwcm1zN5MWYTbg5B9BvnojUv+QXx6rFihRlE5pSJTKWqIKGqwB6eQPQwjPxo8LUIyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMSUmFzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMSUmFzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6DA1F000E9;
	Sat, 27 Jun 2026 21:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782594805;
	bh=tbvwOTEkP9njMWUj8fFRv724UgzF7XF26/BBC1EeU6Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RMSUmFzw8LVPz6p8Sef/zUvD+yBk9bFCClCCp88pUO++14ES6C8Xd5wUjpPSI/vgp
	 H5qt4XkGt6oT4QeDU+m+sm2XMpPypVTASwJ2fxKsk6UDc60tNdpe74Bx4SbdPatpFt
	 cSICBOk4IExA8RUE4yqYITiH+RzuDnWrxQlcK2tePq++rGkhnTfOKUlt1DbLPDxhgA
	 Z/RvBdrltf/LSsBFQRrv3U+S8CKGEHI8jv12sBTlOOhs39NeHTu/zGPbRQmWvniM4T
	 su5oBzo8p7ZkcYbp+hapFU68Z/YmeA4cWcpLxxyezd2QtOSbkEnshTjGXHqEGmSYlK
	 /FWNhREXnVtQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A313938452;
	Sat, 27 Jun 2026 21:13:12 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 7.2-rc1 (batch 2)
From: pr-tracker-bot@kernel.org
In-Reply-To: <akAWnuys9snFTiB_@monoceros>
References: <akAWnuys9snFTiB_@monoceros>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <akAWnuys9snFTiB_@monoceros>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.2-rc1-2
X-PR-Tracked-Commit-Id: 898ab0f30e008e411ce93ddf81c4099abd9d4e46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 780d569e6c4b422290f5cba319eb904b355d64be
Message-Id: <178259479117.1431938.5630421290545007329.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jun 2026 21:13:11 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jun 2026 20:35:33 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/780d569e6c4b422290f5cba319eb904b355d64be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
