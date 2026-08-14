Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56413126BE1
	for <linux-pwm@vger.kernel.org>; Fri, 14 Aug 2026 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714911; cv=none; b=YHmcztsLbK+dijB8Ykw43NFpzltF0jJ67DNogOWy3mgw5iutMNepai6gAWyAw/8tu9OMW9IlusoSSHHjKOOJcpznnFqf96UT4FRIjb2JXXzN0l6Vj8EQiAWhI0b7fOpH5Ig0EFuD3wqZzQ0ZOuu+7h9eEQk/BiWGu7R/jwxwCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714911; c=relaxed/simple;
	bh=ldlWUnsNr/PvaotFOp4JUhkVsZCKFfTwF93dtBGoqEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdxMEHzUoxBQ3BkeEEUKuP39pESmlae6Kwua3vZ+lntoGBJtExN+WKuOZUDyOShVrvymO7N1/HMsFnHHcR0CSo3qmzigjz8oXeCov+PZqYNGUvb/AagVPjtu/eAn2+3X5fOcTDDvAzNv5SWzRhRGXhypY8KBMAUngJ2VHaitsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYoTKv8A; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYoTKv8A"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e347638adso1230741a91.0
        for <linux-pwm@vger.kernel.org>; Fri, 14 Aug 2026 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714910; x=1787319710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qa0TNm7KCRYsvVFqPTjKp5n/g9/IBmYpvLglN9TOkEA=;
        b=ZYoTKv8AAleClkra9RTz8BwI654l+HEFd/wmj6LeweLKtnldfSz/fvVyxIaGft0X/F
         i0pbhsfoBNZBPlJ8n88ez0aZKtqlSgwS0saXdE0OevhFOvblDlaZA79d9IHmR6kxZ/dL
         TFV3ynmUa4jvn3JOJr6hG9uDX/4iBsXrIVp7rUKqcSxtRNgiUif/yQbYas1XOmHat6AZ
         P724eovXMo9Dm/j/m7G9uAbGHILzRTbYuuy4xMt+kFV7wIbQnzweFOafS/m/fa2KIFUY
         ytmvzm5OIEv98Efn0ntspRkumDD9gM8CPIpz/gdctOPkITRm56XkdpZsbCgG0n37mqAb
         MhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714910; x=1787319710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qa0TNm7KCRYsvVFqPTjKp5n/g9/IBmYpvLglN9TOkEA=;
        b=M4LKGjsxq7daE3ZNa1xSS7i37NNrJRLoWWBcZhiOZjvFmujK9QEIG0hTUeDiB7imCI
         MxIKOF+XtRLzjnsOxDhbhgbO68L7U939bf6sg0tN2TIgtnqF6KRNJpwiIQgZL8RY3fb8
         6fabhllUFsUjozLkjLVhANZgqmyt/DYrHeKXRu2N2a14xs3Gsu+wXMqzGSJbgMvkoqiO
         JEr8avX6ZjcLGqRTT36fIGjKhyUIh033i9uV8EHiPGMUQdJFzsWZwnKRyAv56Te245VZ
         bydxDsfKxpzier0Gc+p+aj059sn+SXLHOyy6Vt7jbHTQfIs3PiuNA7sCfPw0lpdbpyUQ
         wBsw==
X-Gm-Message-State: AOJu0YwFMuZTnQ6g9+GsGIuYf5cp1iFIf2s7U7nd00UYUNLz8WFlWaSD
	qwcvvbcSNoxdsufvCrBZWygqBWkjEkIvhCT02KJ2oOA+8V8mcGYrNmY0
