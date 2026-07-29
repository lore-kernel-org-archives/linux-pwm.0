Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5BA2D5432
	for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2026 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785300409; cv=none; b=BVdgxr2vt0rFqvqPL1o4T/I4Yj6KOq9fSCpVTNKpJUC7LKIHUkngis6cXbTa+FqguR3mxJygnsvsLtFOFX9yRTqq+ofr/7/WjLpri0z5ZjldzNJLr5aO/y3XedWMmL08sd0eXADiqWyiDhCx7DSExfHxNz3JrJgulRLxdowxwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785300409; c=relaxed/simple;
	bh=uso+AiL4RRVW994rNUEM+SPENAewotD94oUfNOpNN/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JU+++cO2EWdaJ2mxC1zeKY7OUmg/ktglMQzQhbHvhLL+zorPJbkxUyMM+uD9X8IPS+gkYEmat49QXDgCqYhKBPt/f86NGQWS5hj06TTEacpSL2sjpOwG6F8G9HAZV73I2BR+1Ofacu10FxvCzlteY0m5TjrmeQTcxVWBFpACjXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9+KLd31; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9+KLd31"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca957432c7fso363792a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2026 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785300407; x=1785905207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YcAwqVfZstu8fLwMT3MpubKYI8H9ycEfhFoXc9QzxXc=;
        b=e9+KLd31hJ6SlhtVpyStExEAfojI1qPN+xD3a9ca2UTPT1Oav+1N+mMt/qtRITfr7K
         clvAsPwSElM95ZywSrYXgzcb0BsOrDMPnQLT48SWz17QGU5zNdkp0coVFHz0fkp9MXFs
         1lAdHiKpmZPtd8vIifR+4As+JFpmij76nT0MZMO55oc1SndXadVTaGUQ0JFb49i6xBJj
         furk/msgIJ/RJiCH9O/KUmK64bn8vXCXirlSAcin6RSXvAL//be69QFz9juxVjuvPt8T
         HFfNjaxcKk+SJx4NzwA4E5OXoHqhwdT5RgaCNdtwrrftUDXTZNYHdCQimHsJcDYAN248
         3Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785300407; x=1785905207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YcAwqVfZstu8fLwMT3MpubKYI8H9ycEfhFoXc9QzxXc=;
        b=O1eqJ8Fi5FJJ4V5d1E8TLLRvSlnqsOQJNJbao+1m22JYNIZAWzwarz0r37cQIJ5pIu
         4fuhojexYlzl33+8QkT9JduyREHYV6EriMcG6cx3ZYcUzMs5S0zF3sJNlwUkZlf3kjo6
         XhJ/bsttA16Pra4UboDdPnpF3NIrqfhYqn9auBm93LSkhkJGuBUIqhWcAAzp4WLij8aT
         SEPoI017spC+zSBqsDl+MclQjweZDxUpWcko7DpRWekDhYyg/lKQBwq0gMDCHjD6HIGR
         BxT/W96zbdXwF5sizivFCTi83XSQ3QmfRVBT2AxWagUso2ex4xuR+WaIZr+o3C2k0dDP
         ChPQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2Iph6Xth4diag3GxK6QtsDUq+frCO6NYLG4ihD8/1RphThoRvAiP+ebUfafQ5U1gpqQKO1QxZ2PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynvqjwfsLkLeNGbOv2yt9pbMcZICElb6bsC+DXkVqhC3VIBzYf
	uV1PB5VPrR9zExU76kFr6K+fpexBHKxGA0cPva1aX8YVsfupV2HHCIj3
X-Gm-Gg: AR+sD12smdgxtCAW/5mWA0VUENaa7q/CVVin9wyp0zt3sPFMGgAcYfQLkSbhNcmtVLe
	KJdU3xVWzxSa/yV2sCt6W0cByV2Tn8Sczy7f3PCaAGroZpqMKXG/3U3PpZtKf56xnDXg0P7SH05
	AO5KCwOrGHIXg1oZO557mqhG3SatkDjcOIOlArZFaAqAU6rH88ALp1/uQGDHjtKB7gHRM7xS0xP
	3Ll3BUYuryvw5MmOiSIcoi70iGo5yTqTUvEueNDkeftpZMQWCENJZDzwXxhTka9IzKfXBHTzul/
	WGdAGhqQj9XJNxqqPunKILdMqomo6hvD6AN+1cvMY6n2WvEmy1lZz5tnOSPm/RhfM5bYnBO8AcG
	dvXpWaALjeyEGMRmmiBd9lWwQvdVR9vdShw9Xj8yQ3jx0qw9w2s5ns+waVZzOwNg87LCCmqYMzO
	5EBTavVz6/nfwHL33+uHf43iYZTxkX8wUqQnm+4kv7jgiROMfHJKITN4Ru44Xe5xeqGfdPggtp/
	zbC
