Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498BE41E6DA
	for <linux-pwm@vger.kernel.org>; Tue,  4 Aug 2026 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878860; cv=none; b=mwJiUMjnVwmnTy9Ed2qf4Wa/LNmvWwoOSt4QOKTIBjGz9U6LVajj8iIJKtqtlf6Cjy2Wp7fZLAB9NijNYo+Qu4tNbEOTwAvDv4xDhnfH/hHjh9YCl8AayPnKqoT4mUG4s0o+khyP5H1OjYo6RCj7QNAX1nOXGjaFdMFhsnQendg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878860; c=relaxed/simple;
	bh=Xj2nfGDepiZGa0NSvcobZE3OsNk2DcJY3UKYGvUrxX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CrQoFi4i5ujDH2ldc0FmvFK9Wunh6CLECTnYBUiRNoEGzuUK+F7y+kVonhg19aUJM81FF4NnCcXbbCtEdjWjYGi8V9Yx7tohsLlnd/3qWU3wGQOukGTSC56z69jXYTYzzxxy/p+iuPDFt0lLLM8erbdk8pXaLt9af2dgBcAAndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sb3V7Dde; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sb3V7Dde"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4955cd5da3dso169762b6e.2
        for <linux-pwm@vger.kernel.org>; Tue, 04 Aug 2026 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785878857; x=1786483657; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w+Q9frommDA1jxYT7PN66+gmpag0qJtc9CREHiU22eo=;
        b=sb3V7DdezccxaHrAHqS+mirv4DFcu2BzTQwSujR9++ge3V//TT+HN7dKN9+KxZzH/f
         JjOtcuS0zbYQDDOeu+pJuCLyyMg8WmkjWcvYcT0l/eKAndEYu7yTntUyeO311ym4/PFW
         jSvAQADfqDncliMYLVcUGPwzA6NpX3bQ2eD9LnSH759ZkEwwBZIysIhyJHlhhNgg56Bb
         lfKw8KNO0iKrej7t6diUtuu+nvlrXdG8EFQUYfjw+W8oZ9lIgKvX47QDGn1ZbwGxxtJp
         eQSV8AWZoIND8KAOGcXEh6sXSLnjqltk4efIeRdAc5pObXdAX+903dh5+t5lSZmym+HN
         eTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878857; x=1786483657;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w+Q9frommDA1jxYT7PN66+gmpag0qJtc9CREHiU22eo=;
        b=n0cSTUCk/H4AfBG16phgAwZwuUXs0CGpfXk+v0Nzc5es4U5vl4VSpP+D9lHI2u2Syj
         1Uzk0lF+SQjglZoh6lGjFEv9Z+1zp3QZmG9EpU0hT6wSgiZSLJJQOavXcs7lauKbYaBx
         4UTPfqiJMdz4K3MBiuiOdGvUhgKKth5jORl/sA4vrwj+vJm/iVH+FNPEVaekm2GiVLNa
         kfciVldjqmoXrOPMqyRe6KyBr0G3WVtpUOVta4BO7AcTcsKFoTOEmiZ0U9XqWS4wyJpc
         JT6eQuqQJ4aD2vw5rAudMqCMqs9YLWG8aW8jsFDWfVwGTAte7CaXkNWlZsduAyygWnLG
         09jw==
X-Gm-Message-State: AOJu0YyZEAmHBCkqpyJvzquvcRR5cAWj914p+otdWlSkn+FT4w6ZlP+C
	AzW7S3Xoix5QN3oVoET3X/LH2Ce1fWwNLqhx1on757OYBNRz1Cb1zr2H
X-Gm-Gg: AR+sD12K3Z38atb36hiXSY1Sx+vZEDDAdGq9+BuSfCw+1QF+SR/wJsm/go9Er/Pox+r
	0RFBjY0JCYWXUjjDR3iwUVZCnaXj/ueXvKn7TOcshMi7tZh57wRN79Z7Z0rGWFSiUGufAW8k5/H
	AkNhhk9O5QgBoLIGhqAuz2tay/KWnIm/bvrptXcCKGJHfXLlOBGHk+zakJ79mZLZ4w1yZplqHsd
	pLfLi/CJx6vftInq/xRdHT6hUbm6tMBIm8I4RJGh44slcz6AFnWgxPr/HswbXDMeDIw8hWbVWUp
	FnQydIf3fZJGAmBQ6cqxA1zar97DQBYVBCFeByAhoi1U9QA2x65Cp34DjKD4TkE4707fLNqxNC0
	PaAoxvaiXuxu6FSfhLAf38UBkC3wXY2UXsOKL1PJxDCdsDY3sb/v4hoFZiBv/NLpFXIJqE0aDWK
	6kklADsDfhCvAyf6VvhGo5fjmz4w/JFpybYzDHwTgD1DXPtfdg2VPnI2Y+3dLt50NafDw+4eNEg
	TfS9tR3eJj1yb9R7LSORVSaYTZreyYb97E2ZfqpEBphwZbxdv0nlPYWCiDB86+UpXBBQHlHTekv
	Hb3YfJ+Jk+hbCEi4kiGU9Yq7uQKImuu1KXDmV0oMUudaBGCe5iVN74W/7dqizRC0y7YsjlDxj/G
	WaxrEQz4Zbpa3pi+6
