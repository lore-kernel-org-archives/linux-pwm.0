Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F433AD88
	for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784321992; cv=none; b=jQvXjEKSrmmubTW6FJKsqLW383T+YzZ/JuFgYkeVfzTKR5d39tcb7YQ1hebo4zS7DKx+6pmBZIEp6SdvNyvDFPWIMO1wLCVd3Iadt6WoYvgYfP1KD+7W4DDPd5DFPVvCKtv1BGXY6DNF1VNXCrRzlYkMDAIjhxW26BexWh6prBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784321992; c=relaxed/simple;
	bh=fnVgoboZr5j9JDLEgQ4eEddGgsOOhWK2bjedrn78jJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiVwxyzGD2T69XHj27JWvqQ1vezU0e2kPDHYS8P0unPEev+03It4MBVon/kWyCFPOhkD8Hc6vFyY2BT5lK+zv0QawyA/2i9JogQo1VSUAQC9D2+pg/FJt/19NPel4XyyMi04H3pCqb8Rv4++mS/IEcLAuxixxb/UaG7C4HfPN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeBM+QjU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeBM+QjU"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81eaf3709b4so59571517b3.0
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784321990; x=1784926790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BtAAUJ2YREqt6a8rhFME7soHPuDVoeI++mttqZ0tqsE=;
        b=FeBM+QjU/wUftkYjyo/uskNxGxckRqu/m7ZWYXcAgKD5ZA8xsjQNAL74/Nkvh0Rb10
         SsxsZQf/EF9CD4F2TxOxz9aM+KCBuw+PDPMUleWLc2dJ8c45k0soCIOkltgR4FsvaWJK
         /4Zpd7J/EcR/iHsdeIDkXZQA5ig3VdLyidAr/Og91NvtwPTFFniARZ2QYYkXw0Hg2fS9
         FKqZ4CMlWGC4srWn+RFpkhKsv/cP8dQzWMk9r3IgaM8w9NgGcK9USoDsv1eRgBe9TP9C
         +M7EbXRgMMV+EhpCy0noP0V72hMKHcC49AnIc8xzr2FRw8LXJ7k+Yp8SsrqP7OMBfzsI
         mIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784321990; x=1784926790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BtAAUJ2YREqt6a8rhFME7soHPuDVoeI++mttqZ0tqsE=;
        b=Bu5CE5tE+trZnCAYHqwPjINJzOOqrp1GKQ1RRKWWpHLshn8ovr1+teiiPU3RAEXJ/X
         lsJk9F0oz9lMzvVnhJdqeT9BP5gIkoTSnLmn1A73UyPpFwMDDqWsBfoVYSo/8iJP8TRs
         FGByJkR78nNQeJ68c6pAMUXDT+zqIzn5JtOvRtn8WYw6RHuh5V/kQjGUApkr+5l2TkmM
         bE/IWUilbIADdbVg8KJMJHMyiHrL6CWl8cHVXse6p/b0OQjDvNkRSYUgssBjP0L8A3AR
         eUMhDzWSDalLd4lLS6KEcLuaKxnQM1A4/j+4ZajNyMLclHz1GqZEXw7sKCt42i38nIhB
         K9Wg==
X-Forwarded-Encrypted: i=1; AHgh+RrXO1J69Mc01R4lnznqLvSzWWlxosCkAnkVBZPe3IgB1j7hhHRut/rq+yMQqCKbcxhd4jIqZQY6fAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmXoqJRRrHvdY4DjBxpaSubcVdu3ddHf2jhwKvR0jd3qtBxf8F
	r9KjL9zgzL1aBQ67dNGyEgihhaviACfwx4ZYW498WUlRpOcNBbFsRN06FNBnHiY1
X-Gm-Gg: AfdE7cnt4QbUHBcWF1jsVTbeETycnw1ol9iXSKmfCisnIUzXn1dCcMQ/ONVdeArQbmh
	OiqfYMezlG3dRIPBWGBwcwAK4LcvH5B43F8A5qs8U0cTFWBa1PfWNHY6W9YNRe5IyNfNPkTy+34
	vUWPYa5U8TWwvEOR5V8aYngWVgaPQbcBHSDARrR8v7e9HC2KvvDROcQN0N+09Brjhg5XhFVqNhX
	dyvHsy6dOaPyWMz5SD7634pIuK1jtG9MkyTt5i3x1UaZqD4ZF53TOPYke6mmK5WqDwxQZ1bYfmN
	OIuqIgSlUF8GTkq+e18QJQFrVBeHgpSBDocsMeOKBx4S4xBfOSGakKrh5PFry5f39z+jx7KH+fu
	Sp4tLmSlRziT++28ovSR6xce4JylifprlYO47KLzkaEL8wJGs6rT3RCNhq4ZZMwO6M1JaQQ5RGe
	4fAwGcnTcHBc35yGl/
X-Received: by 2002:a05:690c:7244:b0:80a:9f1a:d48f with SMTP id 00721157ae682-81ef283dacfmr14086577b3.54.1784321990187;
        Fri, 17 Jul 2026 13:59:50 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef3e6656dsm20013647b3.0.2026.07.17.13.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:59:49 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 17 Jul 2026 17:59:17 -0300
Subject: [PATCH v2 4/6] hwmon: (adt7470) Add ADT7470_PWM_MAX macro
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-adt7470_thermalzone-v2-4-a55147958fad@gmail.com>
References: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
In-Reply-To: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Darrick J. Wong" <djwong@us.ibm.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2

Instead of a magic 255, use a macro to refer to it.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/hwmon/adt7470.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 77e7be692790..d881609c99aa 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -100,6 +100,7 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
 #define ADT7470_REG_FAN_MAX(x)	(ADT7470_REG_FAN_MAX_BASE_ADDR + ((x) * 2))
 
 #define ADT7470_PWM_COUNT	4
+#define ADT7470_PWM_MAX		255
 #define ADT7470_REG_PWM(x)	(ADT7470_REG_PWM_BASE_ADDR + (x))
 #define ADT7470_REG_PWM_MAX(x)	(ADT7470_REG_PWM_MAX_BASE_ADDR + (x))
 #define ADT7470_REG_PWM_MIN(x)	(ADT7470_REG_PWM_MIN_BASE_ADDR + (x))
@@ -829,7 +830,7 @@ static int adt7470_pwm_write(struct device *dev, u32 attr, int channel, long val
 
 	switch (attr) {
 	case hwmon_pwm_input:
-		val = clamp_val(val, 0, 255);
+		val = clamp_val(val, 0, ADT7470_PWM_MAX);
 		mutex_lock(&data->lock);
 		data->pwm[channel] = val;
 		err = regmap_write(data->regmap, ADT7470_REG_PWM(channel),
@@ -887,7 +888,7 @@ static ssize_t pwm_max_store(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = clamp_val(temp, 0, 255);
+	temp = clamp_val(temp, 0, ADT7470_PWM_MAX);
 
 	mutex_lock(&data->lock);
 	data->pwm_max[attr->index] = temp;
@@ -922,7 +923,7 @@ static ssize_t pwm_min_store(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = clamp_val(temp, 0, 255);
+	temp = clamp_val(temp, 0, ADT7470_PWM_MAX);
 
 	mutex_lock(&data->lock);
 	data->pwm_min[attr->index] = temp;

-- 
2.55.0

