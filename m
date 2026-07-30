Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591363D75B1
	for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447045; cv=none; b=bqOtEEqY20gVdTL5xgaapjFhXdSiUopghwhUPkZ6E5UZOAh4igm5l6XWGxCfoNgaR3dtKAtrzlr7A+WqdJoAtpw412n5JLpBbMVRzpKcT6tGlhO41741wi3Nmf6vRYacF55T54Srge40Rs/i2V99kPnimkrMrK89iuZzpEIsm08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447045; c=relaxed/simple;
	bh=6Sz4Q0ABr5Tfip31KyIIcvrudC0SDzp/CSjmJxU7CSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbEdOnRlw4eFmkJg57aEAwiWVjYHWk3VM3OeGeSEonut2Fw9b/XcKwJlTkME8DyZYWg1YQKbSEGpgMVGGAQK1vUzD7rFN35tQ+w+jtxLnVZfXyXjQ4XjGCZbnkvrRD2fjHNHMz3DzUGoSd3uNi0kWgoFRyekK3lCCYbxV4R0gTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjiC2hBR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjiC2hBR"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cea3004256so3173055ad.0
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785447040; x=1786051840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mof0gXHLBACZ9mYjnIwYKuzUS/R9hysxBWyHkqLlLTg=;
        b=FjiC2hBRxZ2DURtl3RbwQZgdDKjzmTLF2+9AsccteULbBRMjlolhz0dCj5c0ftw7MK
         T16gZPMO2IqlIonhEQWLT0ZbR26mtoxaPYTPiL0ZkuWCbyaLPfbw82WUfQHgq4Zq08Xc
         TcBsuafTOoNT9ujOA11TGGUQ7Q7dWLB9kLwOhHT4CDcteijvKZpJrOI2jvRwsITc5cZb
         RYQrCkHi0GkhnVLew88F8cnz4frKThuHRzZtk6FLsx372bglXrBxVc02aZ+c7bU7MZcB
         +gfvfMngFywhwnv5jaynCcvIqx2WpOaalatmBpKr9QR5Zui1edYc/qMNxbqeTTInkZVh
         tr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785447040; x=1786051840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mof0gXHLBACZ9mYjnIwYKuzUS/R9hysxBWyHkqLlLTg=;
        b=jUvXZhslLqv/YjHRA7/dT0QOEQgyHTDWdupyNsNCi0qQhp7A4SKxqaJxBtmlxbUpmD
         TdRHcb/b8NkJjuHeRjdav9hhzCy/aQWG/31gbHEnpp/SKC0i8AthvRkyfOR6vLka1Dx0
         T/ZC15Bp8/iiGyCwV6R6KCSig3jPKMJjM4QBNFz2nD3zCueQ/HMDCPOOT4TEIjsd4jM2
         /+dJSy2cdKq1Y/eOsBLpvJYhcqJTEwowy9B7VunbcNIqvpmF3fNbVFByk7PyrmPvxXNA
         8rEJoTE8VrXA8YfvETKf0sLwOlUAZBKbUdeIoYNqsxN7NWnedzTbOKHazaMUgHfeyALZ
         Xd+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpsulOwSkcDYXBxruFn+X9fxAumjcKqMBS/n7813MOan6F/1mhTfyw3ik7pX2OdI7LOzfFJ6K2jbyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwursjtncTs6xytR1Wq6wpYTz/DmySTe1a90HU2zs289jSO+QVz
	U/TfOz/vAMBn0R3yEZISiOaLx2lKZU2RXXes7kZQq+x9bk6aqsDGqGi5
X-Gm-Gg: AR+sD129rNb5iua5dxm0ypYwBUvPhxqu9Rh0vf1Qe31J4O4sIdjScluRR7Fc+dxCgR7
	sxQYK97Ehpwio9ffNcTqM5QnGenXgJ4dcu0UQUurSrJd6PlA37m1jnYg+R7CD7R80giFgsk0jcy
	jkqtLzbvWYSmoBcriSs67fUOiX1uMlpYCfeSzoU4/95prhj3XqeAGo7SbHA/MBIABpM5BNXJsG7
	ScU6Vx0hGVF0w/kzSuzUdxjE9QeH2mwwDvlVmmyPESiI1cBCVIN3Qs3uiHuvudCwH30NWTl9AEC
	+fctXRy6jT4d14rzXJiDrhzH5lcvkNTd55SlPyLyaGb/2KBnyEiDbGpzbFW0tUjBIPLNHg+5ptU
	QFvaGTO76W68fupUsnfwhpkFYPL7DvT3ngwYe0uez0ZC7Ampb/8huuOwYW/9dBdQiR4sEjq8OHJ
	/RCsfZVOCp1Crwg+5rA6Sx4A+HfHCAK5pe2uNy22H0ROvrgAH/OGjQ5pk6WrdpdNmq1KtZqy9Ov
	1qdqQbxR5F12S4=
X-Received: by 2002:a17:903:1b04:b0:2c9:bd37:ae76 with SMTP id d9443c01a7336-2d035d39d58mr43232255ad.47.1785447040402;
        Thu, 30 Jul 2026 14:30:40 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d2ec2asm28584728eec.21.2026.07.30.14.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:30:36 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 30 Jul 2026 18:29:58 -0300