X-Received: by 2002:a05:6808:3506:b0:496:3a1:e44f with SMTP id 5614622812f47-4afadf85227mr1137479b6e.6.1785878856956;
        Tue, 04 Aug 2026 14:27:36 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae7c50e9sm451659b6e.17.2026.08.04.14.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:27:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v8 0/4] Introduce Allwinner H616 PWM controller
Date: Tue, 04 Aug 2026 15:27:23 -0600
Message-Id: <20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XRy07DMBAF0F+pssbWPPxkxX+gLtrEbYxoXDlpA
 FX9d+wiFMQChZV1JZ87I/vajCHHMDaPm2uTwxzHmIYS3MOmafvdcAwidiU3BGTAAYveoBHnt5O
 YnQiEO0/KgiduijjncIjv97bn7VceL/uX0E61ot445HQSU5/Dbmm1wKiJUEv05LQXKHIsw3Mnj
 2FIl+5pn9L0GgfZplMt6eM4pfxx33nGOqwWaSTQCEDsJWrDrPnvprrhTD84WnCkQUkHRGYF5m9
 sAInBMxNJZLLs/AquFs6gwaPXXpJmYKtWcL1whQYZFXpZn7KcK7j5xVUZW7gBzXYFtwv/3wdub
 7fbJ/VHjml3AgAA
X-Change-ID: 20260803-h616-pwm-v8-e21a92470923
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Paul Kocialkowski <paulk@sys-base.io>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, 
 bigunclemax@gmail.com, linux-clk@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2

The Allwinner H616 PWM controller is quite different from the A10 one.

It can drive six PWM channels and, like the A10 controller, each channel
has a bypass that permits it to output a clock instead of a PWM waveform.

The channels are paired two by two and share a first mux, prescaler and
gate. Each channel then has another prescaler, which is bypassed when
that channel's bypass output is enabled.

The clock structure looks like this:

            _____      ______      ________
OSC24M --->|     |    |      |    |        |
APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
           |_____|    |______|    |________|
                          ________
                         |        |
                      +->| /div_k |---> PWM_clock_x
                      |  |________|
                      |    ______
                      |   |      |
                      +-->| Gate |----> PWM_bypass_clock_x
                      |   |______|
PWM_clock_src_xy -----+   ________
                      |  |        |
                      +->| /div_k |---> PWM_clock_y
                      |  |________|
                      |    ______
                      |   |      |
                      +-->| Gate |----> PWM_bypass_clock_y
                          |______|

Here, xy can be 0/1, 2/3 or 4/5.

Because this is unusually complex for a PWM controller, the driver uses
the Common Clock Framework to manage the clocks.

PWM_clock_x/y serve the PWM function. PWM_bypass_clock_x/y serve the
clock-provider function.

The PWM driver acts as a clock provider for the bypass clocks. This is
needed, for example, by the integrated X-Powers AC200 or AC300 Ethernet
PHY co-packaged with some H616-family SoCs, whose input clock comes from
the PWM5 output.

Normally a fixed clock can be built on a PWM through the pwm-clock
driver. That interface, however, passes an integer-nanosecond period and
50% duty waveform to the PWM provider. Its clock-frequency property is
the rate advertised by pwm-clock; it is not an exact-frequency request
made to the underlying PWM hardware.

For example, pwm-clock represents 24 MHz as a 42 ns period with a 21 ns
duty time. The exhaustive v8 PWM rounding happens to select the H616
bypass and produce 24 MHz for that waveform, but this is a consequence
of the PWM rounding rules, not a contract that the hardware rate equals
the rate advertised by pwm-clock. Exposing the bypass through CCF
instead lets the consumer request an actual clock rate, conveys that
duty-cycle and polarity control are not required, and makes the shared
pair source visible to CCF's rate arbitration.

The H616 block is therefore both a PWM controller and a clock provider
when bypass is enabled.

Why v8 substantially restructures v7
------------------------------------

