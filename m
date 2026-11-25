Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623660;
	b=3qh7l9HnAlpKInr+ekt0wWPiMpICxRJV0apeniAvZUgQcoZFi4Dz671SVPO0SOfiBL55
	 3AGSPs8FLsZ14rvKiqd4+myZAntvNh24PFwKaf0kRJYwQAszLzLNS7Jtf9lkq+BOJmF3a
	 5SwygCOQn8Ct9QJfXlyRg2h/MagUcsHj375idQOXbC33H4kzvtuYO8dWcURTDYH+ucffS
	 v1ZcaLKBf2mhhkae7fBR30+AAXxwhZ4nq1J13E68w7XG39rndPmZU8gbezRNmBjoqkmr/
	 kib2qdj4ASNCnqy1OeP6UPyO5jPZgOlfe6nSXOZBvoJaqsKSFrWCsJlLBLOqDJ+V+Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0s6fmlzONGCK6lmJzVfynVtJ2jjFF8VyCT3dCxeu9Vc=;
	b=cYNVJDd+fwMe8k/Tzhvqjwvgd/gbNCQcMoM0HB/oz1O4x5OvBOXpTeaW1C67VUXpvmuk
	 Cy/Nl0jV41kpgITkeYrU/7F9x5VuRfTmkS4PCrw9SFgy0fCegeBOKfU86tNe4hEhsGCvC
	 wjVilntp5U8nTHjIDUnWOc2cS7ICBCnJUqNzto5ULbCjfjuEWqrTYOTS1DzdjXzVXyApf
	 J9E7dQWYe28lF5icVDbc0VGDrq/p3MzvebOK/FaWAQzsB2OtfvQbXZYyApjKdLIOAlw+R
	 oEOGXBlSRl5yqHcWCTlEXEblbUOwssfSCFvt704Kq+NWnp5X05uJtU/EyvKXCB1BYyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RYHkCrYI;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CF606A688
	for <linux-pwm@vger.kernel.org>; Wed, 25 Nov 2026 16:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 055CF606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RYHkCrYI
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so53627395e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 25 Nov 2026 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795623658; x=1796228458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0s6fmlzONGCK6lmJzVfynVtJ2jjFF8VyCT3dCxeu9Vc=;
        b=RYHkCrYIwR6AofqMN7x9sFOrMv6j/xwBfJ2B6o1RKohEr8/S7q6t6mJ213sAn/Rlfs
         sy9EsJlw7BdKC6EWddNnXAQb+tJvOLOY0VEG8ADIvwfzXAei+AX33B8vK1sJCKA0tpXY
         K+wnXJ7s2LO2xVngWfRlSNKySOCDe/+sqI0BZOipT8UroTxiQAOVlCocCbjCCUwa+gqA
         neQXCdOBr0EXeKAhazZx9egdnG7Ev/85uRJSS5idEGS5qlH9hEglPa39iPKFMrwRpVb/
         XUe/+bcS7f64/uibxk6T7oPBHZznYFoskelcjILT8MOPxDebIt8qPboxlnrvmmuFi1jB
         ZqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795623658; x=1796228458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0s6fmlzONGCK6lmJzVfynVtJ2jjFF8VyCT3dCxeu9Vc=;
        b=FbognibaMxu3PSKdbx6ZfQg1e9fAmn8SqlJRWOJ0RH8kRWGG61WNvnvG+QGOuxHtBm
         5Z+dEbMvFRr9EL6zSY9D19fxcrW7bR144JtrNeSAWjvAv/T0WVKZXRI7ZHm7zDp+QeEw
         ttwLOFp+yHXvz++7luy10z1gVPujbrW1Y0rF3A/kwlfRFj0y81a/fMaVBri2mWf5k6Kv
         QnBALt4wv9iPVwZMBDUIKqRF62zeI5WNkKtuiVftSS27/l88AyywLyzpdc9urkup7Gkw
         ++ggcRQ02yI3nLsZ/0uWlhUBmw97vP1unkPJfFsL5Hls1qKi44Nt4ItBCzvd87e6W+f+
         qMvA==
X-Forwarded-Encrypted: i=1; AL+hErHoN6YxjOXhva2nG1Z9pB9FjSMXOXtTrQIyUDKrhRYT3f8AvHi9/2QNVs3SR6uNJ2Y0OqAVDISw/Es=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pcYSbiQTQfxCic0sSTMTh0ciOJRLoAx4s17alFrXRk7bYLvXf
	pj5QEQrVm4E7Le7rNXIwSDB67Aut4HtMTkBvTeyk0FssczeyGjTKVEhTKv1pyPt8LsA=
