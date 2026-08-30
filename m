Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B23B14A2;
	Sun, 30 Aug 2026 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788094734; cv=none; b=Z/JXGcyJJabCMy3jgkRc56fxykPd9jPJ98bLrnY+A0fvvYcmNaT/Ken2jNMbKn84JgcwG6hNiWOCrk3NYc1eWcjo4hptlVdGklJ+DA2VzqRlfg9kvZ7yl3RXvsk4+QIbEvycuX8X897qGA8+6vSaf1eTGQmcyEmE6zYOYrn3syc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788094734; c=relaxed/simple;
	bh=ULLsCIvRURUfWtY7aMZOQIJq838+3+EZQOBCAb4TPwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKHvLdbUd4r7CGweA+cyWclqZsjqt2EG2YrRHPHCq4lV5wmThl4TsfVHbOPaIRBkwaMY+/5DzxdprYPFT9PY/yWFZ1BvRViBDfEqQGV5ImJIc+4XGo7V9hdpsVUFqvCQa2NwJUDrES6xqZ23Lb1iSmMl22HTD51IxSsLChFDVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowADn6jgFKZRqOLuaBg--.22542S2;
	Sun, 30 Aug 2026 20:58:45 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: tegra: fail probe on reset deassert errors
Date: Sun, 30 Aug 2026 20:58:43 +0800
Message-ID: <20260830125843.99132-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADn6jgFKZRqOLuaBg--.22542S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurW5Gw47XFyxAryDur4xCrg_yoWDWFc_u3
	4xXFsrWws8CryvkFnxt3yfZFWayF98uF10grZrtw13Kas0qF15GryvyrW5u34xWan8uFy7
	GFW2vrWfA3sxAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmjgxUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

tegra_pwm_probe() registers the PWM provider after deasserting the reset
control without checking whether the reset controller accepted the request.

Propagate the failure through the existing runtime-PM cleanup path instead
of publishing a PWM controller whose hardware may still be reset.

Fixes: 5dfbd2bd5439 ("pwm: tegra: Add support for reset control")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/pwm/pwm-tegra.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 5cdbe120ba2d8..d9fa16a7b31f4 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -379,7 +379,9 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 		goto put_pm;
 	}
 
-	reset_control_deassert(pc->rst);
+	ret = reset_control_deassert(pc->rst);
+	if (ret)
+		goto put_pm;
 
 	chip->ops = &tegra_pwm_ops;

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.50.1