The v7 driver registered a composite CCF clock for each channel even
though the mux, div_m prescaler and gate belong to a channel pair. That
model made the channels appear independent and allowed one channel's
rate selection to reprogram the active sibling. V8 registers one CCF
clock for each hardware pair and programs only the channel-local div_k
prescaler in the PWM path. Each Linux-managed active output protects the
pair rate, so an incompatible request fails instead of silently changing
the sibling waveform.

Firmware can leave a channel running before Linux has acquired either its
PWM or bypass clock, so CCF reference counts alone cannot describe every
active output. The pair gate and rate-change notifier therefore also
inspect the hardware channel-enable bits. Generic unused-clock cleanup
preserves inherited outputs long enough for declared consumers to claim
them. At driver sync_state(), channels which remain unowned are stopped and
empty shared gates are reconciled through CCF. This prevents both premature
shutdown of a late-probing consumer and indefinite unclaimed outputs.

The bypass clock remains a separate child of the pair clock. PWM request
and clock prepare callbacks arbitrate ownership of the physical output,
while CCF rate protection covers the complete prepared lifetime of a
bypass clock. This models the actual shared resource and avoids encoding
clock intent as a special PWM waveform.

The waveform conversion was also rewritten rather than extending v7's
single-source heuristic. It now enumerates every reachable parent,
div_m, div_k and bypass setting and applies the PWM core's ordered
period, duty and offset rounding rules. This is needed to handle
inverted waveforms, constant levels, the 65536-tick period boundary and
equivalent settings without overflow or an arbitrary parent choice.

Hardware updates are now transactional. The driver waits for a pending
period update to latch, uses live PPR updates only when the input clock,
prescaler and polarity remain safe, and quiesces the channel for rate,
polarity or bypass transitions. A failed pair-rate change is rolled back
before the previous output is restored. This follows the documented
period-ready and PCLK constraints and avoids disturbing an active
sibling. The driver records the active and newly programmed periods to
derive a tight timeout for its own updates. Only an unknown firmware update
falls back to the maximum possible hardware period, and an adaptive sleep
interval bounds the number of MMIO polls even in that case.

Pulse and active dead-zone modes remain unsupported because the PWM API
cannot represent them. A dead-zone enable left behind while both pair
outputs are disabled is only dormant configuration, however, so v8 clears
that state before programming a normal PWM instead of making the channel
unusable until reset.

Finally, all clock topology objects are allocated per device and
registered with managed helpers after reset deassertion. This replaces
v7's mutable static clock templates and manual unwind path, eliminating
cross-device state, lifetime and probe-failure hazards reported during
v7 review.

Runtime validation was performed on an H616 system with a co-packaged
AC300 Ethernet PHY. The PWM5 bypass supplied an exact 24 MHz PHY clock.
PWM waveform tests covered normal and inverted polarity and the 65536-tick
full-duty boundary. PWM4 was exercised concurrently without changing the
active PWM5 clock or Ethernet link, while conflicting PWM5 ownership was
rejected. An injected firmware-active PWM2 bypass remained intact through
probe and unused-clock cleanup, then was stopped at sync_state() because no
consumer claimed it; its now-empty shared pair gate was disabled as well.
An injected firmware-active PWM4 bypass on the same pair was also removed
without changing PWM5's shared gate, rate or Ethernet link. The
firmware-enabled PWM5 bypass was claimed by the AC300 consumer and remained
at exactly 24 MHz with a 100 Mbps link. A dormant dead-zone bit was cleared
before programming and updating a 100 ms waveform, while an active
dead-zone configuration rejected the update without disturbing the running
output.
Full PWM and MAC unbind/rebind recovered successfully, ten cold boots
completed with the 24 MHz clock and 100 Mbps link, and more than 495 MB of
receive traffic completed without RX errors or drops.

