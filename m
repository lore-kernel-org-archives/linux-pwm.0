Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793503622;
	b=hF2ePfOVg7UEHUGHdiniY9M+dN2wfSk73QPsMXRFrP4JTQmHKUaMWl0adp8HgspXkG3e
	 7M2W59vHDqsE3030eLLbHYH+GaNvteQcAkm9hdR0NW+CHSamYXhFfpNb7ufRiDU7MlLzh
	 rzFJFfRSfzgvMw13m4aliQcRwn1uKvuY/+oJSr6f7mNrA2BgOtAR/LtRE9cNoRDcUNH/M
	 0NoX/tWWFxHJq1ABmgHUmxJpYp3kaw88vmkzLIIbD6BlundnIWrevNFlO3jX4y3cmaYcI
	 5isn6G9gLQc+1At7dlx/JGxoBvvWFCMpzW+5Uu6yLSc+U8NBW02jOtm57ifuyUtvO0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793503622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z+poO6efwcGNj69j/DfV8JX7ZC/OFlxZpiE6eh71TzA=;
	b=TdHNOFmspJ7kxKe2j+XsOOceQ9xiL8h0ecclDsUeb3f9TV2U0nYKtOUunMjMf9xYE1s0
	 usCgIQbTgcET62Lkxro07Ah77LfiL3dTCppQeGZWl51Eb1W15Vm1tiqr/n8qkyqXY9Wn/
	 GcIlyu112/pT5PqIyWOkblCXcjkowE4/TGLm6m6OQ0VMv2XqEsptrN3YqSq61K21eklV7
	 UT6QYorED6RfgtfRvukhzKXE5IGfn88CfZZR1gOWMhXmyI7qvR5BX5YKPbV0bh87tTOM5
	 y0kp2hglz9YDqkF5BzHygvJdvW9SttXRc0xtWmo3UWd5Q1ZMaVfslmAT5f9y/cTC0ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EP0qY+sw;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E23606A326
	for <linux-pwm@vger.kernel.org>; Sun,  1 Nov 2026 03:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44E23606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EP0qY+sw
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso11907505ad.0
        for <linux-pwm@vger.kernel.org>; Sat, 31 Oct 2026 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793503622; x=1794108422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z+poO6efwcGNj69j/DfV8JX7ZC/OFlxZpiE6eh71TzA=;
        b=EP0qY+sw7BT9C40L2DjSQr1CG4y31Fg9l/l0swU3caaz+JKEmVDp1NgRJmAT30C2Pi
         /v5HnIXDgXhIAlvaQwGaJWYE+gYaGpHZekD6iy/3GAZL1/98ksvYA3t8K+pfEVvAe0P5
         amlTeHnb1YXgnXgs3ys9OPWeUXDEe7Dy9AeOwH4pv5mkUI4TirWjwph+ne3CvVhZPG36
         inSXD2soCbRG24X2RbCWvTnJ0QTpQ/qXqIkYOr/EXvmHg4X8cUtt095oTNOgGOQS00w/
         QAXcmZkktq4JsboxwR1xwRiWVbA9cRAn4Ca9ZSf0TNnc/j2HAPlk3kMPGEWaaNvOgJr9
         EVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793503622; x=1794108422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z+poO6efwcGNj69j/DfV8JX7ZC/OFlxZpiE6eh71TzA=;
        b=fo6lsKT6HWBvMSJ79xonbSb+UaXJh1YVY7MFGynGf4LLZU2MxPzmHMd914I3SzHKJ2
         +F9ZjemD8VkMAcM6/lXLf++/V3iIuF/wxIW1HNcf5vgkbqvdcxAklWLbGsoDnsvscqFg
         LMLALdy+bnH+QDOtJ3L9GZOofNb5Q8oIFy1Lw1wW3kiObprYoJQNHnnbsM99/ILQMbOn
         YbeAcryK6CZ+xUkj5wYQwhYdXUmAa/HBK2ZaSYTq01iD8OtVVCGPBhpWfiLAH3gTn5AP
         dTaz33Vw1UgI1ZLQLxrtyZWN/m0vjj2ByyviE/BEFohoIDZzAt+s4RT+Ou2xXDyqQ7UU
         FHXA==
