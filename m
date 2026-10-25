Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918007;
	b=CWRl854WJo1WH0K9GTT1Y+d1LywYqywtxttsLPwJUInk5d3KAmmgrUXNLsl53O5W0cmX
	 2u/g6r7ZVApDU9Ep10bx9m9UYkEMNwSxvLBpsc/yJHmMCFSt8UOFUQI5WDYAxoJjme6vS
	 O3WT9vleW6FVz7/38vCp8wocUoMXXnGy+0XDR2USO1W8hizOxKeUs1GblpImgQ4srSSSa
	 n9k3FTt3/O23ErmRQyCIM6RiT7ZyS+5yh7G8JZu9y5FBaNVYdLA51uzhoaFyrww6Bnh3o
	 RD7AmuFaTvT7uZobZQj+Hr+HYa8LHkA3FNU59EujFIc2U+BIkEaPOw3NCySVXdXmMyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DZJtOePkQrLq8/ateRl4kiNkEI0jrsHtDIwcRKpyDC4=;
	b=PsSQeS/k+xDQd3ZtZEFqXxsCXtAdR7cWkm8DF9DNKsMaN0vCHOTSpthLA5xMKjjr4Nii
	 y0m+8u00HalR+d5R/geK1xZDJfV2XAso1Aw6esBzruoA+LhOO+gZv187dZRPbJVyYLA3u
	 Fu3P1QYlWgFySryf99PmlpF2EdYs2OXK+rDUu10dorpMWQDpqscyVE8aAVNS5TTfQhX8m
	 mJA+eGcR9qQZ7uFjovkW9QYyAxNhWG5Q4P08bBz57um2fbidYa9BKYgiAyoUtuG47Myu5
	 jLOhlrnwilIAwCyEgRgijViXSlQ0F1UMg0nmvX9dAiGdFjrEBoN3JCzEgWD45ngiEpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sacsCAWC;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76491606A31D
	for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 08:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76491606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sacsCAWC
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48df8fe8513so1941630f8f.0
        for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 01:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792918005; x=1793522805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DZJtOePkQrLq8/ateRl4kiNkEI0jrsHtDIwcRKpyDC4=;
        b=sacsCAWCmrTu09sFa9ikOphxuUASQYHVKM4+sRpN3oU2QRipbZ2KT7R5klNZ5NVSpn
         EYF5PG3vg855Hpev/RvIRupc+rfVEAop1PtZf3N6dLpU/awS6cMRWyb5kX5ze9FLkXez
         /cl7HIK7KKreXDACoIh/vIHGt+861Gq8/SJxYtxH6tDT8K+4K1mGRjaT19l2kyPzuBXB
         8fYRtE/ENWgC2UL75Tjivj2lakzHDNUKTC+zfGGZXs/a1A5RrutEubIuqHhCXlbXNpT8
         /UWaI/frABxR2jsybSGBrdzxNo1MseEPckhm9FS910fnwZWfNR5IMMi7iZpXEjqvOoF+
         RH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792918005; x=1793522805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DZJtOePkQrLq8/ateRl4kiNkEI0jrsHtDIwcRKpyDC4=;
        b=bwoC/aCdYrY8RqIJukCQBB1wvx61TKiiS7FadP8UkwQ1ZFNNDb0IrDwMVo0FZlurIs
         9gpT5t82Hg6dom/g7twtbzDOs0wPlALmfXX8HIbY5b/ckEE4fBJ8Z3No9fClz/gsB8Vx
         edo2Du/12fTPIKCpeiZF5/gUP0qCu7qhR32djwBcE5rH7jxp2SKBrF7xQ6ir0fmGcyDH
         xcmgEukF8EElydi2ND5QTXo/T4mVX9TxDr9HZmpCuZ5FuIlVodseDKC4NOu41q401j3E
         eCaF7u5Bue5e+paRJrv5vri/DO6WDbf4j5bqY3r5pwyYsgbHDHBAy292fxU82VMeicny
         +zwQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2/XaeaaWrmt2IVyC2HIMnX+ficy9xmkL6MI+aM1MTAVFhXbaYbo5hOOLUBL7YtC4jBGUhtJYD46M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQpwAWtF6H7hK5hP/lSnfIL3QgtHlW63mrBH9CxWuOYdYjbdZ0
	apOCg1V3J/1Eg3XUrRWkS+YXrAktTsV82eLKU4Hmpz+EaDTkViGL/M3ag6miaa6sRmo=