X-Gm-Gg: AZFdTZe3wLzQdFS/bYzmvMkYD/yUVq9l9EVZADv5av2YgLqmZSQ8Jn6Wu5EuRqMwIpT
	vlclYJ0RdPTDE3IgUaY/Q3HfO+wBAjOFFTJUUrBZlB2PXQcEZrTW6VL5SAtul0ljMQOd3gOVA93
	SkFtSOeZFqZhHEBrkt4t4fvyl3NALbWuS0UdA04GsZDTmIApd6IOe3cCcHxKgbnaG+i7M9R7j6B
	rZpnWq3DPpXsUl1Gm7NYqlPogjj2S0SNpjZtEZieTskrVkx9Wmzj9kS0PqL8fhU76wPZhK0We69
	MPMNkcUAS87UYHx2QPNEz4NokDMW5rGR+5s+rb/bSuKki6wR2Z3QgQ9LgkjR7imSEJ7U4KTFr9D
	MKvYq6XVoBzdW1yFwQq1nZKgvuUV23sIqonvRX3AFYpcMrB3u/rx5O7Jgk1dDnBeVJ3HaIynWSx
	XlYVWAZdGyVbCUAEz3UkFQ4NKV6farY/iIzIrbW4WkLC6VBQSBoIO09pSKYRn/JU9CXIJuXjRWh
	sLnhzGgMm0vhCkrUntEjpRtFryCZDgjMsEXfdpR138cCvfIM6+b62Y8B1++QMdKBwoOWOuFYC3z
	aqCsB4o63vAvxaSXs9/jrmmrjtwVckEGBBuFAOiEtD0LgWk77A==
X-Received: by 2002:a05:600c:3b1a:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4bb8881d4damr384617425e9.28.1795623658289;
        Wed, 25 Nov 2026 08:20:58 -0800 (PST)
