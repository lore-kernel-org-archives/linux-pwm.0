Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC53F6610
	for <linux-pwm@vger.kernel.org>; Mon, 14 Sep 2026 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425322; cv=none; b=UeQUFEW3VhcRe5NLcQlq+JCvekhUQVYub7aYvTghmzsTO1cRac41+6UFxwdd667eJe7afpfDFjqFqHH/NqpW/6IsOnyoa4gEUjeI6GOoE53QwKGbxxGg4J8AgmBe7W7a0aaP61N75iK2cCy+WF5lCsIA8n55V8py0gPd5L4HSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425322; c=relaxed/simple;
	bh=lPgEvreu0zPGM3ILg+o19Q8j1zzZ/FcyTs9QLV6/qZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0TOpKxqGurGl7z6l9Ivlv911vwdqE/F6jRuO8T6FQBKZeYSBQpYKO9lhlk316nCns5pj8ddktcZwUnPtjxBGZDfrUKvaae05Q1qnF/1dLv/cWhOmcgPqZQB62qVMdenPhnkqrhB3WZ2VUMIrwihd9/Dgyy0bDTD4mpWE8/KGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=paZw3DSg; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paZw3DSg"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-912333a94fdso6469126d6.3
        for <linux-pwm@vger.kernel.org>; Mon, 14 Sep 2026 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789425320; x=1790030120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EFwlG4gnZYkH84K5Z6UxkyDABvsd4Q+eyxbwPqCRkks=;
        b=paZw3DSg+Y5euFpKVEViYKsZXWDoCmlgn2K0ZJAJnu6v49+jQluFLkJ1s2CwNolcZE
         yChKbfz7bKSmycC9oJam01Ev7bYozTHofpfdIkLy1MUSkNGgTPPxqk/yoeh1V6yze2EH
         WF8IRT/voz9R9RUe+AI486jyY2gV7wh9Rv4HHcUe91VCX5zodPWjDz3jm1eCoZfTKVEp
         VK+TSog4xvSwST3mJBXTBXvrkBFXzK8oxo4L1VC6oxkE5lUVGjtzZ5bprWBi9a3WshpI
         L6wkYge7BXTY2lYkyRzVUTqQkoPtoFmWXk1qh6BGslzPm7897fg5HB4w2zx14Tf95upg
         DMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789425320; x=1790030120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EFwlG4gnZYkH84K5Z6UxkyDABvsd4Q+eyxbwPqCRkks=;
        b=WqozU00b9cU+6QTjl23+Z3bKgfwAAv0YVRtYrJufQb9k0YtNUmsRpwzLJXeXRzHHhJ
         u5smvWLrPFXEtjFZTQ0z21G6bAEi+coTrp1kB4P0Winii15gafVCYqXNtRefSOpucQj4
         azmGso0c6B3oRWPGs3zeuX78nLGjhnEIXZPluFluGi3V0QLYYX2YurjwK7zBjWqXPpOQ
         Cw2gjjlSkf3+FZOCDMzGt4eCpwymRaOY+PJTyawEV79k95nRswQ5whZHYm2YLTlGWznv
         2aBt7pMz2Whf8iVHmzJMZbIcq5V3oczwqAPcg0oCQWkGnECfAOH69bpxxaDfkj2Rvtm5
         CyNw==
X-Forwarded-Encrypted: i=1; AKwUvBzH9WtihX03pXRJmomeaZPLmy/R9YNjfRExX/vTJQ7BG1T+G7BIq/zqScNYruItb6LZKm3Ax339Pqs=@vger.kernel.org
X-Gm-Message-State: AFuF++mWuFoBUSA9KicVGLr265n6YSckecuaBy6ku83hnpaP2EFnvrIa
	sy9zlP8Gtf29tWj+gU4xHtrFwNeQ+MrLEsCwNpkS57CQ8Zyh5PRlpM8=
