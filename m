Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966225F98A
	for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784321998; cv=none; b=MNgR30FdjfR3iMR0ZaKqoQVavjPywJodX7wufED9lnBYG9gBhj/ARW5A+BtXdrQxlW4x4k7ZwQfS1J7PDeVDv0z1hMYksdK2PwFiQZ4OhuWltUjz/m8LjpVGFDBfGzE1A+1k5g38TOinUSuIcg9tvzxpXhXI1zGoKdRXvLa1v98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784321998; c=relaxed/simple;
	bh=86gXb+0iVKo/CNaBiOs1PGuYej+NgCevE8J2gY29EUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e02489VMdxCYzhH2OBHBmsDFCT0C8gyVD7ukDOXjv1iX3c0egOqnKaOf1UzGw7N0oEPyU/14zDvjmwWsPQ9RjqKxYjK5LwGU1fF9qe2Zi1gBbetURSRu8Dz8OybX2cpDa8+RUUgonKkbsnPPvA6w6Tj783s4d0YrYwcJ7ZQZqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfX2qIli; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfX2qIli"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e9d8f3289so61553937b3.1
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784321996; x=1784926796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKIuG7ZT2h5nSeNmJaQ8VJ/Mhodno/coMufjCgnracY=;
        b=rfX2qIli55FppQdCCmrdfcE6+1UWCUgQ41wHu/BhBt82aKhaQJMIL1usnM1qEgusHU
         +AeadF7+rSchl3LBtpr7ZrBZPazjvwcyulwMGCrYbJUKnmyVJD8jVIUYGNfjDAhxgxlf
         ElfeM1YSD83tuoCSJA+H+a3FAIZZ3u/CiSYk0VBANx4r5GmY3Q0jTdwENQnUpWLd6wy+
         6gd/pirkTqhvX8wZ8gNxxdHkVR7NicGbfWguyEC19XWPeZaKpyAfLW7CoFH4JTVRmlqS
         SOCDNEPgGAJ8jUeELPMenZwJhgafMP4LjEegRISp3Ss+3o8b/kDuepir0Sm0sw2HVd4t
         dknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784321996; x=1784926796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKIuG7ZT2h5nSeNmJaQ8VJ/Mhodno/coMufjCgnracY=;
        b=Q2cQ/2mo/ED4FbO6v808j1/XW94VuQRpgfiypbbQrb9WeA7li33LRwfKyx66IgKz2w
         FjT898t5cGHGUtMnoOEet+XF0/lf51cAjbziC3TMeM3dRXjVXiL3pgk6mqMAKlQfcYaA
         9h0v3Pnqu0X1JqoGtNM5hzpuuOph6uRTqTbDnvi9xyVzrsBGKrwL7R7jBUdT9QyEP4Ey
         2whk+TRjlOkH6hmDfgqESEMz2d37crosDkwKAxFTGNjSIE42OMtWLOGEJQ7U2e3PcUf5
         yNcp8udJCDmBiU/ayhivBpJUtV9ES81SxEaV33Lrx9+b/69+XIw8luEgp/Zz/hp4E0Ay
         GNIg==
X-Forwarded-Encrypted: i=1; AHgh+RoSYELAbrmPiURF47dcYTOSILeIkn7Iipk3Pm5uvUQ8Uu2T+V28ufxzP1S2Mhb6jRbYfYe/K10y6w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9hrtZAsgvmCbe5dPhrg0TSW556lOXkUdL7AIZoqst5GB/swY
	CY1mZRV3pAbZIIM2PW+nWPvuyceNXz7G4Hc/0iOqqE7tf1x/Imlt1a93
X-Gm-Gg: AfdE7cmb5eJei6BvEUFrWXYjrVh/RPUMqvX+BoihMnHlhcM/fHnC2Qq2rgf+f2nduFv
	Ghg0Ciz95QRjrWGOllzMC1zWcgCfJ6+D4krEyvDwcn7xn/t3uuemLFByTo4N3VbQHqIdd3gHkxf
	PLFkAigtHVCk1r1XR7XiwvQUGZgXknnsXf2phtbE9aClpQgyO0/kH46wljzoJy11B+5eJ3l2TB7
	nVCXYjmKOYS/YujgjVrqI97KRzvvgRy0pQ8UTUhHs0lFTTZC7P5gmb+rzP2fZX/ntF1yi8vEJBU
	OY21JjWoQIZah8TYJ9W3R0CBk/J/6E8EaPD4dWcVQEMu9Q00ehA47L/mzKfEY/VVCv0+HBi2/zs
	hSzJdD7CVLHaqCut3Y8LAV7gM26uFpXdAWeyghFQAlclZjdY5LWniXPURlI/wprLZEiu8EJ7A/V
	laqJ47IXG2E7EGZKc1