X-Gm-Gg: AYBFou0nv5fi90yA6eUyUsTSA7M5FqSveNXLRH4u6xJSj6KwP55GHiNE9vivRyJzKEL
	SzlPbkR3GrO6bKntdgbiKhPBHnXYdGxlszAdHzU1vbBkhyt2K7jA8Fc9of9JV3OlkoAvZRVboBp
	zh0zGkNne3MmztEJfM03vb2yP7wFhGGBMACxohaUMEZfSdvH2Xii45DPMo1eXL4DOrP2k26GdwV
	203j79Ts6P+aYdqewhd/kSbxecqCPK59iaBQ42wotA0lgUW8ds10XlTJYoUgFNveOzoc14ggm5f
	xTP7PzM+Nqz3GZQGW8f6MbcDHeACQqZfeyCzZ+nDwpzuBisUlMw2BoIBH3QEug3TSHf4Z5t+jQS
	aARfUmxVCYeVVgy/BGJbbOtHAHZ6yeM17e+Qys1SnlRTWuTGueW66YsZ7nKAv6J8Y6/c1+TtK3M
	qD2LLHUQoUayTY7Btd/BqTsJBUzXtfxPehv6o0GNJrd7cz8RbtQCDiRRRt6vNIV88bAAX1c2NRJ
	DsYXyQ63vX1k7+CSPupy3I7X5WXGSoxusz4NNS6JAic0eqmkqCosFS0pHkGT7Sr2v1F0zhpWzwm
	nT1eJcKU93yaEHwBA8AMyI3Crl1+yJwXcoFL4j7NdS+SMue28qGN4A7R/RubUQKp3y1V/1WmyQ=
	=
X-Received: by 2002:a05:600c:524c:b0:4a2:8c5:5e5 with SMTP id 5b1f17b1804b1-4a35ac8c0fdmr68412805e9.7.1792918004829;
        Sun, 25 Oct 2026 01:46:44 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb99esm8616707f8f.23.2026.10.25.01.46.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 01:46:44 -0700 (PDT)
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
Subject: [PATCH 0/2] pwm: Add the Ingenic X1600 PWM controller
Date: Sun, 25 Oct 2026 09:46:41 +0100
Message-ID: <20261025084643.93167-1-olivier@mgcrea.io>
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

Tested on a HiBy R1 (X1600), whose backlight is channel 0, through
pwm-backlight: brightness 1, 25, 50, 60 and 100% give the expected high and
low counts, 0 and 100% switch the channel off at the right idle level,
and an inversed 250 us of 1 ms on channel 1 reads back as INL 0, LOW
9375 then HIGH 28125 with the clock divided by 8. PWM_DEBUG stayed
silent.

The X1600 has no device tree upstream yet; its support is being posted
one subsystem at a time.

Olivier Louvignes (2):
  dt-bindings: pwm: Add the Ingenic X1600 PWM controller
  pwm: Add a driver for the Ingenic X1600 PWM controller

 .../bindings/pwm/ingenic,x1600-pwm.yaml       |  47 ++++
 MAINTAINERS                                   |   6 +
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ingenic-x1600.c               | 260 ++++++++++++++++++
 5 files changed, 325 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ingenic-x1600.c


base-commit: 00e917df050d79ac26ec700717680ad6421d2808
-- 
2.54.0