X-Received: by 2002:a05:6a21:4591:b0:3c0:9c19:6591 with SMTP id adf61e73a8af0-3c8ba60d26bmr6490437637.75.1785300406710;
        Tue, 28 Jul 2026 21:46:46 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b6d14bsm4730437eec.10.2026.07.28.21.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 21:46:45 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 29 Jul 2026 01:46:11 -0300
Subject: [hwmon-next PATCH v4 3/4] hwmon: (adt7470) Expose fan control via
 PWM framework
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-adt7470_thermalzone-v4-3-c14039dfa0e6@gmail.com>
References: <20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com>
In-Reply-To: <20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com>
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

The ADT7470 features four PWM outputs designed to control fans.
Previously, these were only accessible through the legacy hwmon
sysfs interface.

Expose the ADT7470 fan control lines through the generic PWM framework.
This allows generic PWM consumers described in Device Tree, such as
"pwm-fan", to use the device through the "#pwm-cells" property.  This is
particularly necessary for boards where the ADT7470 external temperature
sensors are not populated and the chip is used strictly as a fan
controller (e.g., Edgecore ECS-2100-52T switches). In such setups,
delegating control to the generic PWM subsystem allows the kernel's
thermal framework to manage the fans based on unrelated temperature
zones, such as internal SoC sensors.

When a PWM consumer applies a new PWM state, the driver automatically
switches the corresponding PWM channel to manual mode so that the
requested duty cycle takes effect. The duty cycle specified by the PWM
framework is internally converted to the 0-255 scale expected by the
hardware registers.

The legacy sysfs interface remains unaffected and operates in parallel.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/adt7470.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 6b71e3304b4f..0d6bd117d14d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -224,6 +224,7 @@ config SENSORS_ADT7462
 config SENSORS_ADT7470
 	tristate "Analog Devices ADT7470"
 	depends on I2C
+	depends on PWM || PWM=n
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the Analog Devices
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 87ddd7b8ddae..883838fdcd7d 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -22,6 +22,9 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/util_macros.h>
+#include <linux/pwm.h>
+#include <linux/cleanup.h>
+#include <linux/math64.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
@@ -887,6 +890,125 @@ static int adt7470_pwm_write(struct device *dev, u32 attr, int channel, long val
 	return err;
 }
 
