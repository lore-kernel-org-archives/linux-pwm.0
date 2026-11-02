Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650483;
	b=PGh1QhgPPE8x2j1W2IUKB4n4mbj3TPPZE26ClWQnuo04ELsdb09c8E0nYKz9zx9jfH3J
	 ky+RrTHxpkamLrUjW/pYuGt3mgbJebmzHFZnFEbz2yEcbfWkPu2NIUmSxf/BAcjq4gF+Y
	 tjwBCWoyLuXK3Mvg3Qys29mKEDQOacL36GpoMjSD9BHqhVjsCSezOhvJZiJUN5TcQMixd
	 5gvRfzXlgOgLe10BIJu2dGczKTOlpr5A6G446SVuJbnYB64YxALCDTeHAx3SPRHrCmL0f
	 MDXKBFxrY4YTmVrVN874md7eVAWGozC0W2Qp8Hpo6by9wZzK6DTk9Iatgrb46cuVO/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F0qZYx4u9TnnDtbB9BjrJLHvlePNA0vWLxRrEccaJmo=;
	b=PB+3Ctm1u4BBIDByxlV7QPuFruC4t/keeMWMPq1OHdi/8hjsDW5qB2t+IJ+8dDc0PKHM
	 yowTrGH29ia8Nkl9uI8DoZHjC96MawRiKCrcuS/4Mj1aC46RBGPPCOZuHzRCqRNonfrsz
	 XAUsjhl3bQDgoY/P9omEwdfsky3cy+yGs2QgND/FLnjpOQz57rk4/NhIJd+JJR6OmtBIu
	 t8rLn/b+q1uB6d1CpXf8jnWrBcgvVWkPm93/NgXdn+67L6lxmqiU+HWDnggQukMNnTWCm
	 sfpArhn3lYaGX9BVzkApUFA7IdagEUDd40wajCLiVo7onxf04UywwW/IsVdRa7ZTOOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IjKNJDCO;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8481606A32D
	for <linux-pwm@vger.kernel.org>; Mon,  2 Nov 2026 20:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8481606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IjKNJDCO
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso34618475e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 02 Nov 2026 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793650481; x=1794255281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0qZYx4u9TnnDtbB9BjrJLHvlePNA0vWLxRrEccaJmo=;
        b=IjKNJDCON19xI91iHAVMwQ8G7AwpxC0FK6cKznlFx6cWtYq7fTjlvk3Ke7zCyx8kUH
         9QHFxgj+D8pmwYFdgq6ony1+OhXTDeKl/mRabgy8cpmzqWcylwrTUzbuRHVJXAlx2G0F
         ymtUebS4VY0isduE6A1dQ0cmjQW5/8YKDwUBdm0JakV+tRu1GKzDZMbO2HjCHPbrZZBg
         dhUSHov+FkHN20xnyvQYLY2v0aPDcOe1LwCiXf7RkRQ1ikWreKJbKDiajhjWh9SgVhIZ
         QjoNdcXmZiVnu5EGKPhLM7yXA6hr8f4xmvG+IkZKmW/JQM6H2XbCzOVBRTtG1ArfHN7A
         W0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650481; x=1794255281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0qZYx4u9TnnDtbB9BjrJLHvlePNA0vWLxRrEccaJmo=;
        b=yiu9+e5Ff2hcsXtUvN/zNDaQ2w2HPSeVhCF+RfIusLO5Dvwg2QLhwEO4G5wi8t7BrE
         PS/NYFa2NKE19hZuzLhC9qivNobub5Q2v4IphHDe60Lk71bjjGPVLfnHnBEYyAufmtAu
         dBJFR/LStZytuPEBrPoUapA1ml7DtghTgMjMe7Qb3CPf2J8vSUbZ2wmOTEJhMiIxs77i
         MDT879i42YO6oMPeqakSiL0Lagksq76Eq/Myu3hU0SF7Ff+R+dFJSxmOI5vPaSEOttpY
         Gj5e2arPqHSJ0uYDCF2yRt5vowaQziJk//H10I6ezwse43nBpbs1RqUKNl67rx3pIlap
         9Q9g==
X-Forwarded-Encrypted: i=1; AKwUvBxSsr8NRqM0qs4S+C6XRgfYXq6+gHR5yeSGZbPkHbe0TSMnu1cV0Cyq3EpjgYintvFtdPGI8+0ZnAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJK8Y8UUPFrAmcifoCPZR7w9MDxUHPlyr3Nfodl2BKv4g+Pwr0O
	ulnxIHi5R/Vtm8WkwS/WIQOtb14b8WSeUBfhz9vws6QRLHAQ9Gr01F62m7/Uj/O2/9E=