X-Forwarded-Encrypted: i=1; AKwUvBz8kcpIupy2maN2QaGrA+7OQDNXwByfKx+mHppAvWMqdOZVgiljlqSL++63gLW5bgr0P2rfjCZrJ7Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/k+oPlpmq71x91DfhjNjFziJZSbsS9vHF889sKByikX352/UrV
	OG+Npunz2qMVxBsQpAjwXlzPhfpP2mSSCNE/LK2rYzGBHX/Vtd+CjBGJ
X-Gm-Gg: AYBFou121k3631iRA2hc+RQAGcy7K9pCMoHa8lzqCCvARsSJR/lxOafaTfndhGwUKha
	lv9YQ930K4tAUEjpZiLF3L7bjb2TyCIzuO2lp5ibSR/ARd2CWjhF+248q57z071YeznnGBV5yHt
	GRqvNJA1JmdCog8wBjYTBWZ7IsAoVnB7rUIsOtkGoX/rDLEGx+jXKCdHwmTq9LpkY48f58rUHm2
	1CjE5h/yuEjFFOiJYvXM5Gq2++k/yzQXPLpdUCxt9KLY8GYV5f9XCk25hi0bjT4c+G9Jc50+dqN
	ActybAya/VYysWF8ctZYuAdOelBOPtU1nmeZom7HX/s6UXMnWHqvKQrGBDGBpWFy2Ha+o7u9a8T
	gVIxR2ERjAivWjS6ukxuMWLJgC7MhTU+y58FkEZLqbLfOX6fCP3wERsZPj43QkB7LN5CFkEj7I6
	viAcUbKNM/1GRtfRqV3CmX+G0f1fRmoPqBzrO5eedB6BBJeQftvuCL31KQPdKvJl8IpNsv6wiJx
	VDJAxzmHjwU7CtnY4zd/4zp4nbv21OJxjMcx3J+G7Ca/JKDmjM5078pssNoV7jyUt7YFCDhPbN0
	7MXoiUEHcRSmB/ppvI12+zUQpms9v5wRvg7i7TcZ3NH0hXg19ZhDLeNimaRV2Vm4XxRKHahIi0K
	BngJIdkJDeH1/YhpgzCtncd7ONH1LRkd0Hd4F17ibidxb/tpZkxM+1N3eMfJy7bSmE8+dVaRxUV
	F/35Y=
X-Received: by 2002:a17:903:11cf:b0:2e4:4eed:5cc5 with SMTP id d9443c01a7336-2eb364c02f9mr64614275ad.38.1793503621559;
        Sat, 31 Oct 2026 20:27:01 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392a5f48sm17193685ad.64.2026.10.31.20.26.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 20:27:00 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] pwm: gpio: unregister the chip on driver unbind
Date: Sun,  1 Nov 2026 13:26:46 +1000
Message-ID: <20261101032646.11397-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pwm_gpio_probe() registers the chip with pwmchip_add(), but the driver
has neither a remove callback nor a devm action calling
pwmchip_remove(). On unbind the devres callbacks release the GPIO
descriptor, cancel the hrtimer and drop the reference taken by
devm_pwmchip_alloc(), while the chip stays registered: it is still in
the pwm_chips idr, its sysfs attributes and character device are still
there and chip->operational is still true.

The chip can therefore still be reached through sysfs export, the
character device, debugfs and pwm_get() from a consumer. Those paths
call into chip->ops, which point into unloaded module text once the
module is gone, and pwm_gpio_apply() re-arms the cancelled hrtimer and
drives a GPIO descriptor the driver no longer owns.

Use devm_pwmchip_add() so that the chip is removed before the hrtimer
is cancelled and the GPIO is released.

Fixes: 7f61257cd6e1 ("pwm: Add GPIO PWM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/pwm/pwm-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
index 5644d78..cffdbcd 100644
--- a/drivers/pwm/pwm-gpio.c
+++ b/drivers/pwm/pwm-gpio.c
@@ -212,7 +212,7 @@ static int pwm_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = pwmchip_add(chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "could not add pwmchip\n");
 
-- 
2.43.0

