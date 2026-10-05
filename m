Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACA386426
	for <linux-pwm@vger.kernel.org>; Mon,  5 Oct 2026 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194791; cv=none; b=d0cIIfZE+IDc2cpxN7t+fKxsVallX+hIv+eKxfYoR1lGgmtSLl7uxi9FdMYd7ApMCZPamBWhtwUEAljoPSqnC0xrBMDsYTaVp7Qra5W9hRDD/kCm3lWaVXMhM/XC3ICDJ9hop/5cGLC5gBYl7h3SSWKSQTJ/QLe72gw3eIcGaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194791; c=relaxed/simple;
	bh=tQRX/FLdNvERNHaTAed+MPY7J7geG2lCZiYEYToYdU4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=to2bgwnFCE9yoBg9K7b1JDOWxx+/n3z0Xz7J7OXim7q5/aAFVl6JW0hZOLGyTX/GZBwGj1eFQxdBMKpVX1d+d9jRVEwrjvVr2mCQZ7dYc3B/mpwd9kwC491JxI3UUiMqbsRriU2761wS9g25IV7HUnNFzKxcO5B20C3waj/bxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kT31/pkW; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kT31/pkW"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e32f913c3so249168766b.1
        for <linux-pwm@vger.kernel.org>; Mon, 05 Oct 2026 03:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791194786; x=1791799586; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0tbK+LhZVoVA47l+6TUiqPvZnN/HfVJIxHV+cXh6bK0=;
        b=kT31/pkWmv0FWAqgQyuwU8CWsbfGF0CRkgJ85cYWacvtOEwxN8ZxZLQ+u4ZAwHzoKG
         qhnnFu1oMSjdROrTcbUNhANGc6lurY7ZKrzKXQ/ymSgz07/2KDtuv6T+AoBtXJB3tNle
         UNlPbS70aRI44RrbqEf/BrTaZf3qBwQ4wDWBfDafZDkPiDUnk2hlcREznpcrLKZCMfh+
         yErg5GYqQR/VK/TGjgxqV7sCdwKjWLhGSiGVThHCyNk/nxhdbmU95EHZLT+umUt/0DS6
         dUcspPMnzZvdxqX8rAoYW8umD2jV+ChukDStiKM6egsmEUG6jF3f+ZNwWkHtmm3GbHya
         OF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194786; x=1791799586;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0tbK+LhZVoVA47l+6TUiqPvZnN/HfVJIxHV+cXh6bK0=;
        b=ivrl0M4vY7yoSJX7M95RQVgs0zRS0H0mNy048IPjbDQFcKbHMiD9yFm32UAjbrpKhw
         t/89hGiTkwcds+BqwLGDWwuGU0jIxg+pz9pq36QAhiPjLge1VWs7s+dZQQPfBL0X+0Nv
         78FN3yt3hfDXE4FeSywC+mWdx5I8m1x216cnQpH4QKKbJgha9uMIB3EJzZj9U2QHbPq5
         rKMTOGLG8JFeDJr3KGcZ9yRa9mPVYgvD2XtocMimuNRk9I9RAdI+fTZlS5fcSTIakXiN
         YnfWjJLBnSScyN6f8YqFtVjpGnHThUNConnhNGnIU59n/qH8YOkRiV7DA58MNZTBUxkN
         QtwA==
X-Forwarded-Encrypted: i=1; AKwUvBwurt2XTGwjQypOJQYz/4w9pAqdxpU0p/orbm0qvliaoipPU5C+99XewsX8ze7E8/+y2gYEZarjhHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m0/O7LoBpYN7H0Egbl9wXdzpkC7+TwfKRqOTfkdc2oocXwywD/
	7lygv5t7QrkQ3bqOObneduf/dqnuQxOX2+nbFfaJuInrSa0vOyKBEzs+qCA4JETuhSOejBV2rYr
	MmIbP
