Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300307;
	b=npqBEiv3KNQbdGY8Xo79SnjXN58Z8wPi4lGlxOhMg/AMRlmhQp0pfPrcoRBp5PPJTRoC
	 7mWYBBwL8YKhXtc532t/9mk7o6Yy0o6y5OXzpuLl7bHWhIHqTV6BrI0KP1YJmKqDJOwAk
	 qayNbNKes92Glzl4YvEhCvUeuLgEqG+pORJ8JWOkPpXjdwmBomJgPbURniF16VCGqldN5
	 YkatJDkvzF0VemyZH4TnfpYFGKMhrcEAgDwuPDJNdmXIbKUUMNXruWK1leGpeDqUZewp2
	 m30RST9nVj9JjI4j67jyD7MHlFspjYwDYpbQBCgsNSnXQrmsYn/jRaCMmRormEbvKUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AC5QClsrz1XRA48HDyLQf18t6aBzWu8gJH35sp8Hs1s=;
	b=3EHNF8kx0PmStR7sICif1ls6wkIxaQOerDxnjZlhZg4jF/4YRCF5zWfrWgFluwiI/ycd
	 si/XLo4LPWp8EgzTXJQv4e1tVp7h8REi2OaVGRFNW59BnXE126Qo1spe+pK1f21NXm75C
	 qQ+FdlRbmOzpBeRa+u07hGZj93dnvxTpW1iBUh7AAwcNIKRpIQfVMCA7SGJOMN1SEzYps
	 wKk/sgMfBpgiH62C6eqRXpxs5goIItyBZ5Cap87jv/oZhqsFs0FvI8sIgFToFYAGFmvcS
	 nR0122M9byNI6kZPDuGUHojCWb1h/9/9zEmR/1m1F5LHMakugj4POLAubyrwnVry3eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2g4LzHv;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC63606A31E
	for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 18:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFC63606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2g4LzHv
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a7992e2f7dso23313735e9.3
        for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793300305; x=1793905105; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AC5QClsrz1XRA48HDyLQf18t6aBzWu8gJH35sp8Hs1s=;
        b=i2g4LzHvhEhfgP+kSGpxME33yyHT6bNO4CAOLS1de+ubq5u0E3qJZLxTJCu97A6fbW
         dp6/GWDsuu3RWqSrQGIMvwI/b58TWpQ7oJYQjdSVNCmtcOsKPQs7rZZRw39n4km8wAqI
         +FyA3/aeuLs9Zf+lAuYLq5z2v1vFS5/i2VDK2B+IOHjKElET37icbLOc4Binsk0DGdw+
         BEbx9xwiHF2gRuslQKF8vD7/wMPymnypmxmdADCSet5eTJIeRy/kLePxgs9LRhg/nov1
         l4sKa9dDTVWQWDrR/KMkHC+imSj3+RqreT9+3X9NGtEPjTsE8cX7avF9ldTT2r50cS+4
         00UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300305; x=1793905105;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AC5QClsrz1XRA48HDyLQf18t6aBzWu8gJH35sp8Hs1s=;
        b=FnUBVQg7go4RQKar7VmkHHq5oRCZ7fAwKAvOZjieGajAajmNMfE0AwwzDVlliY1trj
         w2IoH6uCJ/eCxcxf7ov57MCsd+ILzccyaLCQPghT/SjjrGhKw0iD17vpSKfo4r1IY49l
         WdugXoVQNMhg//OO8EJGarUF01YiLj1PwpZaRcrWT3wNJtU8pJ6Pw62X7TdRzSwSljYU
         wn6JlYzSmfSFSKzn6smBmHnkLAqXqVZS+ZpvmIa+8d3GML53PIwgli++YRfW5vvl/NcT
         gA+WPMcQV+ouRvazPXBV2gOrEkiii83uYXbP73Uq04W7gK5Hj6xeT0FeRxVQBh/No/+z
         dO1g==
X-Gm-Message-State: AFq9FYJvFTaVUS9xRc1vKSYfwT5ct2GPsiqlMQ74If98GvJ0ItYLO1Pa
	+PF2CtRFhUCPvNK6a9r5L0uPOrfb7n4p3R9G6RajjO3mODTPEfYyaakz
