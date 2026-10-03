Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1993603E8
	for <linux-pwm@vger.kernel.org>; Sat,  3 Oct 2026 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791016256; cv=none; b=i6iIL+rODfggI2QrrrMF4oD8eDn3FvHb70HVU+AOtqUv29O/xT8P96RFgdAQ7uv6jQfgERFj8/qPabm97S/Kj+zNYyu7TYgY5YZKOVzgNJgi6/7aHbb0ZBx8405SzbvoLPTQ7nZU5Iw9KFS8QiWYB5DfSu241U4D57qgZ1o/8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791016256; c=relaxed/simple;
	bh=TaMpx5R7b+d7k5ur0zpZMj1+E/mTzW5SZHjVmLYbKvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YCvnm2jSGf4/XQhOA8homwQl5YQKXWcYQjkDALCPNXK3DCtRWfSBKoIHVEh2RZ4ShJbMEKRMLk9/rMHjyfVwRVJTrsjJmUplfSZZF46UMCa95zT6D1ZNi0VALGC7SRHSa99Gw2Z1Vih1A3x2QTJ5JJ+anMRkmWrKTwMH1GILSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O69elUty; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O69elUty"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so4391545e9.3
        for <linux-pwm@vger.kernel.org>; Sat, 03 Oct 2026 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791016253; x=1791621053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5XQ8GeFAuXLkcxtw6tW3UD4HNYETCz+1QlyPsmJftWg=;
        b=O69elUtytd4CSjTvnS7VtIjD1Mx2NczBZ4U+dijD4RZKCG+n7m22snMKQ4Ke/DaFvn
         O9HZURGbC0zvplzzhy9/iMFHSkdc5z+G7IPlGvc1tW2f6HBDvVq20iMJrP8iC5wpkGxI
         JnPjVIf7xWrC/bYJ8K5zzgP3x4g1gD7PGDi47n1NDrk671O2W8GRdwZkiyAETyv41UqU
         q/9d6mdBFpX8HDzQNYH3QxVIxMMqHbqwlSzK0ymcDBauzL5iE7IpWactwQMNEeEH+l3U
         cU73VVYmR2P2pDeh0zZ0TFwTBSkKpqLdXBVV37nGNnb5tFPYF6wEk9ohPz3B2tc+Gdz7
         /3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791016253; x=1791621053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5XQ8GeFAuXLkcxtw6tW3UD4HNYETCz+1QlyPsmJftWg=;
        b=i4hrKdfC7y2e3/AK0vAF8n9Yy1thfzfq2E65sct+2MvldCKF2kWT2hsVNwqoFX288L
         29jZ82NlUnT+PlAR9gy3pnxXApQcjtU97EU5NVNkHo1wuAiyOaRWS9kN4pcJi2D8Sb73
         x2SB5zCZMPXugxagUBYiVuWDxyP/1olTVZa92fE7rRqJlwoo846tw14gVGa+hnXyqfW4
         VuW+0Yp6fgeK6tZnSQ+Q1VrQLafAAxuwFZfwjZzw/zNtZV7reZQeDoghvdg128W8Mh8A
         Qxxheq4Ly1q7QZjtNIjJNSYAliZ3sXySxUdywST2hpOhVmAowevXLyZQDEJqm4zgI3Ay
         JwaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbare5tJK57k3+OLjmrMI3pPIFOF2ShEu98TWKmtIfw664eGWMRAVslgeI+uGZnzHY+qSvmKFKRlY=@vger.kernel.org
X-Gm-Message-State: AFuF++lINpT/4rmvso1qSxNOtQcWSaVmg+U/0LKgw803AVTXU0JvUja9
	HHiZchUbBl8xg48TAtzPkDtfE6S+dE4+46b+9XRA++RdnDQH4pJbTnpo
X-Gm-Gg: AYBFou1sZyyXw+TsgS/rQsoguu6WzbpefTiCjJUOdrFzZ85Ip+8Er8RpsoHjnXYgw54
	844Tqa0z57rkLQAkZMYdQ3tem9iIQKZBsOFOmmjcJVIufuoqJboKmg+Es229ZjXf63wb6f2VSSQ
	Rwsl8+xLRo2do3R7YT1700U7pboHTz0lsIBOovcnMphmLbLpi0Fj/99OvS7MhMQGMVeBnPOR8/e
	epFmb/THssU8sowsDHcpRqBudACtk/vprRSpt8fLx2nHtTq2AENaPmQHditm2A2fFEy/bmXb01P
	iyS1FSF7kIQa9HeIJxLw1DWUCaJB5y+ABrdFhjrN40h3Wzyny30ffKktEGnW3FukA3+qgj8QNfM
	PhJh2GPBxaULLA0gWqt/q9vUinLs3jMgUdtKE61WVf4MYfPcZhWO7ktzRlAgS9MrqCw+EnufxjA
	j/gC2z3J5IYjf1Nhf7pliF4IRfDIKFrP/MTzAqkhkqLRMCQCEH61YIvSmajXF0Z66LPkJdfkLyw
	D++uLhEsBz2kCqE1hRc6OHwWxDh7t1HqT6vUwvIVGp/QIPM22+wcqePHJ2ecyWKubdI2LeKJ9BT
	z8s5cs0nPNc+16SxpmbLbd21yfkibK07jRhFuinfg5NDYiWa89kuPeyqj99BYJ1gpUX3vm10aiR
	TvQ==
X-Received: by 2002:a05:600c:46d0:b0:49c:fa21:1c84 with SMTP id 5b1f17b1804b1-4a0275a28d5mr90096835e9.25.1791016253327;
        Sat, 03 Oct 2026 01:30:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0304407d2sm102442715e9.0.2026.10.03.01.30.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 01:30:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: atmel: Fix prescaler for periods of 2^32 clock cycles or more
Date: Sat,  3 Oct 2026 10:30:35 +0200
Message-Id: <20261003083036.21584-1-kmehltretter@gmail.com>
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
for all representable periods. Some out-of-range requests of 2^32 clock
cycles or more were accepted and programmed with truncated values. They
now fail with -EINVAL.

The truncation was not reachable when it was introduced. The period
was an unsigned int in nanoseconds then, which limits it to about
4.29 s. Commit a9d887dc1c60 ("pwm: Convert period and duty cycle to
u64") made longer periods possible.

Fixes: 2101c878f767 ("pwm: atmel: Replace loop in prescale calculation by ad-hoc calculation")
Fixes: a9d887dc1c60 ("pwm: Convert period and duty cycle to u64")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

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
    
    I will report the data sheet text to Microchip.

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

base-commit: e767a4ea70a3992c37ed604157d32f0dfbf9b1e3
-- 
2.39.5 (Apple Git-154)

