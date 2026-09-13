Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13423002C8
	for <linux-pwm@vger.kernel.org>; Sun, 13 Sep 2026 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789272377; cv=none; b=RF8ZCZAHTYjw0rOVeiTailQq77kuq17ObEbwZUM8y2sw4HZj3sFmp4pkDlhyQQsrhhRiv+UPon/ze4+1y3nHMRfoofZYpsWHCiP3daGzr2ror6SAioOIo7PTIirb+ccOiZ0cOrSrzBen6v3uxjUFYyVO0r70ch0rqsQPBCNG4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789272377; c=relaxed/simple;
	bh=DXmCkQye1kDbUZPYw5KB8SL2D6gVtjoWUrghFucJ2ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+ymXOL4IyKj5EtiaDtu3k58z2ydZYZU81Wsju/x8yauyziu36U4PQ6u0K3SalK2SS3+d2mLDkomT1Bk+0D7F1De0K1NdxPh6yfgO5GsiA9/BRiFIRaKoINpj+YMOz/6HkYjCkbU07modsQ14Dh/F2clBv+STlA5e5d6rjmfmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BabGGvSG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BabGGvSG"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5303932c4f3so11927471cf.2
        for <linux-pwm@vger.kernel.org>; Sat, 12 Sep 2026 21:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789272375; x=1789877175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p6qUThvMWk3OXMzannpQNNV81o00j3uVEX2Exkp10Qw=;
        b=BabGGvSGwrZ5fqVzq/RIILGv1XepcOr/sSlw09jdxUMjBxmyZbb1RtMrH1Jh0P5FKd
         rDg0G3IW2DFOeoM/1LtrCa6HA9Wfs1Q+wXJ0FFlNCsdrdSGNCOYnmu+0sav8gE2+fhP/
         bMXxn3QnHhV2fnV2XRk3bgQA9GGSkueZ7WPn99BQtwGFNxxgGZYp6lVJVOaFWGly4EOA
         F8TPMgYp3O68OZEC+AYmcolFPdFSB/alsrBXJFBri9TomcWRyiznRDwWN06YGghfDCDq
         MW6eLTFIkLoVDRFQXupJwgWxJSTd1Za4tKOSzbsXSvgI2ufthiZWVG26uW+9MVmjwMhL
         G5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789272375; x=1789877175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p6qUThvMWk3OXMzannpQNNV81o00j3uVEX2Exkp10Qw=;
        b=JSufA0iFMn1VCsGHhXHg0bPV44g8u+Sh4QVrSp27x30kwdpYZ+jvV+VZiUcip6h5Bc
         ujctExDn+hRob5SzfqP7JED4+s4oBYY+beOKBlZ3+fSRv3kTlzPzctZtaC6UBjN+CbxJ
         m8PxnewyNWcHpCuc1xWx0tq6HsSgZLFpdkE7VL1bRB1qQzJWUr4AxONnJsC0XQfN3twP
         XRkTFsc6EEKiShPq4tNRBy+m7nI0510fjY8PAeWGKNNiJ5ZI4CaNbX09LnLwF76HQWLu
         pH9BA8v4WnimRoY44+CyF4llnsLuvlJu6dajEbWmGkkIrodh+5RwHOyqJC0L6rL2/g6U
         BAJg==
X-Forwarded-Encrypted: i=1; AKwUvBxP6QqhO0Cog0VCTeTTFvRdtkicQxmfSNhBl1H9jX3xZbJets54xRgJ3sGXD28mxKWp8pz4CWx8Kvo=@vger.kernel.org
X-Gm-Message-State: AFuF++lvJnU4NzLhIQk3fNF8EQylwpIw9Ojzq5UweM/8/yqYI+h3BFI+
	eWO6K2zhGlA3935E0+wjxV6ukT+GdNUnY4/75dukl++fVAEt6SWmQdw=
X-Gm-Gg: AYBFou35bPi/9fYZ0fOmoGuDusbyK0XhP1Tj/wlJCTNe5CQCr3OTCf4Y/vs060ME6Bj
	vECpZjOCgVg2IzL9F00VJqn2uArPmvmiMm31NLwBY4E9sQIIo8NqHY/IGZ3wzA0UFGcPIZx9+rL
	lubd2EA+N9J4M3K7AOKg630YQ/0eB6Xw0pBGxIQGuo7ilXQ33JfcrKQfn4LpQLf5HySv4LNkBES
	uWYBVAGV5U9rogOKX79hj6GWKFv0vU9d/03fBNcJIfxw++XKmm3ZMg+7IV55XkmN1WKuN3aoVD0
	VSK/jt45uMtxqjpTXsmAH0/pNMcHAKFg2BHe5AbLk3MYTu02hN0IQ/1dZlBAk+MC8DXZZ7jESF/
	NLq+Ew7ufyrGioyse/ZMqpdfywitFQDz4/DJs/f1epgD8GuJP5dvYr6K8M298xTO5NTSHpIHKjw
	1fMtPyqa0aSSI5ktGA5Mb5k19XXdQ9YHVC8ADwtI+cyomDZjkrng+72MqKrz2nyjm69Y3+tpTJv
	dSI36mHFSuV4zNg11kUxtW53QhQpxjXTK1tuhWiY/SroYfzNDPGi4fOGSVQ348s2iY0/5gntgcj
	4JjGUwtBl+NFqvREZOAuuXg2jbMCXdbpUQ==
X-Received: by 2002:a05:622a:386:b0:52d:ca81:e5b2 with SMTP id d75a77b69052e-530c84d44dfmr167443301cf.5.1789272374653;
        Sat, 12 Sep 2026 21:06:14 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca50c8f1sm61459631cf.27.2026.09.12.21.06.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 21:06:13 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Dmitry Osipenko <digetx@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] pwm: tegra: Disable runtime PM on cleanup errors
Date: Sun, 13 Sep 2026 00:06:06 -0400
Message-ID: <20260913040606.23272-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tegra_pwm_probe() enables runtime PM before requesting the initial resume.
If pm_runtime_resume_and_get() fails, probe returns with runtime PM still
enabled as the managed driver resources are released.

The later probe unwind and remove paths use pm_runtime_force_suspend(),
which disables runtime PM on success but enables it again if the suspend
callback fails. Ignoring that error can therefore also leave runtime PM
enabled during resource cleanup.

Disable runtime PM on the initial resume failure and when force-suspend
fails. Do not disable it a second time after successful force-suspend, and
preserve the original probe error. The failed resume_and_get call has
already balanced its usage count, so it needs no additional put.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 3da9b0feaa16 ("pwm: tegra: Add runtime PM and OPP support")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/pwm/pwm-tegra.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 5cdbe120b..55287afcb 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -346,8 +346,10 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_disable(&pdev->dev);
 		return ret;
+	}
 
 	/* Set maximum frequency of the IP */
 	ret = dev_pm_opp_set_rate(&pdev->dev, ULONG_MAX);
@@ -395,7 +397,8 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	return 0;
 put_pm:
 	pm_runtime_put_sync_suspend(&pdev->dev);
-	pm_runtime_force_suspend(&pdev->dev);
+	if (pm_runtime_force_suspend(&pdev->dev))
+		pm_runtime_disable(&pdev->dev);
 	return ret;
 }
 
@@ -408,7 +411,8 @@ static void tegra_pwm_remove(struct platform_device *pdev)
 
 	reset_control_assert(pc->rst);
 
-	pm_runtime_force_suspend(&pdev->dev);
+	if (pm_runtime_force_suspend(&pdev->dev))
+		pm_runtime_disable(&pdev->dev);
 }
 
 static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