This series is based on upstream commit 31996e14bd59.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Assisted-by: OpenAI Codex:gpt-5.6-sol
---
Changes v7 -> v8:
  - require both the module and bus input clocks for H616
  - clear the complete two-bit clock-source selector field
  - leave rate and period registers untouched when disabling a channel
  - distinguish PWM-owned bypass signals from clock-owned bypass outputs
  - round shortest-period requests using the fastest achievable clock
  - encode constant levels without overflowing the 16-bit active-cycle field
  - rebase on upstream commit 31996e14bd59
  - require #clock-cells for the H616 clock provider  (reported by Sashiko)
  - allocate clock topology state per device, use the fixed two-parent map,
    and use managed clock registration
    (reported by Sashiko and suggested by Philipp)
  - deassert reset before registering clocks and keep the reset handle local
    (reported by Sashiko and suggested by Philipp)
  - arbitrate channel ownership in clock prepare/unprepare and select bypass
    only while the clock output is enabled  (reported by Sashiko)
  - roll back failed PWM requests and serialize channel release
    (reported by Sashiko)
  - protect the shared pair source while either sibling channel is active
    (reported by Sashiko)
  - preserve the 65536-tick duty intermediate before polarity conversion
    (reported by Sashiko)
  - keep the hardware-waveform state within the PWM core storage limit
  - clarify that either co-packaged AC200 or AC300 PHY uses the bypass clock
  - drop driver Tested-by tags after the clock implementation was reworked
  - quantize inverted waveforms in hardware ticks and report their
    physical offset
  - force released channels off so stale waveforms cannot restart with a
    sibling
  - track the active and pending cycle for the period-update handshake,
    adapt the sleep interval to bound MMIO polling on long periods, and
    honor the PCLK rate constraint
  - quiesce rate, polarity and bypass transitions before reprogramming the
    output
  - clear unsupported pulse mode when programming periodic waveforms
  - describe the bypass clock cells and simplify the fixed parent topology
  - avoid resetting active pair registers during probe
  - model only shared pair clocks in CCF and program per-channel dividers
    directly
  - make pair-rate changes transactional and hold exclusivity only while
    an output is active
  - implement formal waveform rounding across all parent, divider and
    bypass choices
  - preserve firmware-active outputs through generic unused-clock cleanup,
    stop any still-unclaimed channels at sync_state(), reconcile empty pair
    gates through CCF, and reject pair retuning while either output is
    active
  - clear dormant dead-zone state when both pair outputs are disabled,
    while rejecting active dead-zone and pulse modes which the PWM API
    cannot represent
  - correct the hardware topology to show the pair gate before div_m
  - Link to v7:
    https://patch.msgid.link/20260703152215.192859-1-richard.genoud@bootlin.com

Changes v6 -> v7:
  - rebase on v7.2-rc1
  - Cc Common Clock Framework maintainers  (suggested by Uwe)
  - add missing static before SUN8I_PWM_X_BYPASS_GATE
  - reorder code in probe to fix potential lifecycle issues
  - set pwmcc_data[i].parent_names to NULL in sun8i_pwm_unregister_clk

Changes v5 -> v6:
  - remove trailing junk after the patch 4 commit message
  - remove Tested-by tags where they do not apply

Changes v4 -> v5:
  - fix bypass handling for channels greater than 1
  - add colons to clarify two debug messages
  - switch from H616 to sun8i prefixes in code, filenames and module names
  - fix consistency issues in macro parameters
  - rename confusing macros
  - rebase on v7.0

Changes v3 -> v4:
  - gather Acked-by and Tested-by tags
  - fix a pointer-to-integer cast size warning on ARC
  - add a managed action for clk_hw_unregister_composite
    (suggested by Philipp)
  - remove the unused pwm_remove function  (suggested by Philipp)

Changes v2 -> v3:
  - use U32_MAX instead of defining UINT32_MAX
  - document U32_MAX usage in clk_round_rate()
  - define clk_table_div_m using macros
  - fix formatting
  - correct the parent clock order
  - simplify code using scoped_guard()
  - add a missing const qualifier and rename to_h616_pwm_chip() to
    h616_pwm_from_chip()
  - add missing error messages and remove redundant ones
  - rename cnt to period_ticks and duty_cnt to duty_ticks
  - fix PWM_PERIOD_MAX
  - add the remove callback
  - replace DIV_ROUND_CLOSEST_ULL with DIV_ROUND_UP_ULL
  - add H616 prefixes
  - protect _reg in macros
  - switch from apply/get_state to waveforms
  - shrink struct h616_pwm_channel
  - rebase on v6.19-rc4

Changes v1 -> v2:
  - rebase on v6.19-rc1
  - add missing headers
  - remove MODULE_ALIAS  (suggested by Krzysztof)
  - use the sun4i-pwm binding instead of adding a new one
    (suggested by Krzysztof)
  - retrieve parent clocks from the device tree
  - change num_parents to unsigned int

---
Richard Genoud (4):
      dt-bindings: pwm: allwinner: add h616 pwm compatible
      pwm: sun8i: Add H616 PWM support
      arm64: dts: allwinner: h616: add PWM controller
      MAINTAINERS: Add entry on Allwinner sun8i/H616 PWM driver

 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml      |   33 +-
 MAINTAINERS                                        |    5 +
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     |   47 +
 drivers/pwm/Kconfig                                |   12 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-sun8i.c                            | 1542 ++++++++++++++++++++
 6 files changed, 1639 insertions(+), 1 deletion(-)
---
base-commit: 31996e14bd59840692d6c1c6e41ef878b77a2967
change-id: 20260803-h616-pwm-v8-e21a92470923

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