X-Gm-Gg: AYBFou0eSe+qQITf04Xw9OJoie1OaMlaKPPil7gmW0JHdRxPzqLyXVS3nUf46Lxgqo6
	8QtrG0Pj7c1ItVRxsaZGfzgvhLJnXLYBzS1jJwScgSU3pzFVw73RWSVFbUU1wwIBH4FOmWP/9TC
	G/YyQ32/c7EQ8P1QsHyvwfLGFE6x5LJcFSUlRstxvBENNmsH437jcT6R+pfjkGXGHKju0+tgTud
	1vOtlI05re9zhA5f9+12FX4W7jn39MSycVi6JfTwAb/be25X7Mrs1YH1x8qeuGvNvCtq+6/BeB/
	KZeKnND++h2MAWpvs2p18TyJg2hCegr8S+xv9Uu+ZASfYeo6aAsBloz/tgZTYac4Es2aep2u6UW
	kWEJlMYL6k0lPJDvfdlVTSIf5I0v7OXe/4KdJx4TFTJBHMD5i1e6flO/33KdnnDtIhW4BIidMQD
	5BikAYW+UGlioUxE2FBOtRPV8JYxYL/3l+zCDlUbgLL9zx2aUrOTtI0KW20KxPuGrnRbXTwvq4W
	NA9GjnHf8UkIZEyKolAXw0gI1etKWbwYGvYSBxfSsIAbeWtZA==
X-Received: by 2002:a17:907:3f1b:b0:c2d:fade:e089 with SMTP id a640c23a62f3a-c2e4a7d4789mr841351266b.0.1791194785779;
        Mon, 05 Oct 2026 03:06:25 -0700 (PDT)
Received: from [192.168.0.42] (host93-7-32-195.dimensionesrl.eu. [195.32.7.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3156360832sm50800766b.75.2026.10.05.03.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:06:25 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH 0/2] drivers: pwm: add mcf5441X mcPWM support
Date: Mon, 05 Oct 2026 12:06:22 +0200
Message-Id: <20261005-wip-bl-stmark2-pwm-v1-0-168b9dc653f2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NzQ7CIBAE4FcxnMWwgNh68j2Mh4VuFbU/gVo1p
 u8u1YPGNB4nmfnmwSIFT5GtZw8WqPfRN3UKMJ8xd8B6T9wXKTMppBGZzPjVt9yeeewqDCfJ22v
 F0RVgHZYqxxVLwzZQ6W8vdLt753ixR3LdKI2Ng49dE+6v1x7G3t+DHrjgRisLlBm9ytXG4v3sb
 aCFayo2fvTyo+RCTyoyKaQhU2JZgDJyQlFfCsCkopKiEaSyJaIz+KMMw/AEXAekVFUBAAA=
X-Change-ID: 20260828-wip-bl-stmark2-pwm-acd1bcaf39a7
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

This patchset add mcf54415 (ColdFire SoC from NXP) mcPWM minimal support.

The "motor control" (mc) pulse width modulator module (PWM) contains four
PWM submodules, each able to control a single half-bridge power stage.

There are 4 independet 16bit counters, i.e. to drive 3-phases motors, the
total counter range can be limited by SMnINIT (start) and SMnVAL1 (end),
in ticks. SMnVAL0 must be set to the middle (half range).
SMnVAL2/3 defines the positive PWM part for channel A, SMnVAL3/4 for B.

In each example, R.M. uses signed values. Reason seems to be:

"Control loop algorithms (like PID controllers or Vector Control matrices)
natively calculate output corrections as signed error vectors (e.g., -50%
to +50% torque or voltage correction)."

So using the same numerical format from this algorithms (signed values)
avoid to reformat values to be written in the VALx registers. This is of
course useful for bare metal drivers programming, but i have to maintain
signed values to have prescaler working (all-unsigned way works but only
with prescaler 0). This seems to be a possible hw bug.

In this initial implementation only output A of the dual-output (A and B)
works for each of the 4 subchannels.

Validation has been done on stmark2 open board, checks by oscilloscope.

---
Angelo Dureghello (2):
      m68k: mcf5441x: add PWM defines
      drivers: pwm: add mcf54415 mcPWM support

 arch/m68k/include/asm/m5441xsim.h |   7 +
 drivers/pwm/Kconfig               |  11 +
 drivers/pwm/Makefile              |   1 +
 drivers/pwm/pwm-mcf.c             | 646 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 665 insertions(+)
---
base-commit: 02156c061b7dfe437f9054b3e353c69fde0f7a58
change-id: 20260828-wip-bl-stmark2-pwm-acd1bcaf39a7

Best regards,
--  
Angelo Dureghello <adureghello@baylibre.com>

