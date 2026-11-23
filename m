Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416655;
	b=0KlgyMP2orGNqC88UV/hEzjsY0JZLAxAnUCiePRC0BBda2FC0Vb8EPWMDyQ6JIj02mv/
	 qG2rHMZP93IOlrnPWYBBMa0N4VBLlFAf2DpgYEVzJYa4UpV1uyV8jchnBnqTHpdRan/zt
	 6t025y4zpi809AWU3KeZADjGDKYxGGNUs0W4kP/Ez0Szgt60kxT2RMKKwrejImmIxHkzS
	 po4dpO3yte7FV8xoIm09G0tbpZAh8wHk3I9XIvOoKVqa5Ik/TBiWFYhX/wU/ntNxqw+Rt
	 /SvpaRRnfWFDj7IhUk6mhMNwwunkcGKxqUJKbxpGHCYrANei/5UTqgZA4TMf2ENDDuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RsghqF/m5W3+Sk6FDMeWBFDKibQsse7a2Bj9+KgEx1c=;
	b=ZTLCaQ8gY28Vyx/4XKRVaJRhdzeVDoMWxaRCMmecjaseO8pkY4YaALItNdpN60R+M4lI
	 LSWhwdhrsLZoIRvmVrmuCPiPL9ObfoXcsdtdtm5b13gfZULWXWyhLxhuWY7T1l7wA3t53
	 Da7GYopgn0A9kMbVP41HLYlwqC/IRBQQ1BJd1dFIRgaU3PHXvDOjzoHE+FfPoURIcI2+e
	 av36z5LH2MRxpICHpiTGTJmVoxxuPs4lwU3T5xlwN4OCTCJ/ee9tQSIomL1eM+8Il5gwv
	 TZzjW3/egrt07mkrKbxfbHYI/Ki6rW8EI0xalC4PlREY9RvJgynY0MGyETD8pZ9R11Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OEE72Kfd;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003CA606A334
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 06:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 003CA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OEE72Kfd
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b4a93d0814so136376a91.1
        for <linux-pwm@vger.kernel.org>; Sun, 22 Nov 2026 22:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416654; x=1796021454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RsghqF/m5W3+Sk6FDMeWBFDKibQsse7a2Bj9+KgEx1c=;
        b=OEE72Kfd+Obfg8FU0f9Bf+u8OMdyF8baJf2O5azWAUnPrPx7XI3CPaz1RAVW2h/vza
         6Kd+aRUE3Sa3hJVDYGhr+tLFcd9Z9jC37/g6rrluW3PSOPQvMkYAmmEdAsHdS73c9DFK
         eZj9eElKxaMZh8zBzNgD7zKAcwDb2hjLqWVvir52pqyhk9oWpPmuVD5vZ1gryD7Ow8Ve
         1at8ctTxVFINOIwitHXCv58Py0mcgn/Sjh0eJv2ly8NQmpI8jWa3146YYA9s4Z3JGI1X
         TeGDdvV0Sue9L20dz0aEW5w7wtFbekF3wJnkaCKEX8XDrAkzQVHw2SMhODtnCHW4npzb
         QOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416654; x=1796021454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RsghqF/m5W3+Sk6FDMeWBFDKibQsse7a2Bj9+KgEx1c=;
        b=iJWH1wRjM7na63338wGyf8DH2y4mWMzcwZeU6KHAVGIAIh6usUUDLspIsnRY4MD7TX
         HYLrRjMd01TF9gP+2KKt5kAe8FxV6+O5Dh9Gz3ZfdDdgSjXkEBqPmM9z075N99mHg1ri
         jyeOPgarUjsxYDCW8G9lbuwCYwYvx269MLbgfHxMq+eEkTiM8l/skr4Sl8AiT3bBHojc
         q3baFJIRw6kyIZs/qW4pWyhkvq/GI18kMo3CtZZ/Ab9PXlQdPfIL+mfrcKRfQ6+eOVW2
         VQs6RsrrHe7r5MfWbNkwQ2kW0InkE3MhQQ4eERuYxTNWM02EXoRqGpn4WgIxoW5DC0eQ
         IS/A==
