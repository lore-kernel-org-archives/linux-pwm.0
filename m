Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4B2BE655
	for <linux-pwm@vger.kernel.org>; Tue,  8 Sep 2026 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886436; cv=none; b=O5rvDZ7+LzQ1lgQ2/pyn/dg3vNUqdSHJNbeidf8BfBgo8FspOnvwf6O6kh3z+e9bU1usT3mJGCZPICcN0vCAshjuqKaPpHu1ery+8y6WFL8uqO3YBd+V5JECvzqBI+todEMk45KPBiUThjHVMylSGlm9aLky8KHoRC1ghA0lIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886436; c=relaxed/simple;
	bh=9M7weo/ro39rmyV3qc6k67t2ckADpSAmD5qUSxEkVV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ncmzh/rCjpvfYePOPI7QNP2bWCa8zd17egeIQKkzP8U0GDniZT67BDxk9naJkyAAf07S3aFI4UppD5kyfX9SWeKxDSHE3885HxnwFtyWYXC+Iqg3babm9sCj6eZETLQ/X/42FEy4KK5w18NVQKJTgmaGJEZiOEZRgTH6JRKGqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Yc3uH1KV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Yc3uH1KV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so58618235e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 08 Sep 2026 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788886432; x=1789491232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJTRRM399Ynn6HcZ5P+mZPLneQozNygw9v2NsKc0JRs=;
        b=Yc3uH1KVPRJPP+ywJXhufNRQ4lyIJHbKWH0QG4WJo53ymYmNHzNQ1qE4YB6e1PK3CF
         mlfO2ucW23d9t4TJr6VuqDoeiEKViFCejQbVQJUNPYuD7sRBBj/Rtrlw3BLOYWBcfDtJ
         shK1vgvASva7pAEVQfGL0x+fKmYId9vr+SCh1DIJX59JiE/+nJZxidV5HtNp/+SuL0uA
         O6SHUIKbtDGi7JIf7/eQElMkMFUQtOufSHXN7s8WWABgFhF8ig2qMnaxVEIH6jm4OU1s
         69Nr1DotvzEpazRKziFrkG1gJCTK555I+Wt3pyX0M7phJEXN4enNEBj0domnbjtVAx00
         meNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886432; x=1789491232;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zJTRRM399Ynn6HcZ5P+mZPLneQozNygw9v2NsKc0JRs=;
        b=W9l5XZY1JdMUZSLvWIat5xyTjTl6KzIvzUKJzxIy+ttUmgSWGrABTrDJnAROf8fohp
         i11waOWxU9TUTTppbxu4lkYTkmvQx69P7y/7XD7JJQc95mH2BnAbfupv8HDJtiqkRcNh
         DjKiO3JSmfqFzSXOwGMteBV1xSr7FHXfc9rGFRIOW4KOMEv45KH5/gHxYXDAqFHXTddv
         kwvRsH1m5m/0C4/0tJBGym8zmk7QV51fBKmLhxzo/AhFyy/xTQ4HkHk4cjMc2g2rT4Wf
         oeMO2S7oqvJNAVryl8zX4B42uEtCB2L/hDGC999XQ+p2VD47b31we4cHnWkDa8YRvyCE
         hoCg==
X-Gm-Message-State: AFuF++mfcOcRhFkbMN0hVPAX95eaHyizLZJxd2S29Kod4fySDFKy7wVK
	HT4jSJZFuGOrswFNxG8Oqc9q7mucbyUZrTqkGCb2S3q9ZjQRxmuvugdCpgJskXyoq3heozaMilP
	WogFH0CY=
