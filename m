Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616888;
	b=4J4O9NRJhW/wnnUYFmAFdzAZE3R5QIMkfA4NpLwe9hrOeox5SfUEvqXZYHgG85WwpXjc
	 CM0WUXBaDAj6cKnoiqTf/ti039AY53cv1B61RBdclor/uU87zczeznSubsTkIFUqRo2mJ
	 T/E07fs4rHtVfBN8q94XwJVdLn0rONTDTm+xrvrvypI6eSS6q9TL8USkgMjZk1/8iiooB
	 JE4tnyDXYn99kQZJ2dYQQuEtl1mQ6M5Ct3oOBrszHe2/NXXp4MJb8ZL+Sm58mmsNC1XIU
	 Oyyw6TsgcDscjooSXugL66B0em0mxKbgS6rrEtJ9+Ulyw1njFHSq6RCRHl13OwSpdEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616888;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ubR51sJIgjaGpPQCtAU7WY1fpXIi71PfU/onh0h78YA=;
	b=5ZvSeH6MGiTRi/1pJApgpRIQjG/RGnfWIdQTixotugpt/AYbZSlSnry0TLThovngC+Jg
	 YwCZAlH46iIRorWDBxCQuOXWg/5Ii27BuRZFRuRzbF1Zv0j99WShStSGLBE9lLh9BgKPV
	 d3OT57bELkUQ0aNgctkFBVkDVVy38oQQ7WNRrMs3Sipam1+QAUJK0t+KQUxGFHzLBJ+J3
	 uWIHob0+kHN8HZNkApL5Qg3CL1uRvuLMTUcfXrPaLu8UN58DivK5wQnISw3c1d5Buuzrv
	 UxOsQS7UQMlr5w3gyXLTKYmzYgtAf9HU/Kb4s2PNswREiA0528IrK+jaB02WBPV3fnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dsg.is;
	spf=pass smtp.mailfrom=dsg.is;
	dkim=pass header.d=dsg.is header.i=@dsg.is header.a=rsa-sha256 header.s=protonmail2 header.b=kK3J4nak;
	arc=none smtp.remote-ip=79.135.106.113
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C8606A882;
	Sat, 14 Nov 2026 00:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 965C8606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dsg.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dsg.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dsg.is header.i=@dsg.is header.a=rsa-sha256 header.s=protonmail2 header.b=kK3J4nak
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dsg.is;
	s=protonmail2; t=1794616882; x=1794876082;
	bh=ubR51sJIgjaGpPQCtAU7WY1fpXIi71PfU/onh0h78YA=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kK3J4nakU/xCtmMNwlYioFGI9Grfd+Bu/LX7Wiftjkun7/MbcjLE4on61F5mC3Wlv
	 fBXZCH2jomktnkjdedFr+6qoX+n4/qBDjn1wfeG9K6uVMXeHuPsKjpWggWSbtkrjD4
	 HpGj0DhH9dpT1gI0i2E98UuapxSm2xKlTTqp0Tq5fJhz8EbQnlFBTbmxaIaBxXCEAy
	 9nxUXmIleBLZQRs5ph028fyYmidElLRvxqeer6uIdmk9JCmXx/2BeKlUMIk44rEROK
	 yD6sAyWLCBzFawy6zcB7fDkfPkMkUSz5mCfoWVc/t/7WNFtPZ18o2xD2UvFCGLucas
	 tpD/Xaknepurg==
X-Pm-Submission-Id: 4jRFg30gVpz2ScQ9
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
Subject: [PATCH 0/4] hwmon: (adt7475) Add thermal sensor and PWM provider support
Date: Sat, 14 Nov 2026 00:41:06 +0000
Message-ID: <20261114004110.328050-1-david@dsg.is>
X-Mailer: git-send-email 2.56.0
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


This series lets boards use the temperature channels of the ADT7473,
ADT7475, ADT7476 and ADT7490 as thermal zone sensors, and drive their
PWM outputs with a PWM consumer such as pwm-fan. The kernel thermal
framework can then control the fans. It follows the ADT7470 series [1],
merged for v7.3.