X-Gm-Gg: AYBFou3EqH9U0MYIlEn3avOanpUOWmAN1rdskewLZL8+loQLaY0k2cvBi2hnUXPm3vY
	rlGZdaUyyn4z1wNs6WMHLTDbhs0EYCi0i5FHxae1lBvQliwB4bdyb15janNIP1xnOTrkH/2d5Kt
	I8FyOqa6GKlCcAp3uL2iWBSv6ECDC64If3Lep22Rqh28jc/H4yUahKiqxaTrZg/RxwbL6u0U67l
	VfKELl5RJoI++qt2VcvkkD+o7NJhmWdR+ya6U5wWxYY0qc7aKHdQiVj2OFgFNahHuTYvQ9E2ArQ
	1Uk2RFn+zpNC4+Wt6jzx3xOnW2J+KCh2irPVEvYlC65OibOAlePIbIBBstsjGM3qrdA8CuGr+0b
	a7jRfy46mHT1yfvzQoGOMuQSvQ44IEwjK1H6X3KxScyR8sboMMekCJ2cc+3smugEfK6H6BtMq77
	oZw7KvqDG+QuO6SYz9cjUTzTWsbg9Bj3aRyFnNWkEdh7R31mZu5DCd6KinkfxI7WdK/4CQSI/Dl
	Nhy0yrmgPVlz+UhFYEsw5U8vuHcllXBUKbgLmLSlN1Wi6ugzFI+W/9A6WxbAt3amdp2ScYi4FEr
	HJWjdaa45xxHGCaMmrf2n+1DxfER59Xds40+xzvC6L9TYOJQzhQivaeBL5mZ5hCV+kUzWg==
X-Received: by 2002:a05:6214:320d:b0:912:289:647f with SMTP id 6a1803df08f44-9122e6906d0mr85830766d6.33.1789425319817;
        Mon, 14 Sep 2026 15:35:19 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f477d42sm106004416d6.18.2026.09.14.15.35.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 15:35:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] pwm: tegra: Use managed runtime PM cleanup
Date: Mon, 14 Sep 2026 18:35:12 -0400
Message-ID: <20260914223512.31049-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Runtime PM remains enabled if the initial resume fails or force-suspend
fails during probe unwind or removal.

Use devm_pm_runtime_enable() and replace the force-suspend calls with a
managed hardware cleanup action. Order cleanup so runtime PM is disabled
before turning off the clock and selecting sleep pinctrl for an active
device. Preserve the probe error and usage-count handling.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 3da9b0feaa16 ("pwm: tegra: Add runtime PM and OPP support")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Use devm_pm_runtime_enable(), as suggested by Mikko Perttunen.
- Replace probe/remove force-suspend calls with ordered managed cleanup.
- Retain clock cleanup for devices that remain active at teardown.

 drivers/pwm/pwm-tegra.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 5cdbe12..b68b690 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -314,6 +314,19 @@ static const struct pwm_ops tegra_pwm_ops = {
 	.apply = tegra_pwm_apply,
 };
 
+static void tegra_pwm_cleanup(void *data)
+{
+	struct device *dev = data;
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
+
+	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_status_suspended(dev))
+		return;
+
+	clk_disable_unprepare(pc->clk);
+	pinctrl_pm_select_sleep_state(dev);
+}
+
 static int tegra_pwm_probe(struct platform_device *pdev)
 {
 	struct pwm_chip *chip;
@@ -344,7 +357,15 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pm_runtime_enable(&pdev->dev);
+	/* Disable runtime PM before cleaning up the hardware. */
+	ret = devm_add_action_or_reset(&pdev->dev, tegra_pwm_cleanup, &pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret)
 		return ret;
@@ -395,7 +416,6 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	return 0;
 put_pm:
 	pm_runtime_put_sync_suspend(&pdev->dev);
-	pm_runtime_force_suspend(&pdev->dev);
 	return ret;
 }
 
@@ -407,8 +427,6 @@ static void tegra_pwm_remove(struct platform_device *pdev)
 	pwmchip_remove(chip);
 
 	reset_control_assert(pc->rst);
-
-	pm_runtime_force_suspend(&pdev->dev);
 }
 
 static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