X-Gm-Gg: AR+sD13YeEfKAmV5VSa203GN4r8HFO7bhT9Fego42ZTdBV4aRXXvs6lQ8pUP0casp5n
	qTC8v2lyU9iOus/W7NEwdjpk10LD+krPXiXhH174MDMgpsCJm/oAtiHkxR51/s4zVpKb8QeryCG
	53+4bgXdw77R8hp2JknswcqserZGM4jZV+DqEPNOJOFIiTEazBH/3XcJ2GjIE8tDxv5vRlCG/GQ
	A4tSjYI3loONbzivnmAZl/cXA6DfKw9noowLtiN6cfWvuauPxPSJl7wWVQF49/LSglAWhb1jY5P
	fERrL+DU0YYXuzEmUQerUMjDfGIGvSq25HKbJus9HvY4wbo9hiViO+IWNKm+zjGyFdTSE6D+LLd
	UC6RYZVEXwigxTZctExhaBUeDOjeljc4+V8ag2hwwXSydxRrAUSwsOazVq8w044OACXY6vpFoPC
	8O2qPVT51LmUa/JU9P5QlHbyUzTPzL0kIRXG4x3k6gWRsjdzyR6U/c8V9U76NdMX6QpHIUJrUq8
	4EXhwDR
X-Received: by 2002:a17:90b:4a4b:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-3933b6ea12fmr6157548a91.1.1786714909519;
        Fri, 14 Aug 2026 06:41:49 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebb888e3sm2750835a91.11.2026.08.14.06.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:41:49 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Axel Lin <axel.lin@ingics.com>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] pwm: renesas-tpu: Fix runtime PM reference leak
Date: Fri, 14 Aug 2026 21:41:43 +0800
Message-ID: <20260814134143.1388120-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpu_pwm_timer_start() used pm_runtime_get_sync() without checking its
return value before touching the TPU clock.  A failed runtime resume was
therefore ignored, and the callback continued into register access.

Use pm_runtime_resume_and_get() and propagate a failed resume.  Keep the
matching put when clock preparation fails after a successful resume.

tpu_pwm_disable() also needs to propagate a failed start so that the PWM
apply callback does not access registers while runtime PM is inactive.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: 99b82abb0a35 ("pwm: Add Renesas TPU PWM driver")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/pwm/pwm-renesas-tpu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 2196080b41770..c0bbe275275c8 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -149,10 +149,14 @@ static int tpu_pwm_timer_start(struct tpu_pwm_device *tpd)
 
 	if (!tpd->timer_on) {
 		/* Wake up device and enable clock. */
-		pm_runtime_get_sync(&tpd->tpu->pdev->dev);
+		ret = pm_runtime_resume_and_get(&tpd->tpu->pdev->dev);
+		if (ret < 0)
+			return ret;
+
 		ret = clk_prepare_enable(tpd->tpu->clk);
 		if (ret) {
 			dev_err(&tpd->tpu->pdev->dev, "cannot enable clock\n");
+			pm_runtime_put(&tpd->tpu->pdev->dev);
 			return ret;
 		}
 		tpd->timer_on = true;
@@ -382,15 +386,21 @@ static int tpu_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	return 0;
 }
 
-static void tpu_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int tpu_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct tpu_device *tpu = to_tpu_device(chip);
 	struct tpu_pwm_device *tpd = &tpu->tpd[pwm->hwpwm];
+	int ret;
 
 	/* The timer must be running to modify the pin output configuration. */
-	tpu_pwm_timer_start(tpd);
+	ret = tpu_pwm_timer_start(tpd);
+	if (ret < 0)
+		return ret;
+
 	tpu_pwm_set_pin(tpd, TPU_PIN_INACTIVE);
 	tpu_pwm_timer_stop(tpd);
+
+	return 0;
 }
 
 static int tpu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -401,7 +411,10 @@ static int tpu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (state->polarity != pwm->state.polarity) {
 		if (enabled) {
-			tpu_pwm_disable(chip, pwm);
+			err = tpu_pwm_disable(chip, pwm);
+			if (err)
+				return err;
+
 			enabled = false;
 		}
 
@@ -412,7 +425,7 @@ static int tpu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (!state->enabled) {
 		if (enabled)
-			tpu_pwm_disable(chip, pwm);
+			return tpu_pwm_disable(chip, pwm);
 
 		return 0;
 	}
-- 
2.51.0

