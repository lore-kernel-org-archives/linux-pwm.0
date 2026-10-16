Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA571399890
	for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2026 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167168; cv=none; b=HPqpllsc8LW4JRwxVeHG4OpizHr56o15aY68EyGtIAJ5+0aB2KerRs8UrVF8y8mD0vzSEwdBCC+VPtC1MUCXgjK/ciNPHmd8LIPvcgQ1fDF5BWLS42XMgjyt0v4MFU+g9iByRGVfI0awfgwTXcT5dwVCfAJmJLCM2J546mHEyBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167168; c=relaxed/simple;
	bh=vIQC0iNEPinyADJNR1IjyEaSuazGFNiYyGhSMhUZOHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZZJjHngjL236jsmeFLSc7cLdg/1uzfmZgMczYEet8kmNFq7gxwT9O1gmb8q3B7PkhqFYxSVHXLh2guVA4qrh+oWUJKDBgfHMc1YHNChcpHE8s73NNJYlwH6oPN1gTvdehn9q1fbU5I4Vi5PDKkGa/6jVtgBOawC1l7d0NNxIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enDCAlY7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enDCAlY7"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-487049569b6so5074f8f.1
        for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2026 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792167162; x=1792771962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OlkwSWzoA5MLDYVrt4WEMA112MFvqLN16uXgQLSqhvM=;
        b=enDCAlY7zVfQ8o16wMUYS6gJeoFVnxyO6uKw/Kq7u3kbHnQXnE9tWIfmJQ4A8VoJtu
         OOWjCr0r5eXnCCUWlT1AoLxZ7iajMwuil9vza0uNKRCgwxDemVHlZHdXP5ujaLw4F9nu
         OgtUWi1ZsEAQOFET+oy1eE9wNxBAtrBkNSu/rYcUCUFl/hqtFyMg2xIRixSl70RJywp0
         OuJK8lXg3AvloJO4AtDQzivaQUgdMVSN6t3OSUhZo+Ls/N25bLjDrcDaHsSwiJDhM/pj
         YRtNohlKd4tscZO53tCg339FcMx4Ux29VG9Kp5gvjGuhNFqJQFh7CtusZ1lGBelkPnpF
         iVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792167162; x=1792771962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlkwSWzoA5MLDYVrt4WEMA112MFvqLN16uXgQLSqhvM=;
        b=u3W1EtOExQFq0a1wsyF96DYEfUdEbClKZXQqRql1YVbH7flTjxZEqFhkAZmwwpwW3Z
         Rd/vgKgIrDHJgyjqwhBa91j+HWBoNjTNx24swNzci5w9W+7tEmfQaiqei4P9zgugPXt3
         059Ycm9bzmeLBfUPV1ZVQbFFZvwExYkQTb3NchsFS1m/dh17Zabs3mMxJwIbEjJlbzG2
         RshMnCMTXsePxx39FKOEJ0eb0NbSxLvDfCHHqzTalJCggA6afvemJTLhTctdYv863SiD
         /afskmel73Yb6uc5Nc86/BJhv5zm0FtbsPgSnL2CeKzQdLcbGX1ORLqSnyICdzZKrfEU
         hzAQ==
X-Forwarded-Encrypted: i=1; AKwUvBy//o5jtvJlkxZ5iXJxiOw4rAW8mJ9F+MF6alnyF3dwYvFjYRSZDji9+ywNRja0wKzvpxQ4AWnUbFU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJfDxBvgXxG81lwIroZA+jJO79TRPbiTQHxrMtdbUXNhaDiKly
	wiuW8LbxD5CAGkscE1W7xpkHvRxgEPqOL267V64ktGnQGvQcSbsfhd4e
X-Gm-Gg: AYBFou3BiLGzeg6CoWpixmJOL5Sjhwi56vvovcWq6NAshZgBLRHcIZSO928g5WykP9g
	g/qFCwoAkCIr3r23fv5jtqLzPd/ysAB1z5rKfepOWmBe6JCjPX/8zlOY0nx/NK+fAjcSLMNKwve
	QRNIoYR8NoBj8WlOX5831VqVbpeMG4GsrnoleyBx0ShpkSMYd7eX91dhA3w6qHMBy4ovDXi2vn7
	qFWtSLb2r54XBYJxYhPNiA7pIS7neOKYQyVEgUguPu9amWZ8/r2lM58AX1S9zolQJNk2MFXhm/N
	iEd7PSz8Vr1mAo7u8WQnP2hUcHwvJWv81lv+Obfu5XmV/+dgIbRmFv4asdslywtFf5Oncml3nWa
	0oTAgBsO7JIwiHPGRHs2xbM3Cepa1VG/RRUUI4sQ1J9iMo8gKL9vPrgUkyBGMbXpu7mGMES2+LC
	X0CxUwTOhjD+eykA8C749eit7Wxnsc6BFQTNOWDXq4yMrxd1950d89VCnJbShiWYmLZPoXR5RYo
	Dy8am5gOi/cuIgmH/ICRsr7BOYv9FdJBcYMBobxrftv00pcj9AG0U1YvCI2a3TI3TMK50m+Raoh
	uzm8Xypih+6Zd5olQK2UNNwUAs2ans6QmncKyBb0Q2tEuG5Cvk0r0XUU1A8MJ65TdNQuU/vjgET
	RRw==