X-Gm-Gg: AYBFou1tcWFzc6w5Vaqo8uWwvB48/VTFKnYWXLS+27567ASwQgkeKO+r7DvbaNHLTzN
	QoJTe8Spjb6hBq9zVqPArEWNx355VIaew0b/HwQ3KHh66VzAwT1PYlGYZVXtpCGGX9SCGgI17rp
	RnvemI7WvGe2e4qkE+6jgLP5+VpHwjwYtkIfu+miz7qjnaKFCtZWqV1TGr5tZ94Jl/08IY8a55s
	+bSWlgDvX8MqDC6w/B8jgeB84nAaPahUIPhqYQ7xm29eFp4B69gNEV6jBqcH20jeuOE8ETcEBGk
	jkhwgIG2vpgTqTc+bKTF592bb6lq1vraD8mMxWjPoqguppjA7X8KRWwjkCi6LFZ8Upwi4k07tpr
	UmQv9j+t3goKRY0XkCLfKFU+eNkPVbzPckkg5lJMMVTXpork/8spX6dYbkcg5eouuHpGuoSN26w
	TrUjk7ID4XVPr7jAMAksA6J6eoaP6NjeiqeU5Cp1J39kqQdHhOG0OUAjghyNHu+Rx/JfUjSKuwH
	BksAdls7jRUu3p9NjAmU+TT/eYjInoKLQhD9sAYI6oFr6NZCGs=
X-Received: by 2002:a05:600c:4e11:b0:49c:f2f4:eddd with SMTP id 5b1f17b1804b1-49cf8268795mr324700295e9.16.1788886431855;
        Tue, 08 Sep 2026 09:53:51 -0700 (PDT)
Received: from localhost (p200300f65f19a9042cc2680c1f1bf2f5.dip0.t-ipconnect.de. [2003:f6:5f19:a904:2cc2:680c:1f1b:f2f5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5d476esm536676275e9.1.2026.09.08.09.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:53:51 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev,
	Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH] pwm: lp3943: Mark parent device's platform data as const
Date: Tue,  8 Sep 2026 18:53:41 +0200
Message-ID: <20260908165341.1423611-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=9M7weo/ro39rmyV3qc6k67t2ckADpSAmD5qUSxEkVV0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqoD2VLnWy5R8B5NkHwHSMkn0/k3VEl+14/KK+G 694a8OVKSaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaqA9lQAKCRCPgPtYfRL+ TnkDB/9+HZE7ZVJbhQULxt24ztlbksvRvJrzMvU3jnHIoTQ1Fhlcty9R37MkMJcuhFjDr3crDB1 Tt/UNPv+m2EXBZSS8iNvzuhgCEW45745F/EOetjt6VezzjdDf6West9mFHQ9JzdOViL5rScuzlC Y5RzXDvHHAQF3HJbel4MUyZlDyFNVlHjBuiPt0aS10/S1tsjjfKLn6YNuzs5fToCnan5TEX86aQ vPRPVTtAaSG7WJhc+htDPSactsXYa8TG5dVtXTZCClQdIofqOm2x5bapTIe+npYFrWgg5ZUOm8j Y1EN8uLSNFXOzwuOcj5aCOvSQGEaAqUAy9ShNRY4rKKTrRrh
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Platform data should never get modified by a driver. So add a respective
`const` which makes it explicit that the pwm-lp3943 driver indeed
doesn't modify platform data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I found this patch opportunity while reviewing another patch to this
driver[1]. A possible followup is to mark struct lp3943::pdata also as
const. I made a note to address at a later point (i.e. when the mfd tree
contains this patch).

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/6a9d5187.d63de05c.175391.a17c@mx.google.com

 drivers/pwm/pwm-lp3943.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 10537e74be28..0fde89018d2a 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -21,7 +21,7 @@
 
 struct lp3943_pwm {
 	struct lp3943 *lp3943;
-	struct lp3943_platform_data *pdata;
+	const struct lp3943_platform_data *pdata;
 	struct lp3943_pwm_map pwm_map[LP3943_NUM_PWMS];
 };
 
@@ -33,7 +33,7 @@ static inline struct lp3943_pwm *to_lp3943_pwm(struct pwm_chip *chip)
 static struct lp3943_pwm_map *
 lp3943_pwm_request_map(struct lp3943_pwm *lp3943_pwm, int hwpwm)
 {
-	struct lp3943_platform_data *pdata = lp3943_pwm->pdata;
+	const struct lp3943_platform_data *pdata = lp3943_pwm->pdata;
 	struct lp3943 *lp3943 = lp3943_pwm->lp3943;
 	struct lp3943_pwm_map *pwm_map = &lp3943_pwm->pwm_map[hwpwm];
 	int i, offset;

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0.11.g153666a7d9bb

