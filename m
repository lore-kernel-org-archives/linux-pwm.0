Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7D3845A7;
	Fri, 28 Aug 2026 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908821; cv=none; b=cptWSmkT9TLX5aPuePsR9gMmqsVthw1188324EaBQirLdJKZT1WtZqD4jyrHPp6o9vAJeEqo8s1bEodowMJT9GvKKGQceVh31f0y8qU4Pc/JFksK96jlgNc5ircOikfrzLkQ91euAMZdR7JjtnjEQs0creWM5L+gF2teDkZ9pbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908821; c=relaxed/simple;
	bh=sQNqPK047NxT+SCQ2xLoY1f0jB0/i52Ovv3ypMjQEuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/htvx4uxWov4vo1jOxGFIE++Pr5uSZE9qzoCqCOuijGzWIicJYQmSV9gqhAPL9ViMh1Y4PYYjs9ZGfFV0kRubk8hTWRCQ8KtsysUx/ITzTNDSU4DhO6T7tRagTtbJrF2/3xTCwIOcjTTn0T1uv3snOGj51F18U9hlCsZMKlpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowACnc0HPUpFqLk11Bg--.64833S2;
	Fri, 28 Aug 2026 17:20:16 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: fsl-ftm: Unwind resume failures
Date: Fri, 28 Aug 2026 17:20:14 +0800
Message-ID: <20260828092014.9211-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnc0HPUpFqLk11Bg--.64833S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy8KrWkKFW5tryDGw4DArb_yoW5GFy7pr
	WfKF1FvrWkXrZ2gan3trs5Jr1rtr4xta43Gay3Kas5uwn0yrsF9a1rGF92vFs0yr18AFy3
	AFs8tFyDCr1jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb4v3UUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

fsl_pwm_resume() ignores all clock-enable and register-cache replay
failures.  A failure can leave a prefix of requested PWM channels
holding clocks while runtime PM reports the chip resumed.

Check each acquisition and regcache_sync(), then unwind completed
channels in the reverse of the suspend order.  Restore cache-only and
dirty state when the register replay fails.

The issue was identified via static analysis and manually reviewed.

Fixes: 97d0b42e39a7 ("pwm: ftm: Add Power Management support for FTM PWM")

Assisted-by: LLM
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/pwm/pwm-fsl-ftm.c | 44 +++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 35406b2e1925..7a61ccb75963 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -501,7 +501,7 @@ static int fsl_pwm_resume(struct device *dev)
 {
 	struct pwm_chip *chip = dev_get_drvdata(dev);
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
-	int i;
+	int i, ret;
 
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
@@ -509,20 +509,52 @@ static int fsl_pwm_resume(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
-		clk_prepare_enable(fpc->ipg_clk);
+		ret = clk_prepare_enable(fpc->ipg_clk);
+		if (ret)
+			goto unwind;
 
 		if (!pwm_is_enabled(pwm))
 			continue;
 
-		clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
-		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
+		ret = clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
+		if (ret) {
+			clk_disable_unprepare(fpc->ipg_clk);
+			goto unwind;
+		}
+
+		ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
+		if (ret) {
+			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
+			clk_disable_unprepare(fpc->ipg_clk);
+			goto unwind;
+		}
 	}
 
 	/* restore all registers from cache */
 	regcache_cache_only(fpc->regmap, false);
-	regcache_sync(fpc->regmap);
+	ret = regcache_sync(fpc->regmap);
+	if (!ret)
+		return 0;
 
-	return 0;
+	regcache_cache_only(fpc->regmap, true);
+	regcache_mark_dirty(fpc->regmap);
+
+unwind:
+	while (i--) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
+			continue;
+
+		if (pwm_is_enabled(pwm)) {
+			clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
+			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
+		}
+
+		clk_disable_unprepare(fpc->ipg_clk);
+	}
+
+	return ret;
 }
 #endif
 
-- 
2.43.0

