Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0E346E55
	for <linux-pwm@vger.kernel.org>; Fri, 18 Sep 2026 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702234; cv=none; b=I1C7FLVFeKujAYIsm4tGxWosVIQlpVeZ+KX7gJbiKo920DmEgg2XQdzY27kiL9qk6K1LlWEhRfhSU7XbeAL+ZFX99P9Qdj8K7TWNcjCL7prqqg6hasCNIxFQ7g8LTFte8RnnVuuWYhn5ED4pn8jpeQ4aOPR6PWPBxuNGXRZgC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702234; c=relaxed/simple;
	bh=oL7iBYRGTXGLUYEI615o03nOb0m0bTLF3HdlXZTknbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhjze0lDQgMJHShKUxyqyH+jvSTL46XDJXv1iWGokcxuF8uVukrDQB0gN68yGVxCpfe6teS1nObfphdkVsVn6fW9cka0IMAtAcWQd8gEsToF+AUvHepcOvBhxp6GpNfoNv9fRBIbbty/Kt3vorQvaSKAeSuoTdNksFGX0SZYUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mhkmqi3n; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhkmqi3n"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2dd68a16955so13901355ad.0
        for <linux-pwm@vger.kernel.org>; Thu, 17 Sep 2026 20:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789702232; x=1790307032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsTXXf0bosmROP35BjT3pvO2TNvWL1hxMB3vfvtmPCY=;
        b=Mhkmqi3n/qPy4geBhcotXJHzyx2Es70VcFh2hL+VhOw/XMh+f+hDb5mxtWhGN0XO0s
         bQvMZG6gHxAEMcxBe/kjtedQ680T7cMj/xeYppEoWDZLDFdehcsyoIQeoC5qwll8ac+1
         716FO/PcB52SwuwUl3+u48UZIQbLJyPJtkjq3xVzFYH34m7q0YGVoXGQ5jN2w/C+qpq9
         CCAAbmPZos3NCYYd48Qn4AmVS8t5vjT/l1IEoNO1f8lRsd655QyoM0fJkV4soOlxeQkK
         YF01lYpwfVQA6BZI9oXZOnyqoDphQrBLAWFsMNQXe8Ek0T0Tot1ykXSdZzCl9xoS8yxb
         CkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789702232; x=1790307032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsTXXf0bosmROP35BjT3pvO2TNvWL1hxMB3vfvtmPCY=;
        b=Ii/9813IoO6fu38yGDubKiaw+DgeHXn86mcA0aCtNeTVts4Pi2Fopf8P4jva+mzLDa
         6Ihkn10zrZgtTq6DMCXsFFhRN64m+gtXQFs7FI79Jmq5uk1CUnfF7OxNkdhkAknLIHEZ
         N7pW9xlw6Tg1vaM3g3mpvp4k/XKuzqDEZHkD0ftlrykGenqU87d2a6tWHacIuWtGnmFM
         JDhFUAR4yqtM2Ghm7Jhjb5EgjZuQ5gNJK3BYE1wNAfSYQdmq3cL8vITLJNSwxjgWyBiu
         F7ciadK532wC3r/QgBl7n6w4f7MK3bxoYJINWfpeiKfs1nlUAGxsPlKI4F1stSBAFMLR
         bfIw==
X-Forwarded-Encrypted: i=1; AKwUvBzPR/WYfnUL11CX1B4nfY+UJM1XPzFDdzL6TqUZuNNmQQMibpoPELJctgPc7LBb5VyajokeYoaLXRI=@vger.kernel.org
X-Gm-Message-State: AFuF++nSDk/Aaf0kmAmUQoncphXQADwf/AxPcKuFbdAkWQBNc49RIA/d
	ZFqcRyH87iUF61HqbJd1yuTm/LkgnoLzfN//OYZfIOoA+eF3vJD7YNUB
X-Gm-Gg: AYBFou3HDN5IHCI6xM4tCN64cM3b6kM8rkFuQWe6aNysytYJvQYzfqZeqzlF3yaYpTW
	O+ZyHi96Xm7XvPbnVjgtsve9QToJdiqHNiJEq9Ug+Sy8yLOkN/y8i7VfJ6oJJ9vdjz1pPXXKUCJ
	aFSc90/zSFRhjA9Si9WJGPFxgtYALdH9EWSHPKOzhXIx43J0azLGhfgiJEE+GZDvYKoNt7As8Mn
	EXNQ06dBB0wgfHQWOPV5kzTKvc+5fXX94iN2hVDKNjr6g6N8YD31FakMxn55vX1KnL8QeiDotWB
	nF1LIfcY2GRbcl6ZkQmCDS/oIWWOzTMvwfEvavgquIX2sDj0Epo8alwiVbK7mes9ZH9dyZuYiYj
	5I0jFEgq86OV8B+Thu5L1Yp/CC8Hjn47jKjGS/V2hENpGqfjLD/15hjOnXX8zXZyEVRcheHwEeM
	otQFWBfKvd44nVwnuy7y0YTcbmodFn6whwVJHaIW2TTtlQfYlTqagGtA==
X-Received: by 2002:a17:90b:4acc:b0:39e:5ba1:ccee with SMTP id 98e67ed59e1d1-39e5ba1d12amr457366a91.24.1789702231551;
        Thu, 17 Sep 2026 20:30:31 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2874bb0csm613271eec.16.2026.09.17.20.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:30:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ed Blake <ed.blake@sondrel.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] pwm: img: stop using autosuspend on remove
Date: Fri, 18 Sep 2026 11:30:17 +0800
Message-ID: <20260918033017.3441183-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

img_pwm_probe() enables runtime PM autosuspend with
pm_runtime_use_autosuspend(). The probe failure path disables
autosuspend again, but the remove path only disables runtime PM.

As a result, the runtime PM autosuspend setting is left enabled after
the driver is unbound.

Call pm_runtime_dont_use_autosuspend() from img_pwm_remove() to undo
the setting established during probe, matching the probe error path
and the runtime PM API requirements.

This issue was found by manual code inspection.

Fixes: e690ae526216 ("pwm: img: Add runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/pwm/pwm-img.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 91e0b19f0c08..c0747f5e0020 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -339,6 +339,7 @@ static void img_pwm_remove(struct platform_device *pdev)
 	struct pwm_chip *chip = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		img_pwm_runtime_suspend(&pdev->dev);
 
-- 
2.43.0

