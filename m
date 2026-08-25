Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7235C6A1
	for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672934; cv=none; b=aqZ3yHSV3MtsXDLzQXMPtcHipZvOQNabTeQBO7Tm/CAsNiDnjevuxPr5XOoWnRBzS79iVKo7wxCKdGQcyiOtSKSom+ZgmNm5Q3o/opoHAvWJqkRckWjMna56Bpqrv8KXxEvWAaI3gR9qNKoiWkMlVKwQgUwI4ybaE/tu0UdeU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672934; c=relaxed/simple;
	bh=rxyHzPNUz9b4zNYK7txdcG7VFbrJRknz+tzv7o8YuWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPZZZE31UMctC8ixMYT4mCq+TvzMbItqvspbXbCbncycWMmBVcTbafBWmlUPyjdI5irrmn33w8e9IiGEUk/6KrBi956mxotGI4ci/lnz+hNXZ5SctxEGyU28wAloReOVU4g32FaxNmbglX/nsOP3n5jn+ixpypwx2w2+xTs9jEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+xAQa/0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+xAQa/0"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2074710751so900164266b.1
        for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787672931; x=1788277731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jebXbQa4a7c2PMydy+yk1SSG+FUmio3GZyCN/zd+c9c=;
        b=N+xAQa/0ceBiYhWnEYB3U+mnD5IDt0WJpcT6pwq9cZgtakR84L+YueI7kLqSVNZdS+
         MvEeAD4KMhPnGCLC51vKWkrXm8aMMulWV4QUKJis2Q2cAxfopDiYWUVOEQm6HHk03T1e
         RWQnNQTUmFq++KJFbti84+f5PCeEiMOJP6vKLRLKwUT5k6h/XpdPd8qd0AUKlxXt6Oe3
         n7cneK0x+ypQNWtPWJPQmAmuQdSaqzmrA5WFgTKp1qSfj4DjDNyzi+QGeKwZVGdoTXCL
         6ZY04SJz2ix/2q0H1fM859BS1FPNBbVzHYhs4z09JvAXtC9LPsUrE/J4BOddsad4TcEw
         zRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787672931; x=1788277731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jebXbQa4a7c2PMydy+yk1SSG+FUmio3GZyCN/zd+c9c=;
        b=NHOuMyZxGMM+UGHqgRglniYUaafcpzlWA8VBkVFXzQjIfZLwBERmOx1w2ioa6m35QC
         aHaWQj0Rrx003xcMM7+cC18X+YHEZP5P97V50cvD5f3X/AleOKqd8t19E7wNMaRzKzMy
         gsO/eB2Z2HMD0mK8XMmXkN5wZkcv/ND9vYfls7Ao1M5SMn9QfTCxtVC2FhxxPAxPr0QQ
         2qYDwM/wqKzJ9ezv2hBaS2uSXClQH32GuMDCN9YAKmFAKBRw63Lx1GaP1+udKZOlAtKg
         izvv5FisCfg3TH7c0HAeYEJzsE+kDyFgfpeHV80EtORDunMrI6+wI5u8a4DSuNP69Rd9
         M3Sw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6e8FNvzcfLdsxy+rAZDFPMdsZibpVZzTZx1ll+4JnZ4OBxVDUOX948UJOSyfRtcOD2L5SxtSyYuo=@vger.kernel.org
X-Gm-Message-State: AFuF++lodOWT2S/sZoEgqg6c+na0iRPHlvchKKq/h8OToR4n9s913H/O
	xoIT/L77P8P/JQRAwgom6fd4A0bIn6OXvS0M0/Y7sKYpV7spEhKNkzRJ
X-Gm-Gg: AR+sD12FLJkkdZ3maI7cOvKNTusimCtP7p0xqMHI1hBWTgIi3P8YltvOLmdOsIcEfzM
	EwXw4HzRM+lDUCYHA+2rDE2A2AMlNM8n5ZlfjVLtdc7F0OWFkwYPxgi92Khy7lA+cw3fTEZSc3U
	Tsz9CsK7KTYeTfAgHwY/Cll+cJKKjkJgUF5NzL3YXHzg41rXMuD1/KXKP+YyH66ExB37dmgtWI3
	joiyZOqvHWGo8RtPkhHbYOfbrU1fd4M92LZGu8E7pxuniQnd3P+X+Vv+fmfCJQKMaHv8KSy80H8
	zE2ThkRFDRjp+7mYPdmLdRlz834ubhvyIAgy4j633TWK2NIjKeOz4WJi7Y8xp5049ni9VtkGgO8
	vmIs0z/DySKI6yM3e2KMOuA+K8g7uGzd2xzObrNYyXsbFsZHogInDYmYDWU3tt07uEwbSuTgN0r
	CMRxOtAYIwpLeO6TNQFqtai2rHuueVm3M2dVgs8T3hBQmKl0UJ78n51HMkesPWJNR3US4Pv713Z
	Hvw6fUoDd8Ds6dA6LX5W+E=
X-Received: by 2002:a17:906:7316:b0:c19:45e3:2f57 with SMTP id a640c23a62f3a-c2491cbca79mr3035402366b.9.1787672930739;
        Tue, 25 Aug 2026 08:48:50 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:81d:57c0:e4cb:959c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a6fd69asm16682066b.18.2026.08.25.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:48:50 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v8 0/9] Add Renesas RZ/G3E GPT support
Date: Tue, 25 Aug 2026 16:48:28 +0100
Message-ID: <20260825154847.197948-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

This series extends the RZ/G2L GPT PWM driver with RZ/G3E SoC support.

The RZ/G3E GPT has a number of hardware differences compared to RZ/G2L:
it exposes 16 channels (across two GPT instances of 8 channels each),
uses a 4-bit GTCR prescaler field (versus 3-bit on RZ/G2L), and has a
discontinuous prescale sequence with powers-of-2 scaling rather than the
continuous powers-of-4 sequence on RZ/G2L. It also has additional clocks
and resets (bus clock and rst_s).

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

Biju Das (9):
  pwm: rzg2l-gpt: Fix macro used for period/duty cycle conversion
  pwm: rzg2l-gpt: Convert to waveform callbacks
  pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
  pwm: rzg2l-gpt: Add prescale_mult variable to struct rzg2l_gpt_info
  pwm: rzg2l-gpt: Add calculate_prescale() callback to struct
    rzg2l_gpt_info
  dt-bindings: pwm: Document RZ/G3E GPT support
  pwm: rzg2l-gpt: Add RZ/G3E support
  dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
  pwm: rzg2l-gpt: Add support for gpt linking with poeg

 .../bindings/pwm/renesas,rzg2l-gpt.yaml       |  23 ++
 .../bindings/pwm/renesas,rzg3e-gpt.yaml       | 323 +++++++++++++++
 drivers/pwm/pwm-rzg2l-gpt.c                   | 385 ++++++++++++++----
 3 files changed, 643 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml

-- 
2.43.0

