Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817844CF2F;
	Tue, 20 Jan 2026 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934250; cv=none; b=RaBN/a6MOb/WGc6BwZAitE/ZFpqUqVXj3cq1oiCZ/M+sjez4wIn2yhlPrQFE5ss5bBzkWQ/f8KhUeJB46/u4FsqU1COqJrFEU+jJdjOsZW9TFuwD3qhsVnKfVGOqKYVT/MDF6tLBxIKGqP3cg0nlfeHdhD3QB29GQ8aHPbo967g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934250; c=relaxed/simple;
	bh=ub4jSQ34mq+qTT+ILljidxJit465wa4ZIOh3O3yYW6E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mzAyeoMtZil2piJdNm5MY/QCv6w68mNCosWtQEDXSA04U7yvBjhS6y8fQgmvPAdHZYQYXGVppvxwrerDzAzGdNdy4v1jLmiPeVghbrgk9y7s1IN81ZMhTXbuE7plDFL9oUd5y8X67fE6dWFuZHjAgviIiGoKSCv1jCvhw3lgxMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV6QWeeF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV6QWeeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF251C16AAE;
	Tue, 20 Jan 2026 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768934249;
	bh=ub4jSQ34mq+qTT+ILljidxJit465wa4ZIOh3O3yYW6E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BV6QWeeF1jsnWWHIp74whSzgy2G7iHNNMDT+WbEG7pDhni2kIbtD59TyRGhZxXHtQ
	 vghdbBcYDc/DlxIXvBBYMLg53KHOEqlC/RNvrWcsHFWPg1qoTIloT3JABKNIDNJVtm
	 3lpi96JTLiWx7cluD0WXD8ZNMKbSa/Ow8cCIEQOmaFasByWKzI4j9hSst6OdpbC3il
	 VoiKZUO136QJ+i5g7+xku8kLwr7T8OD7l261Oef8S0UgXKnHsV36Dx8fGdnBrqhXiZ
	 /hHF+nOqsayJy8MWjP6v482MCG/1Gb/ynwdhNEs9B4Z+m7tFD7mwediwabpJ1cJxzk
	 0X3WM2nygYNLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8C0BC3810935;
	Tue, 20 Jan 2026 18:37:28 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Two fixes and a maintainer update
From: pr-tracker-bot@kernel.org
In-Reply-To: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
References: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.19-rc7-fixes
X-PR-Tracked-Commit-Id: 0a155a8a24ddc647aaf28ce7cdb14af7270c158f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f7537efbe5636a798cf885ea2fa0e4889995fa9
Message-Id: <176893424716.562471.5970388282256942551.pr-tracker-bot@kernel.org>
Date: Tue, 20 Jan 2026 18:37:27 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>, Richard Genoud <richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 20 Jan 2026 10:32:26 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.19-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f7537efbe5636a798cf885ea2fa0e4889995fa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
