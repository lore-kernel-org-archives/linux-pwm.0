Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF74DEC16
	for <linux-pwm@vger.kernel.org>; Thu, 15 Oct 2026 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054443; cv=none; b=Iaf29yf+OnRrpR6Cdo2/6BvbKF7cg0Q1l+q18g5SlZkCuD1pj2rBZLXrTLx2ygsnzuCTedv6LMzauVRDzdnhFDNVfLmFzqVv0WbQQq1n8kkx8WAru530D/P72IVXxOaEbG1UZdffjs8EmV9gwbrZ9yY5jDqfWyMuWOZ3pp3WwdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054443; c=relaxed/simple;
	bh=b96pYTcMW63e49quyJO5xjiSMV8TZP92gd9i71el7b0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=McyybcXCiY4Jzwdzii/9l+/neu2k6TRiDnGCtGK+NresIeXyeVzfyK+Zxbc6W4XpbLeqmsWcIWdHQrfDp65WNFSMPK5pXN1diysVFJNZpuX96wRX0JAVwsNJvzz/9vqZbwflWdIrZqEuhppcLZNqDIu8iyMJEeUqIJEwKpNDlZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=f9wZCKCZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="f9wZCKCZ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df54150dfso240125f8f.0
        for <linux-pwm@vger.kernel.org>; Thu, 15 Oct 2026 01:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792054433; x=1792659233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqtoLOebW3MOpzoS9qJgbIfmlFf7fkdqcloPGFqkfJw=;
        b=f9wZCKCZUphj7XKbyZNyAfAkowHrERTIpC8V7QKdZK5sQrvqm4Dzd7Km2I6e4F/hUV
         mCJOTnHREyZcy99n/rah3jKjjBNoVQYrB/wBRDlPN5GIZKuXOZ3FyLB/ob0SvJoXdfdD
         cEeq707eyuBHIVjs2WukkN9Yil82+HpK2mKw8PGuQ/4B7MCMDOGR2V8D8q88Akyl/8wi
         pxLimomQZRIzMLVAkR4xzzSFF9dRKB3h01x1vEFDXTzyI9P1Z9rF/9L/zjv5YkrQ3MRc
         gGl8QQ+ig4MTzy0pe/ExoNSPiA6TxvuQcfLlDVjrKdoHWisB+Hw+anHt9zTGP9laEMft
         2rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792054433; x=1792659233;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bqtoLOebW3MOpzoS9qJgbIfmlFf7fkdqcloPGFqkfJw=;
        b=c8/DeD6JOvLFRVPDjcXDaODEFt6R1V97xJAvMmoaDXLh1UAHoUfsK7FFQUNLdNcYBg
         7hZrv4F2eDuu0QTjw+bALxHprCKd8ueFaZtMO8ieXSZLlCO0U7s1T4KC1UsveOEhKLPk
         bnHfKiXcJimd8meS5x5rqdYsJk2IPJazkucou4n+PUjpbI7TrgrWxF0Z1RrtmBfdIBX1
         lj69rzCjKpEqd6L3tilhTbNO7eaSLsDe/ZN/HG5CrAvjCU1y9L6XSYpEbn/6rABUbGJ1
         rO4a+vJ0DLn6d+8NkyauwASSj+mDMp3Zd4VSU7qFOttTm3DWb30V7Sn3VULzAhs0e6RX
         Mefg==
X-Gm-Message-State: AFq9FYIXW9WiF4f+BEOtRmFmDMAqpzv9aOC20UBu7X4fsdUjHuuavqr7
	FMU+z4O+MYAZnrsxJIfswcc5LOsXh99GJSLhufWUAXFRtOOcHpHKkqsGIDPLTmf2Bg8=
X-Gm-Gg: AYBFou0tkg+Zsp1W86I+B9U+I/Fzv6XVdHUHaYaFExbs/LAYjF2VkH/hdN2cQXyEe6d
	qK3bnExjfkCl7PfXe1oRfnqWwQF6J09oknEXEM78M++5R9g8QJ/oyf0OIRdnYpzTSfvJutb4TAl
	WH4tFd4z6LyeofvPevQz6iCzmHFWJCYKAc9BaJQxouvl6C2EIDKR9Jk/BAl9QqU2F2D/hjpxoas
	GfVUwzyIfLlkfRZMxoQ0wMs8owajlhvIYB/dUfW2WtJU/WAXT8sR2NGAWpQCKlDvA00GqV1r91/
	iZ2rorBmTPNncZwMnYt+vTj6QFaqh2mPoCaGwrqI8TiUaEyMZeqfgifm4DjBQIAupAf/PmU5QdA
	wXe/ho0VsDFVqjUMQMiuTh+OoGpTIvMfBC2WIV9B+B0FPx+/wt4REs2zq+aBLsHcXgCNgHeZlZz
	SaBYKTYP6rXdKOg1a/T0rtzVMTQAYBPOonj/zgL3ULXdUG0U43HMDLbGLdHJej8hf6KjQIj5jcy
	3EupTjyanSV0io/S+SYGM0icbEJLpgR4HtluIzAP//WWIacRUB6+F0SmMKFD3JDZ6a+z78W