X-Gm-Gg: AYBFou0g6t6Al3vQb6vcNYQAbJc59oiX4Gbd3KVbtSgO6vXVItZHQiZd0K3Aystt3ee
	Y5r/1M4UKTlHbbjInBLmL6oYsef8xg1ujvP+RCmyCgXFWMzF8IFIg9kWLvOt1IFIgv+7fAUkayI
	P1Nw2bsXAtpLl2G3adEWuCUmu6xo3ct4AL1GcMikQiIyE3qwYXvegXasaQ6Beb215tXSPw6SEEU
	kRWe7teGh3/JLHYWfOFy29H11yghZuN8H7y4TJAA1XAhkRN5/TUWV7BJzm2A0oO6AN31rF47c2V
	b6K9225fEO8BCmzwrvxUp8qADO+BiDvXd7dTBqKdmI9z0qX5ch0ke5eM68zbYwKjBASNsy+syMa
	w5Qm3lKowN+VVRVS8zsU3ZXY32oR1sMX+MJUm7t2Op83VTg+8Zx8z62kd7Tu6+MRWUWf3rkaxSD
	6INmojrBM+GKSeM9x8Y4XB9blUWqqGTXDy6m4W7OUk6fZgw33sjXI0cWxvTmGz4Be2z+9T49FOA
	DEuWMaXD0grTi5V7gBMjbryG2NWz6u20fofh0eXkZNI2OLcDi5b0zuZLiauLwfC1Gai5w9G57Wm
	YURg/QWapcBIkohhiYc0kQyNVmLkkjPUNykacKJQVTbeya8hMTeYQiKdzYoGVFky0w==
X-Received: by 2002:a05:600c:37c3:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4a96701830cmr143370895e9.25.1793300305012;
        Thu, 29 Oct 2026 11:58:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:eafc:6fb2:6c68:5ae0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896fesm94291535e9.10.2026.10.29.11.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:58:23 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v9 0/7] Add Renesas RZ/G3E GPT support
Date: Thu, 29 Oct 2026 18:58:21 +0000
Message-Id: <20261029-gpt_rzg3e-v9-0-f3a5520388d3@bp.renesas.com>
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
X-B4-Tracking: v=1; b=H4sIAE2X42oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyLHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNL3fSCkviiqnTjVF2zRAtLs1TDlOQk8zQloPqCotS0zAqwWdGxtbU
 AsTDA3FsAAAA=
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793300303; l=6413;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=c8wDrcdQOd2pMDrdrwfnWxCUIIg51PMtaa0aLHC9stw=;
 b=BbmXptapsN/+aukxD1j5qQ7naQl2PPP5WZElv/bLbBIZctqW/biXkTurrb5DDAWa+ygwy6bs7
 mOyuSSLTxY6C/e0C20JC7e8dWaGgiUvDW+2ep17BTa6tmzBE1A80FwI
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

This series extends the RZ/G2L GPT PWM driver with RZ/G3E SoC support.

The RZ/G3E GPT has a number of hardware differences compared to RZ/G2L:
it exposes 16 channels (across two GPT instances of 8 channels each),
uses a 4-bit GTCR prescaler field (versus 3-bit on RZ/G2L), and has a
discontinuous prescale sequence with powers-of-2 scaling rather than the
continuous powers-of-4 sequence on RZ/G2L. It also has additional clocks
and resets (bus clock and rst_s).

POEG support is dropped from this series and will be added later.

v8->v9:
 * Updated commit header for patch#1
 * Dropped fixes tag from patch#1 as there is no functional change.
 * The prescale always initialised (reuse cache only if the sibling is
   running)
 * The round_waveform_tohw() no longer writes the prescale cache.
 * Disabling an idle channel no longer touches the shared registers/
   counter in rzg2l_gpt_write_waveform()
 * The shared registers are only written (and the counter only stopped/
   restarted) when no sibling is running -> no glitch on a running
   sibling in rzg2l_gpt_write_waveform().
 * The rzg2l_gpt_write_waveform() re-validates, under the lock, that the
   sibling still uses the same prescale/period (returns -EBUSY otherwise)
 * Redundant "enable &&" removed in rzg2l_gpt_write_waveform().
 * The rzg2l_gpt_is_ch_enabled() fills *gtcr before the early return.
 * Updated commit description in bindings channel->channels and
   '8channels' to '8 channels'
 * Retain the tag as the change is trivial.
 * Updated a comment in limitation section '8 Channels'->'8 channels'.
- Link v8: https://lore.kernel.org/all/20260825154847.197947-1-biju.das.jz@bp.renesas.com/
v7->v8:
 * Cached prescale value.
 * Updated rzg2l_gpt_write_waveform() for caching the period, If the
   channel is already enabled and the user changes its period.
 * Updated rzg3e_gpt_calculate_prescale() with >= 64.
v6->v7:
 * Reordered the patched moving POEG support to last.
 * Replaced USEC_PER_SEC->NSEC_PER_MSEC for period/duty cycle
   conversion.
 * Avoided recalculation of prescale, if is_small_second_period == true.
 * Moved `wfhw->gtccr = 0` into the if block in rzg2l_gpt_config().
 * Added rzg2l_gpt_poeg_link_channels() and used __free for deallocating
   device node pointer.
 * Replaced dev_err()->dev_err_probe() in rzg2l_gpt_poeg_link_channels().
 * Replaced local variable cells with num_poeg_pairs in
   rzg2l_gpt_poeg_init().
