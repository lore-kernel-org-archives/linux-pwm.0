Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920257;
	b=wkaOv4BnQSer5I+hWXtiA3lw591ulTxI9m8mQ5IieRlghCg5IhuQH42RzXKF53C4d2rJ
	 v0K38mJ36aRveXRs1gk396w92ZS/tVucQ3xyac6WXvANvRK7fjH2JXW7J1buSKWxyptqk
	 31sOKxftWH9evV6+u6XWlki+Oj94VOftkoNNhe1yI2VCD5ax2tvrVpr1+8nsUsyk3YUrZ
	 fi25Vqe7TNYnEOwXqFaE2X+I/nmXz81vkUMGKOpoeGorZtSQXiCPrs8NcJFo4pMRdJk97
	 xdABsJLP3S4ncSWeetd9+e2pbXnAbHfwwFnXC7Plh0dbVloo855bC6S0qvua5MAQAgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=cwQPpTaL2c/wj1OEDa9qNdi880oheLkZqVlpuujln18=;
	b=1OQE/GIdbN5ObjpkYQQj0SppqtpMXk5207EGk9iPLvyriBOT8YNLXfT4DK/23+gOv5HH
	 J59lh+LoZmqJ8m8gNGMJ+dvZYbzYIe+UHCopjpi5euyY5MyGbhH+n6zO9QeS4u2xKF/LT
	 0R+ob7uCmdGdraGMJqHkrMgLb5ERbMRL9Jau1YIpKEteJLnBz310bBVMs8dJpwB+jiHAY
	 RcKjEoWdCa6rhG3gCMGqROqF1GPbgfenR/qiIlvAppeB44Z6lEGFLLIBtDOCMBUIlYfM0
	 gy+0FbgdqRhXKMrQMtF6Eh4dRIQHjrChOaFHlo5NjFNXtxmEn+zNtQqEmrY673IsPvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="he9Xj1/t";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641A0606A32F
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 12:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 641A0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=he9Xj1/t
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36dbde64409so6800382eec.0
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 04:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794920255; x=1795525055; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cwQPpTaL2c/wj1OEDa9qNdi880oheLkZqVlpuujln18=;
        b=he9Xj1/t6jD+zpDhkV5lhMnEd+n3snktDIJnyh+tRUhWMvREqTYyVLf0gmxsMaXNF+
         wqyv4RZKSq9w2j+Gwn2lk1ZgYxKM30QcFXzjYZH/09XDe16NW0P+gzhcII9w5cpfFaq5
         KahHYFUfKpTpUqjQx9i/QXbC17f/gCVr9GGFE1UH1dGVvXV7B41XPoEw+QFfAIUeG5AQ
         f+m8Waf8SaBB1e+sYlWeHsaun7WqHfs8z/41Nd4FIqZ9A9SNZgMY9fAyKpeRi2ZKUQ//
         47bz+DVNViFUgn71bXz8mgXEK98KfIDriwAhGY18QAhOBjwoxgC3BzmbPkb6jc530t4B
         1j2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920255; x=1795525055;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cwQPpTaL2c/wj1OEDa9qNdi880oheLkZqVlpuujln18=;
        b=yMx8jGqh/isJI9f5SHTBNxWRcA90L92U0kcCAc53zI0AHVSRn1ItMVSbWT1EpcIozJ
         mavJ77SfFG4Fd+6QSkSjxNsHMlG9VHiHQTksT3yY+atDCijYsgd2iP4Pn2DDziw7C2wj
         wSHbR7hdG0OZIP84ixws6gHNhTj3IdaOcTzocPVjgm/gWD4ho61ATiidyQoigpmCds6q
         a4lzhVJDyGSx/9cdSkytcDZzfs45URggiX+MhXtX3pgNa/BpQauZpUnqtdS5Qqf4B9Pt
         NOwPvsg2NJ7Wi5mXiEwGHJFgdZr1iWHIW7JZjAlw+8LMkkILIb8LiQc3v7JzSBYNQbdf
         +muQ==
X-Forwarded-Encrypted: i=1; AL+hErENpjdXXOdP7Sg7SCsISRNFrRh7kpbY3DjHYu6s53KwPbOSIyHelw+3MmXkctRRJfgCDhs3XUgJJlo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EjPGh8U4CxkK2jQYHECOZmcO1/QUz04rwhXN3RFiFQAYYVfra
	Ao7hk5sBiykA83OaTltMAWqvF2Hyl9Q4LlwNeH5kPdFo086afVUYUvDelmsRi7uNjQU=