The board it is for is the Ubiquiti UniFi USW Pro XG 8 PoE, a switch
with a Realtek RTL9313 (MIPS) SoC. Its ADT7475 drives both fans and
reads the CPU and SFP area temperatures. The fans must also follow
eight PHY temperatures that the ADT7475 cannot read, so the chip's
automatic mode does not fit.

Patch 1 adds "#thermal-sensor-cells" to the binding. Patch 2 converts
the driver to hwmon_device_register_with_info(), through which the
hwmon core registers thermal sensors. Patch 3 registers them. Patch 4
registers a PWM chip when the node has "#pwm-cells".

Differences from ADT7470:
- While a PWM consumer holds a channel, writes to that channel's hwmon
  PWM attributes fail with -EBUSY. ADT7470 hides its PWM attributes
  when "#pwm-cells" is present. The ADT7475 binding has documented
  "#pwm-cells" for fan-N children since v6.12, and device trees that
  follow it must keep their attributes. If preferred, the attributes
  could instead be hidden when "#pwm-cells" is present and there are
  no fan-N children.
- The period of each supported frequency is 1 s divided by the
  frequency, rounded down, so the 44444 ns the binding documents
  selects 22.5 kHz exactly. ADT7470 rounds up.
- No warning about "#pwm-cells" without CONFIG_PWM, because fan-N
  children use the property too.

duty_offset_ns is ignored: the chip has no offset, and 0 is the
round-down result for any requested offset.

Testing on hwmon-next, the base of this series:
- checkpatch.pl --strict and dt_binding_check are clean. W=1 builds of
  adt7475.o after each patch, with CONFIG_PWM and CONFIG_THERMAL_OF
  each on and off, give no warnings. sparse reports nothing for
  adt7475.c, and the hwmon htmldocs build gives no warning for
  adt7475.rst.
- x86_64 QEMU guest with i2c-stub, all four chip types, five register
  images each: the attribute list, every value read and written, and
  the final register contents are identical before and after patch 2,
  apart from the two -ERANGE cases its message lists. The same
  comparison between patches 3 and 4, with and without "#pwm-cells"
  and with no PWM consumer, is identical too.
- The same guest with PWM_DEBUG and PROVE_LOCKING runs the PWM sysfs
  interface and pwm-fan as consumers, including unbinding the chip
  under them. No PWM core or lockdep warning.

Testing on hardware, on the switch above running OpenWrt with this
series backported to 6.18. The backported driver differs from this
series only where 6.18 and hwmon-next differ:
- Ten thermal zones (the ADT7475's two remote channels and the eight
  PHYs) drive both fans through pwm-fan at 22.5 kHz. The fan curve
  was stepped through with emul_temp on three zones, and the first
  trip on the other seven; fan state and duty registers matched the
  expected values.
- Unloading and reloading pwm-fan and adt7475: the fans stay at full
  speed while pwm-fan is unloaded, and thermal control resumes after
  the reload.
- Writes to the hwmon attributes of the held channels return -EBUSY
  and leave the registers unchanged; pwm3 stays writable.
The hwmon-next version itself has not run on hardware.

This patch was written with Claude Code, using the models Claude
Opus 5.5 and Claude Fable 5.2. They wrote the code and the initial
commit message draft, which I cleaned up. I directed the design,
reviewed the result, compared against the datasheet as far as I
could, and ran tests including on actual hardware.

Davíð Steinn Geirsson (4):
  dt-bindings: hwmon: adt7475: Add #thermal-sensor-cells
  hwmon: (adt7475) Convert to hwmon_device_register_with_info()
  hwmon: (adt7475) Add thermal zone sensor support
  hwmon: (adt7475) Expose fan control via PWM framework

 .../devicetree/bindings/hwmon/adt7475.yaml    |   16 +
 Documentation/hwmon/adt7475.rst               |   18 +
 drivers/hwmon/adt7475.c                       | 1266 ++++++++++-------
 3 files changed, 809 insertions(+), 491 deletions(-)


base-commit: f9f5501d60c77c71f60bf5b273375e3777d66080
-- 
2.56.0