+struct adt7470_pwm_wfhw {
+	u8 val;
+};
+
+static int adt7470_pwm_round_waveform_tohw(struct pwm_chip *chip,
+					   struct pwm_device *pwm,
+					   const struct pwm_waveform *wf,
+					   void *_wfhw)
+{
+	struct adt7470_data *data = pwmchip_get_drvdata(chip);
+	struct adt7470_pwm_wfhw *wfhw = _wfhw;
+	u64 period_ns;
+
+	if (wf->duty_length_ns == 0) {
+		wfhw->val = 0;
+		return 0;
+	}
+
+	/*
+	 * The PWM frequency (period) is a single chip-wide setting shared by
+	 * all 4 channels, so it cannot be changed on a per-pwm_device basis
+	 * through this API. The duty cycle is rounded against the currently
+	 * configured hardware period rather than the period requested in
+	 * @wf; round_waveform_fromhw() reports the actual resulting
+	 * waveform back so the core/consumer can detect a mismatch.
+	 */
+	period_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, data->pwm_freq);
+	wfhw->val = min_t(u64,
+			  mul_u64_u64_div_u64(wf->duty_length_ns, ADT7470_PWM_MAX, period_ns),
+			  ADT7470_PWM_MAX);
+	return 0;
+}
+
+static int adt7470_pwm_round_waveform_fromhw(struct pwm_chip *chip,
+					     struct pwm_device *pwm,
+					     const void *_wfhw,
+					     struct pwm_waveform *wf)
+{
+	struct adt7470_data *data = pwmchip_get_drvdata(chip);
+	const struct adt7470_pwm_wfhw *wfhw = _wfhw;
+
+	wf->period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, data->pwm_freq);
+	wf->duty_offset_ns = 0;
+	wf->duty_length_ns = mul_u64_u64_div_u64(wfhw->val,
+						 wf->period_length_ns,
+						 ADT7470_PWM_MAX);
+
+	return 0;
+}
+
+static int adt7470_pwm_read_waveform(struct pwm_chip *chip,
+				     struct pwm_device *pwm,
+				     void *_wfhw)
+{
+	struct adt7470_data *data = pwmchip_get_drvdata(chip);
+	struct device *dev = regmap_get_device(data->regmap);
+	struct adt7470_pwm_wfhw *wfhw = _wfhw;
+
+	data = adt7470_update_device(dev);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	/*
+	 * No lock needed: like the other hwmon_ops read callbacks in this
+	 * driver (e.g. adt7470_pwm_read()), this only does a single byte
+	 * read from the cache populated by adt7470_update_device().
+	 */
+	wfhw->val = data->pwm[pwm->hwpwm];
+
+	return 0;
+}
+
+static int adt7470_pwm_write_waveform(struct pwm_chip *chip,
+				      struct pwm_device *pwm,
+				      const void *_wfhw)
+{
+	struct adt7470_data *data = pwmchip_get_drvdata(chip);
+	const struct adt7470_pwm_wfhw *wfhw = _wfhw;
+	unsigned int pwm_auto_reg_mask;
+	int err;
+
+	if (pwm->hwpwm % 2)
+		pwm_auto_reg_mask = ADT7470_PWM2_AUTO_MASK;
+	else
+		pwm_auto_reg_mask = ADT7470_PWM1_AUTO_MASK;
+
+	guard(mutex)(&data->lock);
+
+	if (data->pwm[pwm->hwpwm] == wfhw->val &&
+	    data->pwm_automatic[pwm->hwpwm] == 0)
+		return 0;
+
+	/* Put the PWM channel in manual mode before updating it. */
+	err = regmap_update_bits(data->regmap,
+				 ADT7470_REG_PWM_CFG(pwm->hwpwm),
+				 pwm_auto_reg_mask, 0);
+	if (err < 0)
+		return err;
+
+	data->pwm_automatic[pwm->hwpwm] = 0;
+
+	err = regmap_write(data->regmap,
+			   ADT7470_REG_PWM(pwm->hwpwm), wfhw->val);
+	if (err < 0)
+		return err;
+
+	data->pwm[pwm->hwpwm] = wfhw->val;
+
+	return 0;
+}
+
+static const struct pwm_ops adt7470_pwm_ops = {
+	.sizeof_wfhw = sizeof(struct adt7470_pwm_wfhw),
+	.round_waveform_tohw = adt7470_pwm_round_waveform_tohw,
+	.round_waveform_fromhw = adt7470_pwm_round_waveform_fromhw,
+	.read_waveform = adt7470_pwm_read_waveform,
+	.write_waveform = adt7470_pwm_write_waveform,
+};
+
 static ssize_t pwm_max_show(struct device *dev,
 			    struct device_attribute *devattr, char *buf)
 {
@@ -1336,6 +1458,21 @@ static int adt7470_probe(struct i2c_client *client)
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
 
+	if (IS_REACHABLE(CONFIG_PWM)) {
+		struct pwm_chip *chip;
+
+		chip = devm_pwmchip_alloc(dev, ADT7470_PWM_COUNT, 0);
+		if (IS_ERR(chip))
+			return PTR_ERR(chip);
+
+		chip->ops = &adt7470_pwm_ops;
+		pwmchip_set_drvdata(chip, data);
+
+		err = devm_pwmchip_add(dev, chip);
+		if (err)
+			return dev_err_probe(dev, err, "failed to register PWM chip\n");
+	}
+
 	data->auto_update = kthread_run(adt7470_update_thread, client, "%s",
 					dev_name(hwmon_dev));
 	if (IS_ERR(data->auto_update))

-- 
2.55.0