Subject: [hwmon-next PATCH v5 3/4] hwmon: (adt7470) Expose fan control via
 PWM framework
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-adt7470_thermalzone-v5-3-42995a6bb8c5@gmail.com>
References: <20260730-adt7470_thermalzone-v5-0-42995a6bb8c5@gmail.com>
In-Reply-To: <20260730-adt7470_thermalzone-v5-0-42995a6bb8c5@gmail.com>
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

To prevent conflicting access, the hwmon PWM sysfs attributes are hidden
when the device is registered with PWM framework support (i.e. when
"#pwm-cells" is present in DT and CONFIG_PWM is reachable).

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/adt7470.c | 194 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 194 insertions(+), 1 deletion(-)

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
index 87ddd7b8ddae..eeec3db0da88 100644
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
@@ -164,6 +167,7 @@ struct adt7470_data {
 	char			limits_valid;
 	unsigned long		sensors_last_updated;	/* In jiffies */
 	unsigned long		limits_last_updated;	/* In jiffies */
+	bool			use_pwm_framework;
 
 	int			num_temp_sensors;	/* -1 = probe */
 	int			temperatures_probed;
@@ -887,6 +891,133 @@ static int adt7470_pwm_write(struct device *dev, u32 attr, int channel, long val
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
+	u64 actual_period;
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
+	actual_period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, data->pwm_freq);
+
+	if (actual_period > wf->period_length_ns)
+		/* period too short */
+		return 1;
+
+	if (wf->duty_length_ns >= actual_period) {
+		wfhw->val = ADT7470_PWM_MAX;
+	} else {
+		wfhw->val = mul_u64_u64_div_u64(wf->duty_length_ns,
+						ADT7470_PWM_MAX,
+						actual_period);
+	}
+
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
+	wf->period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, data->pwm_freq);
+	wf->duty_offset_ns = 0;
+	wf->duty_length_ns = DIV_ROUND_UP_ULL((u64)wfhw->val * wf->period_length_ns,
+					      ADT7470_PWM_MAX);
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
@@ -1107,6 +1238,10 @@ static struct attribute *adt7470_attrs[] = {
 	&dev_attr_alarm_mask.attr,
 	&dev_attr_num_temp_sensors.attr,
 	&dev_attr_auto_update_interval.attr,
+	NULL
+};
+
+static struct attribute *adt7470_pwm_attrs[] = {
 	&sensor_dev_attr_force_pwm_max.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
@@ -1131,7 +1266,32 @@ static struct attribute *adt7470_attrs[] = {
 	NULL
 };
 
-ATTRIBUTE_GROUPS(adt7470);
+static const struct attribute_group adt7470_group = {
+	.attrs = adt7470_attrs,
+};
+
+static umode_t adt7470_pwm_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int index)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+
+	if (data->use_pwm_framework)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group adt7470_pwm_group = {
+		.attrs = adt7470_pwm_attrs,
+		.is_visible = adt7470_pwm_is_visible,
+};
+
+static const struct attribute_group *adt7470_groups[] = {
+		&adt7470_group,
+		&adt7470_pwm_group,
+		NULL,
+};
 
 static int adt7470_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			int channel, long *val)
@@ -1166,6 +1326,7 @@ static int adt7470_write(struct device *dev, enum hwmon_sensor_types type, u32 a
 static umode_t adt7470_is_visible(const void *_data, enum hwmon_sensor_types type,
 				  u32 attr, int channel)
 {
+	const struct adt7470_data *data = _data;
 	umode_t mode = 0;
 
 	switch (type) {
@@ -1198,6 +1359,14 @@ static umode_t adt7470_is_visible(const void *_data, enum hwmon_sensor_types typ
 		}
 		break;
 	case hwmon_pwm:
+		/* Hide all pwm attributes if this device is exposed to the PWM
+		 * framework
+		 */
+		if (data->use_pwm_framework) {
+			mode = 0;
+			break;
+		}
+
 		switch (attr) {
 		case hwmon_pwm_input:
 		case hwmon_pwm_enable:
@@ -1328,6 +1497,29 @@ static int adt7470_probe(struct i2c_client *client)
 
 	data->pwm_freq = (u32)freq_val;
 
+	data->use_pwm_framework = false;
+
+	if (device_property_present(dev, "#pwm-cells")) {
+		if (IS_REACHABLE(CONFIG_PWM)) {
+			struct pwm_chip *chip;
+
+			chip = devm_pwmchip_alloc(dev, ADT7470_PWM_COUNT, 0);
+			if (IS_ERR(chip))
+				return PTR_ERR(chip);
+
+			chip->ops = &adt7470_pwm_ops;
+			pwmchip_set_drvdata(chip, data);
+
+			err = devm_pwmchip_add(dev, chip);
+			if (err)
+				return dev_err_probe(dev, err, "failed to register PWM chip\n");
+
+			data->use_pwm_framework = true;
+		} else {
+			dev_warn(dev, "#pwm-cells present but CONFIG_PWM disabled. HWMON PWM attributes not hidden.\n");
+		}
+	}
+
 	/* Register sysfs hooks */
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
 							 &adt7470_chip_info,

-- 
2.55.0

