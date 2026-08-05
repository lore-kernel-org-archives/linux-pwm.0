Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1B471244
	for <linux-pwm@vger.kernel.org>; Wed,  5 Aug 2026 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935757; cv=none; b=jFVZupTmKobmqt5LKrtoYj7IgH5WpZgbm4TQ+2WlH0vqRO3VATDS7pS08xudqUkD6rrhGbxKx9ME2WSoAkL1aHAQcs4VglCvK4bD6AuhLWbP0bf2Ryw/JvLgn1vbZGcryv2sBvddJ3h2DtKWvXKASMr0+1xIuuHyxjevlkHERdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935757; c=relaxed/simple;
	bh=6Sz4Q0ABr5Tfip31KyIIcvrudC0SDzp/CSjmJxU7CSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=beuZgD14vKt4IyKrD+C565tJBEqHc6Nqb4Pi646oJRN4PHsPnY0QTrDu6RReIGgF2BDWzBE9lkrUEq2ONjR0MjM7PwYVqL2D+NVFDSjehwjygmQpNJcKkPd31md3s5QXSeO4NTqDeXf+PIr2s+6le2MYFPld7i3jErk262QsRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIVfKMeB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIVfKMeB"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso879204a91.1
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2026 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785935754; x=1786540554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mof0gXHLBACZ9mYjnIwYKuzUS/R9hysxBWyHkqLlLTg=;
        b=fIVfKMeBxh2GTX0g9jspWdrlay5rqJAUbbY5ZOyBL4kDB9UThb9yxj+gj2sclLXpKV
         1jTomK2FzMOh0Dj8Qs3F+0Dciik4oEK0IdkyIKanSuz5C3cJOW2hM6/JnPeQWmOsc589
         YPXHo1dQfWFb0jnfbMnT7sSeO6nWxEmq97oeuxBA5HhpK8rS9IRwmpqchNDJ8FtGGnXE
         xnJOIyERzqRqMum4WqijDFWXRneyqV3OCWOFNzsf/Qvm1tgYsaKr1bopoe7QJFOgM/3C
         X2XZMEJ/wDfIUjS+flM6RXlrp7xBB6408Kl/yjwN3IucDtXuOiKEAiddLXDsWPX1UrlE
         fLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935754; x=1786540554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mof0gXHLBACZ9mYjnIwYKuzUS/R9hysxBWyHkqLlLTg=;
        b=o+kEhgULSAIl/GWjdT3ZGtexfCdZGdlE2HBwUQ4tiWC8MCfx31ySZ8yvcLDALkX3HJ
         MUifHG6uWU6PpaANNpAk91X9mdVc3D+fZ603VOquIp3gQ2qsXpFkVpoXfYHz3/RcHU9y
         yELFmLWbMG8D7lvXJ+As7C+nUcsNmA7XO6KI3SfN15oGvMsOK60JvBK3IU4xuvYYqv/m
         6TAXWYuiTTVfYqIZTThqwtawGRvR27Hfthzpwhoi87ZWZYcu83VDD5XDU2/UPKpTg4Zu
         XcaoCsJ9svgWsVfJ/m/tHX3Q8PI/4O9qcx2JGGPf0eXKT/FltE33j0kL3w8f2gsoTlxJ
         nE6Q==
X-Forwarded-Encrypted: i=1; AHgh+RrQLI8voAmB1bGVCCMFqDn0ZaEYY/Zuw6joXs9QIFn2mT/C2PvtrSprFCSgTZEXD75jiTRhLSRpLTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQ8oKwvG8jNrThVLgPXRGwyG4kyBmNWv9HyR6hy/puEEX94kZ
	dQx0bmX86i2tovy2nnom5jgQcjbrFBeKDuaxz3oqln4+B9FirMgK8SLc
X-Gm-Gg: AR+sD122uZr7T8+HOKfApJkRCG0C9HjaYMzXzEbmCAA07Kt8u34XntyR1vQQsc+m22e
	oEre2rY065cDGKytGLNgUY0pqOGOUWjZfktVl//hIE0T4S6VhpTsxHlp1/KD31G6cro2Sdx1/7t
	lTz3iJXK/10pt9fefK3Rco1ONBL6i9Ud7fEfdObSjyQfXuqGnX3ktXR1GDOBZXJqcuNSaC9IWxU
	t8QxEPFvwoiC+uK4hWDwnkPttnxrDP3dVYEO55anrhhxQE2SjPsUcAevhSASxOz3Lf+t8rTFn4W
	U5cRJNnDijhtY5EoOK1yonblCYy6OlPYtJUasr55YB3y7VD+EFj6idVj/xzIDdfki9NFQ0jA4S2
	zIbYRKVi7PLPruDzbgyUeDk2N7hq/BZpWr70TQzbTP4EccxGOmn9Y6ULfQ8w6fbAbxQXlWq7bKt
	4JXWyaBZGAhOgSRxZ724ZN+npwLzE7SMWvNO/DLP3Yyar4kzNSNKfDaVC7oqaJIme9feprS38Cs
	7g2Q/0skGA=
X-Received: by 2002:a17:90b:17c6:b0:38f:1a2e:6e56 with SMTP id 98e67ed59e1d1-3903c59330amr6273573a91.9.1785935753895;
        Wed, 05 Aug 2026 06:15:53 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([189.4.123.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673a9e4sm18292261eec.18.2026.08.05.06.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:15:52 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 05 Aug 2026 10:15:19 -0300
Subject: [hwmon-next PATCH v6 3/4] hwmon: (adt7470) Expose fan control via
 PWM framework
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-adt7470_thermalzone-v6-3-5605a5f95467@gmail.com>
References: <20260805-adt7470_thermalzone-v6-0-5605a5f95467@gmail.com>
In-Reply-To: <20260805-adt7470_thermalzone-v6-0-5605a5f95467@gmail.com>
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

