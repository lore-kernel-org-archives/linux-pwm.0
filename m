Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D53D79FB
	for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540446; cv=none; b=uStt2OrL5X/bfS7OZ+qZYyvjLVY3nldoz2W0Z8NV1on4MHFKsQ7SpZFKyKT9cNkDb+tMPQ1XZI6PH2MQHxqG+eLpU+5UkKqBZCIYBphSiZfG39vOT/Cq1ZBBZQ3j6ISOTWFpVfodJvL2FacCUCjqm+gFZOrfVUqAHTHUVk7z93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540446; c=relaxed/simple;
	bh=XBZjd0SYl2Y548z0ARMPGLiYpC3DE5EZ46YkWEKytGw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eQFQf6/vjDUjv0+7coOGX1I7pn6aleqWjadmBI0fM18hCaRgZAGzlxYtneMLTg0JkTpX446fOnXXDrLqaI4GXvURwpo/LVNGTbvK2Us0F9a22BRUJTTabxcqeMP8XxtvawZnk8QBx+KSTodSKnC4qrEKqnVfe50+Gnjgwh7dWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zgt/QY39; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zgt/QY39"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so8680455e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 02:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784540443; x=1785145243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3u1CwozotVn5LDWLD1V9wVLi4fj6wktLd2vv686ZRBI=;
        b=Zgt/QY39MVCzeqtKXFZQl4FMSThS16NZJpTvHtLRqAPcflNEMPEXHZIizv7+b5RU15
         HgdNSMUdOSiW1JdTSaODUvSZFhYeVeGDRMIDwA6IO7tQRF7EgtrVLC40xY4T+cWq8kov
         /msyeNOgOfdaKfsQLx+VgE7H5es5ZF8kojzHWYsqwSeGMsR1TG/5fupOE5mXh9MEj0fm
         0IhUi86lL6d7q2hWocKNYtwj155MF+ioUMlEpj/kArPLZq4tLdzKOVd2JWno1hShMrbc
         t1uyS/V6KhkJi4cwrsK6AEGGws7r5+Fs+NcAeqnx7SV4GiiIj4+cS7Kk6YYIEKVWcRnC
         +sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784540443; x=1785145243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3u1CwozotVn5LDWLD1V9wVLi4fj6wktLd2vv686ZRBI=;
        b=hJ+rB4E+AA+hmKuAHiq2OsN+CsY9MfBo7JKZURjZE78QefM4gwEWbcLsOrkVzopk2J
         mUrxOYUEnsGyzZGZwYqEWakQyWIlna86uBf8CQ9naB5Y/FiJnaElGfJBJ6gdVKobKI5/
         pc3ZNx8IHvgr2L1fJ8guCYRKLwMHDrGsMSaT0KIx29tyv4eC5JuPTYICaVy3ASaQGLs+
         wbXmUFedGEEWShgxTejqfpd1PpLRYtuz7SIz93KgtAGWu+msJEAfD9VX9eq21DX+P+1l
         BH8qn0fczlpO+FB9n8varno3L4gIHVGZDEF0P+wmnBXSuvjp/kouW/YgawklSBj7qjO9
         cA7g==
X-Forwarded-Encrypted: i=1; AHgh+Ro+CUrqfD7I721g3JDOfJkSQWKR1D26G2vJBXqP/tosqX1tFTKiaEOGvnN+GK9rycX8rumdbExsKF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuQG1HvcF5GuVSLwgF9WldGb+d3bXXyKl/gb004jf4N44geqr
	7znP1p/WwJ/GtC2W9gSoG83TExfW5JiDZnsz3/IEaWmEEWQg5KUdng/JioLzwALlbCg=
X-Gm-Gg: AfdE7cl/yBQhh20XcPsVMpQzVQ5srThdzzGO22uIPrsoLspIT7+HZUSqcyHhFLKk/6I
	HIam+rGyiJznQ2BXCXKMAm3Mg+IP6nnEVmmIutqzO4smZiJMqPYNS8riJRNqfWZ6WsbYX5Rh3Bi
	HSkpfdXnG0lQC0JPLS6xL6Mt+oPOESTyMdF6uE7ubsCAZbvT1hCAumOwZiHbNqSMswRC8u65SCm
	pRP9N7bh5ZPUnLVTB89W7PbVxIPjJU9sfkGVev3gM1qR/P+4QrbdpwnM3yB83TKikxnG9d+TISs
	hkx2M9sl3vEiGEF8RuCCOMfpQkBDkg2EmK0fAQtouPr1qLn9xYQSUpsQzIYS3oXkAF8PIaxeMjv
	z94MYv5peR/LnNjp/JumfwzWvHAYJtO2zg185ImWX7foSYi8uIaKbRjb5oE1enolrEYrQIlivbZ
	cpGMULN5BIYw0=
X-Received: by 2002:a05:600c:4585:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-4954a50b811mr138696825e9.26.1784540443117;
        Mon, 20 Jul 2026 02:40:43 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49563969482sm15082875e9.3.2026.07.20.02.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:40:42 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	mbrugger@suse.com,
	Sean Young <sean@mess.org>,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v7 0/3] Add RP1 PWM controller support
Date: Mon, 20 Jul 2026 11:44:04 +0200
Message-ID: <cover.1784539788.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for the PWM controller found on the
Raspberry Pi RP1 southbridge. This is necessary to operate the
cooling fan connected to one of the PWM channels.

The tachometer pin for the fan speed is managed by the firmware 
running on the RP1's M-core. It uses the PHASE2 register
to report the RPM, which is then exported by this driver via
syscon registers. A subsequent patch will add a new device
and driver to read the RPM and export this value via hwmon.
 
Subsequent patches will also add the CPU thermal zone, which
acts as a consumer of the PWM device.

Best regards,
Andrea

CHANGES in V7:

- _tohw(): use *wfhw = (typeof(*wfhw)){...} to initialize the
  structure in the disable case 
- _tohw(): fixed the offset_ticks calculation
- _fromhw(): fixed a rounding error in the duty_offset_ns calculation
- _write_waveform(): dropped the goto in favor of return in diasble
  channel exit path
- _read_waveform(): use *wfhw = (typeof(*wfhw)){...} to initialize
  the structure in the disable case
- dropped rp1_pwm_remove() since this driver depends on syscon
  and cannot be removed/unbound (added a comment to explain that)

Naushir Patuck (2):
  dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
  pwm: rp1: Add RP1 PWM controller driver

Stanimir Varbanov (1):
  arm64: dts: broadcom: rpi-5: Add RP1 PWM node

 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     |  66 +++
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  12 +
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi  |   9 +
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rp1.c                         | 428 ++++++++++++++++++
 6 files changed, 525 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-rp1.c

-- 
2.35.3