v5->v6:
 * Added patch for fixing period_ticks overflow.
 * Added patch to add missing newlines to dev_err_probe() messages.
 * Dropped extra space in poegs variable assignment in
   rzg2l_gpt_poeg_init().
 * Updated the comment sections of rzg2l_gpt_poeg_init() with POEG and GPT
   in upper-case and replaced configure->configures.
 * Format specifiers in dev_err() changed from %d to %u in
   rzg2l_gpt_poeg_init().
 * Dropped local variables pv and dc from rzg2l_gpt_round_waveform_tohw().
 * Dropped blank line in rzg2l_gpt_round_waveform_tohw().
 * Moved assignment of rzg2l_gpt->period_ticks[ch] to *_write_waveform().
 * Restored clamping of duty_ticks with period_ticks in
   rzg2l_gpt_round_waveform_tohw().
 * Simplified rzg2l_gpt_write_waveform() using else if statement.
 * Dropped local variable gptr in rzg2l_gpt_write_waveform().
 * Moved mutex after early return in rzg2l_gpt_round_waveform_tohw().
 * Dropped extra parameter rzg2l_gpt from rzg2l_gpt_calculate_prescale()
   in rzg2l_gpt_round_waveform_tohw().
 * Updated comment in rzg2l_gpt_calculate_period_or_duty().
 * Updated rzg3e_gpt_calculate_prescale().
v4->v5:
 * Merged GPT linking POEG patch series here.
 * Dropped suspend/resume patch; will be added later.
 * Updated commit description for patches #2, #4, #5, and #6.
 * Replaced return type of rzg2l_gpt_poeg_init() from void to int and
   probe() check this return value.
 * Added more error checks in rzg2l_gpt_poeg_init().
 * Added a patch to drop the unused rzg2l_gpt_chip parameter from
   rzg2l_gpt_calculate_prescale().
 * Updated rzg2l_gpt_round_waveform_tohw() to initialize gtccr when the
   period of the second channel is smaller.
 * Replaced period_ticks with RZG2L_MAX_TICKS for the duty_ticks maximum
   value check in rzg2l_gpt_round_waveform_tohw().
v3->v4:
 * Added wave form callback conversion back to this patch series.
 * Updated rzg2l_gpt_is_ch_enabled() fit into 80-character limit for
   consistency with other functions.
 * Dropped field_{get,prep} as mainline now support it.
 * Updated commit description for patch#3
 * Retained RZG2L_GTCR_TPCS bit definitons
 * Replaced gtcr_tpcs_mask->gtcr_tpcs
 * Updated commit header and description for patch#4
 * Renamed prescale_pow_of_two_mult_factor->prescale_mult
 * Added RZG3E_GTCR_TPCS bit definition for RZ/G3E and added to
   rzg3e_data.
 * Added error checks on suspend() and device set to operational state
   on failure().
 * Added Rb tag from Geert for SoC dtsi.
 * Added SW_GPIO9_CAN1_STB check to gpt0 node.
v2->v3:
 * Added Rb tag from Rob for bindings patch
 * Dropped wave form callback conversion from this patch series as
   it is covered in another series[1]
 * Added suspend/resume support.
v1->v2:
 * Created separate document for RZ/G3E GPT.
 * Updated commit header and description for binding patch.
 * Added waveform callback conversion to this series.
 * Collected tag.
 * Added link to hardware manual
 * Updated limitation section in driver patch.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Biju Das (7):
      pwm: rzg2l-gpt: Update macro used for period/duty cycle conversion
      pwm: rzg2l-gpt: Convert to waveform callbacks
      pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
      pwm: rzg2l-gpt: Add prescale_mult variable to struct rzg2l_gpt_info
      pwm: rzg2l-gpt: Add calculate_prescale() callback to struct rzg2l_gpt_info
      dt-bindings: pwm: Document RZ/G3E GPT support
      pwm: rzg2l-gpt: Add RZ/G3E support

 .../devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml | 323 +++++++++++++++++++
 drivers/pwm/pwm-rzg2l-gpt.c                        | 354 ++++++++++++++-------
 2 files changed, 565 insertions(+), 112 deletions(-)
---
base-commit: 4e7443d29aa19bc779a2a485622cf92f1c7145e5
change-id: 20261029-gpt_rzg3e-6a896e1dcb7f

Best regards,
-- 
Biju Das <biju.das.jz@bp.renesas.com>