X-Gm-Gg: AYBFou24EJsASOp13Y5FrQJ7qFMI3fQJOX8gPDOXekl/inrAP+l91CcIxn5SYdejNG2
	nmPFsL96V6ZaWAXR4cCXqB8UdWQZfgoH6AYGvyb6o9RYbfYNJjY2NW4ogLGmpYKzN6a95iF/Ogh
	gF4NKgkYd97qHV7V0odXT0CiSe9xO/FLep/EgZA7XSpwQWh/hId2CPyEII/Svdwku3WSggu9F9W
	fhx1B8+mwhyfDZDEqMILJN0L6uLK2Keint6n8TwbdAUPN+Bxr5/r8ICBn4TGcIxfOR32PVtlFsr
	rEmwWxkDjCpiqWUdnHaLzA6IWVh1XbuGMJhCpqhfXvNKb/ACZJyC71aF43cuazUcyEu8hplnIeZ
	hBXkEhbp9BJJrO7ob+WZZEyRv2r5U1bmzmGgLyz/fl7Iiz7U5UgvJHDzOAAH8fv5fRiCtXkmHCv
	6Z4kU9VS18+j3p6wneBbJlN9/2+1hZUV8mZsYoAkWSelQOXNmJwkBdUvBBwDeCUqUETvW5C4i5M
	TW+NkB3OMOKTe/56hJ8RbayWVHSYqkXY63rUFdUAlpgomGb7nbS+xNh209lQuYFgWXc07vba9L8
	3/sdnHBMfEDIclQf+J8kdrC8g1Mn2jtRSNF0cCmL+1yKZBzITA1Z1MvVJAJe
X-Received: by 2002:a05:600c:3b09:b0:4b1:4017:c4f4 with SMTP id 5b1f17b1804b1-4b14017c507mr79134615e9.20.1793650481373;
        Mon, 02 Nov 2026 12:14:41 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6412:7406:ded:3229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a8d60bc5sm9559305e9.8.2026.11.02.12.14.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 12:14:40 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v3 0/2] pwm: Add the Ingenic X1600 PWM controller
Date: Mon,  2 Nov 2026 21:13:23 +0100
Message-ID: <20261102201325.29507-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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

The Ingenic X1600 has a PWM controller of its own, separate from the TCU
timers that pwm-jz4740 drives on the earlier Ingenic SoCs. This adds its
binding and a driver built on the waveform callbacks.

Changes in v3, after Uwe's review of v2 (thanks):
- Krzysztof's Reviewed-by on the binding, unchanged since v2.
- Kconfig and Makefile entries in alphabetical order.
- The programming manual's link in the driver's header.
- The limitations comment says what 0 and 100% do: the channel is
  switched off, its output held at its idle level.
- No mod_devicetable.h include; bitops.h for fls64().
- X1600_PWM_MAX_COUNT from FIELD_MAX(). PRESCALE is four bits wide, but
  the manual reserves its values from 8 up (section 13.4.7), as a
  comment now says.
- A comment on why x1600_pwm_ns() cannot overflow.
- The prescaler computed without a loop; it matches v2's loop on 300,000
  random waveforms.
- A channel that is off reads back as 0 or 100% by its idle level, over
  the period its counts give, and as disabled only with both counts
  zero. Its initial level plays no part then.
- .write_waveform() no longer waits for BUSY, the clock rate is taken
  exclusively and cached at probe, and the chip is atomic.
- Fixed: v2 changed the divider or the initial level of a running
  channel by switching it off and on again. A channel switched off
  finishes its period, though, and switched on again before that, it
  keeps its old word, so the new waveform was lost. v3 writes the
  divider, then loads the initial level and the word through the update
  register, running or not.

Uwe's questions about the registers, measured on the R1's channel 0
through /dev/mem, with its pin sampled through the GPIO port about every
microsecond and the clock divided by 128 (a 10 ms period):
- IDL is the level while off, and nothing else: set on a running
  channel, it changes nothing; on a channel that is off, the output
  follows it at once. So it does not depend on the offset, and every
  write now sets it.
- INL is loaded with the word: written alone it changes nothing, and
  with an update the new level starts with the next period.
- A word written without an update changes nothing. After an update,
  BUSY stays set until the period ends (8.7 ms in one run), and a second
  word written while BUSY is set replaces the first, which never shows.
- The divider takes effect as soon as it is written, in the middle of a
  period.
- ENC clears EN at once, but the output finishes its period before it
  goes to the idle level.
- An update on a channel that is off keeps BUSY set; ENS then loads the
  word, and BUSY clears at the end of the first period.

v3 itself was tested on the R1 with PWM_DEBUG, sampling the pin the same
way. Through pwm-backlight, 30, 60 and 99% measured 30.8, 59.8 and 99.0%
high, and 0 and 100% switched the channel off with its output held low
and high. Through sysfs on channel 0, with the backlight unbound, all on
a running channel: a new duty cycle; a period from 100 us to 1 ms, so a
new divider, after which it ran at 1 ms and 25%; the polarity inversed,
so a new initial level, after which it was high 75% of the time; then
0 and 100% inversed, and off. PWM_DEBUG reported nothing.

The X1600 has no device tree upstream yet; its support is being posted
one subsystem at a time.

v2: https://lore.kernel.org/r/20261025191624.9219-1-olivier@mgcrea.io
v1: https://lore.kernel.org/r/20261025084643.93167-1-olivier@mgcrea.io

Olivier Louvignes (2):
  dt-bindings: pwm: Add the Ingenic X1600 PWM controller
  pwm: Add a driver for the Ingenic X1600 PWM controller

 .../bindings/pwm/ingenic,x1600-pwm.yaml       |  47 +++
 MAINTAINERS                                   |   6 +
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ingenic-x1600.c               | 289 ++++++++++++++++++
 5 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ingenic-x1600.c


base-commit: 9ad5602d4943635ea2b3b73d1a720161f88da1a1
-- 
2.54.0

