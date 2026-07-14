Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579993921D6;
	Tue, 14 Jul 2026 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030581; cv=none; b=UnMPxTJe4NX7d4CpO6r7NeqN7CW95+4g3SeWopcsPlntqA910W9PI9kHFjyxpGKTIwySUY8kfZ0BHLADtSon0fOCqxrGoTHwUEUazfQ2g/GoAL3UsQwH+2/L7XDHlkyZ0cHbBAL2swqJ3aO8uhzFmvrJdysBTCyc8YGDJ+rqT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030581; c=relaxed/simple;
	bh=zdvttxB++OPgFS/P0oSzYrE+0LjRto99mwDgt5GhiKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TtzjwrbVxtXIOgeNlOY6kGPLlBjah3R3uCiUh/n2HipJKZBm13FCjBKBbSek8/w62azrtB1WlUIrn04IYh1NsZXqwqtSRj9W4cTx9ZihvAv7BMfl0Kv0199womr81+stKnqVe0n/MY3YGEiWQw5LnmD6V0WkjLPQlap/NnVLjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSWM2yjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSWM2yjJ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5994C1F000E9;
	Tue, 14 Jul 2026 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030579;
	bh=fuXufKmvo/6HSifVsX+u9QywX6Yc3DtFcrqAMBwjNwE=;
	h=From:To:Cc:Subject:Date;
	b=MSWM2yjJhbFFUL+U2GgFhW5FlLIfZS/rR2fueB6C1H2f1VKkand/iNOmP6bOByshC
	 oWj3XTk7hhgQvfKUyPBWAPAnGDGUEfgVKHwsPs2pCE8w7YWpsdIuyQTMenCS/z0Sfu
	 5m52r9E1VFfczzNzoMXvarPDl3JS10B2AQtJRfXkB4fcGf5kWxfchgSa3An75B29Je
	 V40LJXXzYwGWU9We7PHGOrYqG5H2hOtQk+tuoJD627Y361AuTGy3TQCyfxMtQse484
	 t2sPezfCjvyVZJB8GDYPfTeBtkuFfxqzhLY/Xv85LtmnEBpZm2joj/6lEakXROSrxx
	 zLbZKBDmyIjZw==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 0/6] pwm: tegra: Cleanups and .get_state()
Date: Tue, 14 Jul 2026 14:02:34 +0200
Message-ID: <cover.1784030076.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=ukleinek@kernel.org; h=from:subject:message-id; bh=zdvttxB++OPgFS/P0oSzYrE+0LjRto99mwDgt5GhiKw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqViVbLMW+VvxQs51fjWIvbf+QIuxwkRkiKpzdo 10m1lzZyFaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalYlWwAKCRCPgPtYfRL+ Tt2iB/99j53XVVjssMyp+W4g8SDMVzAVUEaqnpVuAXOcxMv4rGRWSCygjYhVKral/yzLUPPhtub o+AU+Uuc8rmZTv3khdcmxXjGakP5UTfWBJuUsdIr4V5NUEAaC4FQp0JzfPEmr9v65RAW8rnAYYi 4ggnHEnApCtBDaRFx3p7sIojEwFCUcD+AmAxh1QyXooWyhjcx5H/u203sIMNaZykkz4VlG9PbQf m8dc87lC/U0YaUOR8kBb3JlvXlUcLna9rh8NqqT6mlJRGTFfkPvHY924MNctxT2ddZ60n2Y9od/ 5HmtCdtTUqqTst6dJtZPoTVZhWoBjaUDhON47fSDW3Vf4lOR
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the tegra PWM driver annoyed me for some time. This patch set addresses
some of the concerns. The implementation of .get_state() is the check if
I understood the hardware correctly. If so, the next step is to fix the
rounding in .apply() and/or convert to the waveform callbacks.

The first 5 patches should be fine (unless my understanding of
pm_runtime is wrong, which is quite possible), for the 6th patch I'd
like someone to test it before it gets applied.

Best regards
Uwe

Uwe Kleine-König (6):
  pwm: tegra: Check for match_data being NULL
  pwm: tegra: Make use of dev_err_probe()
  pwm: tegra: Use devm function for pm_runtime_enable()
  pwm: tegra: Simplify using
    devm_reset_control_get_exclusive_deasserted()
  pwm: tegra: Simplify using devm_pwmchip_add()
  pwm: tegra: Implement .get_state()

 drivers/pwm/pwm-tegra.c | 123 ++++++++++++++++++++++++++++------------
 1 file changed, 86 insertions(+), 37 deletions(-)


base-commit: 82dcd68f7246eeacbc2ef614b82e284a50b2b8bb
-- 
2.55.0.11.g153666a7d9bb