X-Received: by 2002:a5d:5386:0:b0:487:767:b301 with SMTP id ffacd0b85a97d-48dbacd94c0mr28298777f8f.57.1792054433004;
        Thu, 15 Oct 2026 01:53:53 -0700 (PDT)
Received: from localhost (p200300f65f19a90465ab3c5965b67ef9.dip0.t-ipconnect.de. [2003:f6:5f19:a904:65ab:3c59:65b6:7ef9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48df7bf4642sm1663459f8f.10.2026.10.15.01.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:53:51 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] pwm: tegra: Fix value discarding for duty and period
Date: Thu, 15 Oct 2026 10:53:35 +0200
Message-ID: <20261015085336.4181137-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3234; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=b96pYTcMW63e49quyJO5xjiSMV8TZP92gd9i71el7b0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq0JSQABZzvkkCBCI1PN3uhG0gm4AQqjvYAZY0o kOEZeg4T5aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCatCUkAAKCRCPgPtYfRL+ TtlyB/0cwvGxYVb9u+fbrW3AD2qOu4yAcu4vWMPwadvI21+ZiP3tIYAU0aera6GOC9c03gw7vRD p9BD0VPXN+r/Ev/jbFYhoSIwOvD2/U8VUH3WnTI6dXV+5Kgn4oKBksH8vSKlP93msUfAysDoMpS ZpcKfiqg8IhpdTgJM6P3AHrAF3/juh2e/s6iB/tHE/56FVYZECFbUY9IcaBNwYylAy8JNjDo+KD 0EZ6Nd1v0GP2zSFi+2dmne+nss1lMJZUxbzIIfqSxQW/cUJSo0I6HVQibA2Fp78+KvigQ3uFS99 tWdVG+4/eRlwfa2xsGMUr0gaowoP9Xdda7o0csBeh6tI5z/M
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

tegra_pwm_config() is called with u64 values passed for duty_ns and
period_ns in tegra_pwm_apply(). Make these parameters u64 instead of int
to not lose the upper bits for bigger values. If such a discard happens
the values that are written to hardware become wrong, or (if the
discarded period value becomes 0) a division by zero happens.

Adapt the math functions accordingly to not let the now potentially
bigger values result in overflows.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/bug/linux-5c5b97d6-4da6-4d06-9dc7-957419dcd832
Fixes: fd3ddd4355c0 ("pwm: tegra: Implement .apply() callback")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

actually the Fixes: line isn't quite accurate. The problem that the
arguments are cropped to int from u64 exists since v4.7-rc1 (commit
5ec803edcb70 ("pwm: Add core infrastructure to allow atomic updates"))
in the pwm core, but the blamed commit above is the commit where this
problem was moved to the pwm-tegra driver and thus it's fixable there.
The problem in the core doesn't exist any more since commit 0829c35dc534
("pwm: Drop support for legacy drivers") in v6.0-rc1.

Note this patch changes the rounding of the duty cycle (from somewhat
round closest to somewhat round down). It would not be hard to keep the
behaviour by introducing a variant of mul_u64_u64_div_u64() that rounds
closest, but the rounding is spoiled anyhow by later rounding of the
period. To actually fix that it would be best to convert the driver to
the waveform callbacks.

Example calculation: Let's assume an input clock (pc->clk_rate) of
100000 Hz and a request with period_ns = 230399744 and
duty_ns = 128249857. To translate that into register settings the
DUTY_SHIFT values will be round down with both approaches and result in
an actual duty_cycle of 127658000 ns (Δ = -591857 ns) while 128557000 ns
(Δ = 307143 ns) would also be possible.

Best regards
Uwe

 drivers/pwm/pwm-tegra.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 5cdbe120ba2d..8b5ed7998fdd 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -138,22 +138,21 @@ static inline void tegra_pwm_writel(struct pwm_device *pwm, unsigned int offset,
 }
 
 static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+			    u64 duty_ns, u64 period_ns)
 {
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
-	unsigned long long c = duty_ns;
 	unsigned long rate, required_clk_rate;
 	u32 val = 0;
 	int err;
+	u64 c;
 
 	/*
 	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
-	 * per TEGRA_PWM_DEPTH cycles and make sure to round to the
-	 * nearest integer during division.
+	 * per TEGRA_PWM_DEPTH cycles.
 	 */
-	c *= TEGRA_PWM_DEPTH;
-	c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
+	c = mul_u64_u64_div_u64(duty_ns, TEGRA_PWM_DEPTH, period_ns);
 
+	/* The cast here is fine as c <= TEGRA_PWM_DEPTH */
 	val = (u32)c << TEGRA_PWM_DUTY_SHIFT;
 
 	/*

base-commit: 00e917df050d79ac26ec700717680ad6421d2808
-- 
2.56.0.rc1