X-Received: by 2002:a05:690c:9a93:b0:80d:fc34:a79e with SMTP id 00721157ae682-81ef26119d8mr15502717b3.35.1784321995782;
        Fri, 17 Jul 2026 13:59:55 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef3e6656dsm20013647b3.0.2026.07.17.13.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:59:55 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 17 Jul 2026 17:59:18 -0300
Subject: [PATCH v2 5/6] hwmon: (adt7470) Register as a PWM provider
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-adt7470_thermalzone-v2-5-a55147958fad@gmail.com>
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

hwmon: (adt7470) Register as a PWM provider

The ADT7470 features four PWM outputs that can be used to control fans.
Previously, these were only accessible through the legacy hwmon sysfs
interface.

Register the ADT7470 as a generic PWM provider. This enables standard
Device Tree PWM consumers, such as "pwm-fan", to use the device through
the "#pwm-cells" property.

When a PWM consumer applies a new PWM state, the driver automatically
switches the corresponding PWM channel to manual mode so that the
requested duty cycle takes effect. The duty cycle specified by the PWM
framework is internally converted to the 0-255 scale expected by the
hardware registers.

The legacy sysfs interface remains unaffected and operates in parallel.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/hwmon/Kconfig   |  1 +
 drivers/hwmon/adt7470.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 08c29685126a..8838b6714e60 100644
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
index d881609c99aa..aaae14a421cd 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -22,6 +22,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/util_macros.h>
+#include <linux/pwm.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
@@ -864,6 +865,57 @@ static int adt7470_pwm_write(struct device *dev, u32 attr, int channel, long val
 	return err;
 }
 
+static int adt7470_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct adt7470_data *data = pwmchip_get_drvdata(chip);
+	unsigned int pwm_auto_reg_mask;
+	int err;
+	u8 val;
+
+	if (pwm->hwpwm % 2)
+		pwm_auto_reg_mask = ADT7470_PWM2_AUTO_MASK;
+	else
+		pwm_auto_reg_mask = ADT7470_PWM1_AUTO_MASK;
+
+	if (state->enabled && state->period > 0)
+		val = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * 255, state->period);
+	else
+		val = 0;
+
+	mutex_lock(&data->lock);
+
+	if (data->pwm[pwm->hwpwm] == val &&
+	    data->pwm_automatic[pwm->hwpwm] == 0) {
+		mutex_unlock(&data->lock);
+		return 0;
+	}
+
+	/* Put the PWM channel in manual mode before updating it. */
+	err = regmap_update_bits(data->regmap,
+				 ADT7470_REG_PWM_CFG(pwm->hwpwm),
+				 pwm_auto_reg_mask, 0);
+	if (err < 0)
+		goto out;
+
+	data->pwm_automatic[pwm->hwpwm] = 0;
+
+	err = regmap_write(data->regmap,
+			   ADT7470_REG_PWM(pwm->hwpwm), val);
+	if (err < 0)
+		goto out;
+
+	data->pwm[pwm->hwpwm] = val;
+out:
+	mutex_unlock(&data->lock);
+
+	return err;
+}
+
+static const struct pwm_ops adt7470_pwm_ops = {
+	.apply = adt7470_pwm_apply,
+};
+
 static ssize_t pwm_max_show(struct device *dev,
 			    struct device_attribute *devattr, char *buf)
 {
@@ -1299,6 +1351,21 @@ static int adt7470_probe(struct i2c_client *client)
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
+			return dev_warn_probe(dev, err, "failed to register PWM chip\n");
+	}
+
 	data->auto_update = kthread_run(adt7470_update_thread, client, "%s",
 					dev_name(hwmon_dev));
 	if (IS_ERR(data->auto_update))

-- 
2.55.0

