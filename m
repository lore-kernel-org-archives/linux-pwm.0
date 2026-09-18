Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED754334C7
	for <linux-pwm@vger.kernel.org>; Fri, 18 Sep 2026 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725334; cv=none; b=gt/9MqdQHnCjcMa8UMpQPtccozBf7fzvQLDChQcChxM4FO61h+CUnWQxlJ01ze7jkXS49gt4k2w0NC/N0JXUvw9cEXUWoxHjbmUaAHIaq51wKlq61dG0x+0Wan3ZnSTNOashoFn/nhtCnnWrmuwPKzVU//yU5lNkaaUky1CXaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725334; c=relaxed/simple;
	bh=VP7hHskNoGPpOXNCBkJJtyv8CeQQ6LuIb5tB/rUYKIY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pGR2EteqLn3MQ91UDU3gu1+EjyrijkqKwcXFSnc2rZFJw0a7MjidMXj/uOrGdKLK/Q61OizmqI9wVr5Z2SIai5XeE88FBsGuAv1EhY05Ck103nAwLz9uBHr/JvTyT8iape4l2kvnBHAfUn4p6c90sm3M71YJqrQrIbFVcjLM+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JtJB3pPu; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JtJB3pPu"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so377123f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 18 Sep 2026 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789725326; x=1790330126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tAZT5ncdu+agHg65mBYy9X51LOw7DQ1MSxf8dHyd0VA=;
        b=JtJB3pPuLwzcCOL+12ZxVZ5VJQnnX1qngms9gjcJ0AEKWvmJCDhnSA7CdQ2GdH3nVA
         G7oGVlqQSxZ01kO3TJzbVx0G/j1RX8lBS3HolIpxOenFAJ8Wweq9ygNrIMu0OXr+7vtI
         EnCPhxp35+xxhNJ/y4tLq8fbM5wZDfdvaHSkGnBTI0at4MXoobdNWrlPQrQsR0t6qKub
         /U7E6d/A/U7VvRZZTTatWwmF0GIqgkvwGTm48+sKQktp/j/dab616PTrJxbn4mTOLEZp
         MwLvEU3IVCR5G8F199AmkQm5j/Ytd5Em+TBKX4UEk65dR13oKjExjT5bHHQFYn14EV9p
         w0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789725326; x=1790330126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tAZT5ncdu+agHg65mBYy9X51LOw7DQ1MSxf8dHyd0VA=;
        b=LxFNldZVkhTx2bC3z7Ewu/X1K1adrZ5ndt3urgPyiypRzZeeMl1y/k7y5eBIYHwn90
         8/cgZKOhxAgfT26l3l3XOiOhPwZFDy4zxumI3iBgHnEWUPkHVKjAV+qKWERygQ+ciArF
         koToobJdFS2/0fenvQJQEv4+j2bxRymqjjw2FYoGTDmwuv06W/iZLNhlggsZmHJokuni
         qlMfEUSQzZp+84ZCFxoPDSSl4r8YPWpKsNIRbZrP5XHcDfGb1wAwWKEgV0RPrZbvqDPE
         Eo+aKalDrMFkHtR3usC7BofMuNmazoZc1hYZaE1BKJgY4u+CPhzkL3zAW7ui6FqwfQsg
         MY6w==
X-Forwarded-Encrypted: i=1; AKwUvBy3t36y4MJm0NVkHCSaPHqHtdNNJqVoQ8DEnsUkZDmFdH1bF8n5RfqEj2UKUl7jtTcVR8B7KBpX8Fg=@vger.kernel.org
X-Gm-Message-State: AFuF++nnlXz7bjD9rqEyWBSv4W7XnMIAFoc9gg1wNccxZT9svx4evO6V
	ta8fstmzk1jBEF9Ow7y1mRgNwXGVhHlRVMWIeo2qCbU9uHzzhKCqXfKTd3OGnismgvU=
X-Gm-Gg: AYBFou01sy9UyIT51LyjQnt10Y34bLy2D1ivoTW/yP2tEhf2XESHNv/lK/NuLtCbQfT
	0wBM0MzQPPxtLLxOJTAiMEJ14JSZW2mIjtoqd6qO/jiuQDpqDgdAs6GSob3/gKPpleN8RtOIaNV
	KbO9b0CMvDCvMcvh9kekxJ1W1oqB6ongLnabG/PCG746jGu6Yw3t1DsoMS6ZGZzIfPjfjHc5Ey9
	ab5mIjhNVgFDJEg3Vzku2dQneSPXRoGJT20uoqoM4s2pw/dQYKvIjvjL3nV5eRXSI+Hm5YlnT1/
	7oxMVuRlI6Om5Oh1crSDgmWwqe6diITzP+IvWzh6C0gYd2pP3ATSv2wf529MLdTYrFtXIWlyqty
	NJqAIfp0rhcv8kDJFZVObN9XfRks8mCyK54HuNEleAykTLQHjjbk2YSuAj1Efajt8GaVFFZFCeU
	Lj2IIhepuG+GwzgZBbhqFNETg51xwGGR571tvRpPiDognep6aIRUaC3sI9X28WZUxrtyXWi9Ffv
	RhwQfFy
X-Received: by 2002:a05:6000:186f:b0:487:36a:c870 with SMTP id ffacd0b85a97d-4871e2123damr2944568f8f.11.1789725326057;
        Fri, 18 Sep 2026 02:55:26 -0700 (PDT)
Received: from localhost ([195.94.147.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872008118dsm3345138f8f.30.2026.09.18.02.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:55:25 -0700 (PDT)
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
	Julian Braha <julianbraha@gmail.com>,
	"Gary Guo" <gary@garyguo.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v9 0/3] Add RP1 PWM controller support
Date: Fri, 18 Sep 2026 11:58:59 +0200
Message-ID: <cover.1789724999.git.andrea.porta@suse.com>
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
a function. A subsequent patch will add a new device and driver
to read the RPM and export this value via hwmon.
 
Subsequent patches will also add the CPU thermal zone, which
acts as a consumer of the PWM device.

Best regards,
Andrea


CHANGES in V9:

All changes are in response of Sashiko's review (where applicable),
see:
https://lore.kernel.org/all/20260908132302.358D91F00ADB@smtp.kernel.org/#t

- linux/bitfield.h is now explicitly included to avoid compile
  time issue related to header refactory
- synchronized the exported function to read the tachometer with
  respect to both the system PM ops and the driver unbind/unload
- reworked the error path of all functions using regmap_read. As
  a consequence, rp1_pwm_apply_config() now returns and int for
  the error.
- made u32 cast explicit for the divisor of DIV_ROUND_UP_ULL
- moved teh struct initializer in rp1_pwm_read_waveform() to the
  top of the function to avoid overwriting part of the resulting
  data.
- dropped suppress_bind_attrs flag and replaced builtin_platform_driver()
  with module_platform_driver((), since the driver can now be
  unbound/unloaded.

Link to V8:
https://lore.kernel.org/all/cover.1788872294.git.andrea.porta@suse.com/


Naushir Patuck (2):
  dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
  pwm: rp1: Add RP1 PWM controller driver

Stanimir Varbanov (1):
  arm64: dts: broadcom: rpi-5: Add RP1 PWM node

 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     |  66 +++
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  12 +
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi  |   9 +
 drivers/pwm/Kconfig                           |   8 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rp1.c                         | 499 ++++++++++++++++++
 include/soc/bcm2835/raspberrypi-pwm-rp1.h     |  10 +
 7 files changed, 605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-rp1.c
 create mode 100644 include/soc/bcm2835/raspberrypi-pwm-rp1.h

-- 
2.35.3

