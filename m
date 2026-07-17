Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7230306754
	for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784321982; cv=none; b=rB40pm72+WI5PsvPs9gwhHC2nxOwTwrx0PHmEZzXgmWgYXtgLUgdO82Ha7gYrP0mGNgHYix9PK9+oEfCBJpteWz/tcgXpTBpaqJ6HO2pmzPTwiEe9VAaCysEiYEudxLMVPQO/9LcJ7TRm+WFpQ6qmmig6+QGWLXH3kSdeQ3CaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784321982; c=relaxed/simple;
	bh=w1Hv0r2r6jSycHFUZO7pD+HmNcQNoWtICO6sg/Lwaxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LHEDUCxXxvy8a+Na2kNip7WM6d4SWqEKvOCvCTjTe+3i4uJpaIS9yfvo4XCHRTh1PlUpMtasYgIVj5v9KBV5JRVKj+bjyoCt97/SyV+TreSG0vu3RUZxt9zIyKnCfuTDpgQC1XuxJjuH8EqrUH01FyshCltLLfoSDPs/zdKhyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHoTu5ib; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHoTu5ib"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ed073fed0so50869537b3.0
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784321980; x=1784926780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sc68CqtTOQLhSPfGgDFsVsO0c0+MZYn4nDNljvauFns=;
        b=CHoTu5ibtN6UTy/xBmB5jPCKVuHXmqV8nDwXlx0b5pFrJaYktU6402wZ5P+GYdbleu
         aWFAjDCjhE8dO1On0eo/WqV52V6iGZfPG7uTETXFpZd5KcAQO8AbKq3nL2RUVAROSOUu
         5DolgkfCNwd3DqGM7rcnZ00SbZA6wb5TNySrJEzWtiWmqRtWa9L0GLAcIi7OMKPqr2/d
         hzWvDtQeQGsMIcpKh9CG6dxp+FXv/vViO22MEh3PJu/SXRU07JdXgToQWHLH6qNgyouq
         FonfB29zzETZtS3D5Zthr/xI3w+GijkqAsCFmgFtpitG8UeOgTc3fvTmsv7eWcHkVA6o
         fNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784321980; x=1784926780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sc68CqtTOQLhSPfGgDFsVsO0c0+MZYn4nDNljvauFns=;
        b=ZYbAQOT0AbT2S5xqKFnOuuYSGEIIQqT2QfPFn0AVfrXhmMQw4r7Sc+qOi4Sf1TJGmj
         GJ0MFk/hMP2zQeDeUPFrAZ8TVStj8qfXCSfQsBiBaDzoq9iF/3zzwAwJz/XgO06ijwCZ
         i9wwWw7wtWYoPv+JApUyo5mv1X7CSfd9YGeqH4qlY34pcGbXDC5mRO0IcMdqiN9YAFtU
         3AmvjMtD0MOOmOUbUF65PMX9vnGSCTr/M5xXSnYxftO3qauuLptSWmJMiD+zbH7SQhMm
         sMX/1NjVZsvZubDLH/o+cvPE89kLT3phzy1tOcAEBzYQ7Cr+5dSdgMoCcuEE5UCQIV/j
         z7Yw==
X-Forwarded-Encrypted: i=1; AHgh+RqkpccVzF/0LCxrpJZGP+Aomdph8RHh+uBKAEgJiKwXB3LccH26ad+Tr64jugqvKEyH1c7RrXuSoTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHan42QsF05qD68WJxCuSEvMXwhiihqAPpQfXPB8F2QS+dNzaZ
	mdSGxs4LXRwsp/D6i5BiG3bFTnQCaQFb3XSxt8n3tsZ3PJrWRb6Ed3jf
X-Gm-Gg: AfdE7ck431TIIGABtUlxSFAyBisxtfTXhSHCiy9Bh0PfIeG1VyfW/74ry1lYi8zK8gu
	R9d2rHNHp/nV5K9JZmW7SnKuFXekIjrc/T+GGw5uvZHO7e6owqee7qGuIfTCGYkEJ6FRWjDmENt
	KDiWcGlnU4LtJqQfocg80RsbjnDfS4zeDXlO6QmU9puKtGA7vNHCTCVIFzvHgL8vdrFXQmK01mt
	yWN4ybh/JJDTutC8rvSYDrwVnc92Hsilje5NdBbld5K7TK7eZf6+0xUlTzJgHHbaLbxXSjBHggg
	+hEAtxmw+jjqsLSHE2H3PguD/7gj/8tRCyVuIkkCBasaPedLhsQoUGWXaeBfAsrRR/Q8ii1BxH+
	DVJJ8RCbkLdaD3/khhFxfIZ57CXkvOKoADc8EKu5k2U02royt8ppBi0zF3dCs1RbOkKr1jcxi0B
	0gJBvw1r1ZTTPcuzKY
