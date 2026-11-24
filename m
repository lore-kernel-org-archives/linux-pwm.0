Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541720;
	b=r5FwtNxEM57DyOT5K+9o2pBDPjLVmKrfLKsw2FW5NeGJaOhIrnsnK08NyBPzrIrs37zv
	 tcz3e1n/AYEm75kuj04fqE4YPD/VyHLOHug2l9LMPPXECWlrnN/fEB9iAMuJvURIBVTWK
	 F62QXuhRH+3bjalwIsM6/5fYyOgL339ihN+3w4xhJVACN91i0rQNEKhLwvcmZnMA6JpQG
	 wuMjCP3qhdqwnTgvd7baM1ZM4tXi4pFUNJkEjesrrvT75cEkHDxXGP/mKFeWCaheiEjsN
	 lRPdc1pVeS5FaX3UoqNuuH1we6EYpUtOWv6SeJQ7mCWPtD16qSkiSFf9yX9rFhbZyCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l0LEHthhhZRejZwuG3VyXNFXNWhsNskJajjPoPmUNCU=;
	b=XKGdoIheRXBUW8Os9bZjOfzleCNVYjEx4wy7J1jvxPgT7SPiHdVakxGgXovl78Lcc4KG
	 361D3fr7S6L96rZINlJKde0iwmzJdi/qgd6A8aLn80DnoqAStY7ufaOMxEivsK0ggG3z/
	 9Y9b49gDmWuu+okN8pYS2aPAGuEp3k70JiP1tjfLgeveQK94CEljIHuI/I2GFo4u5KU4v
	 Mg3FkOfMRPRAGrgiA8JfoHBzUWSPTGTHRtjVK6wKE/S6gmU1mMY9LKrEcviFScbS9+Wpu
	 w8kEIXIPkM3uBYCrX2kgHKYhe+KUvLWtuWPOs44PEb2xswW8/ocYycjJXbQd7RyBhtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JXuQnV0h;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39541606A339
	for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2026 17:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39541606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JXuQnV0h
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so30947535e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2026 09:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795541719; x=1796146519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0LEHthhhZRejZwuG3VyXNFXNWhsNskJajjPoPmUNCU=;
        b=JXuQnV0hcXVJJOzI8OOKGAK1D106+tf42dJm/p5QcmU+NkdTcwy/KCVRZOpzUIaU81
         BdPOP5W9NmlcfZzoIsU2TPqnceWHESBWiDH6IKMgRc58dI8ko7gv/1zU8oeatjWYiRrf
         wAHvu0Y90UWdPy9TQRiQC6OAL7LyHVft37yWZunC7Sxtt4QLeMPCSAKLhLa6qnj+B38f
         cCIFlZFat2axUOrTCa6N9a8IW/URU/jyFgnL4KSUQc9aXyTJn/wdZZofYc4cD4RqHEbb
         yoxtojarjgTYWI9/KKke4BK9BIBJoXXqnlIP8HnHoqye1zU3sXZRmaN+0OVcwSxfI8es
         KoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541719; x=1796146519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0LEHthhhZRejZwuG3VyXNFXNWhsNskJajjPoPmUNCU=;
        b=01YiuyOha8IQ6xaRqhG5Ou12DhFQxfFfHiRqdpaFvL3cDWxA24NM/Mk0vz3FPO9D8e
         EewYXfLjL2dbq/QdTtdS2ioZiHL8EMBxUzSZnjH6rKOH8kIiOZ1zqs+4Scb8iq948gS1
         n+7dxuFJHBV1ioJAgYqVRnnCCyK+F844XslnOiecsy5FumZSMr9Xh5MHxRSDyGy9uGck
         p1fx6VmIPPbtgWF8nfaS4Nc6cin0RPQHBgcg3oMV3GT4WsY3YT8Sa4oOFDCVBI+yuImj
         gKq0E4rvM+kJ5GBZZ+2A3oWqEtYV3xcCGbl57NpmE03nnxE5N09DOaa6IA4RKkUpleYR
         Clyg==
X-Forwarded-Encrypted: i=1; AL+hErEFr1OWIQTSy+dECn1z3aHOD5+aKlx5ac9IMg83/Nu+2hrvElaALzHl3aAYaBlSaGzM09UlKbDe/cA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MCdqvdv4S4BWetAHuP3bRHdBBrHifNUsjumBkarlGpB+6eCFY
	PWAef66vdKcHzDtYwv+ciImWazi0k1JuhFsAAFcIb+kPrOGfUw9L+JlsG0s7jP8Fitk=