Received: from localhost ([195.94.148.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm515826755e9.15.2026.11.25.08.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:20:58 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: naush@raspberrypi.com,
	svarbanov@suse.de,
	gary@garyguo.net,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v14 3/3] pwm: rp1: Register auxiliary device for the fan tachometer
Date: Wed, 25 Nov 2026 17:24:52 +0100
Message-ID: <20261125162453.23573-4-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261125162453.23573-1-andrea.porta@suse.com>
References: <20261125162453.23573-1-andrea.porta@suse.com>
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

On the Raspberry Pi 5, the firmware running on the RP1 Cortex-M core
measures the fan tachometer pulses and periodically writes the computed
RPM value into the phase register of PWM channel 2, inside the RP1 PWM
controller register block.

The Linux PWM framework has no abstraction to report such a value, and
the reading belongs to the hwmon subsystem. Following the auxiliary bus
model, let the PWM driver instantiate a "fan" auxiliary device
(pwm_rp1.fan.<id>) to which the hwmon driver can bind, without needing
any additional DT node.

The way the tachometer value is obtained (the register is shared with
the channel phase control) is an implementation detail of the PWM
driver, so provide rp1_pwm_read_tachometer(), exported in the 'RP1_PWM'
symbol namespace, for the auxiliary driver to use, as documented in
Documentation/driver-api/auxiliary_bus.rst.

The auxiliary device is destroyed first in .remove(), so that the hwmon
driver is unbound before the PWM controller resources are released.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 MAINTAINERS                               |  1 +
 drivers/pwm/Kconfig                       |  5 +++
 drivers/pwm/pwm-rp1.c                     | 49 +++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-pwm-rp1.h | 12 ++++++
 4 files changed, 67 insertions(+)
 create mode 100644 include/soc/bcm2835/raspberrypi-pwm-rp1.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c7b280a2bdb..26f8520c02ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23382,6 +23382,7 @@ L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
 F:	drivers/pwm/pwm-rp1.c
+F:	include/soc/bcm2835/raspberrypi-pwm-rp1.h
 
 RC-CORE / LIRC FRAMEWORK
 M:	Sean Young <sean@mess.org>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 523789e82355..7b271a16a483 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -641,9 +641,14 @@ config PWM_RASPBERRYPI_RP1
 	tristate "RP1 PWM support"
 	depends on MISC_RP1 || COMPILE_TEST
 	depends on HAS_IOMEM
+	select AUXILIARY_BUS
 	help
 	  PWM framework driver for Raspberry Pi RP1 controller.
 
+	  The driver also registers an auxiliary device that allows the
+	  companion hwmon driver (SENSORS_RP1_FAN) to report the fan speed
+	  measured by the RP1 firmware.
+
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/pwm/pwm-rp1.c b/drivers/pwm/pwm-rp1.c
index 30ab06b4cb75..9afe3706e624 100644
--- a/drivers/pwm/pwm-rp1.c
+++ b/drivers/pwm/pwm-rp1.c
@@ -38,6 +38,7 @@
  *   channel. As a result, phase control will be ignored for now.
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
@@ -49,6 +50,7 @@
 #include <linux/pwm.h>
 #include <linux/units.h>
 #include <linux/spinlock.h>
+#include <soc/bcm2835/raspberrypi-pwm-rp1.h>
 
 #define RP1_PWM_GLB_CTRL			0x000
 #define RP1_PWM_GLB_CTRL_CHANNEL_ENABLE(chan)	BIT(chan)
@@ -79,12 +81,16 @@ enum rp1_pwm_ctrl_mode {
 
 #define RP1_PWM_NUM_PWMS			4
 
+/* Channel whose phase register is used by the firmware to report the fan RPM */
+#define RP1_PWM_FAN_TACH_CHAN			2
+
 struct rp1_pwm {
 	void __iomem *base;
 	struct clk *clk;
 	unsigned long clk_rate;
 	bool clk_enabled;
 	spinlock_t lock; /* sync for RP1_PWM_GLB_CTRL RMW access */
+	struct auxiliary_device *fan_adev;
 };
 
 struct rp1_pwm_waveform {
@@ -286,6 +292,32 @@ static const struct pwm_ops rp1_pwm_ops = {
 	.write_waveform = rp1_pwm_write_waveform,
 };
 
+/**
+ * rp1_pwm_read_tachometer() - read the fan speed reported by the RP1 firmware
+ * @adev: the "fan" auxiliary device registered by this driver
+ * @rpm: where to store the fan speed, in RPM
+ *
+ * Meant to be called only by the driver bound to the auxiliary device
+ * created by rp1_pwm_probe(), which carries the controller private data as
+ * platform data. The auxiliary device is unregistered before the PWM
+ * controller resources are released, so that data is guaranteed to be
+ * valid for as long as the auxiliary driver is bound.
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int rp1_pwm_read_tachometer(struct auxiliary_device *adev, u32 *rpm)
+{
+	struct rp1_pwm *rp1 = dev_get_platdata(&adev->dev);
+
+	if (!rp1->clk_enabled)
+		return -EBUSY;
+
+	*rpm = readl(rp1->base + RP1_PWM_PHASE(RP1_PWM_FAN_TACH_CHAN));
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(rp1_pwm_read_tachometer, "RP1_PWM");
+
 static int rp1_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -347,8 +379,23 @@ static int rp1_pwm_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
+	/*
+	 * The fan tachometer is exposed to the hwmon subsystem through an
+	 * auxiliary device. The chip id is unique, so it is used to avoid
+	 * name clashes if more than one RP1 PWM controller is enabled.
+	 */
+	rp1->fan_adev = auxiliary_device_create(dev, KBUILD_MODNAME, "fan",
+						rp1, chip->id);
+	if (!rp1->fan_adev) {
+		ret = dev_err_probe(dev, -ENODEV,
+				    "Failed to register fan auxiliary device\n");
+		goto err_remove_chip;
+	}
+
 	return 0;
 
+err_remove_chip:
+	pwmchip_remove(chip);
 err_disable_clk:
 	clk_disable_unprepare(rp1->clk);
 
@@ -360,6 +407,8 @@ static void rp1_pwm_remove(struct platform_device *pdev)
 	struct pwm_chip *chip = platform_get_drvdata(pdev);
 	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
 
+	/* Unbind the fan driver before tearing down the PWM controller */
+	auxiliary_device_destroy(rp1->fan_adev);
 	pwmchip_remove(chip);
 
 	if (rp1->clk_enabled) {
diff --git a/include/soc/bcm2835/raspberrypi-pwm-rp1.h b/include/soc/bcm2835/raspberrypi-pwm-rp1.h
new file mode 100644
index 000000000000..290a052480bc
--- /dev/null
+++ b/include/soc/bcm2835/raspberrypi-pwm-rp1.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SOC_RASPBERRY_PWM_RP1_H__
+#define __SOC_RASPBERRY_PWM_RP1_H__
+
+#include <linux/types.h>
+
+struct auxiliary_device;
+
+int rp1_pwm_read_tachometer(struct auxiliary_device *adev, u32 *rpm);
+
+#endif /* __SOC_RASPBERRY_PWM_RP1_H__ */
-- 
2.51.0