X-Received: by 2002:a05:690c:4d83:b0:80c:3848:bdf4 with SMTP id 00721157ae682-81ef2671daamr16015557b3.41.1784321979908;
        Fri, 17 Jul 2026 13:59:39 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef3e6656dsm20013647b3.0.2026.07.17.13.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:59:39 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 17 Jul 2026 17:59:15 -0300
Subject: [PATCH v2 2/6] hwmon: (adt7470) Fix fans stuck in manual mode on
 I2C errors
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-adt7470_thermalzone-v2-2-a55147958fad@gmail.com>
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
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-pwm@vger.kernel.org, 
 sashiko-bot@kernel.org
X-Mailer: b4 0.15.2

During adt7470_read_temperatures(), the driver temporarily switches
the PWM channels to manual mode, performs the temperature collection,
and then restores the original configuration registers.

However, if an I2C transaction fails at any point after entering manual
mode, the function aborts and returns immediately. This leaves the
configuration registers un-restored, permanently trapping the fans in
manual mode.

Introduce a recovery path to ensure that the original PWM configuration
registers are always restored, even when intermediate I2C operations
fail.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/r/20260716213252.EACA71F000E9@smtp.kernel.org
Fixes: ef67959c4253 ("hwmon: (adt7470) Convert to use regmap")
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/hwmon/adt7470.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 664349756dc2..481d51617f4b 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -205,11 +205,12 @@ static inline int adt7470_write_word_data(struct adt7470_data *data, unsigned in
 /* Probe for temperature sensors.  Assumes lock is held */
 static int adt7470_read_temperatures(struct adt7470_data *data)
 {
-	unsigned long res;
+	struct device *dev = regmap_get_device(data->regmap);
+	u8 pwm[ADT7470_FAN_COUNT];
 	unsigned int pwm_cfg[2];
-	int err;
+	unsigned long res;
+	int err, err2;
 	int i;
-	u8 pwm[ADT7470_FAN_COUNT];
 
 	/* save pwm[1-4] config register */
 	err = regmap_read(data->regmap, ADT7470_REG_PWM_CFG(0), &pwm_cfg[0]);
@@ -233,19 +234,19 @@ static int adt7470_read_temperatures(struct adt7470_data *data)
 	err = regmap_update_bits(data->regmap, ADT7470_REG_PWM_CFG(2),
 				 ADT7470_PWM_AUTO_MASK, 0);
 	if (err < 0)
-		return err;
+		goto out_restore;
 
 	/* write pwm control to whatever it was */
 	err = regmap_bulk_write(data->regmap, ADT7470_REG_PWM(0), &pwm[0],
 				ADT7470_PWM_COUNT);
 	if (err < 0)
-		return err;
+		goto out_restore;
 
 	/* start reading temperature sensors */
 	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
 				 ADT7470_T05_STB_MASK, ADT7470_T05_STB_MASK);
 	if (err < 0)
-		return err;
+		goto out_restore;
 
 	/* Delay is 200ms * number of temp sensors. */
 	res = msleep_interruptible((data->num_temp_sensors >= 0 ?
@@ -256,13 +257,30 @@ static int adt7470_read_temperatures(struct adt7470_data *data)
 	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
 				 ADT7470_T05_STB_MASK, 0);
 	if (err < 0)
-		return err;
+		goto out_restore;
 
+out_restore:
 	/* restore pwm[1-4] config registers */
-	err = regmap_write(data->regmap, ADT7470_REG_PWM_CFG(0), pwm_cfg[0]);
-	if (err < 0)
-		return err;
-	err = regmap_write(data->regmap, ADT7470_REG_PWM_CFG(2), pwm_cfg[1]);
+	err2 = regmap_write(data->regmap, ADT7470_REG_PWM_CFG(0), pwm_cfg[0]);
+	if (err2 < 0) {
+		dev_warn_ratelimited(dev,
+				     "failed to restore PWM{1,2} config (%d)\n",
+				     err2);
+
+		if (!err)
+			err = err2;
+	}
+
+	err2 = regmap_write(data->regmap, ADT7470_REG_PWM_CFG(2), pwm_cfg[1]);
+	if (err2 < 0) {
+		dev_warn_ratelimited(dev,
+				     "failed to restore PWM{3,4} config (%d)\n",
+				     err2);
+
+		if (!err)
+			err = err2;
+	}
+
 	if (err < 0)
 		return err;
 

-- 
2.55.0