X-Gm-Gg: AZFdTZdKlXDsnMXy2zHFPIPIay40Rv6AO3vHTw8L2LD7xbrirqhOed4hT1tzXwM/I1n
	LYIYBBob6lUJK5CWsuFte1XKaIXwu+zDnEutiNbEnGoV762sic8b5LvD/Ssr7dLBMdUwbdmfJvc
	U06k1mOFwdm03BA51nT3fWEgmKyRIJJKEoCQbs1lS8sdTtq/6C+rQxRz7N95ObPKKaazwp9L0tU
	e6ZxJr0yVtmMIbZcufk1DCLE1HEp+tRnZ0TINrE+e5uF3doJ0F8d5YT0pvEuIlJeSyf+bRjYq+J
	AD88OqrhtIY6En3QBJD60wFh63MgQa+pc2VSt0CNblFQJ2UsGipKD3NmkbsYQ3xXLncVhNFC2rW
	oJtvXp8EHXxYtb3N2Jow9VcIlA9vOtV3lWY21lJ68G7jUrrhSE9/CEXFM0uRuPLXXf18lnwJbKc
	T9r7IHsvA7aYf2O7Mrvsh8Ic+DgXqBToEvpb0MIXT393rwGNQD9pzaV0VZccQ8GEHj4xghOjsQF
	HnplC7n2AUlYpK986xH3Sn0Si+9tl5gyJ2IVFPEgtjHsgIn78ysOoUMlgWkoZcpWMvyEqJOwBOk
	GoxOMM9KIHCav/gAqW7pgzmLKivquglQfTK6XuA6/XuiWcd0pJvN8oqZhlYdwdIcVU7N
X-Received: by 2002:a05:693c:83cb:20b0:375:388:a6d5 with SMTP id 5a478bee46e88-379675fc8fbmr12249938eec.32.1794920255453;
        Tue, 17 Nov 2026 04:57:35 -0800 (PST)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::a1aa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379559189e8sm44767034eec.11.2026.11.17.04.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:57:34 -0800 (PST)
From: Hiago De Franco <hfranco@baylibre.com>
Subject: [PATCH 0/3] Add PWM support for the Sophgo CV1800B
Date: Tue, 17 Nov 2026 09:57:12 -0300
Message-Id: <20261117-milkv-duo-pwm-v1-0-3f1786ea57b7@baylibre.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMT3dzMnOwy3ZTSfN2C8lxdE6O0pGQjiyQDM0tjJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAKwV+flxAAAA
X-Change-ID: 20261104-milkv-duo-pwm-42fbc28b0693
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Chen Wang <unicorn_wang@outlook.com>, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.16.0

This series adds support for the PWM controller of the Sophgo CV1800B,
the SoC used on the Milk-V Duo. The same block is also found on the
CV181x and SG200x, which share cv180x.dtsi.

The CV1800B has four PWM controller instances at 0x03060000, 0x03061000,
0x03062000 and 0x03063000, each with four channels, for 16 outputs in
total. The register layout is derived from the controller already
supported by drivers/pwm/pwm-sophgo-sg2042.c, so instead of adding a
separate driver the new SoC is handled by a new chip_data variant in that
driver, as suggested during the review of the previous submissions [1].

Compared to the SG2044, the CV1800B differs in these points:

 - PERIOD and HLPERIOD are 30 bits wide and PERIOD must be strictly
   greater than HLPERIOD. A 100% duty cycle is therefore not
   representable, and the period must be at least two input clock cycles.
 - POLARITY has the opposite meaning: with bit 0, HLPERIOD counts the low
   part of the period and the pin idles low; with bit 1, HLPERIOD counts
   the high part and the pin idles high.
 - A POLARITY change takes effect immediately, even while the channel is
   running, and does not need PWMUPDATE.
 - HLPERIOD/PERIOD written while the channel is running are only latched
   on a 0 -> 1 transition of PWMUPDATE. Toggling PWMSTART must not be used
   for that, as it restarts the counter.
 - When the counter is stopped the pin is parked at the level selected by
   POLARITY; emitting the inactive level would require changing POLARITY, so
   the driver switches the pin to input mode while the channel is disabled.

Patch 1 extends the DT binding, patch 2 adds the CV1800B variant to the
driver and updates the Kconfig help text, and patch 3 adds the
controller nodes to the shared cv180x.dtsi.

The hardware behaviour described above was verified on a Milk-V Duo with
a logic analyzer (GP4 routed to PWM, i.e. pwm1 channel 1), at 1 kHz/25%
and at 0.5 Hz: polarity mapping, PWMUPDATE latching with a running
channel, and the pin state of a disabled channel.

This follows the earlier CV1800B PWM submissions by Jingbao Qiu (v1-v7)
and Thomas Bonnefille (v8).

[1] https://lore.kernel.org/lkml/20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com/

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
Hiago De Franco (3):
      dt-bindings: pwm: sophgo: add PWM controller for CV1800B
      pwm: sophgo-sg2042: add support for CV1800B
      riscv: dts: sophgo: cv180x: add PWM controller nodes

 .../devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml |   3 +-
 arch/riscv/boot/dts/sophgo/cv180x.dtsi             |  40 ++++
 drivers/pwm/Kconfig                                |   7 +-
 drivers/pwm/pwm-sophgo-sg2042.c                    | 201 ++++++++++++++++++++-
 4 files changed, 241 insertions(+), 10 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261104-milkv-duo-pwm-42fbc28b0693

Best regards,
--  
Hiago