X-Received: by 2002:a05:6000:4eb:b0:48d:f02c:eb68 with SMTP id ffacd0b85a97d-48e07bc4e8emr74849f8f.10.1792167161609;
        Fri, 16 Oct 2026 09:12:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a951-9501-1471-d90c-a21f-9dd7.310.pool.telefonica.de. [2a02:3100:a951:9501:1471:d90c:a21f:9dd7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f9c41sm6366339f8f.38.2026.10.16.09.12.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 09:12:41 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] pwm: atmel: Fix prescaler for periods of 2^32 clock cycles or more
Date: Fri, 16 Oct 2026 18:12:21 +0200
Message-Id: <20261016161221.16553-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atmel_pwm_calculate_cprd_and_pres() keeps the period in clock cycles in
an unsigned long long but derives the prescaler from fls(cycles). fls()
takes an unsigned int, so the upper 32 bits are ignored.

On controllers that the driver configures with a 32-bit period register
(SAM9X60, SAM9X7) a request of 2^32 clock cycles or more therefore gets
prescaler 0 and a truncated CPRD. The request succeeds and sysfs
reports the requested period.

On a SAM9X75 (PWM clock 266.67 MHz) this affects periods from about
16.1 s on. Requesting 20 s with a 10 s duty cycle

  # echo 2 > /sys/class/pwm/pwmchip0/export
  # echo 20000000000 > /sys/class/pwm/pwmchip0/pwm2/period
  # echo 10000000000 > /sys/class/pwm/pwmchip0/pwm2/duty_cycle
  # echo 1 > /sys/class/pwm/pwmchip0/pwm2/enable

programs CPRE=0, CPRD=0x3de4355c and CDTY=0x9ef21aae. The channel runs
with a period of 3.9 s, measured from the period end flag in PWM_ISR.
With this duty cycle CDTY is above CPRD, so the output stays inactive
and an LED on it stays dark.

Use fls64() so that the prescaler is derived from the full 64-bit
value. The driver then programs CPRE=1, CPRD=0x9ef21aae and
CDTY=0x4f790d57. The measured period is 20.0 s and the LED is on for
10 s of every 20 s.

Controllers configured with a 16-bit period register are unaffected
for all representable periods. Some oversized requests of 2^32 clock
cycles or more now fail with -EINVAL instead of being programmed with
truncated values. Clamping such requests to the maximum possible
configuration is a pre-existing issue best addressed when converting
the driver to the waveform API.

The truncation was not reachable when it was introduced. The period
was an unsigned int in nanoseconds then, which limits it to about
4.29 s. Commit a9d887dc1c60 ("pwm: Convert period and duty cycle to
u64") made longer periods possible.

Fixes: a9d887dc1c60 ("pwm: Convert period and duty cycle to u64")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
- Keep only the Fixes tag for the commit that exposed the bug (Uwe).
- Clarify the pre-existing handling of oversized requests (Uwe).
- Add Microchip's confirmation of the data sheet error.
- Rebase onto v7.3-rc7.
- No code changes from v1.

v1: https://lore.kernel.org/r/20261003083036.21584-1-kmehltretter@gmail.com/

Notes:
    Found while testing a Rust port of this driver on a SAM9X75 Curiosity
    board. The port uses a 64-bit fls. Its registers differed from the C
    driver for long periods.

    Tested on that board with a v7.3-rc5-based kernel built with clang
    22.1.8. PC20 was routed to PWM2 (peripheral function C) in a local
    device tree. The blue LED is on that pin.

    - Without the patch there are 23 period ends in 90 s, 3.88 s to 3.93 s
      apart. The LED stays dark.
    - With the patch the period ends are 19.98 s to 20.01 s apart. The LED
      is on for 10 s of every 20 s.

    The SAM9X60 and SAM9X7 data sheets describe the channel counter as
    16 bit. That does not match the hardware.

    - The 20.0 s result needs CPRD=0x9ef21aae. All 32 bits are used.
    - Commit 0285827d546d ("pwm: atmel: Add support for controllers with
      32 bit counters") says 32 bit.
    - Microchip's Harmony PWM example for this board programs
      CPRD=133333333.

    Microchip support has confirmed that the data sheets are incorrect and
    will be corrected.

 drivers/pwm/pwm-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 86918523d821..574020d90a3b 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -195,7 +195,7 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 	 * So for each bit the number of clock cycles is wider divide the input
 	 * clock frequency by two using pres and shift cprd accordingly.
 	 */
-	shift = fls(cycles) - atmel_pwm->data->cfg.period_bits;
+	shift = fls64(cycles) - atmel_pwm->data->cfg.period_bits;
 
 	if (shift > PWM_MAX_PRES) {
 		dev_err(pwmchip_parent(chip), "pres exceeds the maximum value\n");

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.39.5 (Apple Git-154)