X-Gm-Gg: AZFdTZfz1M0P6UxWT5NlR6WrBxWUpY+vbAenKUDI71/JrLtUJKBWT42Bl6nrqV8zvPj
	GG4cflHVH04tXM6ohO7uQLMQQzRd4/8gGcH/8KZBdeH9RfugHU2ZgfbaiI55z9yTqsSHJhkxW7e
	UDwZ0UVGLTWoZK7XZtVQbEtD8kDUuOSIU0a4Q/JLdFQRC9NQeBRew+mMNp8OrF7NAZamHePooe2
	8LSswxaKGAZHCuhZLp5RwNS88SwAxyOiikHCYTuhrapDmSApEd+QSCbmrNcoe6iV5SeiQgLVDXR
	kCS52kg2KrXSOjvNBH0q4jCnfzb9vJt80GUWtqvHFoIA+K9YAe6R5XZqfpKCkEkHYIwE+9PF13z
	97NxPCQ5Y7EfNKid6dyRYWh/QQXgYvakbKOehMurKVxIYQ8r5ygVZiWASC1vGJK7DqGVoya2xVC
	RV1u4+o+6O78ZLyIYTCuX6FoJzBj2egmEdKEPf5Y7UACrKtgWvva9rKvfjWX73IB7rFmYNi7g8M
	WDGSQlLu2IZGjQXC5GB6abIdJG7kpKC/5H/m3YXojndJvFRrmRM6+SvUWn4mIiYp54TZnpnD4HD
	UFwThXTMwmtusDwtGzJLnYTqtVs=
X-Received: by 2002:a05:600c:5303:b0:4ba:4928:8aec with SMTP id 5b1f17b1804b1-4bb88807d7cmr297533605e9.9.1795541718663;
        Tue, 24 Nov 2026 09:35:18 -0800 (PST)
