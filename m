Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616898;
	b=ak/KWDtW16dC8gvuTpnTsm3Y1v9vMtooy/iinfZTy886YVrTAUdEz4GF85UN18jetG/a
	 ocrb4O+BfDdT1F3MPjVXdXOhe+A8k+GkS34HrgNdRXdnDh4UtgqrpC3QqqWcrAyTnRtUV
	 DH6w6dfUHcrCpfmWzSM3gEVZ4KoHuRv/bqyMXpsunes5DSO7xOkF5J24GUzKSwf8j4WAb
	 ntwr4AqLNLlxAFUaZ0L0B3+M17cecsL8M0OByhopTAelA+YKT6JyCwUEw9lMEkUFvyThL
	 Gm3ZkUo6h8SscIiZcCwaLd/xI6tIYYGYGLbOeV3oX5c3zlCYkNc9bGndXf72WJDVdug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616898;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=GdIXmv+X3wjcWU15UyUJ03l3PeprFXiEbY09WCu6xJM=;
	b=ZBSmOxaj2KDtcfNoidZl5FeK9DKOPvMHjgxtEye3kLupBY1ELQG56CFYmp2jckPfLlEY
	 E5o+GujWV+ulxqC8LN/deow4QbJtc52CCZ4SpPinCW/r2JPN6kVyTG+XeJ4Euh+Q1XgHS
	 0yTt/75hTgrdg9LDDkeJMZItDTMqMQoPmoa3z9SgOXzKeIvVafuoYSJdY6Ej3ckAZqmRD
	 nVRMoRfhFumvYEBdAYXXdvtMZi1k+3vRt0ouJiI3Hqx0XFiz5iDwJXEb2i1fAmhWkd9Np
	 eoGhrVOJ6pWa+kDUN/j4KRq5IBk5Irp0WQZOTDW99PbntJYslIXPucQVj4TIfB6gFgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dsg.is;
	spf=pass smtp.mailfrom=dsg.is;
	dkim=pass header.d=dsg.is header.i=@dsg.is header.a=rsa-sha256 header.s=protonmail2 header.b="Rg/5cybm";
	arc=none smtp.remote-ip=79.135.106.112
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE8606A8A7;
	Sat, 14 Nov 2026 00:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CDE8606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dsg.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dsg.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dsg.is header.i=@dsg.is header.a=rsa-sha256 header.s=protonmail2 header.b=Rg/5cybm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dsg.is;
	s=protonmail2; t=1794616894; x=1794876094;
	bh=GdIXmv+X3wjcWU15UyUJ03l3PeprFXiEbY09WCu6xJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Rg/5cybm7kZjoyO+4L4Of52FHggrHLXP8ae1GOOZtGsnbHphy21pTK1K5qdpZ7szA
	 x5HAmt2UYVIGzb1pxNoSugxsP0wELKdF/AV6/qHPTE3s/2M/FGobS9QHqLbnJACYu5
	 b1n89Y+BBHaD5tYEiKo4DLZcrL7DliEdpDdMhbuIxB5N7k3N6iml/vYd8YkkAsx1NB
	 gWrF3vd6ReKJoMPV6+Jk0EvnKeIyN33QNbi+6seQXlUbrf1juPawBY4wgEgQkoecqq
	 zrRLaZcLBbnRvgylMb9BrAXm2Ojd60gEntsoxSSRqP2mH4vKMDCy2eU2p5y6hxXauo
	 kLr9on0lt4JLA==
X-Pm-Submission-Id: 4jRFgH4nfsz2ScQ6
From: =?UTF-8?q?Dav=C3=AD=C3=B0=20Steinn=20Geirsson?= <david@dsg.is>
To: Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Dav=C3=AD=C3=B0=20Steinn=20Geirsson?= <david@dsg.is>
Subject: [PATCH 3/4] hwmon: (adt7475) Add thermal zone sensor support
Date: Sat, 14 Nov 2026 00:41:09 +0000
Message-ID: <20261114004110.328050-4-david@dsg.is>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114004110.328050-1-david@dsg.is>
References: <20261114004110.328050-1-david@dsg.is>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Register the temperature channels as thermal zone sensors. Sensor id N
is temperature channel N, i.e. temp(N+1). Document this in adt7475.rst.

The hwmon core reads a sensor's temperature while registering the
thermal zone, from within hwmon_device_register_with_info(). Read the
chip limits before registering, so that the temperature encoding
(CONFIG5 two's complement bit) is known for that first read.

With CONFIG_THERMAL_OF, devices that have a devicetree node, or sit
below one (the hwmon core uses the nearest ancestor's node), see two
changes:
- Each temperature channel that no thermal zone uses logs
  "tempN_input not attached to any thermal zone" once at probe.
- When a thermal zone uses a channel, the hwmon core sets that
  channel's min and max limit registers to the zone's current trip
  window, as it does for other drivers registering thermal sensors.

Signed-off-by: Davíð Steinn Geirsson <david@dsg.is>
---
This patch was written with Claude Code, using the models Claude
Opus 5.5 and Claude Fable 5.2. They wrote the code and the initial
commit message draft, which I cleaned up. I directed the design,
reviewed the result, compared against the datasheet as far as I
could, and ran tests including on actual hardware.

 Documentation/hwmon/adt7475.rst |  3 +++
 drivers/hwmon/adt7475.c         | 17 ++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/adt7475.rst b/Documentation/hwmon/adt7475.rst
index f90f769d82d6..b5976e3ff3d4 100644
--- a/Documentation/hwmon/adt7475.rst
+++ b/Documentation/hwmon/adt7475.rst
@@ -118,6 +118,9 @@ with a resolution of 0.25 degree Celsius. Temperature readings can be
 configured either for two's complement format or "Offset 64" format,
 wherein 64 is subtracted from the raw value to get the temperature value.
 
+With ``#thermal-sensor-cells = <1>`` in the device node, thermal sensor id N
+is temperature channel N, reported as temp(N+1).
+
 The datasheet is very detailed and describes a procedure for determining
 an optimal configuration for the automatic PWM control.
 
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index d5bdb8011e6d..73c19c10bb34 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1243,6 +1243,9 @@ static const struct hwmon_ops adt7475_hwmon_ops = {
 				 HWMON_PWM_FREQ | HWMON_PWM_AUTO_CHANNELS_TEMP)
 
 static const struct hwmon_channel_info * const adt7475_info[] = {
+	/* The hwmon core only looks for HWMON_C_REGISTER_TZ in info[0] */
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(in,
 			   ADT7475_IN_CONFIG,	/* in0: +2.5V */
 			   ADT7475_IN_CONFIG,	/* in1: Vccp */
@@ -1928,6 +1931,15 @@ static int adt7475_probe(struct i2c_client *client)
 		break;
 	}
 
+	/*
+	 * Read the limits and settings once, before registering: the hwmon
+	 * core reads the thermal sensors while registering, and that needs
+	 * the temperature encoding from CONFIG5.
+	 */
+	ret = adt7475_update_limits(client);
+	if (ret)
+		return ret;
+
 	data->groups[group_num++] = &adt7475_attr_group;
 
 	/* Features that can be disabled individually */
@@ -1966,11 +1978,6 @@ static int adt7475_probe(struct i2c_client *client)
 			 (data->bypass_attn & (1 << 3)) ? " in3" : "",
 			 (data->bypass_attn & (1 << 4)) ? " in4" : "");
 
-	/* Limits and settings, should never change update more than once */
-	ret = adt7475_update_limits(client);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
-- 
2.56.0