X-Forwarded-Encrypted: i=1; AL+hErHpkmFAjSHpWhDtFnfdlL05qYaIl9MNHfgxIbBpkyEgUNv7ux5AEUOccuHdwFiXw79UeJWXdKJREWM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xpBQZkBBw7fZvcI3QucbBUAHPRuXw9/7kxXj2OA/I48AqaJAA
	fIEBuQmH+PDwk0i8WEDFS7uSXulSP6eK07aJkORuAZpldMHuLAHUuvH730yZYA==
X-Gm-Gg: AZFdTZcESOt+WPBaUyNZYZXK3v63U5TuKskhh0R1trZenbDJ91FtnBc6jMXa21W1Kih
	iyx7fWe6TAje2GlYKYnTL7djVwtEv85v05P5PqafOizLg4yfMPcIyLX5av7TkL1JPuqLkKMp55t
	JVmQ8d973TbQ76vJS59NsyaXDuGANAlK6kpn41GrrZ8jWWt7B4bMqsN70gIyztN9NfpkUfUMHG1
	0BvrYByENKUa7awfQu//4zdgomgtl61D6AHz/K3TRlVv40+7szy7Q3oaC+2AxYjKDgihnULnJhg
	x0sDiNwT7ni4UvUjLMCFXJSxVSTl7t7O1fTHMpN7F5rn9WgOlLFTVKH3TwRFn9FWWjnXm9cois0
	0vS8xZOjzohi0ZLKmuxXbThYMv1pfSKJmREJq0kEU/3a9tA/JrYIU1MB9lkN0SfMGymWRSorUen
	9EN4a0b3xIAJkOucgkmWpR6bi4TpDEH7X771bnUjR61Ra70jRs1i2i4I43Odt0vhlfF32AwUIW5
	4Z+z/g14b5uuxOaThOEoNU4Dm9TMxV0QzGOIm5iMuz9VMh6o7vv9T+MvD8CTU8EAbFLDM3y9HL1
	e3xpjokIvJKtoXt+vTu3q+R8dExEPspY2ZNZyYSyqLunvhHIJxPcTEa0eU5mBP8xrPtidXuLQZ8
	hTrqF70669lXauHc=
X-Received: by 2002:a17:90b:55d0:b0:3b0:92be:ea4a with SMTP id 98e67ed59e1d1-3b41c9830demr9484321a91.45.1795416654083;
        Sun, 22 Nov 2026 22:50:54 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm5224811a91.9.2026.11.22.22.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:50:53 -0800 (PST)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v7 0/2] pwm: Add Nuvoton MA35D1 PWM controller support
Date: Mon, 23 Nov 2026 14:50:04 +0800
Message-Id: <20261123065006.28768-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Chi-Wen Weng <cwweng@nuvoton.com>

This series adds the device tree binding and PWM framework driver for the
Nuvoton MA35D1 EPWM controller.

The MA35D1 EPWM controller provides 6 PWM channels. The hardware supports
up, down and up-down counter types, auto-reload and one-shot modes, and
independent and complementary output modes.

The initial driver supports independent output mode only and configures a
channel for up-counting and auto-reload operation when an explicit .apply()
request is made. The waveform generator drives the output high at the zero
point and low at the compare-up point.

In up-counting mode, the counter counts from 0 to PERIOD inclusive. With
the selected waveform actions, CMPDAT = 0 generates a 0% duty cycle and
CMPDAT > PERIOD generates a 100% duty cycle. The driver keeps PERIOD one
count below the 16-bit field maximum so that CMPDAT can be programmed
greater than PERIOD for the full-duty case.

PERIOD and CMPDAT use the hardware period-loading buffers. Since the two
registers are written separately, if a period boundary occurs between the
writes, one transitional cycle can use the new PERIOD value with the
previous CMPDAT value. The following period then uses both new values.