Received: from localhost ([82.192.120.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8d4f9aa8sm410773215e9.4.2026.11.24.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:35:18 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Gary Guo <gary@garyguo.net>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 1/1] hwmon: Add driver for Raspberry Pi RP1 fan tachometer
Date: Tue, 24 Nov 2026 18:39:00 +0100
Message-ID: <20261124173900.31266-2-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261124173900.31266-1-andrea.porta@suse.com>
References: <20261124173900.31266-1-andrea.porta@suse.com>
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

Add a hardware monitoring driver to support the fan tachometer on the
Raspberry Pi RP1 southbridge, found on the Raspberry Pi 5.

The RP1 PWM controller block contains an MMIO register that holds the
current fan speed in RPM. This register is periodically updated by the
RP1 internal firmware based on the tachometer pulses.

The RP1 PWM driver registers a "fan" auxiliary device for the
tachometer. This driver binds to it as an auxiliary driver and reads
the RPM value through rp1_pwm_read_tachometer(), exported by the PWM
driver in the 'RP1_PWM' symbol namespace. Since the auxiliary device is
a child of the PWM controller, no Device Tree node is needed and the
lifetime of this driver is bound to the one of the PWM controller.

Provides the standard hwmon sysfs attribute 'fan1_input'.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/hwmon/index.rst   |  1 +
 Documentation/hwmon/rp1-fan.rst | 43 ++++++++++++++++++
 MAINTAINERS                     |  7 +++
 drivers/hwmon/Kconfig           | 11 +++++
 drivers/hwmon/Makefile          |  1 +
 drivers/hwmon/rp1-hwmon.c       | 78 +++++++++++++++++++++++++++++++++
 6 files changed, 141 insertions(+)
 create mode 100644 Documentation/hwmon/rp1-fan.rst
 create mode 100644 drivers/hwmon/rp1-hwmon.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 199ca79621e9..2d81cf3b46ff 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -240,6 +240,7 @@ Hardware Monitoring Kernel Drivers
    q54sj108a2
    qnap-mcu-hwmon
    raspberrypi-hwmon
+   rp1-fan
    sbrmi
    sbtsi_temp
    sch5627
diff --git a/Documentation/hwmon/rp1-fan.rst b/Documentation/hwmon/rp1-fan.rst
new file mode 100644
index 000000000000..d345551306d8
--- /dev/null
+++ b/Documentation/hwmon/rp1-fan.rst
@@ -0,0 +1,43 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Raspberry Pi RP1 fan tachometer
+=======================================
+
+Supported chips:
+
+ * Raspberry Pi RP1
+
+   Prefix: 'rp1_fan'
+
+   Addresses scanned: -
+
+   Datasheet: not public
+
+Author: Andrea della Porta <andrea.porta@suse.com>
+
+Description
+-----------
+
+The Raspberry Pi RP1 is a multi-function I/O controller (southbridge) used
+on boards such as the Raspberry Pi 5. Among its peripherals, the RP1 includes
+a PWM controller responsible for fan control.
+
+In addition to standard PWM output, the RP1 provides fan speed monitoring
+(tachometer). The tachometer pulse measurement is performed internally by
+firmware running on the RP1 Cortex-M microcontroller core. The computed fan
+speed (RPM) is periodically updated by the firmware directly into dedicated
+MMIO registers located within the RP1 PWM block.
+
+The RP1 PWM controller driver registers an auxiliary device (pwm_rp1.fan.<id>)
+for the tachometer. This driver binds to that auxiliary device, reads the
+firmware-updated register through the PWM driver and exposes the fan speed as
+standard hwmon sysfs attributes. No dedicated Device Tree node is required.
+
+Sysfs entries
+-------------
+
+The following attributes are supported.
+
+======================= ========================================================
+fan1_input              fan tachometer speed in RPM (RO)
+======================= ========================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 26f8520c02ee..f4d011630389 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23368,6 +23368,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
 F:	drivers/media/platform/raspberrypi/rp1-cfe/
 
+RASPBERRY PI RP1 FAN TACHOMETER DRIVER
+M:	Andrea della Porta <andrea.porta@suse.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/rp1-fan.rst
+F:	drivers/hwmon/rp1-hwmon.c
+
 RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 18c682e1a475..c668b1f458b5 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2020,6 +2020,17 @@ config SENSORS_RASPBERRYPI_HWMON
 	  This driver can also be built as a module. If so, the module
 	  will be called raspberrypi-hwmon.
 
+config SENSORS_RP1_FAN
+	tristate "Raspberry Pi RP1 PWM Fan Support"
+	depends on PWM_RASPBERRYPI_RP1
+	help
+	  If you say yes here you get support for reading the fan tachometer
+	  from Raspberry Pi RP1. The driver binds to the auxiliary device
+	  registered by the RP1 PWM controller driver.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rp1-hwmon.
+
 config SENSORS_SL28CPLD
 	tristate "Kontron sl28cpld hardware monitoring driver"
 	depends on MFD_SL28CPLD || COMPILE_TEST
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d4c345ed7261..5c5ffc900a12 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -211,6 +211,7 @@ obj-$(CONFIG_SENSORS_PT5161L)	+= pt5161l.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
 obj-$(CONFIG_SENSORS_QNAP_MCU_HWMON)	+= qnap-mcu-hwmon.o
 obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
+obj-$(CONFIG_SENSORS_RP1_FAN)	+= rp1-hwmon.o
 obj-$(CONFIG_SENSORS_SBTSI)	+= sbtsi_temp.o
 obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
 obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
diff --git a/drivers/hwmon/rp1-hwmon.c b/drivers/hwmon/rp1-hwmon.c
new file mode 100644
index 000000000000..473e6c95f638
--- /dev/null
+++ b/drivers/hwmon/rp1-hwmon.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hardware monitoring fan driver for Raspberry Pi RP1
+ *
+ * The fan speed is measured by the RP1 firmware and reported through a
+ * register of the RP1 PWM controller. The PWM driver registers a "fan"
+ * auxiliary device which this driver binds to.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <soc/bcm2835/raspberrypi-pwm-rp1.h>
+
+static int rp1_fan_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct auxiliary_device *adev = dev_get_drvdata(dev);
+	u32 rpm;
+	int ret;
+
+	if (type != hwmon_fan || attr != hwmon_fan_input)
+		return -EOPNOTSUPP;
+
+	ret = rp1_pwm_read_tachometer(adev, &rpm);
+	if (ret)
+		return ret;
+
+	*val = rpm;
+
+	return 0;
+}
+
+static const struct hwmon_channel_info * const rp1_fan_info[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops rp1_fan_hwmon_ops = {
+	.visible = 0444,
+	.read = rp1_fan_read,
+};
+
+static const struct hwmon_chip_info rp1_fan_chip_info = {
+	.ops = &rp1_fan_hwmon_ops,
+	.info = rp1_fan_info,
+};
+
+static int rp1_fan_probe(struct auxiliary_device *adev,
+			 const struct auxiliary_device_id *id)
+{
+	struct device *hwmon_dev;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&adev->dev, "rp1_fan",
+							 adev,
+							 &rp1_fan_chip_info,
+							 NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct auxiliary_device_id rp1_fan_ids[] = {
+	{ .name = "pwm_rp1.fan" },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, rp1_fan_ids);
+
+static struct auxiliary_driver rp1_fan_driver = {
+	.probe = rp1_fan_probe,
+	.id_table = rp1_fan_ids,
+};
+module_auxiliary_driver(rp1_fan_driver);
+
+MODULE_AUTHOR("Andrea della Porta <andrea.porta@suse.com>");
+MODULE_DESCRIPTION("Raspberry Pi RP1 HWMon Fan Driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("RP1_PWM");
-- 
2.51.0