The driver selects period loading mode by clearing IMMLDENn, WINLDENn and
CTRLDn. When a PWM is disabled, POENn and CNTENn are cleared. Clearing
POENn disables the output driver and puts the output pin into high
impedance.

The driver does not modify the PWM controller during probe. This preserves
PWM outputs that may have been configured and enabled by firmware, such as
a display backlight. The counter and waveform configuration is changed
only for the channel passed to .apply().

Since the independent/complementary mode selection is shared by each pair
of channels, the driver refuses to change an active complementary pair to
independent mode when the paired channel is active.

Changes in v7:
- Rename register macros to match the EPWM register names in the
  reference manual.
- Rename bitfield macros to use the corresponding register name
  as a prefix.
- Rename CNTTYPE and related CTL1 field macros to match the reference
  manual naming.
- Keep short register update calls on a single line.
- No functional changes.

Changes in v6:
- Document that clearing POENn disables the output driver and puts the
  output pin into high impedance.
- Document that a period boundary between the PERIOD and CMPDAT writes can
  result in one transitional cycle using the new period with the previous
  duty cycle.
- No functional changes.

Changes in v5:
- Remove the probe-time controller initialization to preserve PWM outputs
  configured by firmware.
- Configure the counter and waveform settings only for the channel passed to
  .apply().
- Keep the disable path limited to clearing POENn and CNTENn.
- Check for an active paired channel before changing a complementary pair to
  independent mode.
- Return -EBUSY when changing the shared output mode would disturb an active
  paired channel.
- Document that the initial driver supports independent output mode only.
- Remove the unnecessary <linux/mod_devicetable.h> include.
- Simplify the WGCTL action field handling and remove the associated static
  inline mask helpers.
- Rename the PWM field and period limits to clarify their different
  semantics.
- Configure period loading mode explicitly in .apply().
- Preserve the pair-shared clock prescaler and account for it in period and
  duty-cycle calculations.
- Limit the period to 0xffff counter cycles while reserving CMPDAT = 0xffff
  for the full-duty case.

Changes in v4:
- Add a Limitations section to describe the hardware capabilities and driver
  limitations.
- Add a link to the MA35D1 reference manual.
- Replace register address macros containing the base pointer with register
  offset macros.
- Add readl/writel/rmw helper functions.
- Rename TOTAL_CHANNELS to NUM_CHANNELS.
- Use unsigned long for the cached clock rate.
- Use devm_clk_rate_exclusive_get().
- Configure polarity before enabling the counter and output.
- Add controller initialization for up-counting, auto-reload and independent
  output mode.
- Configure the waveform generator for zero-point-high and compare-up-low
  output.
- Fix the period conversion because the hardware period is PERIOD + 1 cycles.
- Limit the maximum PERIOD value to 0xfffe so that CMPDAT = 0xffff can be used
  to generate 100% duty cycle.
- Use CNTEN and POEN bits to report the enabled state in .get_state().
- Disable the PWM by clearing POENn and CNTENn.
- Fix error message capitalization and trailing newlines.
- Fix coding style issues reported by review/checkpatch-style tools.

Changes in v3:
- Update nuvoton,ma35d1-pwm.yaml:
  - Add maintainers entry.
  - Increase "#pwm-cells" to 3.
- Update the MA35D1 PWM driver:
  - Organize include headers and macro definitions.
  - Rename REG_PWM_XXXX macros to MA35D1_REG_PWM_XXXX.
  - Add register address macros.

v2 resend:
- Remove incorrect Reviewed-by tags.

Changes in v2:
- Update nuvoton,ma35d1-pwm.yaml:
  - Fix maxItems of reg to 1.
  - Remove unused label.
- Update the MA35D1 PWM driver:
  - Remove MODULE_ALIAS().
  - Add chip->atomic = true.

Chi-Wen Weng (2):
  dt-bindings: pwm: Add Nuvoton MA35D1 PWM controller
  pwm: Add Nuvoton MA35D1 PWM controller support

 .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      |  45 +++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ma35d1.c                      | 382 ++++++++++++++++++
 4 files changed, 438 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ma35d1.c

-- 
2.25.1

